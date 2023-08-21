#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use materials;

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
# for borosilicate it should be 1.473, put 1.40 to avoid internal reflections
# Mirazita
my @irefr_window_h8500 = ( 1.473,  1.473,  1.473,  1.473,  1.473,
1.473,  1.473,  1.473,  1.473,  1.473,
1.473,  1.473,  1.473,  1.473,  1.473,
1.473,  1.473,  1.473,  1.473,  1.473,
1.473,  1.473,  1.473,  1.473,  1.473,
1.473,  1.473,  1.473,  1.473,  1.473,
1.473,  1.473,  1.473,  1.473,  1.473,
1.473,  1.473,  1.473,  1.473,  1.473,
1.473,  1.473,  1.473,  1.473,  1.473,
1.473,  1.473,  1.473,  1.473,  1.473,
1.473,  1.473,  1.473,  1.473,  1.473,
1.473,  1.473,  1.473,  1.473,  1.473,
1.473,  1.473,  1.473,  1.473,  1.473,
1.473,  1.473,  1.473,  1.473,  1.473,
1.473 );


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



sub define_aerogel
{
    
    # typical index of refraction of an aerogel tile
	my %mat = init_mat();
	$mat{"name"}          = "aerogel";
	$mat{"name"}          = "aerogel";
	$mat{"description"}   = "typical aerogel properties";
	$mat{"density"}       = "0.24";
	$mat{"ncomponents"}   = "1";
	$mat{"components"}    = "G4_CARBON_DIOXIDE 1.0";
	$mat{"photonEnergy"}      = arrayToString(@penergy);
	$mat{"indexOfRefraction"} = arrayToString(@irefr_aerogel);
	$mat{"absorptionLength"}  = arrayToString(@abslength_aerogel);
	print_mat(\%configuration, \%mat);




}

sub define_aerogels
{
    my $sector = shift;
    my $sectorsuffix = "_s" . $sector;
    my %mat = init_mat();
    my $n400Fit = 1.0494; #TODO: do we still use this, or just refr. index from updated tables?

    # Computing the wavelength in microns from the energy
    my @wavelength;
    my $arrSize = @penergy;
    my $conversion = 1.2305;
    for(my $i=0; $i < $arrSize; $i++){
	my @array = split(/\*/, $penergy[$i]);
	my $lambda = $conversion / $array[0];
	$wavelength[$i] = $lambda;
	#printf(" E=%s   lambda=%f\n", $penergy[$i], $lambda);
    }

    if($sector eq "1"){   
	my $AerogelTable = "Aerogel_module2.txt";
	open (INFILE, "<$AerogelTable");
    }
    else{
        my $AerogelTable = "Aerogel_module1.txt";
        open (INFILE, "<$AerogelTable");
    }

    my $j = 1;
    while (<INFILE>) {

        chomp;
	my @array = split(/ /);

	my $sector = $array[0];
	my $layer = $array[1];
	my $component = $array[2];
	#printf(" layer %d  comp %d   rho=%f\n", $layer, $component, $density);

	my $n400 = $array[4];
	my $density = ($n400 * $n400  - 1) / 0.438;

	# refractive index calculation
	my $p1 = $array[5];
	my $p2 = $array[6];
	#printf("J=%d   n400=%f   p1=%f  p2=%f\n", $j, $n400, $p1, $p2);
	# RECALCULATE here the array irefr_aerogel using these parameters
	my @irefr_aerogel2;
	for(my $i=0; $i < $arrSize; $i++){
	    if ($p1 != 0 && $p2 != 0) {
		my $lambda = $wavelength[$i] * 1000;
		$irefr_aerogel2[$i] = $n400/$n400Fit * sqrt (1. + ($p1*$lambda*$lambda) / ($lambda*$lambda-$p2*$p2));
	    }
	    else {
		$irefr_aerogel2[$i] = 1.;
	    }
	}

	# transparency calculation
	my $thickness = $array[3];
	my $A0 = $array[7];
	my $Clarity = $array[9];
	# RECALCULATE here the array abslength_aerogel using these prameters
	my @abslength_aerogel2;
	for(my $i=0; $i < $arrSize; $i++){
	    if ($thickness != 0 && $A0 != 0 && $Clarity != 0) {
		my $lambda = $wavelength[$i];
		my $L = ($lambda*$lambda*$lambda*$lambda) / $Clarity;
		#if ($j == 100) {
		 #   printf("lambda=%f  C=%f   L=%f   Lref=%s\n", $lambda, $Clarity, $L, $abslength_aerogel[$i]);
		#}
		$abslength_aerogel2[$i] = $L . "*cm";
	    }
	    else {
		$abslength_aerogel2[$i] = "0*cm";
	    }
	}
    
    # typical index of refraction of an aerogel tile
#	my %mat = init_mat();
	$mat{"name"}          = "aerogel_sector" . $sector . "_layer" . $layer . "_component" . $component;
	$mat{"description"}   = "Aerogel tile " . $j;
	$mat{"density"}       = $density;
        #$mat{"density"}       = "0.24";
	$mat{"ncomponents"}   = "1";
        #$mat{"components"}    = "G4_CARBON_DIOXIDE 1.0";
	$mat{"components"}    = "G4_SILICON_DIOXIDE 1.0";
	$mat{"photonEnergy"}      = arrayToString(@penergy);
	$mat{"indexOfRefraction"} = arrayToString(@irefr_aerogel2);
	#$mat{"indexOfRefraction"} = arrayToString(@irefr_aerogel);
	$mat{"absorptionLength"}  = arrayToString(@abslength_aerogel2);
        #$mat{"absorptionLength"}  = arrayToString(@abslength_aerogel);
	print_mat(\%configuration, \%mat);

	$j = $j + 1;
    }
    close(INFILE);


}


sub define_MAPMT
{

	my %mat = init_mat();
	# materials for the H8500 window - BoromTriOxide
	$mat{"name"}          = "BoromTriOxide";
	$mat{"description"}   = "MAPMT window component";
	$mat{"density"}       = "2.55";  # in g/cm3
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "B 2 O 3";
	print_mat(\%configuration, \%mat);

	# materials for the H8500 window - MagnesiumOxide
	%mat = init_mat();
	$mat{"name"}          = "MagnesiumOxide";
	$mat{"description"}   = "MAPMT window component";
	$mat{"density"}       = "3.58";  # in g/cm3
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "Mg 1 O 1";
	print_mat(\%configuration, \%mat);

	# materials for the H8500 window - IronTriOxide
	%mat = init_mat();
	$mat{"name"}          = "IronTriOxide";
	$mat{"description"}   = "MAPMT window component";
	$mat{"density"}       = "5.242";  # in g/cm3
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "Fe 1 O 3";
	print_mat(\%configuration, \%mat);

	# materials for the H8500 window - SilicOxide
	%mat = init_mat();
	$mat{"name"}          = "SilicOxide";
	$mat{"description"}   = "MAPMT window component";
	$mat{"density"}       = "2.00";  # in g/cm3 --> CHECK THE DENSITY: questa me la sono inventata io!
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "Si 1 O 1";
	print_mat(\%configuration, \%mat);


	# materials for the H8500 window - SodMonOxide
	%mat = init_mat();
	$mat{"name"}          = "SodMonOxide";
	$mat{"description"}   = "MAPMT window component";
	$mat{"density"}       = "2.00";  # in g/cm3 --> CHECK THE DENSITY: questa me la sono inventata io!
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "N 1 O 1";
	print_mat(\%configuration, \%mat);

	# materials for the H8500 window - CalciumOxide
	%mat = init_mat();
	$mat{"name"}          = "CalciumOxide";
	$mat{"description"}   = "MAPMT window component";
	$mat{"density"}       = "3.3";  # in g/cm3 
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "Ca 1 O 1";
	print_mat(\%configuration, \%mat);

	# materials for the H8500 window - AluminiumOxide
	%mat = init_mat();
	$mat{"name"}          = "AluminiumOxide";
	$mat{"description"}   = "MAPMT window component";
	$mat{"density"}       = "3.97";  # in g/cm3
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "Al 2 O 3";
	print_mat(\%configuration, \%mat);


	# h8500 windows
	%mat = init_mat();
	$mat{"name"}          = "Glass_H8500";
	$mat{"description"}   = "MAPMT window";
	$mat{"density"}       = "2.76";  # in g/cm3
	$mat{"ncomponents"}   = "8";
	$mat{"components"}    = "G4_SILICON_DIOXIDE 0.8071 G4_BORON_OXIDE 0.126 G4_SODIUM_MONOXIDE 0.042 G4_ALUMINUM_OXIDE 0.022 G4_CALCIUM_OXIDE 0.001 G4_Cl 0.001 G4_MAGNESIUM_OXIDE 0.0005 G4_FERRIC_OXIDE 0.0004";
	$mat{"photonEnergy"}      = arrayToString(@penergy);
        $mat{"indexOfRefraction"} = arrayToString(@irefr_window_h8500);
        $mat{"absorptionLength"}  = arrayToString(@abslength_window_h8500);
 	print_mat(\%configuration, \%mat);

}


# To define an EFFECTIVE CFRP for Spherical Mirrors


sub define_CFRP
{
  #To verify

        my %mat = init_mat();

        # epoxy
	$mat{"name"}          = "epoxy";
	$mat{"description"}   = "epoxy glue 1.16 g/cm3";
	$mat{"density"}       = "1.16";
	$mat{"ncomponents"}   = "4";
	$mat{"components"}    = "H 32 N 2 O 4 C 15";
	print_mat(\%configuration, \%mat);
	
	
	# carbon fiber
  
  #to check with Sandro and Dario about the material (comment done on June 2017
	%mat = init_mat();
	$mat{"name"}          = "CarbonFiber";
	$mat{"description"}   = "ft carbon fiber material is epoxy and carbon - 1.75g/cm3";
	$mat{"density"}       = "1.75";
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "G4_C 0.745 epoxy 0.255";
	print_mat(\%configuration, \%mat);

}



#define_aerogel();
#define_aerogels();

#define_MAPMT();

#define_CFRP();

1;
