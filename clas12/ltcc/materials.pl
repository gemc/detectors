use strict;
use warnings;

our %configuration;

# Table of optical photon energies (wavelengths) from 190-650 nm:
my @penergy = ( "2.034*eV", "4.136*eV" );

# Index of refraction of C4F10 gas:
my @irefr = ( 1.001331,  1.00143);


# Transparency of CO2 gas at STP:
# (completely transparent except at very short wavelengths below ~200 nm)
my @abslength = ( "10.*m",  "3*m");


# Table of optical photon energies (wavelengths) from 190-650 nm for the quartz PMT
my @penergyQ = ( "1.9074494*eV",  "1.9372533*eV",  "1.9680033*eV",  "1.9997453*eV",  "2.0325280*eV",
"2.0664035*eV",  "2.1014273*eV",  "2.1376588*eV",  "2.1751616*eV",  "2.2140038*eV",
"2.2542584*eV",  "2.2960039*eV",  "2.3393247*eV",  "2.3843117*eV",  "2.4310630*eV",
"2.4796842*eV",  "2.5302900*eV",  "2.5830044*eV",  "2.6379619*eV",  "2.6953089*eV",
"2.7552047*eV",  "2.8178230*eV",  "2.8833537*eV",  "2.9520050*eV",  "3.0240051*eV",
"3.0996053*eV",  "3.1790823*eV",  "3.2627424*eV",  "3.3509246*eV",  "3.4440059*eV",
"3.5424060*eV",  "3.6465944*eV",  "3.7570973*eV",  "3.8745066*eV",  "3.9994907*eV",
"4.1328070*eV",  "4.2753176*eV",  "4.4280075*eV",  "4.5920078*eV",  "4.7686235*eV",
"4.9593684*eV",  "5.1660088*eV",  "5.3906179*eV",  "5.6356459*eV",  "5.9040100*eV",
"6.1992105*eV",  "6.5254848*eV" );

# Index of refraction of HTCC PMT quartz window:
my @rindexLTCCpmt = ( 1.5420481,  1.5423678,  1.5427003,  1.5430465,  1.5434074,
1.5437840,  1.5441775,  1.5445893,  1.5450206,  1.5454731,
1.5459484,  1.5464485,  1.5469752,  1.5475310,  1.5481182,
1.5487396,  1.5493983,  1.5500977,  1.5508417,  1.5516344,
1.5524807,  1.5533859,  1.5543562,  1.5553983,  1.5565202,
1.5577308,  1.5590402,  1.5604602,  1.5620045,  1.5636888,
1.5655313,  1.5675538,  1.5697816,  1.5722449,  1.5749797,
1.5780296,  1.5814472,  1.5852971,  1.5896593,  1.5946337,
1.6003470,  1.6069618,  1.6146902,  1.6238138,  1.6347145,
1.6479224,  1.6641955 );


# Quantum efficiency of HTCC PMT with quartz window:
my @qeLTCCpmt = (0.0000000,     0.0014000,     0.0024000,     0.0040000,     0.0065000,
0.0105000,     0.0149000,     0.0216000,     0.0289000,     0.0376000,
0.0482000,     0.0609000,     0.0753000,     0.0916000,     0.1116000,
0.1265000,     0.1435000,     0.1602000,     0.1725000,     0.1892000,
0.2017000,     0.2122000,     0.2249000,     0.2344000,     0.2401000,
0.2418000,     0.2394000,     0.2372000,     0.2309000,     0.2291000,
0.2275000,     0.2301000,     0.2288000,     0.2236000,     0.2268000,
0.2240000,     0.2219000,     0.2219000,     0.2223000,     0.2189000,
0.2158000,     0.2093000,     0.2038000,     0.1950000,     0.1836000,
0.1612000,     0.1305000 );


sub materials
{
    # ltcc gas is C4F10 with optical properties
	my %mat = init_mat();
	$mat{"name"}          = "C4F10";
	$mat{"description"}   = "clas12 ltcc gas";
	$mat{"density"}       = "0.01012";
	$mat{"ncomponents"}   = "2";
	$mat{"components"}    = "G4_C 0.3 G4_F 0.7";
	$mat{"photonEnergy"}       = arrayToString(@penergy);
	$mat{"indexOfRefraction"}  = arrayToString(@irefr);
	$mat{"absorptionLength"}   = arrayToString(@abslength);
	print_mat(\%configuration, \%mat);
	
	
	# UV window of LTCC PMT:
	# - refractive index (required for tracking of optical photons)
	# - efficiency (for quantum efficiency of photocathode)
	# NOTE: in principle the quantum efficiency data of the photocathode
	# already includes the effects of reflection and transmission
	# at the interface between the window and the surrounding environment.
	# Therefore, it is possible that we are "double-counting" such effects
	# on the photo-electron yield by including the refractive index here.
	# However, only a small fraction of the light will be reflected by the
	# window in any case so we don't need to worry too much.
	%mat = init_mat();
	$mat{"name"}         = "LTCCPMTGlass";
	$mat{"description"}  = "refractive index and efficency of LTCC PMT glass window";
	$mat{"density"}      = "2.32";
	$mat{"ncomponents"}  = "1";
	$mat{"components"}   = "G4_SILICON_DIOXIDE 1.0";
	$mat{"photonEnergy"} = arrayToString(@penergyQ);
	$mat{"efficiency"}   = arrayToString(@qeLTCCpmt);
	$mat{"indexOfRefraction"} = arrayToString(@rindexLTCCpmt);
	print_mat(\%configuration, \%mat);

}


