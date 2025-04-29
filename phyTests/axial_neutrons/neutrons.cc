#include <cstdlib>

// ===== Hipo headers =====
#include <reader.h>
#include <writer.h>
#include <dictionary.h>

#include <TH1D.h>
#include <TH2D.h>
#include <TFile.h>
#include <TMath.h>

#include <iostream>
using namespace std;

int main(int argc, char** argv) {
	// exit with warning if first argument is not given or if it's not an hipo file
	if (argc < 2) {
		cout << " *** please provide a file name..." << endl;
		exit(0);
	}

	const double r2d = TMath::RadToDeg();

	hipo::reader reader;
	reader.open(argv[1]);

	hipo::dictionary factory;
	reader.readDictionary(factory);
	factory.show();

	hipo::event event;
	int         evCounter = 0;

	hipo::bank bMCTrue(factory.getSchema("MC::True"));
	auto       file_out = new TFile("neutrons.root", "Recreate");

	TH2D h_npos1("h_npos1", "h_npos1", 500, -150, 150, 500, -150, 150);
	TH2D h_npos2("h_npos2", "h_npos2", 500, -150, 150, 500, -150, 150);

	TH1D h_edep1("h_edep1", "h_edep1", 300, 0, 100);
	TH1D h_edep2("h_edep2", "h_edep2", 300, 0, 100);

	TH1D h_edep1_c("h_edep1_c", "h_edep1_c", 300, 0, 100);
	TH1D h_edep2_c("h_edep2_c", "h_edep2_c", 300, 0, 100);

	TH1D h_theta("h_theta", "h_theta", 360, -60, 60);

	TH1D h_z("h_z", "h_z", 2600, 0, 2600);
	TH1D h_beta("h_beta", "h_beta", 500, 0.0, 0.8);


	const int neutron_ID = 2112;
	double    zpos1      = 536.0;
	double    zpos2      = 2536.0;
	double    M          = 939.565; // MeV
	double    ene_cut    = 3;

	try {
		while (reader.next() == true) {
			reader.read(event);

			evCounter = evCounter + 1;

			if (evCounter % 1000 == 0) { cout.flush() << "Processed " << evCounter << " events \r"; }

			event.getStructure(bMCTrue);

			int nPart = bMCTrue.getRows();

			double Edep_slab1 = 0;
			double Edep_slab2 = 0;
			for (int ip = 0; ip < nPart; ip++) {
				double avgZ = bMCTrue.getFloat("avgZ", ip);
				double Edep = double(bMCTrue.getFloat("totEdep", ip));

				// in slab1
				if (avgZ < zpos1 - 4) { Edep_slab1 += Edep; }
				// in slab2
				if (avgZ > zpos1 + 4 && avgZ < zpos2 - 4) { Edep_slab2 += Edep; }
			}

			for (int ip = 0; ip < nPart; ip++) {
				int pid = bMCTrue.getInt("pid", ip);

				double avgX = bMCTrue.getFloat("avgX", ip);
				double avgY = bMCTrue.getFloat("avgY", ip);
				double avgZ = bMCTrue.getFloat("avgZ", ip);

				double phi = atan2(avgY, avgX) * r2d;
				phi        = phi < 0 ? phi + 360 : phi;


				if (pid == neutron_ID) {

					h_z.Fill(avgZ);

					double E = double(bMCTrue.getFloat("trackE", ip));

					// in flux dets
					// if avgZ is within zpos1 plus or minus 1 mm, fill h_npos1
					if (fabs(avgZ - zpos1) < 2.0) { h_npos1.Fill(avgX, avgY); }
					if (fabs(avgZ - zpos2) < 2.0) {
						h_edep1.Fill(Edep_slab1);

						if (Edep_slab1 > ene_cut) {

							h_npos2.Fill(avgX, avgY);
							h_edep1_c.Fill(Edep_slab1);

							// calculate the theta angle between the position on slab2 and slab1
							double dX       = avgX;
							double dY       = avgY;
							double dZ       = avgZ - zpos1;
							double R        = sqrt(dX * dX + dY * dY + dZ * dZ);
							double costheta = dZ / R;
							double theta    = acos(costheta) * r2d;
							if (theta > 0) {
								if (dY > 0) h_theta.Fill(theta);
								else h_theta.Fill(-theta);
							}
							// calculate beta of the neutron
							double ratio = pow(M / E, 2);
							double beta  = sqrt(1 - ratio);

							h_beta.Fill(beta);
						}
					}
				}
			}
		}
	}
	catch (const char msg) { cerr << msg << endl; }

	cout << " Ration of Edep_slab1/Edep = " << 100*h_edep1_c.Integral(0, 300) / h_edep1.Integral(0, 300) << endl;

	gDirectory->Write();
	return 0;
}
