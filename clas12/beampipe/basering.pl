use strict;
use warnings;

our %configuration;

sub build_basering
{
	my %detector = init_det();
	$detector{"name"}        = "basering";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Base Ring";
	$detector{"color"}       = "335555";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 11*counts 22.6297*mm 22.6297*mm 22.6297*mm 22.6297*mm 22.6297*mm 22.6297*mm 7.75*mm 7.75*mm 8.8*mm 8.8*mm 8.8*mm 25.25*mm 25.25*mm 25.15*mm 25.15*mm 25.25*mm 25.25*mm 29.25*mm 29.25*mm 29.25*mm 29.25*mm 10.3049*mm 1366.11*mm 1367.11*mm 1367.11*mm 1371.11*mm 1371.11*mm 1376.98*mm 1376.98*mm 1388.51*mm 1388.51*mm 1389.26*mm 1389.51*mm";
	$detector{"material"}    = "G10";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

}

sub build_basering2
{
	my %detector = init_det();
	$detector{"name"}        = "basering2";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Base Ring inner tube";
	$detector{"color"}       = "335555";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 7.75*mm 7.75*mm 8.70966*mm 8.70966*mm 1366.11*mm 1376.98*mm";
	$detector{"material"}    = "G10";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

}
