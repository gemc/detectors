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
 	print "   Will create the CLAS12 micromegas materials\n";
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
	my %mat = init_mat();
	$mat{"name"}          = "epoxy";
	$mat{"description"}   = "micromegas epoxy";
	$mat{"density"}       = "1.16";
	$mat{"ncomponents"}   = "4";
	$mat{"components"}    = "C 15 H 32 N 2 O 4";
	print_mat(\%configuration, \%mat);

	%mat = init_mat();
	my $MMStripTransparency_Density = 300./400.*8.96;
	$mat{"name"}          = "MMStrips";
	$mat{"description"}   = "micromegas strips are copper";
	$mat{"density"}       = "$MMStripTransparency_Density";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_Cu 1";
	print_mat(\%configuration, \%mat);

	# PC Board
	%mat = init_mat();
	$mat{"name"}          = "pcBoardMaterial";
	$mat{"description"}   = "bst pc board material";
	$mat{"density"}       = "1.860";
	$mat{"ncomponents"}   = "3";
	$mat{"components"}    = "G4_Fe 0.3 G4_C 0.4 G4_Si 0.3";
	print_mat(\%configuration, \%mat);

	# Peek chemical formula (C19 H12 O3)
	%mat = init_mat();
	$mat{"name"}          = "peek";
	$mat{"description"}   = "bst peek";
	$mat{"density"}       = "1.31";
	$mat{"ncomponents"}   = "3";
	$mat{"components"}    = "C 19 H 12 O 3";
	print_mat(\%configuration, \%mat);

}

print_materials();

