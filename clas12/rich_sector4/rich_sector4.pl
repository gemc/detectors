#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use hit;
use bank;
use mirrors;
use math;
use materials;
use POSIX;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   rich.pl <configuration filename>\n";
 	print "   Will create the CLAS12 Ring Imaging Cherenkov (rich) using the variation specified in the configuration file\n";
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

# To get the parameters proper authentication is needed.
#our %parameters    = get_parameters(%configuration);

my $javaCadDir = "javacad";
system(join(' ', 'groovy -cp "../*" factory.groovy', $javaCadDir));

# materials
require "./materials.pl";

# banks definitions
require "./bank.pl";

# hits definitions
require "./hit.pl";

#mirror material
require "./mirrors.pl";

# Loading RICH specific subroutines for original geometry
#require "./geometry/box.pl";
#require "./geometry/frontal_system.pl";
#require "./geometry/pmt.pl";

# java geometry
require "./geometry_java.pl";

# all the scripts must be run for every configuration
my @allConfs = ("java");

# bank definitions
#define_bank();

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;

	if($configuration{"variation"} eq "java")
	{
		our @volumes = get_volumes(%configuration);
		coatjava::makeRICH($javaCadDir);
	}

	# materials
	#materials();
	
	# hits
    #define_hit();
}
