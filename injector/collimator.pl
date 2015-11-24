#!/usr/bin/perl -w

use strict;
use warnings;

our %configuration;
our %parameters;

my $inches = 2.54;


# still need to define pipe position in respect to center

my $collimatorRadiatorGap = 0.3;
my $collimatorLength      = 3*$inches;  # this is semilength
my $collimatorIR          = 0.5;        # this is Inner Radius
my $collimatorOR          = 3*$inches;  # this is Outer Radius


sub makeCollimator()
{

	my $zpos = $collimatorLength + $collimatorRadiatorGap;
	
	my %detector = init_det();
	$detector{"name"}        = "collimator";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Bubble Collimator";
	$detector{"color"}       = "ffff44";
	$detector{"pos"}         = "0*cm 0*cm $zpos*cm";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$collimatorIR*cm $collimatorOR*cm $collimatorLength*cm 0*deg 360*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);



}
