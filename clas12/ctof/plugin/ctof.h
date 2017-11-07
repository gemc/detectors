#ifndef CTOFPLUGIN
#define CTOFPLUGIN 1

// gdynamic
#include "gdynamic.h"

// c++
#include <string>
using namespace std;

class ctofPlugin : public GDynamic {
	
public:
	bool loadConstants(int runno, string variation);
	void loadSensitivePars(int runno, string variation);
	GObservables* digitizeHit(GHit *ghit);

	
	vector<string> showConstants();
	bool checkPlugin() { return true; }
	
private:
	
	double var1;
	int var2[2];
	vector<double> var3;
	string var4;
	
};


#endif
