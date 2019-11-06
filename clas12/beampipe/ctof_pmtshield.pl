use strict;
use warnings;

our %configuration;


sub build_ctof_pmtshield
{
	my %detector = init_det();
	$detector{"name"}        = "ctof_pmtshield";
	$detector{"mother"}      = "root";
	$detector{"description"} = "PMT Shield";
	$detector{"color"}       = "775555";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 180*deg 10*counts 26*mm 26*mm 47*mm 47.625*mm 47.625*mm 47.625*mm 47.625*mm 47*mm 26*mm 26*mm 26*mm 31.4*mm 53*mm 53*mm 63.9*mm 63.9*mm 53*mm 53*mm 31.4*mm 26*mm 0*mm 5*mm 25*mm 25*mm 145*mm 185*mm 305*mm 305*mm 325*mm 330*mm";
	$detector{"material"}    = "G4_Fe";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub build_ctof_pmtshield2
{
	my %detector = init_det();
	$detector{"name"}        = "ctof_pmtshield2";
	$detector{"mother"}      = "root";
	$detector{"description"} = "PMT Shield";
	$detector{"color"}       = "000099";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 180*deg 6*counts 26*mm 26*mm 39*mm 39*mm 26*mm 26*mm 26*mm 28*mm 42*mm 42*mm 28*mm 26*mm 50*mm 53*mm 70*mm 260*mm 277*mm 280*mm";
	$detector{"material"}    = "hiperm49";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub build_ctof_pmtshield3
{
	my %detector = init_det();
	$detector{"name"}        = "ctof_pmtshield3";
	$detector{"mother"}      = "root";
	$detector{"description"} = "PMT Shield";
	$detector{"color"}       = "000055";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 180*deg 2*counts 27*mm 27*mm 29*mm 29*mm 85*mm 245*mm";
	$detector{"material"}    = "conetic";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub build_ctof_pmtshieldcoil
{
	my %detector = init_det();
	$detector{"name"}        = "ctof_pmtshieldcoil";
	$detector{"mother"}      = "root";
	$detector{"description"} = "PMT Shield";
	$detector{"color"}       = "cc5500";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 180*deg 2*counts 32.4*mm 32.4*mm 32.6*mm 32.6*mm 65*mm 265*mm";
	$detector{"material"}    = "G4_Cu";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}
