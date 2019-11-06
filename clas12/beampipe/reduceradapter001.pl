use strict;
use warnings;

our %configuration;

sub build_reduceradapter001_1
{
	my %detector = init_det();
	$detector{"name"}        = "reduceradapter001_1";
	$detector{"mother"}      = "root";
	$detector{"description"} = "reducer adaptor001_1";
	$detector{"color"}       = "335555";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 4*counts 100.437*mm 100.437*mm 98.2356*mm 98.2356*mm 101.6*mm 101.6*mm 101.6*mm 101.6*mm 2199.89*mm 2203.53*mm 2203.53*mm 2206.53*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

}

sub build_reduceradapter001_2
{
	my %detector = init_det();
	$detector{"name"}        = "reduceradapter001_2";
	$detector{"mother"}      = "root";
	$detector{"description"} = "reducer adaptor001_2";
	$detector{"color"}       = "335555";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 4*counts 95.375*mm 95.375*mm 95.375*mm 95.375*mm 95.375*mm 98.1951*mm 98.2356*mm 98.2356*mm 2194.65*mm 2203.53*mm 2203.53*mm 2218.65*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

}
