use strict;
use warnings;

our %configuration;


sub build_flangetube
{
	my %detector = init_det();
	$detector{"name"}        = "flangetube";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Flangetube";
	$detector{"color"}       = "339999";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm 2395.91*mm";
	$detector{"dimensions"}  = "96*mm 101*mm 196*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

