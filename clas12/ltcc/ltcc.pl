#!/usr/bin/perl -w
use strict;
use warnings;

use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use hit;
use bank;
use math;
use Math::Trig;
use materials;
use mirrors;

our $startS = 1;
our $endS   = 6;
our $startN = 1;
our $endN   = 18;


# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   ltcc.pl <configuration filename>\n";
	print "   Will create the LTCC Geomery\n";
	print "   Note: The passport and .visa files must be present if connecting to MYSQL. \n\n";
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

# Global pars - these should be read by the load_parameters from file or DB
our %parameters = get_parameters(%configuration);


# materials
require "./materials.pl";

# banks definitions
require "./bank.pl";

# hits definitions
require "./hit.pl";

# Loading LTCC specific subroutines
#require "./ltcc_box.pl";      # mother volume
require "./ltccBox.pl";      # mother volume
require "./ell_mirrors.pl";   # ell mirrors
require "./hyp_mirrors.pl";   # hyp mirrors
require "./pmts.pl";          # pmts

# mirrors properties
require "./mirrors.pl";


# all the scripts must be run for every configuration
my @allConfs = ("original");

# bank definitions commong to all variations
define_bank();

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;
	
	# materials
	materials();
	
	# hits
	define_hit();
	
	# Building LTCC Box
	build_ltcc_box();
	
	# Elliptical mirrors
	buildEllMirrors();

	# Hyperbolic
	buildHypMirrors();
	
	# mirrors surfaces
	buildMirrorsSurfaces();

	# PMTs
	buildPmts();
}


