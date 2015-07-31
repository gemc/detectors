#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/io");
use utils;
use materials;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   materials.pl <configuration filename>\n";
 	print "   Will create the BDX materials\n";
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
# some materials that are now taken from the G4 DB should be checked:
# Tungsten, SteinlessSteel, Mylar
# also PCB composition should be checked and VM2000 added 


# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);

# One can change the "variation" here if one is desired different from the config.dat
# $configuration{"variation"} = "myvar";

sub print_materials
{
	# uploading the mat definition
	
	
	# Iron
	my %mat = init_mat();
	$mat{"name"}          = "bdx_iron";
	$mat{"description"}   = "beam dump iron blocks";
	$mat{"density"}       = "7.874";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_Fe 1.";
	print_mat(\%configuration, \%mat);
	

	# scintillator
	%mat = init_mat();
	$mat{"name"}          = "scintillator";
	$mat{"description"}   = "ft scintillator material C9H10 1.032 g/cm3";
	$mat{"density"}       = "1.032";
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "C 9 H 10";
	print_mat(\%configuration, \%mat);


	# micromegas mylar
	%mat = init_mat();
	$mat{"name"}          = "bdx_mylar";
	$mat{"description"}   = "ft micromegas mylar 1.40g/cm3";
	$mat{"density"}       = "1.4";
	$mat{"ncomponents"}   = "3";
	$mat{"components"}    = "G4_H 0.041958 G4_C 0.625017 G4_O 0.333025";
	print_mat(\%configuration, \%mat);
	
}

print_materials();

