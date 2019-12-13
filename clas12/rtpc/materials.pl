#!/usr/bin/perl -w

use strict;
use warnings;

our %configuration;

sub materials
{
	# PCB
	my %mat = init_mat();
	$mat{"name"}          ="PCB";
	$mat{"description"}   = "Printed circuit board";
	$mat{"density"}       = "1.850";  # in g/cm3
	$mat{"ncomponents"}   = "3";
	$mat{"components"}    = "G4_Fe 0.3 G4_C 0.4 G4_Si 0.3";
	print_mat(\%configuration, \%mat);
    
    # Rohacell
    %mat = init_mat();
    $mat{"name"}          = "Rohacell";
    $mat{"description"}   = "Rohacell Foam";
    $mat{"density"}       = "0.100";  # in g/cm3
    $mat{"ncomponents"}   = "4";
    $mat{"components"}    = "G4_C 0.6465 G4_H 0.0784 G4_N 0.0839 G4_O 0.1912";
    print_mat(\%configuration, \%mat);

    # Ultem
    %mat = init_mat();
    $mat{"name"}          = "Ultem";
    $mat{"description"}   = "Ultem";
    $mat{"density"}       = "1.27";  # in g/cm3
    $mat{"ncomponents"}   = "4";
    $mat{"components"}    = "G4_C 0.5363 G4_H 0.3480 G4_N 0.0289 G4_O 0.0868";
    print_mat(\%configuration, \%mat);
    
    #G10
    %mat = init_mat();
    $mat{"name"}          = "G10";
    $mat{"description"}   = "G10 material";
    $mat{"density"}       = "1.700";
    $mat{"ncomponents"}   = "4";
    $mat{"components"}    = "G4_Si 0.1 G4_O 0.2 G4_C 0.35 G4_H 0.35";
    print_mat(\%configuration, \%mat);
    
    # DriftbonusGas
    %mat = init_mat();
    my $He_prop = 0.8;
    my $CO2_prop = 0.2;
    my $He_dens = 0.0001664;
    my $CO2_dens = 0.00184212;
    my $bonusGas_Density = $He_prop*$He_dens+$CO2_prop*$CO2_dens;
    $mat{"name"}          ="BONuSGas";
    $mat{"description"}   = "80:20 He:CO2 Drift region BONuS12 Gas";
    $mat{"density"}       = $bonusGas_Density;  # in g/cm3
    $mat{"ncomponents"}   = "2";
    $mat{"components"}    = "G4_He $He_prop G4_CARBON_DIOXIDE $CO2_prop";
    print_mat(\%configuration, \%mat);
    
    # TargetbonusGas
    %mat = init_mat();
    $mat{"name"}          ="DeuteriumTargetGas";
    $mat{"description"}   = "7 atm deuterium gas";
    $mat{"density"}       = "0.00126";  # in g/cm3
    $mat{"ncomponents"}   = "1";
    $mat{"components"}    = "deuteriumGas 1";
    print_mat(\%configuration, \%mat);
    
    # Connector material is Vectra E130i
    %mat = init_mat();
    $mat{"name"}          ="rtpc_Vectra";
    $mat{"description"}   = "Vectra E130i";
    $mat{"density"}       = "1.610";  # in g/cm3
    # CHANGE components (Currently PCB)
    $mat{"ncomponents"}   = "3";
    $mat{"components"}    = "G4_Fe 0.3 G4_C 0.4 G4_Si 0.3";
    print_mat(\%configuration, \%mat);
    
    # Protection circuit material
    %mat = init_mat();
    $mat{"name"}          ="protectionCircuit";
    $mat{"description"}   = "Protection circuit material";
    $mat{"density"}       = "1.610";  # in g/cm3
    $mat{"ncomponents"}   = "1";
    $mat{"components"}    = "rtpc_Vectra 1.0";
    print_mat(\%configuration, \%mat);
    
    # Material smearing of the electronics, ribs, and spines
    %mat = init_mat();
    my $G10_prop = 0.098;
    my $air_prop = 0.519;
    my $vectra_prop = 0.383;
    
    my $G10_dens = 1.8;
    my $vectra_dens = 1.61;
    my $air_dens = 0.001225;
    my $ERS_density = $G10_prop * $G10_dens + $vectra_prop * $vectra_dens + $air_prop * $air_dens;
    $mat{"name"}          ="ERS";
    $mat{"description"}   = "Electronics, ribs, and spines";
    $mat{"density"}       = $ERS_density;  # in g/cm3
    $mat{"ncomponents"}   = "3";
    $mat{"components"}    = "G10 $G10_prop rtpc_Vectra $vectra_prop G4_AIR $air_prop";
    print_mat(\%configuration, \%mat);

}

