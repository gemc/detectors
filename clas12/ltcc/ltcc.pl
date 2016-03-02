#!/usr/bin/perl -w
use strict;
use warnings;

use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use hit;
use math;
use Math::Trig;
use materials;
use mirrors;


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
require "./ltcc_box.pl";      # mother volume
require "./ell_mirrors.pl";   # ell mirrors
#require "./hyp_mirrors.pl";   # hyp mirrors
#require "./pmts.pl";          # pmts
#require "./spot_finder.pl";   # spot finder #nate


# mirrors properties
require "./mirrors.pl";


# all the scripts must be run for every configuration
my @allConfs = ("original");

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;
	
	# materials
	materials();
	
	# hits
	#define_hit();
	
	
	# bank definitions
	#define_banks();
	
	# Building LTCC Box
	build_ltcc_box();
	
	# Elliptical mirrors
	buildEllMirrors();

	# mirrors surfaces
	buildMirrorsSurfaces();

}




# detector build subroutine
sub build_detector
{
	
	
	# Building Elliptical mirrors
	#	build_ell_mirrors();
	#	#build_check_ell_cheeseform();
	
	
	# Building Hyperbolic mirrors
	#	build_hyp_mirrors();
	
	# Build PMTs
	#build_pmts();
	
	#spot finder #nate
	#	build_spot_finder();
	
}


# Hit definition
# Execute only when there are changes
#require "./hit.pl";
#quartz_pmt_hit();
#mirrors_hit();

# banks
#require "./bank.pl";
#define_ltcc_bank();
