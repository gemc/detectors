use strict;
use warnings;

our %configuration;


sub build_flangespacer
{
	my %detector = init_det();
	$detector{"name"}        = "flangespacer";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Flange Spacer";
	$detector{"color"}       = "ee3344";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 6*counts 118.5*mm 118.5*mm 118.5*mm 118.5*mm 123.5*mm 123.5*mm 123.5*mm 123.5*mm 152.5*mm 152.5*mm 152.5*mm 152.5*mm 2609.08*mm 2609.08*mm 2609.08*mm 2644.61*mm 2644.61*mm 2648.71*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);
}

