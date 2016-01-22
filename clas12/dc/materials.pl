use strict;
use warnings;

our %configuration;


sub materials
{
	# uploading the mat definition
	
	# Scintillator
	my %mat = init_mat();
	$mat{"name"}          = "dcgas";
	$mat{"description"}   = "clas12 dc gas";
	$mat{"density"}       = "0.0018";
	$mat{"ncomponents"}   = "3";
	$mat{"components"}    = "G4_Ar 0.9 G4_O 0.066 G4_C 0.034";
	print_mat(\%configuration, \%mat);
	
}


