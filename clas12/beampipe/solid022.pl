use strict;
use warnings;

our %configuration;


sub build_solid022
{
	my %detector = init_det();
	$detector{"name"}        = "solid022";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Solid022 minus face 2";
	$detector{"color"}       = "779999";
	$detector{"type"}        = "Sphere";
	$detector{"pos"}         = "0*mm 0*mm 1067.21*mm";
	$detector{"dimensions"}  = "39.6*mm 50*mm 0*deg 360*deg 90*deg 70*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);
}

sub build_solid022_1
{
	my %detector = init_det();
	$detector{"name"}        = "solid022_1";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Solid022 face 7";
	$detector{"color"}       = "779999";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 4*counts 12.85*mm 12.85*mm 17.10*mm 26.31*mm 20.181*mm 21.7109*mm 21.7109*mm 26.31*mm 1017.27*mm 1020*mm 1020*mm 1024*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub build_solid022_2
{
	my %detector = init_det();
	$detector{"name"}        = "solid022_2";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Solid022 face 7 inside";
	$detector{"color"}       = "779999";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 12.85*mm 12.85*mm 17.0*mm 13.54*mm 1020.23*mm 1029.75*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}
