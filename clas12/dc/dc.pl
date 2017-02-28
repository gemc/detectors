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
	print "   dc.pl <configuration filename>\n";
 	print "   Will create the CLAS12 DC geometry, materials, bank and hit definitions\n";
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


# materials
require "./materials.pl";
require "./shield_material.pl";

# banks definitions
require "./bank.pl";

# hits definitions
require "./hit.pl";

# run DC factory from COATJAVA to produce volumes
system('groovy -cp "../*" factory.groovy');

# sensitive geometry
require "./geometry_java.pl";

# sensitive geometry
require "./geometry.pl";

# dc plates
require "./basePlates.pl";
require "./endPlates.pl";

# region3 shielding for ddvcs
require "./region3_shield.pl";

# calculate the parameters
require "./utils.pl";


# all the scripts must be run for every configuration
# Right now run both configurations, later on just ccdb
#my @allConfs = ("ccdb", "cosmicR1", "ddvcs", "java");
my @allConfs = ("java");

# bank definitions commong to all variations
define_bank();

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;
	
	# materials
	materials();
	shield_material();

	# hits
	define_hit();
	

	# sensitive geometry
	if($configuration{"variation"} eq "java")
	{
		# Global pars - these should be read by the load_parameters from file or DB
		our @volumes = get_volumes(%configuration);

		coatjava::makeDC();
	}
	else
	{
		# calculate pars
		calculate_dc_parameters();

		makeDC_perl();
		# dc plates
		make_plates();
	}

	# region 3 shielding
	if($configuration{"variation"} eq "ddvcs")
	{
		make_region3_front_shield();
		make_region3_back_shield();
	}
}

