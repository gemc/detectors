use strict;
use warnings;

our %configuration;


sub build_solid019
{
	my %detector = init_det();
	$detector{"name"}        = "solid019";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Solid019";
	$detector{"color"}       = "557777";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 400*mm 1760.09*mm";
	$detector{"dimensions"}  = "43*mm 44.5*mm 334*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

