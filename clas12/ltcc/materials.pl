use strict;
use warnings;

our %configuration;

# Table of optical photon energies (wavelengths) from 190-650 nm:
my @penergy = ( "2.034*eV", "4.136*eV" );

# Index of refraction of CO2 gas at STP:
my @irefr = ( 1.001331,  1.00143);


# Transparency of CO2 gas at STP:
# (completely transparent except at very short wavelengths below ~200 nm)
my @abslength = ( "10.*m",  "3*m");


		
sub materials
{
    # htcc gas is 100% CO2 with optical properties
	my %mat = init_mat();
	$mat{"name"}          = "C4F10";
	$mat{"description"}   = "clas12 ltcc gas";
	$mat{"density"}       = "0.01012";
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "G4_C 0.3 G4_F 0.7";
	$mat{"photonEnergy"}       = arrayToString(@penergy);
	$mat{"indexOfRefraction"}  = arrayToString(@irefr);
	$mat{"absorptionLength"}   = arrayToString(@abslength);
	$mat{"scintillationyield"} = "10";
	$mat{"resolutionscale"}    = "1";
	$mat{"yieldratio"}         = "0.8";
	print_mat(\%configuration, \%mat);
	
}


