#ifndef PCAL_HITPROCESS_H
#define PCAL_HITPROCESS_H 1

// gemc headers
#include "HitProcess.h"

// pc constants
// these are loaded with initWithRunNumber
class pcConstants
{
	public:
	
		// runNo is mandatory variable to keep track of run number changes
		int runNo;
		string variation;
		string date;
		string connection;
		char   database[80];
	
		double attlen[3][68][3][6];  // Attenuation Length (mm)
		double attl;
		double TDC_time_to_evio;     // Conversion from time (ns) to EVIO TDC format
		double ADC_MeV_to_evio;      // Conversion from energy (MeV) to EVIO FADC250 format
		double PE_yld;               // Number of p.e. divided by the energy deposited in MeV.
		double veff;                 // Effective velocity of scintillator light (mm/ns)
};

// Class definition
class pcal_HitProcess : public HitProcess
{
	public:
	
		~pcal_HitProcess(){;}
	
		// constants initialized with initWithRunNumber
		static pcConstants pcc;
	
		void initWithRunNumber(int runno);
	
		// - integrateDgt: returns digitized information integrated over the hit
		map<string, double> integrateDgt(MHit*, int);
	
		// - multiDgt: returns multiple digitized information / hit
		map< string, vector <int> > multiDgt(MHit*, int);
	
		// The pure virtual method processID returns a (new) identifier
		// containing hit sharing information
		vector<identifier> processID(vector<identifier>, G4Step*, detector);
	
		// creates the HitProcess
		static HitProcess *createHitClass() {return new pcal_HitProcess;}
};

#endif
