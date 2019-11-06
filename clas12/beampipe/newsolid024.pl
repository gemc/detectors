use strict;
use warnings;

our %configuration;


sub build_solid024
{
	my %detector = init_det();
	$detector{"name"}        = "solid024";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Solid 024";
	$detector{"color"}       = "aaaaaa";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 400*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 8*counts 72*mm 72*mm 80.8926*mm 80.8926*mm 80.8926*mm 80.8926*mm 80.8926*mm 80.8926*mm 85*mm 85*mm 85*mm 85*mm 107.5*mm 107.5*mm 103.5*mm 103.5*mm 2238.61*mm 2248.61*mm 2248.61*mm 2638.61*mm 2638.61*mm 2644.61*mm 2644.61*mm 2648.61*mm";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

