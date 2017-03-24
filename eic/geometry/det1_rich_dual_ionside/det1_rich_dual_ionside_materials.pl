#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use lib ("$ENV{GEMC}/io");
use utils;
use materials;

# Make sure the argument list is correct
# If not pring the help
if( scalar @ARGV != 1)
{
	help();
	exit;
}


# Loading configuration file from argument
our %configuration = load_configuration($ARGV[0]);

# One can change the "variation" here if one is desired different from the config.dat
# $configuration{"variation"} = "myvar";

	my $DetectorName = 'det1_rich_dual_ionside';
	
sub define_material
{
	# the first argument to this function become the variation
# 	$configuration{"variation"} = shift;

	# Aerogel
	my %mat = init_mat();
	$mat{"name"}          = "MAT\_$DetectorName\_aerogel";
	$mat{"description"}   = "eic rich aerogel material";
	$mat{"density"}       = "0.02";  # in g/cm3
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "Si 1 O 2";
	#$mat{"photonEnergy"}      = "2.5*eV 3*eV 3.5*eV 4*eV";
	$mat{"photonEnergy"}      = "2*eV 2.5*eV 3*eV 3.5*eV 4*eV";
	#$mat{"indexOfRefraction"} = "1.01992 1.02029 1.02074 1.02128";
	$mat{"indexOfRefraction"} = "1.01963 1.01992 1.02029 1.02074 1.02128";
	#$mat{"indexOfRefraction"} = "1.02 1.02 1.02 1.02 1.02";		
	$mat{"absorptionLength"}  = "30*cm 30*cm 30*cm 30*cm 30*cm";
	#$mat{"rayleigh"} = "1.001 1.001 1.001 1.001 1.05";
	#$mat{"photonEnergy"}      = arrayToString(@PhotonEnergyBin);
	#$mat{"indexOfRefraction"} = arrayToString(@AgelRefrIndex);
	#$mat{"absorptionLength"}  = arrayToString(@AgelAbsLength);
	print_mat(\%configuration, \%mat);

	# Lens Acrylic
# 	%mat = init_mat();
# 	$mat{"name"}          = "acrylic";
# 	$mat{"description"}   = "eic rich lens material";
# 	$mat{"density"}       = "1.19";  # in g/cm3
# 	$mat{"ncomponents"}   = "3";
# 	$mat{"components"}    = "C 5 H 8 O 2";
# 	$mat{"photonEnergy"}      = arrayToString(@PhotonEnergyBin);
# 	$mat{"indexOfRefraction"} = arrayToString(@AcRefrIndex);
# 	$mat{"absorptionLength"}  = arrayToString(@AcAbsLength);
# 	print_mat(\%configuration, \%mat);

	#CF4 gas
	%mat = init_mat();
	$mat{"name"}          = "MAT\_$DetectorName\_gas";
	$mat{"description"}   = "eic rich gas";
	$mat{"density"}       = "0.00372";  # in g/cm3
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "C 1 F 4";
	$mat{"photonEnergy"}      = "2*eV 2.5*eV 3*eV 3.5*eV 4*eV 4.5*eV 5*eV 5.5*eV 6*eV 6.5*eV 7*eV";
	$mat{"indexOfRefraction"} = "1.00048 1.00048 1.00049 1.00049 1.00050 1.00050 1.00051 1.00052 1.00052 1.00053 1.00054";
	#$mat{"indexOfRefraction"} = "1.00048 1.00048 1.00048 1.00048 1.00048 1.00048 1.00048 1.00048 1.00048 1.00048 1.00048";
	$mat{"absorptionLength"}  = "10*m";
	print_mat(\%configuration, \%mat);

}

define_material();
