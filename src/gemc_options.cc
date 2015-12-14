// gemc headers
#include "options.h"

void goptions::setGoptions()
{
	// Initialize all the options in the map<string, aopt>
	//
	// The "string" of the pair in the map is the argument name: -"name"=
	// args = the string type argument
	// arg  = the numeric type argument
	// help = Long explanation.
	// name = Short description.
	// type = 1 for argumenst that are strings, 0 for numbers.
    
	// Generator
	optMap["BEAM_P"].args  = "e-, 11*GeV, 0*deg, 0*deg";
	optMap["BEAM_P"].help  = "Beam particle, momentum, angles (in respect of z-axis). \n";
	optMap["BEAM_P"].help += "      Example: -BEAM_P=\"e-, 6*GeV, 15*deg, 20*deg\" sets 6 GeV electrons 15 degrees in theta, 20 degrees in phi. \n";
	optMap["BEAM_P"].help += "      Use -BEAM_P=\"show_all\" to print the list of G4 supported particles.\n";
	optMap["BEAM_P"].name  = "Primary particle, Energy, Theta, Phi";
	optMap["BEAM_P"].type  = 1;
	optMap["BEAM_P"].ctgr  = "generator";
	
	optMap["SPREAD_P"].args  = "0*GeV, 0*deg, 0*deg";
	optMap["SPREAD_P"].help  = "Spread Primary Particle energy and angles (in respect of z-axis). \n";
	optMap["SPREAD_P"].help += "      Example: -SPREAD_P=\"0*GeV, 10*deg, 20*deg\" spreads 10 degrees in theta, 20 degrees in phi. \n";
	optMap["SPREAD_P"].name  = "delta_Energy, delta_Theta, delta_phi";
	optMap["SPREAD_P"].type  = 1;
	optMap["SPREAD_P"].ctgr  = "generator";
	
	optMap["ALIGN_ZAXIS"].args  = "no";
	optMap["ALIGN_ZAXIS"].help  = "Align z axis to a custom direction. Options:\n";
	optMap["ALIGN_ZAXIS"].help += "      - \"beamp\"  aligns z axis to the beam directions specified by BEAM_P.\n";
	optMap["ALIGN_ZAXIS"].help += "      - \"custom, theta*unit, phi*unit\" aligns z axis to a custom direction, changes BEAM_P reference frame.";
	optMap["ALIGN_ZAXIS"].name  = "Align z axis to a custom direction.";
	optMap["ALIGN_ZAXIS"].type  = 1;
	optMap["ALIGN_ZAXIS"].ctgr  = "generator";
	
	optMap["BEAM_V"].args = "(0, 0, 0)cm";
	optMap["BEAM_V"].help = "Primary Particle Vertex. Example: -BEAM_V=\"(0, 0, -20)cm\". ";
	optMap["BEAM_V"].name = "Primary Particle Vertex";
	optMap["BEAM_V"].type = 1;
	optMap["BEAM_V"].ctgr = "generator";
	
	optMap["SPREAD_V"].args = "(0, 0)cm";
	optMap["SPREAD_V"].help = "Spread Primary Particle Radius, Z position. Example: -SPREAD_V=\"(0.1, 10)cm\". ";
	optMap["SPREAD_V"].name = "Primary Particle Vertex Spread";
	optMap["SPREAD_V"].type = 1;
	optMap["SPREAD_V"].ctgr = "generator";
	
	optMap["POLAR"].args  = "100, 0*deg, 0*deg";
	optMap["POLAR"].help  = "Primary Particle polarization percentage and angles  (in respect of z-axis). \n";
	optMap["POLAR"].help += "      Example: -POLAR=\"90, 90*deg, 270*deg\" sets 90% polarization 90 degrees in theta, 270 degrees in phi. \n";
	optMap["POLAR"].help += "      Use -POLAR=\"show_all\" to print the list of G4 supported particles.\n";
	optMap["POLAR"].name  = "Primary Particle polarization in %, Theta, Phi";
	optMap["POLAR"].type  = 1;
	optMap["POLAR"].ctgr  = "generator";
	
	optMap["N"].arg  = 0;
	optMap["N"].help = "Number of events to be simulated.";
	optMap["N"].name = "Number of events to be simulated";
	optMap["N"].type = 0;
	optMap["N"].ctgr = "generator";
	
	optMap["INPUT_GEN_FILE"].args = "gemc_internal";
	optMap["INPUT_GEN_FILE"].help = "Generator Input. Current availables file formats:\n";
	optMap["INPUT_GEN_FILE"].help += "      LUND. \n";
	optMap["INPUT_GEN_FILE"].help += "      example: -INPUT_GEN_FILE=\"LUND, input.dat\" or -INPUT_GEN_FILE=\"StdHEP, darkphoton.stdhep\" \n";
	optMap["INPUT_GEN_FILE"].name = "Generator Input File";
	optMap["INPUT_GEN_FILE"].type = 1;
	optMap["INPUT_GEN_FILE"].ctgr = "generator";
	
	optMap["NGENP"].arg  = 10;
	optMap["NGENP"].help = "Max Number of Generated Particles to save in the Output.";
	optMap["NGENP"].name = "Max Number of Generated Particles to save in the Output";
	optMap["NGENP"].type = 0;
	optMap["NGENP"].ctgr = "generator";
	
	optMap["STEER_BEAM"].arg = 0;
	optMap["STEER_BEAM"].type = 0;
	optMap["STEER_BEAM"].ctgr = "generator";
	optMap["STEER_BEAM"].name = "STEER_BEAM";
	optMap["STEER_BEAM"].help = "Steer the beam, and translate the vertex, of an StdHep file by the amount specified in Beam_P, Beam_V, Spread_V \n";
	
	optMap["COSMICRAYS"].args = "no";
	optMap["COSMICRAYS"].help = "Cosmic Generator. The model has a (cos(theta), p) probability function:\n\n";
	optMap["COSMICRAYS"].help += "              a^(b*cos(theta))/(c*p^2). \n\n";
	optMap["COSMICRAYS"].help += "      The COSMICRAYS option sets the parameters and the momentum range in the last two numbers. \n";
	optMap["COSMICRAYS"].help += "      By default the parameters are: \n";
	optMap["COSMICRAYS"].help += "       a = 55.6: \n";
	optMap["COSMICRAYS"].help += "       b = 1.04: \n";
	optMap["COSMICRAYS"].help += "       c = 64: \n";
	optMap["COSMICRAYS"].help += "      One can use the defaults or set the pars with the options: \n";
	optMap["COSMICRAYS"].help += "      example 1: -COSMICRAYS=\"default, 1, 10\" will use the default parameterization, and momentum range [1-10] GeV \n";
	optMap["COSMICRAYS"].help += "      example 2: -COSMICRAYS=\"55, 2, 66, 3, 4\" will set the parameterization, and momentum range [3-4] GeV \n";
	optMap["COSMICRAYS"].name = "Cosmic Generator";
	optMap["COSMICRAYS"].type = 1;
	optMap["COSMICRAYS"].ctgr = "generator";

	optMap["COSMICAREA"].args = "0*cm, 0*cm, 0*cm, 50*cm";
	optMap["COSMICAREA"].help = "Target (x,y,z) location and radius of area of interest";
	optMap["COSMICAREA"].name = "Target (x,y,z) location and radius of area of interest";
	optMap["COSMICAREA"].type = 1;
	optMap["COSMICAREA"].ctgr = "generator";
	

	
	// Luminosity Beam
	optMap["LUMI_P"].args  = "e-, 11*GeV, 0*deg, 0*deg";
	optMap["LUMI_P"].help  = "Luminosity Particle, momentum, angles (in respect of z-axis). \n";
	optMap["LUMI_P"].help += "            Example: -LUMI_P=\"proton, 1*GeV, 25*deg, 2*deg\" sets 1 GeV protons, 25 degrees in theta, 2 degrees in phi. \n";
	optMap["LUMI_P"].help += "            Use -LUMI_P=\"show_all\" to print the list of G4 supported particles.\n";
	optMap["LUMI_P"].name  = "Luminosity Particle, Energy, Theta, Phi";
	optMap["LUMI_P"].type  = 1;
	optMap["LUMI_P"].ctgr = "luminosity";
	
	optMap["LUMI_SPREAD_P"].args  = "0*GeV, 0*deg, 0*deg";
	optMap["LUMI_SPREAD_P"].help  = "Spread Luminosity Particle energy and angles (in respect of z-axis). \n";
	optMap["LUMI_SPREAD_P"].help += "      Example: -LUMI_SPREAD_P=\"0*GeV, 10*deg, 20*deg\" spreads 10 degrees in theta, 20 degrees in phi. \n";
	optMap["LUMI_SPREAD_P"].name  = "delta_Energy, delta_Theta, delta_phi";
	optMap["LUMI_SPREAD_P"].type  = 1;
	optMap["LUMI_SPREAD_P"].ctgr  = "generator";
	
	optMap["LUMI_V"].args = "(0, 0, -20)cm";
	optMap["LUMI_V"].help = "Luminosity Particle Vertex. Example: -LUMI_V=\"(0, 0, -20)cm\". ";
	optMap["LUMI_V"].name = "Luminosity Particle Vertex";
	optMap["LUMI_V"].type = 1;
	optMap["LUMI_V"].ctgr = "luminosity";
	
	optMap["LUMI_SPREAD_V"].args = "(0, 0)cm";
	optMap["LUMI_SPREAD_V"].help = "Spread Luminosity Particle Radius, Z position. Example: -SPREAD_V=\"(0.1, 10)cm\". ";
	optMap["LUMI_SPREAD_V"].name = "Luminosity Particle Vertex Spread";
	optMap["LUMI_SPREAD_V"].type = 1;
	optMap["LUMI_SPREAD_V"].ctgr = "luminosity";
	
	optMap["LUMI_EVENT"].args = "0, 0*ns, 2*ns";
	optMap["LUMI_EVENT"].help = "Luminosity Particle Parameters: number of Particles/Event, Time Window, Time Between Bunches\n";
	optMap["LUMI_EVENT"].help += "            Example: -LUMI_EVENT=\"10000, 120*ns, 2*ns\" simulate 10K particles per event distributed over 120 ns, at 2ns intervals. \n";
	optMap["LUMI_EVENT"].name = "Luminosity Particle Parameters";
	optMap["LUMI_EVENT"].type = 1;
	optMap["LUMI_EVENT"].ctgr = "luminosity";
	
	optMap["LUMI2_P"].args  = "proton, 50*GeV, 175*deg, 180*deg";
	optMap["LUMI2_P"].help  = "Luminosity Particle 2, momentum, angles (in respect of z-axis). \n";
	optMap["LUMI2_P"].help += "            Example: -LUMI2_P=\"proton, 1*GeV, 25*deg, 2*deg\" sets 1 GeV protons, 25 degrees in theta, 2 degrees in phi. \n";
	optMap["LUMI2_P"].help += "            Use -LUMI2_P=\"show_all\" to print the list of G4 supported particles.\n";
	optMap["LUMI2_P"].name  = "Luminosity Particle 2, Energy, Theta, Phi";
	optMap["LUMI2_P"].type  = 1;
	optMap["LUMI2_P"].ctgr = "luminosity";
	
	optMap["LUMI2_SPREAD_P"].args  = "0*GeV, 0*deg, 0*deg";
	optMap["LUMI2_SPREAD_P"].help  = "Spread Luminosity Particle 2 energy and angles (in respect of z-axis). \n";
	optMap["LUMI2_SPREAD_P"].help += "      Example: -LUMI2_SPREAD_P=\"0*GeV, 10*deg, 20*deg\" spreads 10 degrees in theta, 20 degrees in phi. \n";
	optMap["LUMI2_SPREAD_P"].name  = "delta_Energy, delta_Theta, delta_phi";
	optMap["LUMI2_SPREAD_P"].type  = 1;
	optMap["LUMI2_SPREAD_P"].ctgr  = "generator";
	
	optMap["LUMI2_V"].args = "(4, 0, 50)cm";
	optMap["LUMI2_V"].help = "Luminosity Particle 2 Vertex. Example: -LUMI2_V=\"(0, 0, -20)cm\". ";
	optMap["LUMI2_V"].name = "Luminosity Particle 2 Vertex";
	optMap["LUMI2_V"].type = 1;
	optMap["LUMI2_V"].ctgr = "luminosity";
	
	optMap["LUMI2_SPREAD_V"].args = "(0, 0)cm";
	optMap["LUMI2_SPREAD_V"].help = "Spread Luminosity Particle 2 Radius, Z position. Example: -SPREAD_V=\"(0.1, 10)cm\". ";
	optMap["LUMI2_SPREAD_V"].name = "Luminosity Particle Vertex 2 Spread";
	optMap["LUMI2_SPREAD_V"].type = 1;
	optMap["LUMI2_SPREAD_V"].ctgr = "luminosity";
	
	optMap["LUMI2_EVENT"].args = "0, 2*ns";
	optMap["LUMI2_EVENT"].help = "Luminosity Particle 2 Parameters: number of Particles/Event, Time Between Bunches. The Time Window is specified with the LUMI_EVENT flag\n";
	optMap["LUMI2_EVENT"].help += "            Example: -LUMI2_EVENT=\"10000, 2*ns\" simulate 10K particles per event at 2ns intervals. \n";
	optMap["LUMI2_EVENT"].name = "Luminosity Particle 2 Parameters";
	optMap["LUMI2_EVENT"].type = 1;
	optMap["LUMI2_EVENT"].ctgr = "luminosity";
	
	
	
	// MySQL Database
	optMap["DBHOST"].args = "no";
	optMap["DBHOST"].help = "Selects mysql server host name.";
	optMap["DBHOST"].name = "mysql server host name";
	optMap["DBHOST"].type = 1;
	optMap["DBHOST"].ctgr = "mysql";
	
	optMap["DATABASE"].args = "no";
	optMap["DATABASE"].help = "Selects mysql Database.";
	optMap["DATABASE"].name = "mysql Database";
	optMap["DATABASE"].type = 1;
	optMap["DATABASE"].ctgr = "mysql";
	
	optMap["DBUSER"].args = "gemc";
	optMap["DBUSER"].help = "Select mysql user name";
	optMap["DBUSER"].name = "Select mysql user name";
	optMap["DBUSER"].type = 1;
	optMap["DBUSER"].ctgr = "mysql";
	
	optMap["DBPSWD"].args = "no";
	optMap["DBPSWD"].help = "mysql password";
	optMap["DBPSWD"].name = "Select mysql password";
	optMap["DBPSWD"].type = 1;
	optMap["DBPSWD"].ctgr = "mysql";
	
	optMap["DBPORT"].arg = 0;
	optMap["DBPORT"].help = "Select mysql server port.";
	optMap["DBPORT"].name = "Select mysql server port";
	optMap["DBPORT"].type = 0;
	optMap["DBPORT"].ctgr = "mysql";
	
	
	
	
	
	
	// Verbosity
	optMap["G4P_VERBOSITY"].arg  = 1;
	optMap["G4P_VERBOSITY"].help = "Controls Physical Volumes Construction Log Output.";
	optMap["G4P_VERBOSITY"].name = "Logical Volume Verbosity";
	optMap["G4P_VERBOSITY"].type = 0;
	optMap["G4P_VERBOSITY"].ctgr = "verbosity";
	
	optMap["GEO_VERBOSITY"].arg  = 1;
	optMap["GEO_VERBOSITY"].help = "Controls Geometry Construction Log Output.";
	optMap["GEO_VERBOSITY"].name = "Geometry Verbosity";
	optMap["GEO_VERBOSITY"].type = 0;
	optMap["GEO_VERBOSITY"].ctgr = "verbosity";
	
	optMap["GUI_VERBOSITY"].arg  = 1;
	optMap["GUI_VERBOSITY"].help = "Controls GUI Construction Log Output.";
	optMap["GUI_VERBOSITY"].name = "GUI Verbosity";
	optMap["GUI_VERBOSITY"].type = 0;
	optMap["GUI_VERBOSITY"].ctgr = "verbosity";
	
	optMap["HIT_VERBOSITY"].arg  = 1;
	optMap["HIT_VERBOSITY"].help = "Controls Hits Log Output. ";
	optMap["HIT_VERBOSITY"].name = "Hit Verbosity";
	optMap["HIT_VERBOSITY"].type = 0;
	optMap["HIT_VERBOSITY"].ctgr = "verbosity";
	
	optMap["CATCH"].args = "Maurizio";
	optMap["CATCH"].help = "Catch volumes matching the given string.";
	optMap["CATCH"].name = "Volume catcher";
	optMap["CATCH"].type = 1;
	optMap["CATCH"].ctgr = "verbosity";
	
	optMap["FIELD_VERBOSITY"].arg   = 0;
	optMap["FIELD_VERBOSITY"].help  = "Controls Electro-Magnetic Fields Log Output:\n";
	optMap["FIELD_VERBOSITY"].help += "  0: no log";
	optMap["FIELD_VERBOSITY"].help += "  1: field definitions log";
	optMap["FIELD_VERBOSITY"].help += "  2: max field details";
	optMap["FIELD_VERBOSITY"].name  = "Electro-Magnetic Fields Verbosity";
	optMap["FIELD_VERBOSITY"].type  = 0;
	optMap["FIELD_VERBOSITY"].ctgr  = "verbosity";
	
	optMap["PRINT_EVENT"].arg  = 1000;
	optMap["PRINT_EVENT"].help = "-PRINT_EVENT=N: Print Event Number every N events.";
	optMap["PRINT_EVENT"].name = "Print Event Modulus";
	optMap["PRINT_EVENT"].type = 0;
	optMap["PRINT_EVENT"].ctgr = "verbosity";
	
	optMap["BANK_VERBOSITY"].arg  = 1;
	optMap["BANK_VERBOSITY"].help = "Controls Bank Log Output.";
	optMap["BANK_VERBOSITY"].name = "Bank Output Verbosity";
	optMap["BANK_VERBOSITY"].type = 0;
	optMap["BANK_VERBOSITY"].ctgr = "verbosity";
	
	optMap["PHY_VERBOSITY"].arg  = 1;
	optMap["PHY_VERBOSITY"].help = "Controls Physics List Log Output.";
	optMap["PHY_VERBOSITY"].name = "Physics List Verbosity";
	optMap["PHY_VERBOSITY"].type = 0;
	optMap["PHY_VERBOSITY"].ctgr = "verbosity";
	
	optMap["GEN_VERBOSITY"].arg  = 0;
	optMap["GEN_VERBOSITY"].help = "Controls Geant4 Generator Verbosity.";
	optMap["GEN_VERBOSITY"].name = "Geant4 Generator Verbosity";
	optMap["GEN_VERBOSITY"].type = 0;
	optMap["GEN_VERBOSITY"].ctgr = "verbosity";
	
	optMap["G4TRACK_VERBOSITY"].arg  = 0;
	optMap["G4TRACK_VERBOSITY"].help = "Controls Geant4 Track Verbosity.";
	optMap["G4TRACK_VERBOSITY"].name = "Geant4 Track Verbosity";
	optMap["G4TRACK_VERBOSITY"].type = 0;
	optMap["G4TRACK_VERBOSITY"].ctgr = "verbosity";
	
	optMap["MATERIAL_VERBOSITY"].arg  = 0;
	optMap["MATERIAL_VERBOSITY"].help = "Controls Geant4 Material Verbosity.";
	optMap["MATERIAL_VERBOSITY"].name = "Geant4 Material Verbosity";
	optMap["MATERIAL_VERBOSITY"].type = 0;
	optMap["MATERIAL_VERBOSITY"].ctgr = "verbosity";
	
	optMap["PARAMETER_VERBOSITY"].arg  = 0;
	optMap["PARAMETER_VERBOSITY"].help = "Controls Parameters Verbosity.";
	optMap["PARAMETER_VERBOSITY"].name = "Parameters Verbosity";
	optMap["PARAMETER_VERBOSITY"].type = 0;
	optMap["PARAMETER_VERBOSITY"].ctgr = "verbosity";
	
	optMap["MIRROR_VERBOSITY"].arg  = 0;
	optMap["MIRROR_VERBOSITY"].help = "Controls Mirrors Verbosity.";
	optMap["MIRROR_VERBOSITY"].name = "Mirrors Verbosity";
	optMap["MIRROR_VERBOSITY"].type = 0;
	optMap["MIRROR_VERBOSITY"].ctgr = "verbosity";
	
	
	
	
	
	
	// Run Control
	optMap["EXEC_MACRO"].args = "no";
	optMap["EXEC_MACRO"].help = "Executes commands in macro file.";
	optMap["EXEC_MACRO"].name = "Executes commands in macro file";
	optMap["EXEC_MACRO"].type = 1;
	optMap["EXEC_MACRO"].ctgr = "control";
	
	optMap["CHECK_OVERLAPS"].arg  = 0;
	optMap["CHECK_OVERLAPS"].help  = "Checks Overlapping Volumes:\n";
	optMap["CHECK_OVERLAPS"].help += "      1.  Check Overlaps at Construction Time\n";
	optMap["CHECK_OVERLAPS"].help += "      2.  Check Overlaps based on standard lines grid setup\n";
	optMap["CHECK_OVERLAPS"].help += "      3.  Check Overlaps by shooting lines according to a cylindrical pattern\n";
	optMap["CHECK_OVERLAPS"].name = "Checks Overlapping Volumes";
	optMap["CHECK_OVERLAPS"].type = 0;
	optMap["CHECK_OVERLAPS"].ctgr = "control";
	
	optMap["USE_GUI"].arg   = 1;
	optMap["USE_GUI"].help  = " GUI switch\n";
	optMap["USE_GUI"].help += "      0.  Don't use the graphical interface\n";
	optMap["USE_GUI"].help += "      1.  Qt GUI Interface. \n";
	optMap["USE_GUI"].help += "      2.  OpenGL Stored mode (can't interact with picture; sliders works well)\n";
	optMap["USE_GUI"].help += "      3.  OpenGL Immediate mode (can't interact with picture; sliders works well; slower than Stored mode)\n";
	optMap["USE_GUI"].help += "      4.  QT OpenGL Stored mode (can interact with picture; sliders works but picture needs to be updated by clicking on it)\n";
	optMap["USE_GUI"].name  = "QT Gui";
	optMap["USE_GUI"].type  = 0;
	optMap["USE_GUI"].ctgr  = "control";
	
	optMap["geometry"].args="620x620";
	optMap["geometry"].help = "Specify the size of the QT display window. Default '600x600' ";
	optMap["geometry"].name="geometry";
	optMap["geometry"].type=1;
	optMap["geometry"].ctgr = "control";
	
	optMap["GUIPOS"].args="(150, 150)";
	optMap["GUIPOS"].help = "Specify the position of the QT display window. Default is at 50, 50 ";
	optMap["GUIPOS"].name="geometry";
	optMap["GUIPOS"].type=1;
	optMap["GUIPOS"].ctgr = "control";
	
	optMap["QTSTYLE"].args  = "no";
	optMap["QTSTYLE"].name  = "Sets the GUI Style";
	optMap["QTSTYLE"].help  = "Sets the GUI Style. Available options: \n";
	optMap["QTSTYLE"].help += "      - QCleanlooksStyle \n";
	optMap["QTSTYLE"].help += "      - QMacStyle \n";
	optMap["QTSTYLE"].help += "      - QPlastiqueStyle \n";
	optMap["QTSTYLE"].help += "      - QWindowsStyle \n";
	optMap["QTSTYLE"].help += "      - QMotifStyle";
	optMap["QTSTYLE"].type  = 1;
	optMap["QTSTYLE"].ctgr  = "control";
	
	optMap["RANDOM"].args = "TIME";
	optMap["RANDOM"].help = "Random Engine Initialization. The argument (seed) can be an integer or the string TIME.";
	optMap["RANDOM"].name = "Random Engine Initialization";
	optMap["RANDOM"].type = 1;
	optMap["RANDOM"].ctgr = "control";
	
	optMap["gcard"].args = "no";
	optMap["gcard"].help = "gemc card file.";
	optMap["gcard"].name = "gemc card file";
	optMap["gcard"].type = 1;
	optMap["gcard"].ctgr = "control";
	
	optMap["EVN"].arg  = 1;
	optMap["EVN"].help = "Initial Event Number.";
	optMap["EVN"].name = "Initial Event Number";
	optMap["EVN"].type = 0;
	optMap["EVN"].ctgr = "control";
		
	optMap["ENERGY_CUT"].arg  = -1.;
	optMap["ENERGY_CUT"].help = "Set an energy cut in MeV below which no particle will be tracked further. -1. turns this off.";
	optMap["ENERGY_CUT"].name = "Tracking Energy cut (in MeV)";
	optMap["ENERGY_CUT"].type = 0;
	optMap["ENERGY_CUT"].ctgr = "control";
	
	optMap["MAX_X_POS"].arg  = 20000.;
	optMap["MAX_X_POS"].help = "Max X Position in millimeters. Beyond this the track will be killed";
	optMap["MAX_X_POS"].name = "Max X Position in millimeters. Beyond this the track will be killed.";
	optMap["MAX_X_POS"].type = 0;
	optMap["MAX_X_POS"].ctgr = "control";
	
	optMap["MAX_Y_POS"].arg  = 20000.;
	optMap["MAX_Y_POS"].help = "Max Y Position in millimeters. Beyond this the track will be killed";
	optMap["MAX_Y_POS"].name = "Max Y Position in millimeters. Beyond this the track will be killed.";
	optMap["MAX_Y_POS"].type = 0;
	optMap["MAX_Y_POS"].ctgr = "control";
	
	optMap["MAX_Z_POS"].arg  = 20000.;
	optMap["MAX_Z_POS"].help = "Max Z Position in millimeters. Beyond this the track will be killed";
	optMap["MAX_Z_POS"].name = "Max Z Position in millimeters. Beyond this the track will be killed.";
	optMap["MAX_Z_POS"].type = 0;
	optMap["MAX_Z_POS"].ctgr = "control";
	
	optMap["DAWN_N"].arg = 0;
	optMap["DAWN_N"].name = "Number of events to be displayed with the DAWN driver (also activate the DAWN driver)";
	optMap["DAWN_N"].help = "Number of events to be displayed with the DAWN driver (also activate the DAWN driver).";
	optMap["DAWN_N"].type = 0;
	optMap["DAWN_N"].ctgr = "control";
	
	optMap["HIT_PROCESS_LIST"].args = "clas12";
	optMap["HIT_PROCESS_LIST"].name = "Registers Hit Process Routines.";
	optMap["HIT_PROCESS_LIST"].help = "Registers Hit Process Routines. Can register multiple experiments, separated by space, e.v. \"clas12 aprime\"\n";
	optMap["HIT_PROCESS_LIST"].help += "      clas12.  CLAS12 hit process routines (default)\n";
	optMap["HIT_PROCESS_LIST"].help += "      aprime.  aprime hit process routines\n";
	optMap["HIT_PROCESS_LIST"].help += "      gluex.   GlueX  hit process routines\n";
	optMap["HIT_PROCESS_LIST"].type = 1;
	optMap["HIT_PROCESS_LIST"].ctgr = "control";
	
	optMap["SAVE_ALL_MOTHERS"].arg = 0;
	optMap["SAVE_ALL_MOTHERS"].name = "Set to 1 to save mother vertex and pid infos in output. High Memory Usage";
	optMap["SAVE_ALL_MOTHERS"].help = "Set to 1 to save mother vertex and pid infos in output. High Memory Usage. Default is 0.\n";
	optMap["SAVE_ALL_MOTHERS"].type = 0;
	optMap["SAVE_ALL_MOTHERS"].ctgr = "control";
	
	optMap["HIGH_RES"].arg = 1;
	optMap["HIGH_RES"].name = "Use High Resolution Graphics";
	optMap["HIGH_RES"].help = "Use High Resolution Graphics\n";
	optMap["HIGH_RES"].type = 0;
	optMap["HIGH_RES"].ctgr = "control";
	
	optMap["RECORD_PASSBY"].arg = 0;
	optMap["RECORD_PASSBY"].name = "Set to one if you want to save zero energy hits in the output";
	optMap["RECORD_PASSBY"].help = "Set to one if you want to save zero energy hits in the output. Default is 0.\n";
	optMap["RECORD_PASSBY"].type = 0;
	optMap["RECORD_PASSBY"].ctgr = "control";
	
	optMap["RECORD_MIRRORS"].arg = 0;
	optMap["RECORD_MIRRORS"].name = "Set to one if you want to save mirror hits in the output";
	optMap["RECORD_MIRRORS"].help = "Set to one if you want to save mirror hits in the output. Default is 0.\n";
	optMap["RECORD_MIRRORS"].type = 0;
	optMap["RECORD_MIRRORS"].ctgr = "control";
	
	optMap["RUNNO"].arg  = 1;
	optMap["RUNNO"].name = "Run Number. Controls the geometry and calibration parameters";
	optMap["RUNNO"].help = "Run Number. Controls the geometry and calibration parameters. Default is 1\n";
	optMap["RUNNO"].type = 0;
	optMap["RUNNO"].ctgr = "control";
	
	optMap["RUN_WEIGHTS"].args  = "no";
	optMap["RUN_WEIGHTS"].name  = "Simulate events based on run based conditions table (text file)";
	optMap["RUN_WEIGHTS"].help  = "Simulate events based on run based conditions table (text file)\n";
	optMap["RUN_WEIGHTS"].help += "      The text file must have two columns, run# and weight.\n";
	optMap["RUN_WEIGHTS"].help += "      For example:\n\n";
	optMap["RUN_WEIGHTS"].help += "        11 0.1\n";
	optMap["RUN_WEIGHTS"].help += "        12 0.7\n";
	optMap["RUN_WEIGHTS"].help += "        13 0.2\n\n";
	optMap["RUN_WEIGHTS"].help += "      Will simulate 10% of events with run number 11 conditions, 70% run 12 and 20% run 13.\n";
	optMap["RUN_WEIGHTS"].type  = 1;
	optMap["RUN_WEIGHTS"].ctgr  = "control";
	
	
	
	
	// Output
	optMap["OUTPUT"].args = "no, output";
	optMap["OUTPUT"].help = "Type of output, output filename. Supported output: evio, txt. Example: -OUTPUT=\"evio, out.ev\"";
	optMap["OUTPUT"].name = "Type of output, output filename. ";
	optMap["OUTPUT"].type = 1;
	optMap["OUTPUT"].ctgr = "output";
	
	// disabled by default
	optMap["INTEGRATEDRAW"].args = "no";
	optMap["INTEGRATEDRAW"].help = "Activates integrated geant4 raw output for system(s). Example: -INTEGRATEDRAW=\"DC, TOF\"";
	optMap["INTEGRATEDRAW"].name = "Activates integrated geant4 raw output for system(s)";
	optMap["INTEGRATEDRAW"].type = 1;
	optMap["INTEGRATEDRAW"].ctgr = "output";
	
	// disabled by default
	optMap["INTEGRATEDDGT"].args = "yes";
	optMap["INTEGRATEDDGT"].help = "Activates integrated digitized output for system(s). Example: -INTEGRATEDDGT=\"DC, TOF\"";
	optMap["INTEGRATEDDGT"].name = "Activates integrated digitized output for system(s). ";
	optMap["INTEGRATEDDGT"].type = 1;
	optMap["INTEGRATEDRAW"].ctgr = "output";
	
	// disabled by default
	optMap["ALLRAWS"].args = "no";
	optMap["ALLRAWS"].help = "Activates step-by-step output for system(s). Example: -ALLRAWS=\"DC, TOF\"";
	optMap["ALLRAWS"].name = "Activates step-by-step output for system(s). ";
	optMap["ALLRAWS"].type = 1;
	optMap["ALLRAWS"].ctgr = "output";
	
	// disabled by default
	optMap["SIGNALVT"].args = "no";
	optMap["SIGNALVT"].help = "Activates voltage (t) output for system(s). Example: -SIGNALVT=\"DC, TOF\"";
	optMap["SIGNALVT"].name = "Activates voltage (t) output for system(s). ";
	optMap["SIGNALVT"].type = 1;
	optMap["SIGNALVT"].ctgr = "output";
	
	// voltage versus time resolution, in ns
	optMap["VTRESOLUTION"].arg = 0.1;
	optMap["VTRESOLUTION"].help = "Voltage versus time resolution, in ns";
	optMap["VTRESOLUTION"].name = "Voltage versus time resolution, in ns.";
	optMap["VTRESOLUTION"].type = 0;
	optMap["VTRESOLUTION"].ctgr = "output";
	
	// sampling time of electronics (typically FADC), electronic event time size
	// the VT output is sampled every TSAMPLING nanoseconds to produce a ADC
	// the default for event time size is 2 microsecond, for a total of 500 ADC points / channel
	optMap["TSAMPLING"].args = "4, 500";
	optMap["TSAMPLING"].help = "Sampling time of electronics (typically FADC)";
	optMap["TSAMPLING"].name = "Sampling time of electronics (typically FADC)";
	optMap["TSAMPLING"].type = 1;
	optMap["TSAMPLING"].ctgr = "output";
	

	// Physics
	optMap["PHYSICS"].args = "FTFP_BERT";
	optMap["PHYSICS"].help =  "    Physics List. The lists are modular and can be added together. \n";
	optMap["PHYSICS"].help +=  "     For example, a choice could be 'QGSC_BERT + STD + HP + Optical'\n";
	optMap["PHYSICS"].help +=  "     Possible Choices:\n";
	optMap["PHYSICS"].help +=  "      Hadronic: \n";
	optMap["PHYSICS"].help +=  "      - CHIPS\n";
	optMap["PHYSICS"].help +=  "      - FTFP_BERT\n";
	optMap["PHYSICS"].help +=  "      - FTFP_BERT_TRV\n";
	optMap["PHYSICS"].help +=  "      - FTF_BIC\n";
	optMap["PHYSICS"].help +=  "      - LHEP\n";
	optMap["PHYSICS"].help +=  "      - QGSC_BERT\n";
	optMap["PHYSICS"].help +=  "      - QGSP\n";
	optMap["PHYSICS"].help +=  "      - QGSP_BERT\n";
	optMap["PHYSICS"].help +=  "      - QGSP_BERT_CHIPS\n";
	optMap["PHYSICS"].help +=  "      - QGSP_BERT_HP\n";
	optMap["PHYSICS"].help +=  "      - QGSP_BIC\n";
	optMap["PHYSICS"].help +=  "      - QGSP_BIC_HP\n";
	optMap["PHYSICS"].help +=  "      - QGSP_FTFP_BERT\n";
	optMap["PHYSICS"].help +=  "      - QGS_BIC\n";
	optMap["PHYSICS"].help +=  "      - QGSP_INCLXX\n";
	optMap["PHYSICS"].help +=  "      Electromagnetic: \n";
	optMap["PHYSICS"].help +=  "      - STD\n";
	optMap["PHYSICS"].help +=  "      - EMV\n";
	optMap["PHYSICS"].help +=  "      - EMX\n";
	optMap["PHYSICS"].help +=  "      - EMY\n";
	optMap["PHYSICS"].help +=  "      - EMZ\n";
	optMap["PHYSICS"].help +=  "      - LIV\n";
	optMap["PHYSICS"].help +=  "      - PEN\n";
	optMap["PHYSICS"].name = "Choice of Physics List";
	optMap["PHYSICS"].type = 1;
	optMap["PHYSICS"].ctgr = "physics";
		
	optMap["HALL_MATERIAL"].args = "Vacuum";
	optMap["HALL_MATERIAL"].help = "Composition of the Experimental Hall. \n";
	optMap["HALL_MATERIAL"].help += "            Air normal simulation\n";
	optMap["HALL_MATERIAL"].help += "            Air_Opt Simulation with Optical Physics\n";
	optMap["HALL_MATERIAL"].help += "            Vacuum (default)\n";
	optMap["HALL_MATERIAL"].name = "Composition of the Experimental Hall";
	optMap["HALL_MATERIAL"].type = 1;
	optMap["HALL_MATERIAL"].ctgr = "physics";
	
	optMap["DEFAULT_MATERIAL"].args = "none";
	optMap["DEFAULT_MATERIAL"].help = "Default material for missing material field.\n";
	optMap["DEFAULT_MATERIAL"].name = "Default material for missing material field";
	optMap["DEFAULT_MATERIAL"].type = 1;
	optMap["DEFAULT_MATERIAL"].ctgr = "physics";
	
	optMap["HALL_FIELD"].args = "no";
	optMap["HALL_FIELD"].help = "Magnetic Field of the Hall. \n";
	optMap["HALL_FIELD"].name = "Magnetic Field of the Hall";
	optMap["HALL_FIELD"].type = 1;
	optMap["HALL_FIELD"].ctgr = "physics";
	
	optMap["HALL_DIMENSIONS"].args = "20*m, 20*m, 20*m";
	optMap["HALL_DIMENSIONS"].help = "(x,y,z) semi-dimensions of the experimental Hall.\n";
	optMap["HALL_DIMENSIONS"].name = "(x,y,z) semi-dimensions of the experimental Hall.";
	optMap["HALL_DIMENSIONS"].type = 1;
	optMap["HALL_DIMENSIONS"].ctgr = "physics";
	
	optMap["FIELD_DIR"].args = "env";
	optMap["FIELD_DIR"].help = "Magnetic Field Maps Location. \n";
	optMap["FIELD_DIR"].name = "Magnetic Field Maps Location";
	optMap["FIELD_DIR"].type = 1;
	optMap["FIELD_DIR"].ctgr = "physics";
	
	optMap["NO_FIELD"].args = "none";
	optMap["NO_FIELD"].help = "Sets Magnetic Field of a volume to zero. \"all\" means no magnetic field at all. \n";
	optMap["NO_FIELD"].name = "Sets Magnetic Field of a volume to zero. \"all\" means no magnetic field at all ";
	optMap["NO_FIELD"].type = 1;
	optMap["NO_FIELD"].ctgr = "physics";
	
	optMap["PHYS_VERBOSITY"].arg = 0;
	optMap["PHYS_VERBOSITY"].help = "Physics List Verbosity";
	optMap["PHYS_VERBOSITY"].name = "Physics List Verbosity";
	optMap["PHYS_VERBOSITY"].type = 0;
	optMap["PHYS_VERBOSITY"].ctgr = "physics";
	
	
	// by default set max field step to 1 cm. Notice: it has to be greater than the min!
	optMap["MAX_FIELD_STEP"].arg =  0;
	optMap["MAX_FIELD_STEP"].help = "Sets Maximum Acceptable Step in Magnetic Field (in mm).\n";
	optMap["MAX_FIELD_STEP"].name = "Sets Maximum Acceptable Step in Magnetic Field (in mm) ";
	optMap["MAX_FIELD_STEP"].type = 0;
	optMap["MAX_FIELD_STEP"].ctgr = "physics";
	
	optMap["SCALE_FIELD"].args  = "no, 1";
	optMap["SCALE_FIELD"].help  = "Scales Magnetic Field by a factor.\n";
	optMap["SCALE_FIELD"].help += "      Usage:\n";
	optMap["SCALE_FIELD"].help += "      -SCALE_FIELD=\"fieldname, scalefactor\"\n";
	optMap["SCALE_FIELD"].help += "      Example: -SCALE_FIELD=\"srr-solenoid, 0.5\"\n";
	optMap["SCALE_FIELD"].name  = "Electro-Magnetic Field scale";
	optMap["SCALE_FIELD"].type  = 1;
	optMap["SCALE_FIELD"].ctgr  = "physics";
	
	optMap["ACTIVEFIELDS"].args  = "none";
	optMap["ACTIVEFIELDS"].help  = "List of activated fields\n";
	optMap["ACTIVEFIELDS"].name  = "List of activated fields";
	optMap["ACTIVEFIELDS"].type  = 1;
	optMap["ACTIVEFIELDS"].ctgr  = "physics";

	optMap["PRODUCTIONCUT"].arg   = 10;
	optMap["PRODUCTIONCUT"].help  = "Production cut for root, in mm\n";
	optMap["PRODUCTIONCUT"].name  = "Production cut for root, in mm";
	optMap["PRODUCTIONCUT"].type  = 0;
	optMap["PRODUCTIONCUT"].ctgr  = "physics";
	

	
	// General
	optMap["DF"].args  = "no";
	optMap["DF"].help  = "Selects Detector System and Factory type. \n";
	optMap["DF"].help += "      Example:\n";
	optMap["DF"].help += "        -DF=\"CTOF, MYSQL\"  selects the MYSQL factory for the detector CTOF\n";
	optMap["DF"].name  = "Detector System and Factory type.";
	optMap["DF"].type  = 1;
	optMap["DF"].ctgr  = "general";
	
 	optMap["DC_MSTAG_R3"].arg  = 0.0;
	optMap["DC_MSTAG_R3"].help = "Mini Stagger for Region 3. Each layer will alternate +- |this value|";
	optMap["DC_MSTAG_R3"].name = "Mini Stagger for Region 3. Each layer will alternate +- |this value|";
	optMap["DC_MSTAG_R3"].type = 0;
	optMap["DC_MSTAG_R3"].ctgr = "general";
	
	optMap["DC_MSTAG_R2"].arg  = 0.0;
	optMap["DC_MSTAG_R2"].help = "Mini Stagger for Region 2. Each layer will alternate +- |this value|";
	optMap["DC_MSTAG_R2"].name = "Mini Stagger for Region 2. Each layer will alternate +- |this value|";
	optMap["DC_MSTAG_R2"].type = 0;
	optMap["DC_MSTAG_R2"].ctgr = "general";
	
}


