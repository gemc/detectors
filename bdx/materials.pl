use strict;

our %configuration;

# One can change the "variation" here if one is desired different from the config.dat
# $configuration{"variation"} = "myvar";

sub define_bdx_materials
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


    
    # CsI(Tl)
    %mat = init_mat();
    $mat{"name"}          = "CsI_Tl";
    $mat{"description"}   = "Babar crystal CsI(Tl) 4.53 g/cm3";
    $mat{"density"}       = "4.53";
    $mat{"ncomponents"}   = "2";
    $mat{"components"}    = "G4_CESIUM_IODIDE 0.999 G4_Tl 0.001";
    print_mat(\%configuration, \%mat);
    
    
    
	# micromegas mylar
	%mat = init_mat();
	$mat{"name"}          = "bdx_mylar";
	$mat{"description"}   = "ft micromegas mylar 1.40g/cm3";
	$mat{"density"}       = "1.4";
	$mat{"ncomponents"}   = "3";
	$mat{"components"}    = "G4_H 0.041958 G4_C 0.625017 G4_O 0.333025";
	print_mat(\%configuration, \%mat);
    
    # Concrete
    %mat = init_mat();
    $mat{"name"}          = "Concrete";
    $mat{"description"}   = "Concrete";
    $mat{"density"}       = "2.7";
    $mat{"ncomponents"}   = "10";
    $mat{"components"}    = "G4_H 0.01 G4_C 0.001 G4_O 0.529107 G4_Na 0.016 G4_Mg 0.002 G4_Al 0.033872 G4_Si 0.337021 G4_K 0.013 G4_Ca 0.044 G4_Fe 0.014";
    print_mat(\%configuration, \%mat);
    
    
    # Epoxy
    %mat = init_mat();
    $mat{"name"}          = "Epoxy";
    $mat{"description"}   = "Epoxy";
    $mat{"density"}       = "1.16";
    $mat{"ncomponents"}   = "4";
    $mat{"components"}    = "H 32 N 2 O 4 C 15";
    print_mat(\%configuration, \%mat);
  
    
    
    # CarbonFiber
    %mat = init_mat();
    $mat{"name"}          = "CarbonFiber";
    $mat{"description"}   = "CarbonFiber";
    $mat{"density"}       = "1.750";
    $mat{"ncomponents"}   = "2";
    $mat{"components"}    = "G4_C 0.745 Epoxy 0.255";
    print_mat(\%configuration, \%mat);
   
    
    
	
}


