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
	print "   bst.pl <configuration filename>\n";
	print "   Will create the CLAS12 BST geometry, materials, bank and hit definitions\n";
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
$configuration{"variation"} = "default" ;

# materials
require "./materials.pl";

# banks definitions
require "./bank.pl";

# hits definitions
require "./hit.pl";


# all the scripts must be run for every configuration
#my @allConfs = ("original", "java");
my @allConfs = ($configuration{"variation"}); # java variation only, for testing

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf;

	# materials
	materials();
	
	# hits
	define_hit();
	
	# bank definitions
	define_bank();

	if($configuration{"variation"} eq "original") {
		# Global pars - these should be read by the load_parameters from file or DB
		our %parameters = get_parameters(%configuration);

		require "./geometry.pl";
		makeBST();
	} else {
		system("groovy -cp '../*:..' factory.groovy --variation $configuration{variation} --runnumber 11");

		# Global pars - these should be read by the load_parameters from file or DB
		our %parameters = get_parameters(%configuration);
		our @volumes = get_volumes(%configuration);

		require "./geometry_java.pl";
		coatjava::makeBST();
	}
}
