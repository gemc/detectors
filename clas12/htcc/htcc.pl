#!/usr/bin/perl -w

use strict;
use warnings;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use hit;
use bank;
use materials;
use mirrors;
use Math::Trig;

# Help Message
sub help() {
    print "\n Usage: \n";
    print "   htcc.pl <configuration filename>\n";
    print "   Will create the CLAS12 HTCC geometry, materials, bank and hit definitions\n";
    print "   Note: if the sqlite file does not exist, create one with:  \$GEMC/api/perl/sqlite.py -n ../clas12.sqlite\n";
    exit;
}

# Make sure the argument list is correct
if (scalar @ARGV != 1) {
    help();
    exit;
}

# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);


# Global pars - these should be read by the load_parameters from file or DB
our %parameters    = get_parameters(%configuration);


# import scripts
require "./materials.pl";
require "./bank.pl";
require "./hit.pl";
require "./geometry.pl";
require "./mirrors.pl";


# all the scripts must be run for every configuration
my @allConfs = ("original", "spring18", "fall18");

# bank definitions commong to all variations
define_bank();

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;
	
	# materials
	materials();
	
	# hits
	define_hit();
	
	# geometry
	makeHTCC();
	
	# mirrors surfaces
	buildMirrorsSurfaces();
	
}


