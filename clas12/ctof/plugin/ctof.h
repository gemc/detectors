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
	bool checkPlugin() { return true; }
	
	private:
	
	double var1;
	int var2[2];
	vector<double> var3;
	string var4;
	
};

extern "C" GDynamic* GDynamicFactory(void) {
	return static_cast<GDynamic*>(new ctofPlugin);
}


#endif
