#!/usr/bin/perl -w

use strict;
use warnings;

our %configuration;
our %parameters;

sub define_hit
{
    # uploading the hit definition
    my %hit = init_hit();
    $hit{"name"}            = "eic_compton";
    $hit{"description"}     = "Compton Region Detector and Chicane";
    $hit{"identifiers"}     = "id";
    $hit{"signalThreshold"} = "0.*MeV";
    $hit{"timeWindow"}      = "0*ns";
    $hit{"prodThreshold"}   = "1*mm";
    $hit{"maxStep"}         = "1*mm";
    $hit{"delay"}           = "10*ns";
    $hit{"riseTime"}        = "1*ns";
    $hit{"fallTime"}        = "1*ns";
    $hit{"mvToMeV"}         = 100;
    $hit{"pedestal"}        = -20;
    print_hit(\%configuration, \%hit);
}
define_hit();
