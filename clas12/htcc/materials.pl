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
 	print "   Will create the CLAS12 High Threshold Cherenkov Counter (htcc) materials\n";
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

# Table of optical photon energies (wavelengths) from 190-650 nm:
my @penergy = ( "1.9074494*eV",  "1.9372533*eV",  "1.9680033*eV",  "1.9997453*eV",  "2.0325280*eV",
                "2.0664035*eV",  "2.1014273*eV",  "2.1376588*eV",  "2.1751616*eV",  "2.2140038*eV",
                "2.2542584*eV",  "2.2960039*eV",  "2.3393247*eV",  "2.3843117*eV",  "2.4310630*eV",
                "2.4796842*eV",  "2.5302900*eV",  "2.5830044*eV",  "2.6379619*eV",  "2.6953089*eV",
                "2.7552047*eV",  "2.8178230*eV",  "2.8833537*eV",  "2.9520050*eV",  "3.0240051*eV",
                "3.0996053*eV",  "3.1790823*eV",  "3.2627424*eV",  "3.3509246*eV",  "3.4440059*eV",
                "3.5424060*eV",  "3.6465944*eV",  "3.7570973*eV",  "3.8745066*eV",  "3.9994907*eV",
                "4.1328070*eV",  "4.2753176*eV",  "4.4280075*eV",  "4.5920078*eV",  "4.7686235*eV",
                "4.9593684*eV",  "5.1660088*eV",  "5.3906179*eV",  "5.6356459*eV",  "5.9040100*eV",
	            "6.1992105*eV",  "6.5254848*eV" );

# Index of refraction of CO2 gas at STP:
my @irefr = ( 1.0004473,  1.0004475,  1.0004477,  1.0004480,  1.0004483,
              1.0004486,  1.0004489,  1.0004492,  1.0004495,  1.0004498,
              1.0004502,  1.0004506,  1.0004510,  1.0004514,  1.0004518,
              1.0004523,  1.0004528,  1.0004534,  1.0004539,  1.0004545,
              1.0004552,  1.0004559,  1.0004566,  1.0004574,  1.0004583,
              1.0004592,  1.0004602,  1.0004613,  1.0004625,  1.0004638,
              1.0004652,  1.0004668,  1.0004685,  1.0004704,  1.0004724,
              1.0004748,  1.0004773,  1.0004803,  1.0004835,  1.0004873,
              1.0004915,  1.0004964,  1.0005021,  1.0005088,  1.0005167,
	          1.0005262,  1.0005378 );


# Transparency of CO2 gas at STP:
# (completely transparent except at very short wavelengths below ~200 nm)
my @abslength = ( "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m", \
                  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m", \
                  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m", \
                  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m", \
                  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m", \
                  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m", \
                  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m", \
                  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m", \
                  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",  "1000.0000000*m",    "82.8323273*m", \
	                 "4.6101432*m",     "0.7465970*m");


sub print_materials
{
    # htcc gas is 100% CO2 with optical properties
	my %mat = init_mat();
	$mat{"name"}          = "htccGas";
	$mat{"description"}   = "htcc gas is 100% CO2 with optical properties";
	$mat{"density"}       = "0.00184";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_CARBON_DIOXIDE 1.0";
	$mat{"photonEnergy"}      = arrayToString(@penergy);
	$mat{"indexOfRefraction"} = arrayToString(@irefr);
	$mat{"absorptionLength"}  = arrayToString(@abslength);
	print_mat(\%configuration, \%mat);

	%mat = init_mat();
	$mat{"name"}          = "rohacell31";
	$mat{"description"}   = "htcc gas is 100% CO2 with optical properties";
	$mat{"density"}       = "0.032";
	$mat{"ncomponents"}   = "4";
	$mat{"components"}    = "G4_C 0.6463 G4_H 0.0784 G4_N 0.0839 G4_O 0.1914";
	print_mat(\%configuration, \%mat);

}

print_materials();

