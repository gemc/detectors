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
	print "   Will create the ALERT FTOF geometry, materials, bank and hit definitions\n";
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

# materials
require "./materials.pl";

# banks definitions
require "./bank.pl";

# hits definitions
require "./hit.pl";

# read volumes from txt output of groovy script
require "./geometry_java.pl";

# all the scripts must be run for every configuration
my @allConfs = ("default");

# bank definitions commong to all variations
define_banks();

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;

	# materials
	materials();
	
	# hits
	define_hit();

	# run AFTOF factory from COATJAVA to produce volumes
#	system("groovy -cp '../*:..' factory.groovy --variation $configuration{variation} --runnumber 11");
#
#	# Global pars - these should be read by the load_parameters from file or DB
#	our %parameters = get_parameters(%configuration);
#
#	# Global pars - these should be read by the load_parameters from file or DB
#	our @volumes = get_volumes(%configuration);
#
#	coatjava::makeATOF();

}

1;

