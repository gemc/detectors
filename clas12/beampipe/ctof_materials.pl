use strict;
use warnings;

our %configuration;

sub materials
{	
	# Scintillator
	my %mat = init_mat();
	$mat{"name"}          = "scintillator";
	$mat{"description"}   = "ctof scintillator material";
	$mat{"density"}       = "1.032";
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "C 9 H 10";	
	print_mat(\%configuration, \%mat);

	# Hiperm-49
	my %mat = init_mat();
	$mat{"name"}          = "hiperm49";
	$mat{"description"}   = "pmt shield material";
	$mat{"density"}       = "18.4";  # 0.295 lb/in3 ~ 18.4375 g/cm3
	$mat{"ncomponents"}   = "5"; # OLD "7";
	$mat{"components"}    = "G4_Ni 0.48 G4_Mg 0.005 G4_Si 0.0035 G4_C 0.0002 G4_Fe 0.5113";
	# OLD $mat{"components"}    = "G4_Ni 0.48 G4_P 0.0002 G4_Si 0.005 G4_Mn 0.008 G4_C 0.00035 G4_S 0.00008 G4_Fe 0.50637";
	print_mat(\%configuration, \%mat);

	# CO-NETIC
	my %mat = init_mat();
	$mat{"name"}          = "conetic";
	$mat{"description"}   = "pmt shield material";
	$mat{"density"}       = "8.7";  # 0.316 lb/in3 ~ 18.4375 g/cm3
	$mat{"ncomponents"}   = "6";
	$mat{"components"}    = "G4_Ni 0.806 G4_Fe 0.14 G4_Mo 0.0449 G4_Si 0.004 G4_Mn 0.005 G4_C 0.0001";
	print_mat(\%configuration, \%mat);
	
}


