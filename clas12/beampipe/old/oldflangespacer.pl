use strict;
use warnings;

our %configuration;


sub build_flangespacer
{
	my %detector = init_det();
	$detector{"name"}        = "flangespacer";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Flange Spacer";
	$detector{"color"}       = "339999";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm 2629.845*mm";
	$detector{"dimensions"}  = "123*mm 152*mm 38*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

