#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use math;
use materials;

use Math::Trig;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   geometry.pl <configuration filename>\n";
 	print "   Will create the DDVS setup using the variation specified in the configuration file\n";
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

our $pi    = 3.141592653589793238;
our $toRad = $pi/180.0;

# Loading configuration file from argument
our %configuration = load_configuration($ARGV[0]);

# materials
require "./materials.pl";

# Loading DDVCS geometry routines specific subroutines
require "./ddvcsCone.pl";
require "./muCal.pl";
require "./beamSupport.pl";

# all the scripts must be run for every configuration
my @allConfs = ("original");

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;
	
	# materials
	materials();
	
	# geometry
	make_mu_cal();
   buildBeamPipe();
	buildBeamShield();
	
}


