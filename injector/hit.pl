#!/usr/bin/perl -w

use strict;
#use lib ("$ENV{GEMC}/api/perl");
use lib ("$ENV{GEMC}/io");
use utils;
use hit;

use strict;
use warnings;

# Help Message
sub help()
{
    print "\n Usage: \n";
    print "   hit.pl  <configuration filename>\n";
    print "   Will create the bubble hit definition\n";
    print "   Note: The passport and .visa files must be present to connect to MYSQL. \n\n";
    exit;
}

# Make sure the argument list is correct
# If not pring the help
if( scalar @ARGV != 1)
{
    help();
    exit;
}

# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);

# One can change the "variation" here if one is desired different from the config.dat
# $configuration{"variation"} = "myvar";

sub define_hit
{
    # uploading the hit definition
    my %hit = init_hit();
    $hit{"name"}            = "bubble";
    $hit{"description"}     = "bubble hit definitions";
    $hit{"identifiers"}     = "detId";
    $hit{"signalThreshold"} = "0.1*KeV";
    $hit{"timeWindow"}      = "0*ns";
    $hit{"prodThreshold"}   = "1*mm";
    $hit{"maxStep"}         = "1*cm";
    $hit{"delay"}           = "50*ns";
    $hit{"riseTime"}        = "5*ns";
    $hit{"fallTime"}        = "8*ns";
    $hit{"mvToMeV"}         = 100;
    $hit{"pedestal"}        = -20;
    print_hit(\%configuration, \%hit);
}

# timeWindow: 0 means “every track”. Anything other than 0 will integrate over time window to define a hit
# prodThreshold: this is minimum distance that secondaries have to travel in order to be created
# maxStep: max step of particles

define_hit();

1;
