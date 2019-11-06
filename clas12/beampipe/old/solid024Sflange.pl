use strict;
use warnings;

our %configuration;


sub build_solid024Sflange
{
	my %detector = init_det();
	$detector{"name"}        = "solid024Sflange";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Solid024 small flange";
	$detector{"color"}       = "557777";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 400*mm 2646.61*mm";
	$detector{"dimensions"}  = "80.6164*mm 103.5*mm 2*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

