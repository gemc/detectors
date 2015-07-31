#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/io");
use utils;
use hit;

use strict;
use warnings;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   hit.pl  <configuration filename>\n";
 	print "   Will define the CLAS12 Drift Chambers (dc) hit \n";
 	print "   Note: The passport and .visa files must be present to connect to MYSQL. \n\n";
	exit;
}

# Make sure the argument list is correct
# If not pring the help
if( scalar @ARGV != 1)
{
	help();
	exit;
}

# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);

# One can change the "variation" here if one is desired different from the config.dat
# $configuration{"variation"} = "myvar";


sub define_hit
{
	# uploading the hit definition
	my %hit = init_hit();
	$hit{"name"}            = "dc";
	$hit{"description"}     = "dc hit definitions ";
	$hit{"identifiers"}     = "sector  superlayer layer wire";
	$hit{"signalThreshold"} = "0.1*KeV";
	$hit{"timeWindow"}      = "500*ns";
	$hit{"prodThreshold"}   = "1*mm";
	$hit{"maxStep"}         = "1*mm";
	$hit{"delay"}           = "50*ns";
	$hit{"riseTime"}        = "1*ns";
	$hit{"fallTime"}        = "2*ns";
	$hit{"mvToMeV"}         = 100;
	$hit{"pedestal"}        = -20;
	print_hit(\%configuration, \%hit);
}


define_hit();

1;
