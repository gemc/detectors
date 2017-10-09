#include "ctof.h"

bool ctofPlugin::loadConstants(int runno, string variation)
{
	
	var1    = 2.198;
	
	if(runno == 11)
		var1    = 11.198;
	if(runno == 12)
		var1    = 12.198;
	if(runno == 13)
		var1    = 13.198;

	var2[0] = 1;
	var2[0] = 2;

	var3.push_back(3.0);
	var3.push_back(4.0);
	var3.push_back(5.0);
	var3.push_back(6.0);

	var4 = "hello";

	return true;
}
