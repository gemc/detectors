#!/usr/bin/perl -w

use strict;
use warnings;

our %configuration;
our %parameters;

my $inches = 2.54;

my $collimatorRadiatorGap = 1.5;
my $collimatorLength      = 6.0/2.0*$inches;   # this is semilength
my $collimatorIR          = 0.315/2.0*$inches; # this is Inner Radius
my $collimatorOR          = 4.0/2.0*$inches;   # this is Outer Radius


sub makeCollimator()
{
    
    my $zpos = $collimatorLength + $collimatorRadiatorGap; # From front of radiator
    
    my %detector = init_det();
    $detector{"name"}        = "collimator";
    $detector{"mother"}      = "root";
    $detector{"description"} = "Bubble Collimator";
    $detector{"color"}       = "ffcc44";
    $detector{"pos"}         = "0*cm 0*cm $zpos*cm";
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "$collimatorIR*cm $collimatorOR*cm $collimatorLength*cm 0*deg 360*deg";
    $detector{"material"}    = "G4_Cu";
    $detector{"style"}       = 1;
 
    print_det(\%configuration, \%detector);    
 
}
