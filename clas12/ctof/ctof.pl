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
	print "   ctof.pl <configuration filename>\n";
 	print "   Will create the CLAS12 CTOF geometry, materials, bank and hit definitions\n";
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

# sensitive geometry
require "./geometry.pl";


# all the scripts must be run for every configuration
my @allConfs = ("original");

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;
	
	# materials
	materials();
	
	# hits
	define_hit();
	
	# bank definitions
	define_bank();
	
	# geometry
	makeCTOF();
	
}


