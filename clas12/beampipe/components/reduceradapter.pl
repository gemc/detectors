use strict;
use warnings;

our %configuration;

sub build_reduceradapter
{
	my %detector = init_det();
	$detector{"name"}        = "reduceradapter";
	$detector{"mother"}      = "root";
	$detector{"description"} = "reducer adaptor";
	$detector{"color"}       = "335555";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 400*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 3*counts 71*mm 75*mm 75*mm 71.4*mm 76*mm 76*mm 2180.11*mm 2184.88*mm 2236.11*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

}

