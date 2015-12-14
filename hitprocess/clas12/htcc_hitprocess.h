#ifndef HTCC_HITPROCESS_H
#define HTCC_HITPROCESS_H 1

// gemc headers
#include "HitProcess.h"


// Class definition
class htcc_HitProcess : public HitProcess
{
	public:
	
		~htcc_HitProcess(){;}
	
		// - integrateDgt: returns digitized information integrated over the hit
		map<string, double> integrateDgt(MHit*, int);
		
		// - multiDgt: returns multiple digitized information / hit
		map< string, vector <int> > multiDgt(MHit*, int);
		
		// The pure virtual method processID returns a (new) identifier
		// containing hit sharing information
		vector<identifier> processID(vector<identifier>, G4Step*, detector);
	
		// creates the HitProcess
		static HitProcess *createHitClass() {return new htcc_HitProcess;}
	
	
	private:

	
	
};

#endif
