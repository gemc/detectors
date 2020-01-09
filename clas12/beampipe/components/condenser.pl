use strict;
use warnings;

our %configuration;

sub build_condenser
{
	my %detector = init_det();
	$detector{"name"}        = "condenser";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Condenser";
	$detector{"color"}       = "aa4400";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 4*counts 34.8806*mm 34.8806*mm 34.8806*mm 35.8771*mm 67.9999*mm 69.8815*mm 69.8815*mm 68.9999*mm 2259.19*mm 2261.19*mm 2340.19*mm 2341.19*mm";
	$detector{"material"}    = "G4_Cu";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

}

