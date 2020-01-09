use strict;
use warnings;

our %configuration;

sub build_basecone
{
	my %detector = init_det();
	$detector{"name"}        = "basecone";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Base cone";
	$detector{"color"}       = "eecc55";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 400*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 9*counts 11.822*mm 11.822*mm 11.6603*mm 11.6603*mm 22.6297*mm 22.6297*mm 22.6297*mm 25.25*mm 25.25*mm 11.822*mm 13.272*mm 13.272*mm 14.098*mm 25.070*mm 26.75*mm 26.75*mm 26.75*mm 26.75*mm 1340.84*mm 1342.91*mm 1342.91*mm 1344.09*mm 1359.76*mm 1362.16*mm 1366.11*mm 1366.11*mm 1372.11*mm";
	$detector{"material"}    = "G10";
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);

}

sub build_cellwall
{
	my %detector = init_det();
	$detector{"name"}        = "cellwall";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Cell wall";
	$detector{"color"}       = "ee3344";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 400*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 7.49154*mm 11.7216*mm 7.54193*mm 11.7718*mm 1280.68*mm 1342.91*mm";
	$detector{"material"}    = "G4_KAPTON";
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);

}

sub build_cellendcap
{
	my %detector = init_det();
	$detector{"name"}        = "cellendcap";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Cell end cap";
	$detector{"color"}       = "ee3344";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 400*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 5*counts 5*mm 5*mm 7.4942*mm 7.59083*mm 7.86904*mm 5*mm 5.29445*mm 7.71148*mm 7.71575*mm 7.99374*mm 1279.1*mm 1279.24*mm 1280.62*mm 1280.68*mm 1284.68*mm";
	$detector{"material"}    = "G4_KAPTON";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

}
