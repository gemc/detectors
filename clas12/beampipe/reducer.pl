use strict;
use warnings;

our %configuration;

sub build_reducer
{
	my %detector = init_det();
	$detector{"name"}        = "reducer";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Reducer";
	$detector{"color"}       = "339999";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 50.8*mm 98.4*mm 50.85*mm 101.6*mm 2051.28*mm 2199.89*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

