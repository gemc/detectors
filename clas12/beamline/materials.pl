#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use materials;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   materials.pl <configuration filename>\n";
 	print "   Will create the CLAS12 beamline materials\n";
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

# TODO:
# add other materials (steinless steel etc. with the correct composition)


# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);

# One can change the "variation" here if one is desired different from the config.dat
# $configuration{"variation"} = "myvar";

sub print_materials
{
	# uploading the mat definition
	
	# Beamline_Tungsten
	my %mat = init_mat();
	$mat{"name"}          = "beamline_W";
	$mat{"description"}   = "beamline tungsten alloy 17.6 g/cm3";
	$mat{"density"}       = "17.6";
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "G4_Fe 0.08 G4_W 0.92";
	print_mat(\%configuration, \%mat);
	
	
}

$configuration{"variation"} = "noft" ;
print_materials();

$configuration{"variation"} = "baseline" ;
print_materials();

$configuration{"variation"} = "noft-l254-r195.4" ;
print_materials();

$configuration{"variation"} = "ft" ;
print_materials();

