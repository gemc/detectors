#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/io");
use utils;
use mirrors;


# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   materials.pl <configuration filename>\n";
 	print "   Will create the a simple mirror\n";
	exit;
}

# Make sure the argument list is correct
# If not pring the help
if( scalar @ARGV != 1)
{
	help();
	exit;
}

# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);


# Below is an actual measurement of Reflectivity as a function of wavelength
# for the CLAS12 HTCC mirror.

# Table of optical photon energies (wavelengths) from 190-650 nm:
=pod
my $penergy =
"  1.9074494*eV  1.9372533*eV  1.9680033*eV  1.9997453*eV  2.0325280*eV " .
"  2.0664035*eV  2.1014273*eV  2.1376588*eV  2.1751616*eV  2.2140038*eV " .
"  2.2542584*eV  2.2960039*eV  2.3393247*eV  2.3843117*eV  2.4310630*eV " .
"  2.4796842*eV  2.5302900*eV  2.5830044*eV  2.6379619*eV  2.6953089*eV " .
"  2.7552047*eV  2.8178230*eV  2.8833537*eV  2.9520050*eV  3.0240051*eV " .
"  3.0996053*eV  3.1790823*eV  3.2627424*eV  3.3509246*eV  3.4440059*eV " .
"  3.5424060*eV  3.6465944*eV  3.7570973*eV  3.8745066*eV  3.9994907*eV " .
"  4.1328070*eV  4.2753176*eV  4.4280075*eV  4.5920078*eV  4.7686235*eV " .
"  4.9593684*eV  5.1660088*eV  5.3906179*eV  5.6356459*eV  5.9040100*eV " .
"  6.1992105*eV  ";

# Reflectivity of AlMgF2 coated on thermally shaped acrylic sheets, measured by AJRP, 10/01/2012:
my $reflectivity =
"  0.8331038     0.8309071     0.8279127     0.8280742     0.8322623 " .
"  0.837572      0.8396875     0.8481834     0.8660284     0.8611336 " .
"  0.8566167     0.8667431     0.86955       0.8722481     0.8728122 " .
"  0.8771635     0.879907      0.879761      0.8831943     0.8894673 " .
"  0.8984234     0.9009531     0.8910166     0.8887382     0.8869093 " .
"  0.8941976     0.8948479     0.8877356     0.9026919     0.8999685 " .
"  0.9101617     0.8983005     0.8991694     0.8990987     0.9000493 " .
"  0.9065833     0.9028855     0.8985184     0.9009736     0.9086968 " .
"  0.9015145     0.8914838     0.8816829     0.8666895     0.8496298 " .
"  0.9042583 ";
=cut
# Photon energy bins
my @PhotonEnergyBin = ( "1.7712*eV", "6.1992*eV" );
my @Reflectivity = ( 0.95, 0.95 );

my @PhotonEnergyBin1 = ( "2.04358*eV", "2.0664*eV", "2.09046*eV", "2.14023*eV", 
"2.16601*eV", "2.20587*eV", "2.23327*eV", "2.26137*eV", 
"2.31972*eV", "2.35005*eV", "2.38116*eV", "2.41313*eV", 
"2.44598*eV", "2.47968*eV", "2.53081*eV", "2.58354*eV", 
"2.6194*eV", "2.69589*eV", "2.73515*eV", "2.79685*eV", 
"2.86139*eV", "2.95271*eV", "3.04884*eV", "3.12665*eV", 
"3.2393*eV", "3.39218*eV", "3.52508*eV", "3.66893*eV",
"3.82396*eV", "3.99949*eV", "4.13281*eV", "4.27679*eV", 
"4.48244*eV", "4.65057*eV", "4.89476*eV", "5.02774*eV", 
"5.16816*eV", "5.31437*eV", "5.63821*eV", "5.90401*eV", 
"6.19921*eV");

my @Reflectivity1 = (0.8678125, 0.8651562, 0.8639063, 0.8637500,
0.8640625, 0.8645313, 0.8643750, 0.8656250,
0.8653125, 0.8650000, 0.8648437, 0.8638281, 
0.8635156, 0.8631250, 0.8621875, 0.8617188,
0.8613281, 0.8610156, 0.8610938, 0.8616016,
0.8623047, 0.8637500, 0.8655859, 0.8673828,
0.8700586, 0.8741992, 0.8781055, 0.8825195,
0.8876172, 0.8937207, 0.8981836, 0.9027441,
0.9078369, 0.9102002, 0.9093164, 0.9061743,
0.9004223, 0.8915210, 0.8599536, 0.8208313,
0.7625024);

#my @Reflectivity = ( 1., 1. );


sub print_mirror
{
 	# the first argument to this function become the variation
	$configuration{"variation"} = shift;

	my %mir = init_mir();
	$mir{"name"}         = "spherical_mirror";
	$mir{"description"}  = "reflective mirrors for eic rich";
	$mir{"type"}         = "dielectric_dielectric";
	$mir{"finish"}       = "polishedfrontpainted";
	$mir{"model"}        = "unified";
	$mir{"border"} 	     = "SkinSurface";
	$mir{"photonEnergy"} = arrayToString(@PhotonEnergyBin1);
	$mir{"reflectivity"} = arrayToString(@Reflectivity1);
	print_mir(\%configuration, \%mir);

}

print_mirror("Original");









