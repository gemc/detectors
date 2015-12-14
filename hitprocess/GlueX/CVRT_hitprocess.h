#ifndef CVRT_HITPROCESS_H
#define CVRT_HITPROCESS_H 1

// gemc headers
#include "HitProcess.h"


// Class definition
class CVRT_HitProcess : public HitProcess
{
	public:
	
		~CVRT_HitProcess(){;}
	
		// - integrateDgt: returns digitized information integrated over the hit
		map<string, double> integrateDgt(MHit*, int);
		
		// - multiDgt: returns multiple digitized information / hit
		map< string, vector <int> > multiDgt(MHit*, int);
		
		// The pure virtual method processID returns a (new) identifier
		// containing hit sharing information
		vector<identifier> processID(vector<identifier>, G4Step*, detector);
	
		// creates the HitProcess
		static HitProcess *createHitClass() {return new CVRT_HitProcess;}
};

#endif
