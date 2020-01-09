use strict;
use warnings;

our %configuration;


sub build_solid012
{
	my %detector = init_det();
	$detector{"name"}        = "solid012";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Solid012";
	$detector{"color"}       = "dd5511";
	$detector{"visible"}     = 1;
	$detector{"type"}        = "Sphere";
	$detector{"pos"}         = "0*mm 400*mm 1303.27*mm";
	$detector{"dimensions"}  = "0*mm 1.5*mm 0*deg 360*deg 0*deg 180*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

