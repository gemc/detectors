use strict;
use warnings;

our %configuration;


sub build_cryotube
{
	my %detector = init_det();
	$detector{"name"}        = "cryotube";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Cryotube";
	$detector{"color"}       = "777777";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 6*counts 123.825*mm 123.825*mm 123.825*mm 123.825*mm 123.825*mm 123.825*mm 152.4*mm 152.4*mm 127*mm 127*mm 152.4*mm 152.4*mm 2648.71*mm 2667.76*mm 2667.76*mm 4329.69*mm 4329.69*mm 4348.74*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

