#include "ctof.h"

// tells the DLL how to create a GDynamicFactory
extern "C" GDynamic* GDynamicFactory(void) {
	return static_cast<GDynamic*>(new ctofPlugin);
}

