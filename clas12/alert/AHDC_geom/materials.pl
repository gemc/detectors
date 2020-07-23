use strict;
use warnings;

our %configuration;


sub materials
{
	# uploading the mat definition
	
	# ALERT drift chamber gas
	my %mat = init_mat();
	my $He_prop = 0.8;
    	my $CO2_prop = 0.2;
    	my $He_dens = 0.0001664;
    	my $CO2_dens = 0.00184212;
	my $AHDCGas_Density = $He_prop*$He_dens+$CO2_prop*$CO2_dens;
	$mat{"name"}          = "AHDCgas";
	$mat{"description"}   = "80:20 He:CO2 drift region gas taken from bonus12";
	$mat{"density"}       = $AHDCGas_Density; # in g/cm3
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "G4_He $He_prop G4_CARBON_DIOXIDE $CO2_prop";
	print_mat(\%configuration, \%mat);
	
}
