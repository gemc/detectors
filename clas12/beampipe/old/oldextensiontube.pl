use strict;
use warnings;

our %configuration;


sub build_extensiontube
{
	my %detector = init_det();
	$detector{"name"}        = "extensiontube";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Extension Tube, Solid023, Solid021, Solid022 face 2";
	$detector{"color"}       = "339999";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm 1559.245*mm";
	$detector{"dimensions"}  = "49.2*mm 50.8*mm 492.035*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

