#ifndef bmt_strip_H
#define bmt_strip_H 1


#include <vector>
using namespace std;

/// \class bmt_strip
/// <b> bmt_strip </b>\n\n
/// Micromegas strip finding routine\n
/// \author \n S. Procureu, G. Charles, M. Ungaro
/// \author mail: sebastien.procureur@cea.fr, gabriel.charles@cea.fr, ungaro@jlab.org\n\n\n


class bmt_strip
{
	public:
		int Nsector;
		double Pi;

		double interlayer;       // distance between 2 layers of a superlayer
		vector<double> Z0;       // z of the upstream part of the layer
		vector<double> DZ;       // total z length of the layer
		vector<double> R;        // radii of layers
		vector<double> MidTile;  // mid angle of the sector
		vector<int> Nstrips;     // number of strips in each detector
		
		double interStripZ; // interstrip for CRnZ
		double interStripC; // interstrip for CRnC
		double pitchZ4;  // pitch for Z4
		double pitchZ5;  // pitch for Z5
		double pitchZ6;  // pitch for Z6
		vector<double> pitchC4;  // pitch for C4
		vector<double> pitchC5;  // pitch for C5
		vector<double> pitchC6;  // pitch for C6
		
		vector<double> Inactivtheta; // dead angle because of mecanics
		double DZ_inLength; // size of the band of dead zones all around in the length of the card
		double DZ_inWidth; // size of the band of dead zones all around in the width of the card
		double DZ4_inLength; // size of the band of dead zones all around in the length of the card (for CR4Z)
		double DZ4_inWidth; // size of the band of dead zones all around in the width of the card (for CR4C)
		double DZ5_inLength; // size of the band of dead zones all around in the length of the card (for CR5Z)
		double DZ5_inWidth; // size of the band of dead zones all around in the width of the card (for CR5C)
		double DZ6_inLength; // size of the band of dead zones all around in the length of the card (for CR6Z)
		double DZ6_inWidth; // size of the band of dead zones all around in the width of the card (for CR6C)
		

		double hDrift;           // Size of the drift gap
		double hStrip2Det;       // distance between strips and the middle of the conversion gap (~half the drift gap)
		double sigma_td_max;     // maximum value of the transverse diffusion
		double sigma_td;         // current value of the transverse diffusion
		double theta_L;          // Lorentz angle (for Z detectors)
		double w_i;              // mean ionization potential
		int Nel;                 // number of electrons (Nt) for a given hit
		double z_real, phi_real; // z and phi of the hit after transverse diffusion


		double x,y,z;            // z of the track is redefined in FindCard. Units are microns - input are millimiters 
		void fill_infos(); 
		vector<double> FindStrip( int layer, int sector, double x, double y, double z, double Edep);   // Strip Finding Routine
   
};

#endif
