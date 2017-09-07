use strict;
use warnings;

our %configuration;



sub materials
{
	my $thisVariation = $configuration{"variation"} ;
	
	# rohacell
	my %mat = init_mat();
	$mat{"name"}          = "rohacell";
	$mat{"description"}   = "target  rohacell scattering chamber material";
	$mat{"density"}       = "0.1";  # 100 mg/cm3
	$mat{"ncomponents"}   = "4";
	$mat{"components"}    = "G4_C 0.6465 G4_H 0.0784 G4_N 0.0839 G4_O 0.1912";
	print_mat(\%configuration, \%mat);


	# epoxy
	%mat = init_mat();
	$mat{"name"}          = "epoxy";
	$mat{"description"}   = "epoxy glue 1.16 g/cm3";
	$mat{"density"}       = "1.16";
	$mat{"ncomponents"}   = "4";
	$mat{"components"}    = "H 32 N 2 O 4 C 15";
	print_mat(\%configuration, \%mat);


	# carbon fiber
	%mat = init_mat();
	$mat{"name"}          = "carbonFiber";
	$mat{"description"}   = "ft carbon fiber material is epoxy and carbon - 1.75g/cm3";
	$mat{"density"}       = "1.75";
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "G4_C 0.745 epoxy 0.255";
	print_mat(\%configuration, \%mat);

	if($thisVariation eq "ND3")
	{
		#my %mat = init_mat();
		#$mat{"name"}          = "solidND3";
		#$mat{"description"}   = "solid ND3 target";
		#$mat{"density"}       = "1.007";  # 1.007 g/cm3
		#$mat{"ncomponents"}   = "1";
		#$mat{"components"}    = "ND3 1";
		#print_mat(\%configuration, \%mat);
		my %mat = init_mat();
		$mat{"name"}          = "lHe";
		$mat{"description"}   = "liquid helium";
		$mat{"density"}        = "0.145";  # 0.145 g/cm3 <—————————————
		$mat{"ncomponents"}   = "1";
		$mat{"components"}    = "G4_He 1";
		print_mat(\%configuration, \%mat);
		
		%mat = init_mat();
		my $my_density = 0.6*1.007+0.4*0.145; # 60% of ND3 and 40% of liquid-helium
		my $ND3_mass_fraction=0.6*1.007/$my_density;
		my $lHe_mass_fraction=0.4*0.145/$my_density;
		$mat{"name"}          = "solidND3";
		$mat{"description"}   = "solid ND3 target";
		$mat{"density"}        =  $my_density;
		$mat{"ncomponents"}   = "2";
		$mat{"components"}    = "ND3 $ND3_mass_fraction lHe $lHe_mass_fraction";
		print_mat(\%configuration, \%mat);
	}
}
