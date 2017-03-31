#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use lib ("$ENV{GEMC}/io");
use parameters;
use utils;

use geometry;
use hit;
use bank;
use math;

# use Math::Trig;
# use Math::MatrixReal;
# use Math::VectorReal;

# system("rm meic_det1__*txt");

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   detector.pl <configuration filename>\n";
 	print "   Will create the detector\n";
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
my $config_file   = $ARGV[0];
our %configuration = load_configuration($config_file);

#if($#ARGV < 0){
#    do 'configs/pvdis_CLEO_nominal.pl';
#}else{
#    do 'configs/'.$ARGV[0];
#}

# One can change the "variation" here if one is desired different from the config.dat
# $configuration{"detector_name"} = "det1_solenoid_dual";
$configuration{"variation"} = "Original";

# To get the parameters proper authentication is needed.
# our %parameters    = get_parameters(%configuration);
# $configuration{"detector_name"} = "meic_det1_dual";

#####Load geometry ########################################################
require "det1_romanpot_iondownstream_geometry.pl";
det1_romanpot_iondownstream();

