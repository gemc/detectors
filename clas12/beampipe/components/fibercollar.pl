use strict;
use warnings;

our %configuration;


sub build_forwardretainingring
{
	my %detector = init_det();
	$detector{"name"}        = "forwardretainingring";
	$detector{"mother"}      = "root";
	$detector{"description"} = "forwardretainingring";
	$detector{"color"}       = "557777";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 6.27451*mm 7.91238*mm 12*mm 12*mm 1391.23*mm 1395.73*mm";
	$detector{"material"}    = "G10";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub build_fibercollar
{
	my %detector = init_det();
	$detector{"name"}        = "fibercollar";
	$detector{"mother"}      = "root";
	$detector{"description"} = "fibercollar";
	$detector{"color"}       = "557777";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 6.00001*mm 6.00001*mm 12*mm 12*mm 1395.73*mm 1400.73*mm";
	$detector{"material"}    = "G10";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

