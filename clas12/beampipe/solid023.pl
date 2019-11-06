use strict;
use warnings;

our %configuration;


sub build_solid023
{
	my %detector = init_det();
	$detector{"name"}        = "solid023";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Solid023, Solid021, Solid022 face 2";
	$detector{"color"}       = "eecccc";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 5*counts 39.6*mm 39.6*mm 39.6*mm 39.6*mm 43.1932*mm 50*mm 50*mm 49.11*mm 49.11*mm 49.11*mm 1067.21*mm 1409.31*mm 1409.31*mm 1413.67*mm 1419.71*mm";
	$detector{"material"}    = "rohacell";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

