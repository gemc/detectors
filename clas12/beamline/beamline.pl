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
our $inches    = 25.4;
our $degrad    = 57.27;

# Torus numbers:
our $TorusZpos        = 151.855*$inches;                 # center of the torus position
our $SteelFrameLength = 94.*$inches/2.0;                 # 1/2 length


require "./downstream.pl";
require "./noft_moller_shield.pl";
require "./ft_moller_shield.pl";
require "./tagger.pl";

# these are the values present in the downstream.pl
# BEFORE I changed anything at all.
$configuration{"variation"} = "noft" ;
make_moller_shield();
make_downstream_shielding(300.0,170.0,"beamline_W");
make_beamline_torus();

$configuration{"variation"} = "ft" ;
#make_tagger();

# 10" depth, extra thick, considered the nominal working design
$configuration{"variation"} = "noft-l254-r195.4";
make_moller_shield();
make_beamline_torus();
make_downstream_shielding(254.0,195.4,"beamline_W");

# without nose
$configuration{"variation"} = "baseline";
make_moller_shield();
make_beamline_torus();
make_orig();
