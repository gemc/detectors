use strict;
use warnings;

our %configuration;


sub build_ledadapter
{
	my %detector = init_det();
	$detector{"name"}        = "ledadapter";
	$detector{"mother"}      = "root";
	$detector{"description"} = "LED Adapter";
	$detector{"color"}       = "557777";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 400*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 3*counts 19.0999*mm 19.0999*mm 19.0999*mm 25.0499*mm 25.0499*mm 19.4874*mm 2589.89*mm 2616.71*mm 2617.89*mm";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

