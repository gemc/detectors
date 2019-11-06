use strict;
use warnings;

our %configuration;


sub build_distributiontube003_1
{
	my %detector = init_det();
	$detector{"name"}        = "distributiontube003_1";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Distribution tube 003";
	$detector{"color"}       = "223333";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"rotation"}    = "0.62*deg -0.36*deg 0*deg";
	$detector{"dimensions"}  = "0*deg 360*deg 2 4.049*mm 4.049*mm 4.762*mm 4.762*mm 1377.05*mm 2115.9*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub build_distributiontube003_2
{
	my %detector = init_det();
	$detector{"name"}        = "distributiontube003_2";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Distribution tube 003";
	$detector{"color"}       = "223333";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "-355*mm 212*mm 129*mm";
	$detector{"rotation"}    = "17*deg -10*deg 0*deg";
	$detector{"dimensions"}  = "0*deg 360*deg 2 4.049*mm 4.049*mm 4.762*mm 4.762*mm 2123.81*mm 2169.74*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub build_distributiontube003_3
{
	my %detector = init_det();
	$detector{"name"}        = "distributiontube003_3";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Distribution Tube 003 and Cell Adapter 003";
	$detector{"color"}       = "223333";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "23*mm 840*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "0*deg 360*deg 11 4.049*mm 4.049*mm 4.049*mm 4.049*mm 4.049*mm 4*mm 4*mm 4*mm 4*mm 4*mm 4*mm 4.762*mm 4.762*mm 6*mm 8*mm 8*mm 7*mm 7*mm 9*mm 9*mm 5*mm 5*mm 2177.95*mm 2190.76*mm 2232.29*mm 2232.29*mm 2238.04*mm 2238.04*mm 2239.69*mm 2239.69*mm 2250.74*mm 2250.74*mm 2259.19*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}
