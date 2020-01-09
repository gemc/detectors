use strict;
use warnings;

our %configuration;


sub build_flange
{
	my %detector = init_det();
	$detector{"name"}        = "flange";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Flange";
	$detector{"color"}       = "119911";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 400*mm 2250.11*mm";
	$detector{"dimensions"}  = "85.03*mm 87.37*mm 26*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

