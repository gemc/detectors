use strict;
use warnings;

our %configuration;

sub build_solid020
{
	my %detector = init_det();
	$detector{"name"}        = "solid020";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Solid020";
	$detector{"color"}       = "557777";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 400*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 9*counts 44.5001*mm 44.5001*mm 44.5001*mm 43.001*mm 60.3552*mm 61.2885*mm 62.867*mm 64.097*mm 64.097*mm 45.4971*mm 47.5761*mm 48.8206*mm 48.8206*mm 67.2017*mm 68.0602*mm 69.7701*mm 69.7701*mm 69.7701*mm 2094.41*mm 2102.6*mm 2106.42*mm 2106.42*mm 2162.82*mm 2165.85*mm 2173.46*mm 2184.53*mm 2192.84*mm";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

}

