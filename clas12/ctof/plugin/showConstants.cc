#include "ctof.h"

vector<string> ctofPlugin::showConstants()
{
	vector<string> messages;
	
	messages.push_back(" Var 1 is " + to_string(var1));
//	cout << " Var 1 is " << var1 << endl;
	
	return messages;
}
