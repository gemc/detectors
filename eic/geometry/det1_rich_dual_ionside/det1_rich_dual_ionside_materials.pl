#!/usr/bin/perl -w

use strict;
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

	my @RichAerogel_PhoE=
	(   	"1.87855*eV","1.96673*eV","2.05490*eV","2.14308*eV","2.23126*eV",
		"2.31943*eV","2.40761*eV","2.49579*eV","2.58396*eV","2.67214*eV",
		"2.76032*eV","2.84849*eV","2.93667*eV","3.02485*eV","3.11302*eV",
		"3.20120*eV","3.28938*eV","3.37755*eV","3.46573*eV","3.55391*eV",
		"3.64208*eV","3.73026*eV","3.81844*eV","3.90661*eV","3.99479*eV",
		"4.08297*eV","4.17114*eV","4.25932*eV","4.34750*eV","4.43567*eV",
		"4.52385*eV","4.61203*eV","4.70020*eV","4.78838*eV","4.87656*eV",
		"4.96473*eV","5.05291*eV","5.14109*eV","5.22927*eV","5.31744*eV",
		"5.40562*eV","5.49380*eV","5.58197*eV","5.67015*eV","5.75833*eV",
		"5.84650*eV","5.93468*eV","6.02286*eV","6.11103*eV","6.19921*eV" );
	my @RichAerogel_Rind3=
	(   	"1.01825","1.01829","1.01834","1.01839","1.01844",
		"1.01849","1.01854","1.01860","1.01866","1.01872",
		"1.01878","1.01885","1.01892","1.01899","1.01906",
		"1.01914","1.01921","1.01929","1.01938","1.01946",
		"1.01955","1.01964","1.01974","1.01983","1.01993",
		"1.02003","1.02014","1.02025","1.02036","1.02047",
		"1.02059","1.02071","1.02084","1.02096","1.02109",
		"1.02123","1.02137","1.02151","1.02166","1.02181",
		"1.02196","1.02212","1.02228","1.02244","1.02261",
		"1.02279","1.02297","1.02315","1.02334","1.02354" );
	my @RichAerogel_Abs=
	(   	"17.5000*cm","17.7466*cm","17.9720*cm","18.1789*cm","18.3694*cm",
		"18.5455*cm","18.7086*cm","18.8602*cm","19.0015*cm","19.1334*cm",
		"19.2569*cm","19.3728*cm","19.4817*cm","19.5843*cm","19.6810*cm",
		"19.7725*cm","19.8590*cm","19.9410*cm","20.0188*cm","20.0928*cm",
		"18.4895*cm","16.0174*cm","13.9223*cm","12.1401*cm","10.6185*cm",
		"9.3147*cm","8.1940*cm","7.2274*cm","6.3913*cm","5.6659*cm",
		"5.0347*cm","4.4841*cm","4.0024*cm","3.5801*cm","3.2088*cm",
		"2.8817*cm","2.5928*cm","2.3372*cm","2.1105*cm","1.9090*cm",
		"1.7296*cm","1.5696*cm","1.4266*cm","1.2986*cm","1.1837*cm",
		"1.0806*cm","0.9877*cm","0.9041*cm","0.8286*cm","0.7603*cm" );
	my @RichAerogel_Scat=
	(   	"23.4256*cm","19.4987*cm","16.3612*cm","13.8302*cm","11.7702*cm",
		"10.0798*cm","8.6823*cm","7.5188*cm","6.5439*cm","5.7219*cm",
		"5.0251*cm","4.4312*cm","3.9225*cm","3.4847*cm","3.1064*cm",
		"2.7780*cm","2.4919*cm","2.2417*cm","2.0221*cm","1.8288*cm",
		"1.6580*cm","1.5067*cm","1.3723*cm","1.2525*cm","1.1455*cm",
		"1.0497*cm","0.9637*cm","0.8864*cm","0.8166*cm","0.7536*cm",
		"0.6965*cm","0.6448*cm","0.5977*cm","0.5549*cm","0.5159*cm",
		"0.4802*cm","0.4475*cm","0.4176*cm","0.3901*cm","0.3649*cm",
		"0.3417*cm","0.3203*cm","0.3005*cm","0.2822*cm","0.2653*cm",
		"0.2497*cm","0.2352*cm","0.2217*cm","0.2092*cm","0.1975*cm" );
	my @RichAerogel_Scat_scaled=
	( "35.1384*cm", "29.24805*cm", "24.5418*cm", "20.7453*cm", "17.6553*cm",
          "15.1197*cm", "13.02345*cm", "11.2782*cm", "9.81585*cm", "8.58285*cm",
          "7.53765*cm", "6.6468*cm", "5.88375*cm", "5.22705*cm", "4.6596*cm",
          "4.167*cm", "3.73785*cm", "3.36255*cm", "3.03315*cm", "2.7432*cm", 
          "2.487*cm", "2.26005*cm", "2.05845*cm", "1.87875*cm", "1.71825*cm",
          "1.57455*cm", "1.44555*cm", "1.3296*cm", "1.2249*cm", "1.1304*cm",
          "1.04475*cm", "0.9672*cm", "0.89655*cm", "0.83235*cm", "0.77385*cm",
          "0.7203*cm", "0.67125*cm", "0.6264*cm", "0.58515*cm", "0.54735*cm",
          "0.51255*cm", "0.48045*cm", "0.45075*cm", "0.4233*cm", "0.39795*cm",
          "0.37455*cm", "0.3528*cm", "0.33255*cm", "0.3138*cm", "0.29625*cm" );


=pod
for (my $f = 0; $f < 50; $f++)
  {
    $RichAerogel_Scat[$f] = $RichAerogel_Scat[$f]*1.5;
    print($RichAerogel_Scat[$f]);
    printf "*cm ";
  } 
=cut

#==================== Table of optical properties for Acrylic =====================#
my @PhotonEnergyBin = ( "2.034*eV",  "3.181*eV", "4.136*eV", "4.13281*eV", "6.19921*eV" );

my @AcRefrIndex = ( "1.4902", "1.5017", "1.5017" , "1.5017", "1.590" );

my @AcRefrIndex1 = ( 1.4902, 1.4907, 1.4913, 1.4918, 1.4924,
                  1.4930,  1.4936,  1.4942,  1.4948,  1.4954,
                  1.4960,  1.4965,  1.4971,  1.4977,  1.4983,
                  1.4991,  1.5002,  1.5017,  1.5017,  1.5017,
                  1.5017,  1.5017,  1.5017,  1.5017,  1.5017,
                  1.5017,  1.5017,  1.5017,  1.5017,  1.5017,
		  1.5017,  1.5017,  1.5017,  1.5017,  1.5017,
                  1.5017,  1.5017,  1.5017,  1.5017,  1.5017,
                  1.5017,  1.5017,  1.5017,  1.5017,  1.5017,
                  1.5017,  1.5017,  1.5017,  1.5017,  1.5017,
                  );

my @AcAbsLength = (  "5*cm", "4.5*cm", "4*mm", "1*mm", "0*mm"); 

my @AcAbsLength1=
	      (    "14.8495*cm" , "14.8495*cm" , "14.8495*cm" , "14.8495*cm" , "14.8495*cm" , 
                   "14.8495*cm" , "14.8495*cm" , "14.8495*cm" , "14.8495*cm" , "14.8495*cm" ,
                   "14.8495*cm" , "14.8495*cm" , "14.8495*cm" , "14.8495*cm" , "14.8495*cm" ,  
                   "14.8495*cm" , "14.8495*cm" , "14.8494*cm" , "14.8486*cm" , "14.844*cm" , 
                   "14.8198*cm" , "14.7023*cm" , "14.1905*cm" , "12.3674*cm" , "8.20704*cm" , 
                   "3.69138*cm" , "1.33325*cm" , "0.503627*cm" , "0.23393*cm" , "0.136177*cm" ,  
                   "0.0933192*cm" , "0.0708268*cm" , "0.0573082*cm" , "0.0483641*cm" , "0.0420282*cm" , 
                   "0.0373102*cm" , "0.033662*cm" , "0.0307572*cm" , "0.0283899*cm" , "0.0264235*cm" , 
                   "0.0247641*cm" , "0.0233451*cm" , "0.0221177*cm" , "0.0210456*cm" , "0.0201011*cm" , 
                   "0.0192627*cm" , "0.0185134*cm" , "0.0178398*cm" , "0.0172309*cm" , "0.0166779*cm"  );
#=======================================================================================#


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
	$mat{"photonEnergy"}      = "2*eV 2.5*eV 3*eV 3.5*eV 4*eV 7*eV";
	#$mat{"indexOfRefraction"} = "1.01992 1.02029 1.02074 1.02128";
	#$mat{"indexOfRefraction"} = "1.01963 1.01992 1.02029 1.02074 1.02128";
	$mat{"indexOfRefraction"} = "1.02 1.02 1.02 1.02 1.02 1.02";		
	$mat{"absorptionLength"}  = "30*cm 30*cm 30*cm 30*cm 30*cm 30*cm";
	#$mat{"rayleigh"} = "1.001 1.001 1.001 1.001 1.05";
	#$mat{"photonEnergy"}      = arrayToString(@RichAerogel_PhoE);
	#$mat{"indexOfRefraction"} = arrayToString(@RichAerogel_Rind3);
	#$mat{"absorptionLength"}  = arrayToString(@RichAerogel_Abs);
	#$mat{"rayleigh"} = arrayToString(@RichAerogel_Scat_scaled);
	print_mat(\%configuration, \%mat);

	# Lens Acrylic
 	%mat = init_mat();
 	$mat{"name"}          = "acrylic";
 	$mat{"description"}   = "eic rich lens material";
 	$mat{"density"}       = "1.19";  # in g/cm3
 	$mat{"ncomponents"}   = "3";
 	$mat{"components"}    = "C 5 H 8 O 2";
 	$mat{"photonEnergy"}      = arrayToString(@PhotonEnergyBin);
 	$mat{"indexOfRefraction"} = arrayToString(@AcRefrIndex);
 	$mat{"absorptionLength"}  = arrayToString(@AcAbsLength);
 	print_mat(\%configuration, \%mat);
	
=pod
	#CF4 gas
	%mat = init_mat();
	$mat{"name"}          = "MAT\_$DetectorName\_gas";
	$mat{"description"}   = "eic rich gas";
	#$mat{"density"}       = "0.00372";  # in g/cm3
        $mat{"density"}       = "0.00363285";  # in g/cm3 mixture 	
	#$mat{"ncomponents"}   = "2"; #CF4
	$mat{"ncomponents"}   = "3"; #mixture
	#$mat{"components"}    = "C 1 F 4";
        $mat{"components"}    = "C 50 F 190 O 5"; #CF4 - CO2 95/5 mixture
	$mat{"photonEnergy"}      = "2*eV 2.5*eV 3*eV 3.5*eV 4*eV 4.5*eV 5*eV 5.5*eV 6*eV 6.5*eV 7*eV";
	#$mat{"indexOfRefraction"} = "1.000482 1.000485 1.000488 1.000492 1.000497 1.000502 1.000509 1.000516 1.000524 1.000533 1.000543"; #pure CF4
        #$mat{"indexOfRefraction"} = "1.000480 1.000483 1.000486 1.000491 1.000496 1.000501 1.000508 1.000515 1.000524 1.000533 1.000544"; #mixture
	$mat{"indexOfRefraction"} = "1.00048 1.00048 1.00048 1.00048 1.00048 1.00048 1.00048 1.00048 1.00048 1.00048 1.00048";
	$mat{"absorptionLength"}  = "10*m 10*m 10*m 10*m 10*m 10*m 10*m 10*m 10*m 10*m 10*m";
	print_mat(\%configuration, \%mat);
=cut

	# Lens Acrylic
 	%mat = init_mat();
 	$mat{"name"}          = "acrylic_a";
 	$mat{"description"}   = "eic rich lens material";
 	$mat{"density"}       = "1.19";  # in g/cm3
 	$mat{"ncomponents"}   = "3";
 	$mat{"components"}    = "C 5 H 8 O 2";
 	$mat{"photonEnergy"}      = arrayToString(@RichAerogel_PhoE);
 	$mat{"indexOfRefraction"} = arrayToString(@AcRefrIndex1);
 	$mat{"absorptionLength"}  = arrayToString(@AcAbsLength1);

 	print_mat(\%configuration, \%mat);

	#C2F6 gas
	%mat = init_mat();
	$mat{"name"}          = "MAT\_$DetectorName\_gas";
	$mat{"description"}   = "eic rich gas";
	$mat{"density"}       = "0.005734";  # in g/cm3	
	$mat{"ncomponents"}   = "2"; #C2F6
	$mat{"components"}    = "C 2 F 6";
	$mat{"photonEnergy"}      = "2*eV 2.5*eV 3*eV 3.5*eV 4*eV 4.5*eV 5*eV 5.5*eV 6*eV 6.5*eV 7*eV";
	#$mat{"indexOfRefraction"} = "1.000823 1.000829 1.000835 1.000843 1.000852 1.000863 1.000875 1.000889 1.000905 1.000923 1.000943"; #pure C2F6
	$mat{"indexOfRefraction"} = "1.000823 1.000823 1.000823 1.000823 1.000823 1.000823 1.000823 1.000823 1.000823 1.000823 1.000823";
	$mat{"absorptionLength"}  = "10*m 10*m 10*m 10*m 10*m 10*m 10*m 10*m 10*m 10*m 10*m";
	print_mat(\%configuration, \%mat);


}

define_material();
