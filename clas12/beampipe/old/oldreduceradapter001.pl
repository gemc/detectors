use strict;
use warnings;

our %configuration;

sub build_reduceradapter001
{
	my %detector = init_det();
	$detector{"name"}        = "reduceradapter001";
	$detector{"mother"}      = "root";
	$detector{"description"} = "reducer adaptor001";
	$detector{"color"}       = "335555";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 400*mm 1500*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 6 97*mm 97*mm 97*mm 97*mm 97*mm 95*mm 100*mm 100*mm 102*mm 102*mm 97.1*mm 95.1*mm 0*mm 12.12*mm 12.12*mm 18.76*mm 18.76*mm 24*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

}

