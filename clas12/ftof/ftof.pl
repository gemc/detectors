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
	print "   ftof.pl <configuration filename>\n";
 	print "   Will create the CLAS12 FTOF geometry, materials, bank and hit definitions\n";
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
#our %parameters = get_parameters(%configuration);

system('groovy -cp "../coat-libs-2.0-SNAPSHOT.jar" factory.groovy');                                                                                        

# Global pars - these should be read by the load_parameters from file or DB
our @volumes = get_volumes(%configuration);

# materials
require "./materials.pl";

# banks definitions
require "./bank.pl";

# hits definitions
require "./hit.pl";

# sensitive geometry
#require "./geometry.pl";

# read volumes from txt output of groovy script
require "./volumes.pl";

# calculate the parameters
require "./utils.pl";


# all the scripts must be run for every configuration
my @allConfs = ("java");

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;
	
	# materials
	materials();
	
	# hits
	define_hit();
	
	# calculate pars
	# calculate_ftof_parameters();

	# bank definitions
	define_banks();
	
	# geometry
	# makeFTOF();
	
	# volumes
	makeFTOF();
}


