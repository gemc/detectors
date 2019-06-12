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

my $javaCadDir = "javacad";
system(join(' ', 'groovy -cp "../*:.." factory.groovy --variation rga_fall2018 --runnumber 11', $javaCadDir));

# materials
require "./materials.pl";

# banks definitions
require "./bank.pl";

# hits definitions
require "./hit.pl";

# sensitive geometry
require "./geometry.pl";

# java geometry
require "./geometry_java.pl";

# all the scripts must be run for every configuration
my @allConfs = ("cad", "rga_fall2018");

# bank definitions
define_bank();

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;

	if($configuration{"variation"} eq "rga_fall2018")
	{
		our @volumes = get_volumes(%configuration);

		coatjava::makeCTOF($javaCadDir);
	}
	else
	{
		# geometry
		makeCTOF();
	}

	# materials
	materials();
	
	# hits
	define_hit();
}


