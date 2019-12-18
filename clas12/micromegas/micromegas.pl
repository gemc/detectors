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
	print "   micromegas.pl <configuration filename>\n";
 	print "   Will create the micromegas using the variation specified in the configuration file\n";
 	print "   Note: The passport and .visa files must be present to connect to MYSQL. \n\n";
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
#our %parameters    = get_parameters(%configuration);



# materials
require "./materials.pl";

# banks definitions
require "./bank.pl";

# hits definitions
require "./hit.pl";


# bank definitions commong to all variations
define_bank();


# all the scripts must be run for every configuration
my @allConfs = ("michel", "rgf_spring2020");

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;

	
	# hits
	define_hit();
	
	if($configuration{"variation"} eq "michel") {

		# loading pars according to variation
		our %parameters    = get_parameters(%configuration);


		# sensitive geometry
		require "./bmt.pl";
		require "./fmt.pl";

		# geometry
		define_bmt();
		define_fmt();
		
		# materials
		materials();


	} elsif( $configuration{"variation"} eq "rgf_spring2020") {

		# loading pars according to variation
		our %parameters    = get_parameters(%configuration);

		# sensitive geometry
		require "./bmt.pl";
		require "./fmt.pl";


		# geometry
		define_fmt();

		# materials
		materials();

	}
}


