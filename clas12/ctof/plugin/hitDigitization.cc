#include "ctof.h"

GObservables* ctofPlugin::digitizeHit(GHit *ghit)
{
	GObservables* gdata = new GObservables();

	double dvar = 2.22;
	int ivar = 33;

	gdata->addObservable(dvar,       // variable value
						 "dvar",     // variable name
						 "m",        // variable units
						 "double");  // save to disk as type
	
	gdata->addObservable(ivar,       // variable value
						 "ivar",     // variable name
						 "count",    // variable units
						 "int");     // save to disk as type

	ivar = 44;
	gdata->addObservable(ivar,       // variable value
						 "ivar2",    // variable name
						 "ns",       // variable units
						 "int");     // save to disk as type
	ivar = 55;
	gdata->addObservable(ivar,       // variable value
						 "ivar3",    // variable name
						 "ms",       // variable units
						 "int");     // save to disk as type

	float exampleF = 3.2;
	gdata->addObservable(exampleF,   // variable value
						 "exampleF", // variable name
						 "cm",       // variable units
						 "float");   // save to disk as type
	
	return gdata;
}
