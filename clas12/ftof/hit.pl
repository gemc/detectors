#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use hit;

use strict;
use warnings;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   hit.pl  <configuration filename>\n";
 	print "   Will define the CLAS12 Forward Time of Flight (ftof) hit \n";
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


sub define_p1a_hit
{
	# uploading the hit definition
	my %hit = init_hit();
	$hit{"name"}            = "ftof_p1a";
	$hit{"description"}     = "ftof hit definitions for panel 1A";
	$hit{"identifiers"}     = "sector paddle";
	$hit{"signalThreshold"} = "0.5*MeV";
	$hit{"timeWindow"}      = "5*ns";
	$hit{"prodThreshold"}   = "1*mm";
	$hit{"maxStep"}         = "1*cm";
	$hit{"delay"}           = "50*ns";
	$hit{"riseTime"}        = "1*ns";
	$hit{"fallTime"}        = "2*ns";
	$hit{"mvToMeV"}         = 100;
	$hit{"pedestal"}        = -20;
	print_hit(\%configuration, \%hit);
}

sub define_p1b_hit
{
	# uploading the hit definition
	my %hit = init_hit();
	$hit{"name"}            = "ftof_p1b";
	$hit{"description"}     = "ftof hit definitions for panel 1B";
	$hit{"identifiers"}     = "sector paddle";
	$hit{"signalThreshold"} = "0.5*MeV";
	$hit{"timeWindow"}      = "5*ns";
	$hit{"prodThreshold"}   = "1*mm";
	$hit{"maxStep"}         = "1*cm";
	$hit{"delay"}           = "50*ns";
	$hit{"riseTime"}        = "1*ns";
	$hit{"fallTime"}        = "2*ns";
	$hit{"mvToMeV"}         = 100;
	$hit{"pedestal"}        = -20;
	print_hit(\%configuration, \%hit);
}

sub define_p2_hit
{
	# uploading the hit definition
	my %hit = init_hit();
	$hit{"name"}            = "ftof_p2";
	$hit{"description"}     = "ftof hit definitions for panel 2";
	$hit{"identifiers"}     = "sector paddle";
	$hit{"signalThreshold"} = "0.5*MeV";
	$hit{"timeWindow"}      = "5*ns";
	$hit{"prodThreshold"}   = "1*mm";
	$hit{"maxStep"}         = "1*cm";
	$hit{"delay"}           = "50*ns";
	$hit{"riseTime"}        = "1*ns";
	$hit{"fallTime"}        = "2*ns";
	$hit{"mvToMeV"}         = 100;
	$hit{"pedestal"}        = -20;
	print_hit(\%configuration, \%hit);
}


sub define_ftof_hits
{
	define_p1a_hit();
	define_p1b_hit();
	define_p2_hit();
}

define_ftof_hits();


1;