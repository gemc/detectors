use strict;
use warnings;

our %configuration;


sub build_centraltracker
{
	my %detector = init_det();
	$detector{"name"}        = "centraltracker";
	$detector{"mother"}      = "root";
	$detector{"description"} = "CLAS12 Central Tracker";
	$detector{"color"}       = "339999";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 49.2*mm 49.2*mm 50.8*mm 50.8*mm 1409.33*mm 2058.92*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

