#include "ctof.h"

bool ctofPlugin::loadConstants(int runno, string variation)
{
	var1    = 2.98;
	var2[0] = 1;
	var2[0] = 2;

	var3.push_back(3.0);
	var3.push_back(4.0);
	var3.push_back(5.0);
	var3.push_back(6.0);

	var4 = "hello";

	cout << " Constants loaded for run number " << runno << " for ctof! var1  is " << var1 << " var2 pointer is " << var2 << endl;

	return true;
}
