use strict;
use warnings;

our %configuration;


sub build_cnd_muonshield
{
	my %detector = init_det();
	$detector{"name"}        = "cnd_muonshield";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Muon Shield";
	$detector{"color"}       = "555555";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 4*counts 29*mm 39*mm 39*mm 29*mm 30*mm 40*mm 40*mm 30*mm 0*mm 10*mm 12*mm 22*mm";
	$detector{"material"}    = "G4_LEAD";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

