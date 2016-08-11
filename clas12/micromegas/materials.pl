use strict;
use warnings;
use materials;

our %configuration;


sub materials
{
	my %mat = init_mat();
	$mat{"name"}          = "myEpoxy";
	$mat{"description"}   = "micromegas epoxy";
	$mat{"density"}       = "1.16";
	$mat{"ncomponents"}   = "4";
	$mat{"components"}    = "C 15 H 32 N 2 O 4"; #not sure about the formula... old...
	print_mat(\%configuration, \%mat);

	%mat = init_mat();
	my $fmtMMStripTransparency_Density = (400./525.)*8.96; # for fmt
	$mat{"name"}          = "myfmtMMStrips";
	$mat{"description"}   = "micromegas fmt strips are copper";
	$mat{"density"}       = "$fmtMMStripTransparency_Density";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_Cu 1";
	print_mat(\%configuration, \%mat);
	
	%mat = init_mat();
	my $bmtz4MMStripTransparency_Density = (1-10*64*0.201/311.881)*8.96; # for bmt Z4 (311.881 from computation with pitches)
	$mat{"name"}          = "mybmtz4MMStrips";
	$mat{"description"}   = "micromegas bmt Z4 strips are copper";
	$mat{"density"}       = "$bmtz4MMStripTransparency_Density";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_Cu 1";
	print_mat(\%configuration, \%mat);
	
	%mat = init_mat();
	my $bmtz5MMStripTransparency_Density = (1-11*64*0.201/345)*8.96; # for bmt Z5 #no existing value, value guess
	$mat{"name"}          = "mybmtz5MMStrips";
	$mat{"description"}   = "micromegas bmt Z5 strips are copper";
	$mat{"density"}       = "$bmtz5MMStripTransparency_Density";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_Cu 1";
	print_mat(\%configuration, \%mat);
	
	%mat = init_mat();
	my $bmtz6MMStripTransparency_Density = (1-12*64*0.201/403.968)*8.96; # for bmt Z6 # 12*64*(0.201+0.325) = 403.968 from computation with pitches instead of 407.16 (geometry)
	$mat{"name"}          = "mybmtz6MMStrips";
	$mat{"description"}   = "micromegas bmt Z6 strips are copper";
	$mat{"density"}       = "$bmtz6MMStripTransparency_Density";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_Cu 1";
	print_mat(\%configuration, \%mat);
	
	%mat = init_mat();
	my $bmtc4MMStripTransparency_Density = (1-14*64*0.16/372.75)*8.96; # for bmt C4 (372.75 from geometry)
	$mat{"name"}          = "mybmtc4MMStrips";
	$mat{"description"}   = "micromegas bmt C4 strips are copper";
	$mat{"density"}       = "$bmtc4MMStripTransparency_Density";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_Cu 1";
	print_mat(\%configuration, \%mat);
	
	%mat = init_mat();
	my $bmtc5MMStripTransparency_Density = (1-16*64*0.16/423.99)*8.96; # for bmt C5  (423.99 from geometry)
	$mat{"name"}          = "mybmtc5MMStrips";
	$mat{"description"}   = "micromegas bmt C5 strips are copper";
	$mat{"density"}       = "$bmtc5MMStripTransparency_Density";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_Cu 1";
	print_mat(\%configuration, \%mat);
	
	%mat = init_mat();
	my $bmtc6MMStripTransparency_Density = (1-18*64*0.16/444.96)*8.96; # for bmt C6  (444.96 from geometry)
	$mat{"name"}          = "mybmtc6MMStrips";
	$mat{"description"}   = "micromegas bmt C6 strips are copper";
	$mat{"density"}       = "$bmtc6MMStripTransparency_Density";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_Cu 1";
	print_mat(\%configuration, \%mat);
	
	%mat = init_mat();
	$mat{"name"}          = "myCopper";
	$mat{"description"}   = "copper";
	$mat{"density"}       = "8.96";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_Cu 1";
	print_mat(\%configuration, \%mat);

	# PC Board
	#%mat = init_mat();
	#$mat{"name"}          = "pcBoardMaterial"; #old, not FR4, don't know what it is actually
	#$mat{"description"}   = "bst pc board material";
	#$mat{"density"}       = "1.860";
	#$mat{"ncomponents"}   = "3";
	#$mat{"components"}    = "G4_Fe 0.3 G4_C 0.4 G4_Si 0.3";
	#print_mat(\%configuration, \%mat);

	# Peek chemical formula (C19 H12 O3)
	%mat = init_mat();
	$mat{"name"}          = "myPeek"; # old data, should check formula and density, to be safe...
	$mat{"description"}   = "peek";
	$mat{"density"}       = "1.31";
	$mat{"ncomponents"}   = "3";
	$mat{"components"}    = "C 19 H 12 O 3";
	print_mat(\%configuration, \%mat);
	
	%mat = init_mat();
	$mat{"name"}          = "myAlu";
	$mat{"description"}   = "Aluminium";
	$mat{"density"}       = "2.699";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_Al 1";
	print_mat(\%configuration, \%mat);
	
	
	%mat = init_mat();
	$mat{"name"}          = "mybmtMMGas"; # found in gemc materials database
	$mat{"description"}   = "micromegas bmt argon isobutan gas";
	$mat{"density"}       = "1.70335";
	$mat{"ncomponents"}   = "3";
#	$mat{"components"}    = "G4_Ar 0.95 G4_H 0.0086707 G4_C 0.0413293";
	$mat{"components"}    = "G4_Ar 0.90 G4_H 0.0173414 G4_C 0.0826586";
	print_mat(\%configuration, \%mat);
	
	%mat = init_mat();
	$mat{"name"}          = "myfmtMMGas"; # found in gemc materials database
	$mat{"description"}   = "micromegas fmt neon ethan CF4 gas";
	$mat{"density"}       = "1.17";
	$mat{"ncomponents"}   = "4";
	$mat{"components"}    = "G4_Ne 0.79 G4_H 0.022121 G4_C 0.101529 G4_F 0.08635";
	print_mat(\%configuration, \%mat);

	%mat = init_mat();
	my $fmtMMMeshTransparency_Density = 0.490*7.93; #(45*45)/(45+18)*(45+18) = 0.51
	$mat{"name"}          = "myfmtMMMesh"; # found in gemc materials database. Shouldn't have changed since then thought, I guess...
	$mat{"description"}   = "micromegas fmt micromesh is inox";
	$mat{"density"}       = "$fmtMMMeshTransparency_Density";
	$mat{"ncomponents"}   = "5";
	$mat{"components"}    = "G4_Mn 0.02 G4_Si 0.01 G4_Cr 0.19 G4_Ni 0.10 G4_Fe 0.68";
	print_mat(\%configuration, \%mat);

	%mat = init_mat();
	my $bmtMMMeshTransparency_Density = 0.408*7.93; #Sebastien had 0.395... don't know how or why ? (60*60)/(60+18)*(60+18) = 0.592
	$mat{"name"}          = "mybmtMMMesh"; # found in gemc materials database. Shouldn't have changed since then thought, I guess...
	$mat{"description"}   = "micromegas bmt micromesh is inox";
	$mat{"density"}       = "$bmtMMMeshTransparency_Density";
	$mat{"ncomponents"}   = "5";
	$mat{"components"}    = "G4_Mn 0.02 G4_Si 0.01 G4_Cr 0.19 G4_Ni 0.10 G4_Fe 0.68";
	print_mat(\%configuration, \%mat);

	#%mat = init_mat();
	#$mat{"name"}          = "myMMMylar"; # found in gemc materials database, not used anymore
	#$mat{"description"}   = "Mylar";
	#$mat{"density"}       = "1.40";
	#$mat{"ncomponents"}   = "3";
	#$mat{"components"}    = "G4_H 0.041958 G4_C 0.625017 G4_O 0.333025";
	#print_mat(\%configuration, \%mat);

	%mat = init_mat();
	$mat{"name"}          = "myKapton"; # found in gemc materials database.
	$mat{"description"}   = "Kapton";
	$mat{"density"}       = "1.42";
	$mat{"ncomponents"}   = "4";
	$mat{"components"}    = "G4_H 0.026362 G4_C 0.691133 G4_N 0.073270 G4_O 0.209235";
	print_mat(\%configuration, \%mat);

	%mat = init_mat();
	$mat{"name"}          = "myRohacell"; # found in gemc materials database as rohacell31... not sure if it is the good model
	$mat{"description"}   = "Rohacell";
	$mat{"density"}       = "0.032";
	$mat{"ncomponents"}   = "4";
	$mat{"components"}    = "G4_C 0.6463 G4_H 0.0784 G4_N 0.0839 G4_O 0.1914";
	print_mat(\%configuration, \%mat);
	
	%mat = init_mat();
	my $fmtResistPasteTransparency_Density = (325./525.)*2.0; # for fmt
	$mat{"name"}          = "myfmtResistPaste"; # assumed it was carbon. Don't know the formula yet. Has to be checked and eventually, changed
	$mat{"description"}   = "micromegas fmt resistiv strips";
	$mat{"density"}       = "$fmtResistPasteTransparency_Density";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_C 1";
	print_mat(\%configuration, \%mat);
	
	%mat = init_mat();
	my $bmtz4ResistPasteTransparency_Density = (1-10*64*0.201/311.881)*2.0; # for bmt Z4 (311.881 from computation with pitches)
	$mat{"name"}          = "mybmtz4ResistPaste"; # assumed it was carbon. Don't know the formula yet. Has to be checked and eventually, changed
	$mat{"description"}   = "micromegas bmt Z4 resistiv strips";
	$mat{"density"}       = "$bmtz4ResistPasteTransparency_Density";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_C 1";
	print_mat(\%configuration, \%mat);
	
	%mat = init_mat();
	my $bmtz5ResistPasteTransparency_Density = (1-11*64*0.201/345)*2.0; # for bmt Z5 #no existing value, value guess
	$mat{"name"}          = "mybmtz5ResistPaste"; # assumed it was carbon. Don't know the formula yet. Has to be checked and eventually, changed
	$mat{"description"}   = "micromegas bmt Z5 resistiv strips";
	$mat{"density"}       = "$bmtz5ResistPasteTransparency_Density";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_C 1";
	print_mat(\%configuration, \%mat);
	
	%mat = init_mat();
	my $bmtz6ResistPasteTransparency_Density = (1-12*64*0.201/403.968)*2.0; # for bmt Z6 # 12*64*(0.201+0.325) = 403.968 from computation with pitches instead of 407.16 (geometry)
	$mat{"name"}          = "mybmtz6ResistPaste"; # assumed it was carbon. Don't know the formula yet. Has to be checked and eventually, changed
	$mat{"description"}   = "micromegas bmt Z6 resistiv strips";
	$mat{"density"}       = "$bmtz6ResistPasteTransparency_Density";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_C 1";
	print_mat(\%configuration, \%mat);
	
	%mat = init_mat();
	my $bmtc4ResistPasteTransparency_Density = (1-14*64*0.16/372.75)*2.0; # for bmt C4 (372.75 from geometry)
	$mat{"name"}          = "mybmtc4ResistPaste"; # assumed it was carbon. Don't know the formula yet. Has to be checked and eventually, changed
	$mat{"description"}   = "micromegas bmt C4 resistiv strips";
	$mat{"density"}       = "$bmtc4ResistPasteTransparency_Density";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_C 1";
	print_mat(\%configuration, \%mat);
	
	%mat = init_mat();
	my $bmtc5ResistPasteTransparency_Density = (1-16*64*0.16/423.99)*2.0; # for bmt C5  (423.99 from geometry)
	$mat{"name"}          = "mybmtc5ResistPaste"; # assumed it was carbon. Don't know the formula yet. Has to be checked and eventually, changed
	$mat{"description"}   = "micromegas bmt C5 resistiv strips";
	$mat{"density"}       = "$bmtc5ResistPasteTransparency_Density";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_C 1";
	print_mat(\%configuration, \%mat);
	
	%mat = init_mat();
	my $bmtc6ResistPasteTransparency_Density = (1-18*64*0.16/444.96)*2.0; # for bmt C6  (444.96 from geometry)
	$mat{"name"}          = "mybmtc6ResistPaste"; # assumed it was carbon. Don't know the formula yet. Has to be checked and eventually, changed
	$mat{"description"}   = "micromegas bmt C6 resistiv strips";
	$mat{"density"}       = "$bmtc6ResistPasteTransparency_Density";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_C 1";
	print_mat(\%configuration, \%mat);
	
	%mat = init_mat();
	$mat{"name"}          = "myFR4"; # found in geant4 materials database here : http://www.phenix.bnl.gov/~suhanov/ncc/geant/rad-source/src/ExN03DetectorConstruction.cc
	$mat{"description"}   = "pcb FR4";
	$mat{"density"}       = "1.86";
	$mat{"ncomponents"}   = "4";
	$mat{"components"}    = "G4_C 0.4355 G4_H 0.03654 G4_Si 0.2468 G4_O 0.28116"; # not sure about it
	print_mat(\%configuration, \%mat);
	
	#data unknown
	#%mat = init_mat();
	#$mat{"name"}          = "myGlue";
	#$mat{"description"}   = "Glue";
	#$mat{"density"}       = "1";
	#$mat{"ncomponents"}   = "1";
	#$mat{"components"}    = "G4_C 1";
	#print_mat(\%configuration, \%mat);

}

