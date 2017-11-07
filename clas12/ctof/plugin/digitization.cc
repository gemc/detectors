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
						 "digitized double var",  // variable description
						 "int");                  // save to disk as type


	return gdata;
}
