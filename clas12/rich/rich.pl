#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use math;
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


# One can change the "variation" here if one is desired different from the config.dat
# $configuration{"variation"} = "myvar";

# To get the parameters proper authentication is needed.
our %parameters    = get_parameters(%configuration);

# Loading RICH specific subroutines
require "./geometry/box.pl";
require "./geometry/frontal_system.pl";
require "./geometry/pmt.pl";

build_rich();

sub build_rich
{
	for(my $s=4; $s<=4; $s++)
	{

		build_rich_box($s);
		build_frontal_system_bottom($s);
		build_frontal_system_top($s);
		build_pmts($s);

	}
}
