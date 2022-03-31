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
require "./ltccBox.pl";        # mother volume
require "./ltcc_frame.pl";     # frame
require "./cyl_mirrors.pl";    # cyl mirrors
require "./hyp_mirrors.pl";    # hyp mirrors
require "./ell_mirrors.pl";    # ell mirrors
require "./pmts.pl";           # pmts
require "./cones.pl";          # cones
require "./shields.pl";        # shields

# mirrors properties
require "./mirrors.pl";


# all the scripts must be run for every configuration
my @allConfs = ("rga_spring2018", "rga_fall2018",  "rgb_winter2019", "rgb_spring2019", "rgm", "default");

# sectors 1 2 3 4 5 6 presence
our @rga_spring2018_sectorsPresence = (   0,       1,       1,       0,       1,      1);
our @rga_spring2018_materials       = ("na",    "N2",    "N2",    "na", "C4F10",   "N2");

our @rga_fall2018_sectorsPresence   = (   0,       0,       1,       0,       1,      0);
our @rga_fall2018_materials         = ("na",    "na", "C4F10",     "na",   "N2",   "na");

our @rgb_winter2019_sectorsPresence = (   0,       0,       1,       0,       1,      0);
our @rgb_winter2019_materials       = ("na",    "na", "C4F10",    "na", "C4F10",    "na");

our @rgb_spring2019_sectorsPresence = (   0,       0,       1,       0,       1,      0);
our @rgb_spring2019_materials       = ("na",    "na", "C4F10",    "no", "C4F10",   "na");

our @rgm_sectorsPresence            = (   0,       1,       1,       0,       1,      1);
our @rgm_materials                  = ("na",    "N2",    "N2",    "na",    "N2",   "N2");

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

	# frame
	buildLtccFrame();

	# Cylindrical mirrors
	buildCylMirrors();

	# Hyperbolic
	buildHypMirrors();

	# Elliptical mirrors
	buildEllMirrors();

	# PMTs
	buildPmts();

	# Cones
	buildCones();

	# Shields
	buildShields();

	# mirrors surfaces
	buildMirrorsSurfaces();

}


