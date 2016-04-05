#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use math;
use materials;

use Math::Trig;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   geometry.pl <configuration filename>\n";
 	print "   Will create the DDVS setup using the variation specified in the configuration file\n";
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

our $pi    = 3.141592653589793238;
our $toRad = $pi/180.0;
our $microgap = 0.1;

our $CwidthU =   13.0;    # Upstream   crystal width in mm (side of the squared front face)
our $CwidthD =   17.0;    # Downstream crystal width in mm (side of the squared front face)
our $Clength =  200.0;    # Crystal length in mm

our $CZpos      =  500.0;    # Position of the front face of the crystals
our $CentryAngle = 7*$toRad;
our $CexitAngle  = 30*$toRad;

our $CrminU = $CZpos*tan($CentryAngle);
our $CrmaxU = $CZpos*tan($CexitAngle);

our $CrminD = $CrminU + $Clength*tan($CentryAngle);
our $CrmaxD = $CrmaxU + $Clength*tan($CexitAngle);


# aluminum support
our $supportLength = 50;
our $Smax = $CrmaxD + $supportLength*tan($CexitAngle); # support max

our $pipeIR = 29;
our $pipeOR = 31.5;
our $pipeL  = 1000;


# shield
our $TSThick  = 300;
our $TSLength = 1500;
our $TSrmax = $Smax + $TSThick*tan($CexitAngle) + 10;



# Loading configuration file from argument
our %configuration = load_configuration($ARGV[0]);

# materials
require "./materials.pl";

# Loading DDVCS geometry routines specific subroutines
require "./ddvcsCone.pl";
require "./muCal.pl";
require "./beamSupport.pl";

# all the scripts must be run for every configuration
my @allConfs = ("original");

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;
	
	# materials
	materials();
	
	# geometry
	make_mu_cal();
   buildBeamPipe();
	buildBeamShield();
	
}


