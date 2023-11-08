/* 
 * File:   PhotonStudy.cc
 * Author: rafopar
 *
 * Created on October 30, 2023, 3:35 PM
 */

#include <cstdlib>
// ===== Hipo headers =====
#include <reader.h>
#include <writer.h>
#include <dictionary.h>

#include <TH1D.h>
#include <TH1D.h>
#include <TFile.h>
#include <TMath.h>

using namespace std;

/*
 * 
 */
int main(int argc, char** argv) {

    char inputFile[256];
    int l_targ; // target length in microns

    if (argc > 1) {
        l_targ = atoi(argv[1]);
        sprintf(inputFile, "Data/filtered_%dMicron.hipo", l_targ);
        //sprintf(outputFile,"%s",argv[2]);
    } else {
        std::cout << " *** please provide a file name..." << std::endl;
        exit(0);
    }

    const double Eb = 11.;
    const int electron_ID = 11;
    const int photon_ID = 22;
    const double r2d = TMath::RadToDeg();

    hipo::reader reader;
    reader.open(inputFile);

    hipo::dictionary factory;

    reader.readDictionary(factory);

    factory.show();

    hipo::event event;
    int evCounter = 0;

    hipo::bank bMCTrue(factory.getSchema("MC::True"));
    TFile *file_out = new TFile(Form("PhotonSpectra_Sn_%d_Micron.root", l_targ), "Recreate");

    TH1D h_EPhot1("h_EPhot1", "", 2000, 0., 2.);
    TH1D h_phiPhot1("h_phiPhot1", "", 200, 0., 360);
    TH1D h_cosThPhot1("h_cosThPhot1", "", 200, -1.01, 1.01);
    TH1D h_EPhot2("h_EPhot2", "", 2000, 0., 2.);
    TH1D h_phiPhot2("h_phiPhot2", "", 200, 0., 360);
    TH1D h_cosThPhot2("h_cosThPhot2", "", 200, -1.01, 1.01);
    TH1D h_EPhot3("h_EPhot3", "", 2000, 0., 2.);
    TH1D h_Eelectron1("h_Eelectron1", "", 2000, 0., Eb);
    TH1D h_phiElectron1("h_phiElectron1", "", 200, 0., 360);
    TH1D h_cosThElectron1("h_cosThElectron1", "", 200, -1.01, 1.01);

    try {

        while (reader.next() == true) {
            reader.read(event);

            evCounter = evCounter + 1;

            if (evCounter % 10000 == 0) {
                cout.flush() << "Processed " << evCounter << " events \r";
            }

            event.getStructure(bMCTrue);

            int nPart = bMCTrue.getRows();

            for (int ip = 0; ip < nPart; ip++) {
                int pid = bMCTrue.getInt("pid", ip);
                int otid = bMCTrue.getInt("otid", ip);
                int mtid = bMCTrue.getInt("mtid", ip);

                double avgX = bMCTrue.getFloat("avgX", ip);
                double avgY = bMCTrue.getFloat("avgY", ip);
                double avgZ = bMCTrue.getFloat("avgZ", ip);

                double phi = atan2(avgY, avgX) * r2d;
                phi = phi < 0 ? phi + 360 : phi;
                double cos_Th = avgZ / sqrt(avgX * avgX + avgY * avgY + avgZ * avgZ);

                double E = double(bMCTrue.getFloat("trackE", ip));

                if (pid == photon_ID) {
                    h_EPhot1.Fill(E);
                    h_phiPhot1.Fill(phi);
                    h_cosThPhot1.Fill(cos_Th);

                    if (mtid == 1) {
                        h_EPhot2.Fill(E);
                        h_phiPhot2.Fill(phi);
                        h_cosThPhot2.Fill(cos_Th);

                    }

                    if (cos_Th < -0.25) {
                        h_EPhot3.Fill(E);
                    }

                    //                    if( E > 0.5099 && E < 0.5112 ){
                    //                        bMCTrue.show();
                    //                    }

                } else if (pid == electron_ID && otid == 1) {
                    h_Eelectron1.Fill(E);
                    h_phiElectron1.Fill(phi);
                    h_cosThElectron1.Fill(cos_Th);
                }
            }
        }
    } catch (const char msg) {
        cerr << msg << endl;
    }

    gDirectory->Write();
    return 0;
}

