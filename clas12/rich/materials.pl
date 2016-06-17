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


# Table of optical photon energies:
my @penergy = ( "1.3778*eV",  "1.3933*eV",  "1.4091*eV",  "1.4253*eV",  "1.4419*eV",
		"1.4588*eV",  "1.4762*eV",  "1.4940*eV",  "1.5122*eV",  "1.5309*eV",
		"1.5500*eV",  "1.5696*eV",  "1.5897*eV",  "1.6104*eV",  "1.6316*eV",
		"1.6533*eV",  "1.6757*eV",  "1.6986*eV",  "1.7222*eV",  "1.7465*eV",
		"1.7714*eV",  "1.7971*eV",  "1.8235*eV",  "1.8507*eV",  "1.8788*eV",
		"1.9077*eV",  "1.9375*eV",  "1.9683*eV",  "2.0000*eV",  "2.0328*eV",
		"2.0667*eV",  "2.1017*eV",  "2.1379*eV",  "2.1754*eV",  "2.2143*eV",
		"2.2545*eV",  "2.2963*eV",  "2.3396*eV",  "2.3846*eV",  "2.4314*eV",
		"2.4800*eV",  "2.5306*eV",  "2.5833*eV",  "2.6383*eV",  "2.6957*eV",
		"2.7556*eV",  "2.8182*eV",  "2.8837*eV",  "2.9524*eV",	"3.0244*eV",   
		"3.1000*eV",  "3.1795*eV",  "3.2632*eV",  "3.3514*eV", 	"3.4444*eV",   
		"3.5429*eV",  "3.6471*eV",  "3.7576*eV",  "3.8750*eV", 	"4.0000*eV",   
		"4.1333*eV",  "4.2759*eV",  "4.4286*eV",  "4.5926*eV",  "4.7692*eV",   
		"4.9600*eV",  "5.1667*eV",  "5.3913*eV",  "5.6364*eV",  "5.9048*eV",   
		"6.2000*eV" );

# ------- H8500/12700 window optical properties ------

# Index of refraction of the pmt window
my @irefr_window_h8500 = ( 1.49,  1.49,  1.49,  1.49,  1.49,
			   1.49,  1.49,  1.49,  1.49,  1.49,
			   1.49,  1.49,  1.49,  1.49,  1.49,
			   1.49,  1.49,  1.49,  1.49,  1.49,
			   1.49,  1.49,  1.49,  1.49,  1.49,
			   1.49,  1.49,  1.49,  1.49,  1.49,
			   1.49,  1.49,  1.49,  1.49,  1.49,
			   1.49,  1.49,  1.49,  1.49,  1.49,
			   1.49,  1.49,  1.49,  1.49,  1.49,
			   1.49,  1.49,  1.49,  1.49,  1.49,
			   1.49,  1.49,  1.49,  1.49,  1.49,
			   1.49,  1.49,  1.49,  1.49,  1.49,
			   1.49,  1.49,  1.49,  1.49,  1.49,
			   1.49,  1.49,  1.49,  1.49,  1.49,
			   1.49 );


# Absorption coefficient for H8500 window glass
my @abslength_window_h8500 = ( "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",
			       "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",
			       "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",
			       "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",
			       "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",
			       "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",
			       "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",
			       "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",
			       "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",
			       "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",
			       "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",
			       "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",
			       "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",
			       "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",  "42.0000*m",
			       "42.0000*m" );

# ------- gas in gap optical properties ---------

# Index of refraction of air:
my @irefr_gas_in_gap = ( 1.00,  1.00,  1.00,  1.00,  1.00,
			     1.00,  1.00,  1.00,  1.00,  1.00,
			     1.00,  1.00,  1.00,  1.00,  1.00,
			     1.00,  1.00,  1.00,  1.00,  1.00,
			     1.00,  1.00,  1.00,  1.00,  1.00,
			     1.00,  1.00,  1.00,  1.00,  1.00,
			     1.00,  1.00,  1.00,  1.00,  1.00,
			     1.00,  1.00,  1.00,  1.00,  1.00,
			     1.00,  1.00,  1.00,  1.00,  1.00,
			     1.00,  1.00,  1.00,  1.00,  1.00,
			     1.00,  1.00,  1.00,  1.00,  1.00,
			     1.00,  1.00,  1.00,  1.00,  1.00,
			     1.00,  1.00,  1.00,  1.00,  1.00,
			     1.00,  1.00,  1.00,  1.00,  1.00,
			     1.00 );

# absorption is the same of the window

# -------- aerogel properties ----------

# Index of refraction of the pmt window
my @irefr_aerogel = ( 1.04709, 1.0471 , 1.04712, 1.04713, 1.04715,
		      1.04717, 1.04718, 1.0472 , 1.04722 ,1.04723,
		      1.04725, 1.04727 ,1.04729, 1.04731 ,1.04733 ,
		      1.04735 ,1.04737 ,1.04739 ,1.04741 ,1.04743 ,
		      1.04746 ,1.04748 ,1.04751 ,1.04753 ,1.04756 ,
		      1.04759 ,1.04761 ,1.04764 ,1.04768 ,1.04771 ,
		      1.04774 ,1.04778 ,1.04781 ,1.04785 ,1.04789 ,
		      1.04794 ,1.04798 ,1.04803 ,1.04808 ,1.04813 ,
		      1.04819 ,1.04825 ,1.04831 ,1.04838 ,1.04845 ,
		      1.04853 ,1.04861 ,1.0487  ,1.04879 ,1.04889 ,
		      1.049   ,1.04912 ,1.04925 ,1.04939 ,1.04954 ,
		      1.04971 ,1.04989 ,1.05009 ,1.05031 ,1.05056 ,
		      1.05084 ,1.05115 ,1.0515  ,1.0519  ,1.05236 ,
		      1.05289 ,1.0535  ,1.05422 ,1.05508 ,1.05611 ,
		      1.05737 ) ;


# Absorption coefficient for aerogel
my @abslength_aerogel = ( "29.2394*cm",   "28.9562*cm",   "28.6784*cm",   "26.8925*cm",   "27.8637*cm",
			  "28.062*cm",    "27.7242*cm",   "27.1399*cm",   "26.7512*cm",   "26.2139*cm",
			  "26.0152*cm",   "25.4976*cm",   "25.0999*cm",   "24.6385*cm",   "24.2303*cm",
			  "23.7303*cm",   "23.2742*cm",   "22.696*cm",    "22.0729*cm",   "21.5874*cm",
			  "21.2631*cm",   "20.7086*cm",   "20.1605*cm",   "19.6154*cm",   "19.061*cm",
			  "18.4774*cm",   "17.8838*cm",   "17.2989*cm",   "16.6933*cm",   "16.0711*cm",
			  "15.4677*cm",   "14.8278*cm",   "14.2079*cm",   "13.5876*cm",   "12.9715*cm",
			  "12.372*cm",    "11.757*cm",    "11.1353*cm",   "10.5343*cm",   "9.94904*cm",
			  "9.45342*cm",   "9.01897*cm",   "8.3964*cm",    "7.8098*cm",    "7.32422*cm",
			  "6.91571*cm",   "6.45606*cm",   "5.98628*cm",   "5.54014*cm",   "5.11227*cm",
			  "4.69784*cm",   "4.3044*cm",    "3.93536*cm",   "3.58572*cm",   "3.24993*cm",
			  "2.93707*cm",   "2.64329*cm",   "2.36809*cm",   "2.10761*cm",   "1.86117*cm",
			  "1.62074*cm",   "1.40979*cm",   "1.21606*cm",   "1.04008*cm",   "0.887008*cm",
			  "0.753044*cm",  "0.630981*cm",  "0.516107*cm",  "0.409999*cm",  "0.314334*cm",
			  "0.242124*cm" );


sub print_materials
{
    # typical index of refraction of an aerogel tile
	my %mat = init_mat();
	$mat{"name"}          = "aerogel";
	$mat{"description"}   = "typical aerogel properties";
	$mat{"density"}       = "0.24";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_CARBON_DIOXIDE 1.0";
	$mat{"photonEnergy"}      = arrayToString(@penergy);
	$mat{"indexOfRefraction"} = arrayToString(@irefr_aerogel);
	$mat{"absorptionLength"}  = arrayToString(@abslength_aerogel);
	print_mat(\%configuration, \%mat);

	%mat = init_mat();
	$mat{"name"}          = "rohacell31";
	$mat{"description"}   = "htcc gas is 100% CO2 with optical properties";
	$mat{"density"}       = "0.032";
	$mat{"ncomponents"}   = "4";
	$mat{"components"}    = "G4_C 0.6463 G4_H 0.0784 G4_N 0.0839 G4_O 0.1914";
	print_mat(\%configuration, \%mat);

}


sub define_material
{

        my %mat = init_mat();

        # epoxy
	$mat{"name"}          = "epoxy";
	$mat{"description"}   = "epoxy glue 1.16 g/cm3";
	$mat{"density"}       = "1.16";
	$mat{"ncomponents"}   = "4";
	$mat{"components"}    = "H 32 N 2 O 4 C 15";
	print_mat(\%configuration, \%mat);
	
	
	# carbon fiber
	%mat = init_mat();
	$mat{"name"}          = "CarbonFiber";
	$mat{"description"}   = "ft carbon fiber material is epoxy and carbon - 1.75g/cm3";
	$mat{"density"}       = "1.75";
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "G4_C 0.745 epoxy 0.255";
	print_mat(\%configuration, \%mat);


        # gas_ingap
	%mat = init_mat();
        $mat{"name"}          = "Gas_inGap";
        $mat{"description"}   = "gas in gap";
        $mat{"density"}       = "0.00129";  # in g/cm3
        $mat{"ncomponents"}   = "2";
        $mat{"components"}    = "C 1 O 2";
        $mat{"photonEnergy"}      = arrayToString(@penergy);
        $mat{"indexOfRefraction"} = arrayToString(@irefr_gas_in_gap);
        $mat{"absorptionLength"}  = arrayToString(@abslength_window_h8500);
        print_mat(\%configuration, \%mat);

	# h8500 windows
	%mat = init_mat();
	$mat{"name"}          = "Glass_H8500";
	$mat{"description"}   = "Glass_H8500";
	$mat{"density"}       = "2.76";  # in g/cm3
	$mat{"ncomponents"}   = "8";
	$mat{"components"}    = "G4_SILICON_DIOXIDE 0.8071 G4_BORON_OXIDE 0.126 G4_SODIUM_MONOXIDE 0.042 G4_ALUMINUM_OXIDE 0.022 G4_CALCIUM_OXIDE 0.001 G4_Cl 0.001 G4_MAGNESIUM_OXIDE 0.0005 G4_FERRIC_OXIDE 0.0004";
	$mat{"photonEnergy"}      = arrayToString(@penergy);
        $mat{"indexOfRefraction"} = arrayToString(@irefr_window_h8500);
        $mat{"absorptionLength"}  = arrayToString(@abslength_window_h8500);
 	print_mat(\%configuration, \%mat);

	# NOV105_2cm_cern6_tile1
	%mat = init_mat();
	$mat{"name"}          = "NOV105_2cm_cern6_tile1";
	$mat{"description"}   = "NOV105_2cm_cern6_tile1";
	$mat{"density"}       = "0.24";  # in g/cm3
	$mat{"ncomponents"}   = "1";
#	$mat{"components"}    = "AerogelQuartz 97.0 H2O 3";
	$mat{"components"}    = "G4_SILICON_DIOXIDE 1.0";
	print_mat(\%configuration, \%mat);

}


sub define_photocatode_materials
{

	my %mat = init_mat();
	# materials for the H8500 window - BoromTriOxide
	$mat{"name"}          = "BoromTriOxide";
	$mat{"description"}   = "BoromTriOxide";
	$mat{"density"}       = "2.55";  # in g/cm3
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "B 2 O 3";
	print_mat(\%configuration, \%mat);

	# materials for the H8500 window - MagnesiumOxide
	%mat = init_mat();
	$mat{"name"}          = "MagnesiumOxide";
	$mat{"description"}   = "MagnesiumOxide";
	$mat{"density"}       = "3.58";  # in g/cm3
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "Mg 1 O 1";
	print_mat(\%configuration, \%mat);

	# materials for the H8500 window - IronTriOxide
	%mat = init_mat();
	$mat{"name"}          = "IronTriOxide";
	$mat{"description"}   = "IronTriOxide";
	$mat{"density"}       = "5.242";  # in g/cm3
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "Fe 1 O 3";
	print_mat(\%configuration, \%mat);

	# materials for the H8500 window - SilicOxide
	%mat = init_mat();
	$mat{"name"}          = "SilicOxide";
	$mat{"description"}   = "SilicOxide";
	$mat{"density"}       = "2.00";  # in g/cm3 --> CHECK THE DENSITY: questa me la sono inventata io!
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "Si 1 O 1";
	print_mat(\%configuration, \%mat);


	# materials for the H8500 window - SodMonOxide
	%mat = init_mat();
	$mat{"name"}          = "SodMonOxide";
	$mat{"description"}   = "SodMonOxide";
	$mat{"density"}       = "2.00";  # in g/cm3 --> CHECK THE DENSITY: questa me la sono inventata io!
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "N 1 O 1";
	print_mat(\%configuration, \%mat);

	# materials for the H8500 window - CalciumOxide
	%mat = init_mat();
	$mat{"name"}          = "CalciumOxide";
	$mat{"description"}   = "CalciumOxide";
	$mat{"density"}       = "3.3";  # in g/cm3 
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "Ca 1 O 1";
	print_mat(\%configuration, \%mat);

	# materials for the H8500 window - AluminiumOxide
	%mat = init_mat();
	$mat{"name"}          = "AluminiumOxide";
	$mat{"description"}   = "AluminiumOxide";
	$mat{"density"}       = "3.97";  # in g/cm3
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "Al 2 O 3";
	print_mat(\%configuration, \%mat);


}

define_material();

print_materials();

define_photocatode_materials();
