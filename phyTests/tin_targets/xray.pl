#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use hit;
use bank;
use math;
use materials;

use Math::Trig;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   xray.pl <configuration filename>\n";
 	print "   Will create the pi- absorbtion test geometry using the variation specified in the configuration file\n";
	exit;
}

# Make sure the argument list is correct
if( scalar @ARGV != 1) 
{
	help();
	exit;
}


# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);


# Loading geo routines
require "./geometry.pl";




# all the scripts must be run for every configuration
my @allConfs = ("1microns", "10microns", "20microns", "100microns", "180microns", "360microns");


foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;
    make_test_geo();
}

