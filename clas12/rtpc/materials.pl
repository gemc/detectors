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

        # DME
        %mat = init_mat();
        $mat{"name"}          ="DME";
        $mat{"description"}   = "DME";
        $mat{"density"}       = "0.00197";  # in g/cm3
        $mat{"ncomponents"}   = "3";
        $mat{"components"}    = "C 2 H 6 O 1";
        print_mat(\%configuration, \%mat);

        # DriftbonusGas
        %mat = init_mat();
        my $HeProp = 0.9;
        my $DMEProp = 0.1;
        my $bonusGas_Density = $HeProp*0.0001664+$DMEProp*0.00197;
        $mat{"name"}          ="BONuSGas";
        $mat{"description"}   = "Drift region BONuS Gas";
        $mat{"density"}       = $bonusGas_Density;  # in g/cm3
        $mat{"ncomponents"}   = "2";
        $mat{"components"}    = "G4_He $HeProp DME $DMEProp";
        print_mat(\%configuration, \%mat);

        # TargetbonusGas
        %mat = init_mat();
        $mat{"name"}          ="DeuteriumTargetGas";
        $mat{"description"}   = "7 atm deuterium gas";
        $mat{"density"}       = "0.001025";  # in g/cm3
        $mat{"ncomponents"}   = "1";
        $mat{"components"}    = "deuteriumGas 1";
        print_mat(\%configuration, \%mat);

}
