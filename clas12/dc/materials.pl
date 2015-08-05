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
 	print "   Will create the CLAS12 Drift Chambers (dc) materials\n";
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

sub print_materials
{
	# uploading the mat definition
	
	# Scintillator
	my %mat = init_mat();
	$mat{"name"}          = "dcgas";
	$mat{"description"}   = "clas12 dc gas";
	$mat{"density"}       = "0.0018";
	$mat{"ncomponents"}   = "3";
	$mat{"components"}    = "G4_Ar 0.9 G4_O 0.066 G4_C 0.034";
	print_mat(\%configuration, \%mat);
	
}

print_materials();

