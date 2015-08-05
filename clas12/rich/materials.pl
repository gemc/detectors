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
 	print "   Will create rich materials\n";
	exit;
}

# Make sure the argument list is correct
# If not pring the help
if( scalar @ARGV != 1)
{
	help();
	exit;
}


# Loading configuration file from argument
our %configuration = load_configuration($ARGV[0]);

sub define_material
{
	# gas_ingap
	my %mat = init_mat();
	$mat{"name"}          = "Gas_inGap";
	$mat{"description"}   = "gas in gap";
	$mat{"density"}       = "0.00129";  # in g/cm3
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "C 1 O 2";
	print_mat(\%configuration, \%mat);

	%mat = init_mat();
	$mat{"name"}          = "Glass_H8500";
	$mat{"description"}   = "Glass_H8500";
	$mat{"density"}       = "2.76";  # in g/cm3
	$mat{"ncomponents"}   = "8";
	$mat{"components"}    = "SilicOxide 80.71 BoromTriOxide 12.6 SodMonOxide 4.2 AluminiumOxide 2.2 CalciumOxide 0.1 G4_Cl 0.1 MagnesiumOxide 0.05 IronTriOxide 0.04";
	print_mat(\%configuration, \%mat);

}


define_material();

