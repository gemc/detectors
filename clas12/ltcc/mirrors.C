#include "parameters/ltcc.h"

void mirrors() {



	string variation = "original";
	string PRINT     = ".png";
	int RECALC       = 0;  // 0 will read pars from file
	int RECALC2      = 0;  // 0 will read histos from file
	

	string pname[3] = {"electron", "pion", "kaon"};
	int PART = 0;
	
	string mirname[4] = {"perfect", "ltcc", "eciw", "ecis"};
	int MIRROR = 0;
	
	string gasname[2] = {"perfect", "c4f10"};
	int GAS = 0;
	
	string pmtname[4] = {"perfect", "std", "uvg", "qtz"};
	int PMT = 0;
	
	string wcname[4] = {"perfect", "wc_good", "wc_soso", "wc_bad"};
	int WC = 0;

	
//	gROOT->LoadMacro("utils/calculations.C");
//	gROOT->LoadMacro("utils/show_phe.C");
//	gROOT->LoadMacro("utils/utils.C");
//	gROOT->LoadMacro("utils/show_segment.C");
//	gROOT->LoadMacro("utils/io.C");
//	gROOT->LoadMacro("utils/showMeasurements.C");

#include "utils/calculations.C"
#include "utils/show_phe.C"
#include "utils/utils.C"
#include "utils/show_segment.C"
#include "utils/io.C"
#include "utils/showMeasurements.C"

	
	//setStyle();
	//init_parameters();
	//write_parameters();
	
	//simulateResponse();
	
	bar = new TControlBar("vertical", "LTCC Segments  by Maurizio Ungaro");
	bar->AddButton("","");
	bar->AddButton("Show Photon Yield",              "draw_W()");
	bar->AddButton("","");
	bar->AddButton("Show refractive index of C4F10", "draw_c4f10n()");
	bar->AddButton("Show quantum efficiencies",      "draw_qes()");
	bar->AddButton("Show reflectivities",            "draw_reflectivities()");
	bar->AddButton("Show wc reflectivities",         "draw_wcreflectivities()");
	bar->AddButton("Show Window Gains",            	 "draw_window_gain()");
	bar->AddButton("","");
	bar->AddButton("Inetgrate Yield",   "integrate_yield()");
	bar->AddButton("Plot Yields",			"plot_yields()");
	bar->AddButton("Plot Ratios",			"normalized_yields_mirrors()");
	bar->AddButton("","");
	bar->AddButton("Change particle",  "change_particle()");
	bar->AddButton("Change mirror",    "change_mirror()");
	bar->AddButton("Change gas",       "change_gas()");
	bar->AddButton("Change pmt",       "change_pmt()");
	bar->AddButton("Change WC",        "change_WC()");
	bar->AddButton("","");
	bar->AddButton("Simulate Response", "simulateResponse()");
	bar->AddButton("","");
	bar->AddButton("Write Parameters", "write_parameters()");
	bar->AddButton("","");
	bar->Show();
	
}




























