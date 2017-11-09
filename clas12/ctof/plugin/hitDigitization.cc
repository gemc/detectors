#include "ctof.h"

GObservables* ctofPlugin::digitizeHit(GHit *ghit)
{
	GObservables* gdata = new GObservables();

	double dvar = 2.22;
	int ivar = 33;

	gdata->addObservable(dvar,                    // variable value
						 "dvar",                  // variable name
						 "digitized double var",  // variable description
						 "double");               // save to disk as type
	
	gdata->addObservable(ivar,                    // variable value
						 "ivar",                  // variable name
						 "digitized int var",  // variable description
						 "int");                  // save to disk as type

	ivar = 44;
	gdata->addObservable(ivar,                    // variable value
						 "ivar2",                  // variable name
						 "digitized int var2",  // variable description
						 "int");                  // save to disk as type
	ivar = 55;
	gdata->addObservable(ivar,                    // variable value
						 "ivar3",                  // variable name
						 "digitized int var3",  // variable description
						 "int");                  // save to disk as type

	float exampleF = 3.2;
	gdata->addObservable(exampleF,                    // variable value
						 "exampleF",                  // variable name
						 "digitized float var",  // variable description
						 "float");                  // save to disk as type
	

	return gdata;
}
