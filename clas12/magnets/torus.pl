#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use geometry;
use math;

use Math::Trig;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   torus.pl <configuration filename>\n";
 	print "   Will create the CLAS12 Torus using the variation specified in the configuration file\n";
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


# Global pars - these should be read by the load_parameters from file or DB

# General:
our $inches      = 25.4;
our $TorusLength = 94.*$inches/2.0;  # 1/2 length. 1193.8mm
our $TorusZpos   = 3947.6;           # center of the torus position (include its semilengt). Value from M. Zarecky, R. Miller PDF file on 1/13/16


# hub
require "./torusHub.pl";

# front and back plates
require "./torusPlates.pl";

# coils
require "./torusCoils.pl";


# building the torus
torusHub();
#torusPlates();
torusCoils();





