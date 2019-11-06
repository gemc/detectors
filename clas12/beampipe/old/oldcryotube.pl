use strict;
use warnings;

our %configuration;


sub build_cryotube
{
	my %detector = init_det();
	$detector{"name"}        = "cryotube";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Cryotube";
	$detector{"color"}       = "339999";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm 3498.7*mm";
	$detector{"dimensions"}  = "123*mm 127*mm 831*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

