#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/io");
use utils;
use parameters;
use geometry;
use math;

use Math::Trig;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   geometry.pl <configuration filename>\n";
 	print "   Will create the CLAS12 High Threshold Cherenkov Counter (htcc) using the variation specified in the configuration file\n";
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

# Loading configuration file from argument
our %configuration = load_configuration($ARGV[0]);

# One can change the "variation" here if one is desired different from the config.dat
# $configuration{"variation"} = "myvar";

# Load the parameters
# our %parameters    = get_parameters(%configuration);


# Loading DDVCS geometry routines specific subroutines
require "./ddvcsCone.pl";


build_ddvcsCone();
