#!/usr/bin/perl -w

use strict;
use warnings;

our %configuration;
our %parameters;

my $inches = 2.54;

my $dlength = $parameters{"PhotonDumpLength"}/2.0*$inches;
my $dwidth   = $parameters{"PhotonDumpWidth"}/2.0*$inches;
my $dheight   = $parameters{"PhotonDumpHeight"}/2.0*$inches;

sub makePhotonDump()
{
    
    my $zpos = 100.0; # From center of radiator
    
    my %detector = init_det();
    $detector{"name"}        = "PhotonDump";
    $detector{"mother"}      = "root";
    $detector{"description"} = "Bubble Photon Dump";
    $detector{"color"}       = "eeeeFF";
    $detector{"pos"}         = "0*cm 0*cm $zpos*cm";
    $detector{"type"}        = "Box";
    $detector{"dimensions"}  = "$dwidth*cm $dheight*cm $dlength*cm";
    $detector{"material"}    = "G4_Al";
    $detector{"style"}       = 1;
    print_det(\%configuration, \%detector);
    
}
