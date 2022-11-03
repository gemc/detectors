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
	print "   uRwell.pl <configuration filename>\n";
 	print "   Will create the CLAS12 uRwell geometry, materials, bank and hit definitions\n";
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
$configuration{"variation"} = "default" ;

# Global pars - these should be read by the load_parameters from file or DB


# materials
require "./materials.pl";

# banks definitions
require "./bank.pl";

# hits definitions
require "./hit.pl";

# run DC factory from COATJAVA to produce volumes

system("groovy -cp '../*:..' factory.groovy --variation $configuration{variation} --runnumber 11");

# sensitive geometry
require "./geometry_java.pl";


# all the scripts must be run for every configuration
# Right now run both configurations, later on just ccdb
#my @allConfs = ("ccdb", "cosmicR1", "ddvcs", "java");
my @allConfs = ($configuration{"variation"});

# bank definitions common to all variations
define_bank();

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;

	# materials
	materials();

	# hits
	define_hit();
	

	# sensitive geometry
	# Global pars - these should be read by the load_parameters from file or DB
	our @volumes = get_volumes(%configuration);

	coatjava::makeURWELL();
	
}

