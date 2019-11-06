use strict;
use warnings;

our %configuration;


sub build_flangetube
{
	my %detector = init_det();
	$detector{"name"}        = "flangetube";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Flangetube";
	$detector{"color"}       = "777777";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 9*counts 98.4*mm 98.4*mm 98.4*mm 98.4*mm 98.4*mm 123.2*mm 124*mm 124*mm 124*mm 101.6*mm 101.6*mm 151.499*mm 152.4*mm 152.4*mm 152.4*mm 152.4*mm 152.4*mm 151.499*mm 2206.53*mm 2591.03*mm 2591.03*mm 2591.93*mm 2604.93*mm 2604.93*mm 2607.93*mm 2608.13*mm 2609.03*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);
}

