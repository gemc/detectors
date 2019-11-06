use strict;
use warnings;

our %configuration;


sub build_basetube
{
	my %detector = init_det();
	$detector{"name"}        = "basetube";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Basetube";
	$detector{"color"}       = "557777";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 11*counts 7.6152*mm 5*mm 5*mm 6.025*mm 6.025*mm 6.025*mm 6.025*mm 6.025*mm 6.025*mm 6.025*mm 6.025*mm 7.75*mm 7.75*mm 7.75*mm 7.75*mm 7.75*mm 7.65*mm 7.65*mm 7.75*mm 7.75*mm 8.75*mm 8.75*mm 1325.85*mm 1327.32*mm 1327.91*mm 1327.91*mm 1368.11*mm 1368.11*mm 1387.51*mm 1387.51*mm 1388.51*mm 1388.51*mm 1389.51*mm";
	$detector{"material"}    = "G4_KAPTON";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub build_quartzglasstube
{
	my %detector = init_det();
	$detector{"name"}        = "quartzglasstube";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Quartz Glass Tube";
	$detector{"color"}       = "999999";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 6*counts 5*mm 5*mm 5.0116*mm 5.0711*mm 5.21108*mm 6.8482*mm 6*mm 6*mm 6*mm 6.09046*mm 6.27450*mm 7.91237*mm 1349.75*mm 1390.03*mm 1390.21*mm 1390.72*mm 1391.23*mm 1395.73*mm";
	$detector{"material"}    = "G4_SILICON_DIOXIDE";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

