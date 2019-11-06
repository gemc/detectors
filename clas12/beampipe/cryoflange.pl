use strict;
use warnings;

our %configuration;


sub build_cryoflange
{
	my %detector = init_det();
	$detector{"name"}        = "cryoflange";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Flange of Cryotube";
	$detector{"color"}       = "339999";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm 4339.215*mm";
	$detector{"dimensions"}  = "123*mm 152*mm 10*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

