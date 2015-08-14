#!/usr/bin/perl -w


use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use hit;
use bank;
use math;

use Math::Trig;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   beamline.pl <configuration filename>\n";
 	print "   Will create the CLAS12 moller_shields with two variations: noft and ft\n";
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
#my %parameters    = get_parameters(%configuration); 



# Global parameters
# Downstream beamline is a 4cm thick pipe of lead, with OD = 350 mm

# General:
our $inches   = 25.4;
our $degrad    = 57.27;

# Torus numbers:
our $TorusZpos        = 151.855*$inches;                 # center of the torus position
our $SteelFrameLength = 94.*$inches/2.0;                 # 1/2 length


require "./noft_moller_shield.pl";
require "./downstream.pl";
require "./ft_moller_shield.pl";
require "./tagger.pl";

$configuration{"variation"} = "noft" ;
#make_moller_shield();
#make_downstream_shielding();
make_tagger();

$configuration{"variation"} = "ft" ;
#make_moller_shield_ft();
#make_downstream_shielding();



