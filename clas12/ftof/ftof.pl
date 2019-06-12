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
$configuration{"variation"} = "rga_fall2018" ;

# run FTOF factory from COATJAVA to produce volumes
system("groovy -cp '../*:..' factory.groovy --variation $configuration{variation} --runnumber 11");
#system('~kenjo/.groovy/groovy-2.4.12/bin/groovy -cp "../*" factory.groovy');

# materials
require "./materials.pl";

# banks definitions
require "./bank.pl";

# hits definitions
require "./hit.pl";

# read volumes from txt output of groovy script
require "./geometry_java.pl";

# all the scripts must be run for every configuration
my @allConfs = ("original", $configuration{"variation"});

# bank definitions commong to all variations
define_banks();

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;

	# materials
	materials();
	
	# hits
	define_hit();

	# Global pars - these should be read by the load_parameters from file or DB
	our %parameters = get_parameters(%configuration);
	
	if($configuration{"variation"} eq "original")
	{

		# calculate the parameters
		require "./utils.pl";

		# sensitive geometry
		require "./geometry.pl";

		# calculate pars
		calculate_ftof_parameters();

		# volumes
		makeFTOF();

		# make
		make_pb();
	} else {
		# Global pars - these should be read by the load_parameters from file or DB
		our @volumes = get_volumes(%configuration);

		coatjava::makeFTOF();
		coatjava::make_pb();
	}
}


