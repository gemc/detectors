#!/usr/bin/perl -w

use strict;
# use warnings;
use lib ("$ENV{GEMC}/io");
use parameters;
use utils;
use geometry;
use hit;
use bank;
use math;

use Getopt::Long;
use Math::Trig;

my $config_file   = $ARGV[0];
our %configuration = load_configuration($config_file);

# One can change the "variation" here if one is desired different from the config.dat
$configuration{"detector_name"} = "../geometry/det1_beamline_magnet/det1_beamline_magnet";
$configuration{"variation"} = "Original";

# To get the parameters proper authentication is needed.
our %parameters    = get_parameters(%configuration);

# there are 3 dipole in ion downstream

#length in m, halfaperture in cm, streng in T or T/m, X in m, Z in m, Theta in rad
my $i_ds_dipole1_length			= $parameters{"i_ds_dipole1_length"};
my $i_ds_dipole1_innerhalfaperture	= $parameters{"i_ds_dipole1_innerhalfaperture"};
my $i_ds_dipole1_outerhalfaperture	= $parameters{"i_ds_dipole1_outerhalfaperture"};
my $i_ds_dipole1_strength		= $parameters{"i_ds_dipole1_strength"};
my $i_ds_dipole1_X			= $parameters{"i_ds_dipole1_X"};
my $i_ds_dipole1_Z			= $parameters{"i_ds_dipole1_Z"};
my $i_ds_dipole1_Theta			= $parameters{"i_ds_dipole1_Theta"};
my $i_ds_dipole2_length			= $parameters{"i_ds_dipole2_length"};
my $i_ds_dipole2_innerhalfaperture	= $parameters{"i_ds_dipole2_innerhalfaperture"};
my $i_ds_dipole2_outerhalfaperture	= $parameters{"i_ds_dipole2_outerhalfaperture"};
my $i_ds_dipole2_strength		= $parameters{"i_ds_dipole2_strength"};
my $i_ds_dipole2_X			= $parameters{"i_ds_dipole2_X"};
my $i_ds_dipole2_Z			= $parameters{"i_ds_dipole2_Z"};
my $i_ds_dipole2_Theta			= $parameters{"i_ds_dipole2_Theta"};
my $i_ds_dipole3_length			= $parameters{"i_ds_dipole3_length"};
my $i_ds_dipole3_innerhalfaperture	= $parameters{"i_ds_dipole3_innerhalfaperture"};
my $i_ds_dipole3_outerhalfaperture	= $parameters{"i_ds_dipole3_outerhalfaperture"};
my $i_ds_dipole3_strength		= $parameters{"i_ds_dipole3_strength"};
my $i_ds_dipole3_X			= $parameters{"i_ds_dipole3_X"};
my $i_ds_dipole3_Z			= $parameters{"i_ds_dipole3_Z"};
my $i_ds_dipole3_Theta			= $parameters{"i_ds_dipole3_Theta"};


# there are 4 quadrupole in ion downstream and 3 quadrupole in ion upstream 

#length in m, halfaperture in cm, streng in T or T/m, X in m, Z in m, Theta in rad
my $i_ds_quad1_length		= $parameters{"i_ds_quad1_length"};
my $i_ds_quad1_innerhalfaperture= $parameters{"i_ds_quad1_innerhalfaperture"};
my $i_ds_quad1_outerhalfaperture= $parameters{"i_ds_quad1_outerhalfaperture"};
my $i_ds_quad1_strength		= $parameters{"i_ds_quad1_strength"};
my $i_ds_quad1_X		= $parameters{"i_ds_quad1_X"};
my $i_ds_quad1_Z		= $parameters{"i_ds_quad1_Z"};
my $i_ds_quad1_Theta		= $parameters{"i_ds_quad1_Theta"};
my $i_ds_quad2_length		= $parameters{"i_ds_quad2_length"};
my $i_ds_quad2_innerhalfaperture= $parameters{"i_ds_quad2_innerhalfaperture"};
my $i_ds_quad2_outerhalfaperture= $parameters{"i_ds_quad2_outerhalfaperture"};
my $i_ds_quad2_strength		= $parameters{"i_ds_quad2_strength"};
my $i_ds_quad2_X		= $parameters{"i_ds_quad2_X"};
my $i_ds_quad2_Z		= $parameters{"i_ds_quad2_Z"};
my $i_ds_quad2_Theta		= $parameters{"i_ds_quad2_Theta"};
my $i_ds_quad3_length		= $parameters{"i_ds_quad3_length"};
my $i_ds_quad3_innerhalfaperture= $parameters{"i_ds_quad3_innerhalfaperture"};
my $i_ds_quad3_outerhalfaperture= $parameters{"i_ds_quad3_outerhalfaperture"};
my $i_ds_quad3_strength		= $parameters{"i_ds_quad3_strength"};
my $i_ds_quad3_X		= $parameters{"i_ds_quad3_X"};
my $i_ds_quad3_Z		= $parameters{"i_ds_quad3_Z"};
my $i_ds_quad3_Theta		= $parameters{"i_ds_quad3_Theta"};
my $i_ds_quad4_length		= $parameters{"i_ds_quad4_length"};
my $i_ds_quad4_innerhalfaperture= $parameters{"i_ds_quad4_innerhalfaperture"};
my $i_ds_quad4_outerhalfaperture= $parameters{"i_ds_quad4_outerhalfaperture"};
my $i_ds_quad4_strength		= $parameters{"i_ds_quad4_strength"};
my $i_ds_quad4_X		= $parameters{"i_ds_quad4_X"};
my $i_ds_quad4_Z		= $parameters{"i_ds_quad4_Z"};
my $i_ds_quad4_Theta		= $parameters{"i_ds_quad4_Theta"};

my $i_us_quad1_length		= $parameters{"i_us_quad1_length"};
my $i_us_quad1_innerhalfaperture= $parameters{"i_us_quad1_innerhalfaperture"};
my $i_us_quad1_outerhalfaperture= $parameters{"i_us_quad1_outerhalfaperture"};
my $i_us_quad1_strength		= $parameters{"i_us_quad1_strength"};
my $i_us_quad1_X		= $parameters{"i_us_quad1_X"};
my $i_us_quad1_Z		= $parameters{"i_us_quad1_Z"};
my $i_us_quad1_Theta		= $parameters{"i_us_quad1_Theta"};
my $i_us_quad2_length		= $parameters{"i_us_quad2_length"};
my $i_us_quad2_innerhalfaperture= $parameters{"i_us_quad2_innerhalfaperture"};
my $i_us_quad2_outerhalfaperture= $parameters{"i_us_quad2_outerhalfaperture"};
my $i_us_quad2_strength		= $parameters{"i_us_quad2_strength"};
my $i_us_quad2_X		= $parameters{"i_us_quad2_X"};
my $i_us_quad2_Z		= $parameters{"i_us_quad2_Z"};
my $i_us_quad2_Theta		= $parameters{"i_us_quad2_Theta"};
my $i_us_quad3_length		= $parameters{"i_us_quad3_length"};
my $i_us_quad3_innerhalfaperture= $parameters{"i_us_quad3_innerhalfaperture"};
my $i_us_quad3_outerhalfaperture= $parameters{"i_us_quad3_outerhalfaperture"};
my $i_us_quad3_strength		= $parameters{"i_us_quad3_strength"};
my $i_us_quad3_X		= $parameters{"i_us_quad3_X"};
my $i_us_quad3_Z		= $parameters{"i_us_quad3_Z"};
my $i_us_quad3_Theta		= $parameters{"i_us_quad3_Theta"};

# there are 6 dipole in ele downstream

#length in m, halfaperture in cm, streng in T or T/m, X in m, Z in m, Theta in rad
my $e_ds_dipole1_length			= $parameters{"e_ds_dipole1_length"};
my $e_ds_dipole1_innerhalfaperture	= $parameters{"e_ds_dipole1_innerhalfaperture"};
my $e_ds_dipole1_outerhalfaperture	= $parameters{"e_ds_dipole1_outerhalfaperture"};
my $e_ds_dipole1_strength		= $parameters{"e_ds_dipole1_strength"};
my $e_ds_dipole1_X			= $parameters{"e_ds_dipole1_X"};
my $e_ds_dipole1_Z			= $parameters{"e_ds_dipole1_Z"};
my $e_ds_dipole1_Theta			= $parameters{"e_ds_dipole1_Theta"};
my $e_ds_dipole2_length			= $parameters{"e_ds_dipole2_length"};
my $e_ds_dipole2_innerhalfaperture	= $parameters{"e_ds_dipole2_innerhalfaperture"};
my $e_ds_dipole2_outerhalfaperture	= $parameters{"e_ds_dipole2_outerhalfaperture"};
my $e_ds_dipole2_strength		= $parameters{"e_ds_dipole2_strength"};
my $e_ds_dipole2_X			= $parameters{"e_ds_dipole2_X"};
my $e_ds_dipole2_Z			= $parameters{"e_ds_dipole2_Z"};
my $e_ds_dipole2_Theta			= $parameters{"e_ds_dipole2_Theta"};
my $e_ds_dipole2a_length		= $parameters{"e_ds_dipole2a_length"};
my $e_ds_dipole2a_innerhalfaperture	= $parameters{"e_ds_dipole2a_innerhalfaperture"};
my $e_ds_dipole2a_outerhalfaperture	= $parameters{"e_ds_dipole2a_outerhalfaperture"};
my $e_ds_dipole2a_strength		= $parameters{"e_ds_dipole2a_strength"};
my $e_ds_dipole2a_X			= $parameters{"e_ds_dipole2a_X"};
my $e_ds_dipole2a_Z			= $parameters{"e_ds_dipole2a_Z"};
my $e_ds_dipole2a_Theta			= $parameters{"e_ds_dipole2a_Theta"};
my $e_ds_dipole3a_length		= $parameters{"e_ds_dipole3a_length"};
my $e_ds_dipole3a_innerhalfaperture	= $parameters{"e_ds_dipole3a_innerhalfaperture"};
my $e_ds_dipole3a_outerhalfaperture	= $parameters{"e_ds_dipole3a_outerhalfaperture"};
my $e_ds_dipole3a_strength		= $parameters{"e_ds_dipole3a_strength"};
my $e_ds_dipole3a_X			= $parameters{"e_ds_dipole3a_X"};
my $e_ds_dipole3a_Z			= $parameters{"e_ds_dipole3a_Z"};
my $e_ds_dipole3a_Theta			= $parameters{"e_ds_dipole3a_Theta"};
my $e_ds_dipole3_length			= $parameters{"e_ds_dipole3_length"};
my $e_ds_dipole3_innerhalfaperture	= $parameters{"e_ds_dipole3_innerhalfaperture"};
my $e_ds_dipole3_outerhalfaperture	= $parameters{"e_ds_dipole3_outerhalfaperture"};
my $e_ds_dipole3_strength		= $parameters{"e_ds_dipole3_strength"};
my $e_ds_dipole3_X			= $parameters{"e_ds_dipole3_X"};
my $e_ds_dipole3_Z			= $parameters{"e_ds_dipole3_Z"};
my $e_ds_dipole3_Theta			= $parameters{"e_ds_dipole3_Theta"};
my $e_ds_dipole4_length			= $parameters{"e_ds_dipole4_length"};
my $e_ds_dipole4_innerhalfaperture	= $parameters{"e_ds_dipole4_innerhalfaperture"};
my $e_ds_dipole4_outerhalfaperture	= $parameters{"e_ds_dipole4_outerhalfaperture"};
my $e_ds_dipole4_strength		= $parameters{"e_ds_dipole4_strength"};
my $e_ds_dipole4_X			= $parameters{"e_ds_dipole4_X"};
my $e_ds_dipole4_Z			= $parameters{"e_ds_dipole4_Z"};
my $e_ds_dipole4_Theta			= $parameters{"e_ds_dipole4_Theta"};

# there are 5 quadrupole in ele downstream and 3 quadrupole in ele upstream 

#length in m, halfaperture in cm, streng in T or T/m, X in m, Z in m, Theta in rad
my $e_ds_quad1_length		= $parameters{"e_ds_quad1_length"};
my $e_ds_quad1_innerhalfaperture= $parameters{"e_ds_quad1_innerhalfaperture"};
my $e_ds_quad1_outerhalfaperture= $parameters{"e_ds_quad1_outerhalfaperture"};
my $e_ds_quad1_strength		= $parameters{"e_ds_quad1_strength"};
my $e_ds_quad1_X		= $parameters{"e_ds_quad1_X"};
my $e_ds_quad1_Z		= $parameters{"e_ds_quad1_Z"};
my $e_ds_quad1_Theta		= $parameters{"e_ds_quad1_Theta"};
my $e_ds_quad2_length		= $parameters{"e_ds_quad2_length"};
my $e_ds_quad2_innerhalfaperture= $parameters{"e_ds_quad2_innerhalfaperture"};
my $e_ds_quad2_outerhalfaperture= $parameters{"e_ds_quad2_outerhalfaperture"};
my $e_ds_quad2_strength		= $parameters{"e_ds_quad2_strength"};
my $e_ds_quad2_X		= $parameters{"e_ds_quad2_X"};
my $e_ds_quad2_Z		= $parameters{"e_ds_quad2_Z"};
my $e_ds_quad2_Theta		= $parameters{"e_ds_quad2_Theta"};
my $e_ds_quad3_length		= $parameters{"e_ds_quad3_length"};
my $e_ds_quad3_innerhalfaperture= $parameters{"e_ds_quad3_innerhalfaperture"};
my $e_ds_quad3_outerhalfaperture= $parameters{"e_ds_quad3_outerhalfaperture"};
my $e_ds_quad3_strength		= $parameters{"e_ds_quad3_strength"};
my $e_ds_quad3_X		= $parameters{"e_ds_quad3_X"};
my $e_ds_quad3_Z		= $parameters{"e_ds_quad3_Z"};
my $e_ds_quad3_Theta		= $parameters{"e_ds_quad3_Theta"};
my $e_ds_quad4_length		= $parameters{"e_ds_quad4_length"};
my $e_ds_quad4_innerhalfaperture= $parameters{"e_ds_quad4_innerhalfaperture"};
my $e_ds_quad4_outerhalfaperture= $parameters{"e_ds_quad4_outerhalfaperture"};
my $e_ds_quad4_strength		= $parameters{"e_ds_quad4_strength"};
my $e_ds_quad4_X		= $parameters{"e_ds_quad4_X"};
my $e_ds_quad4_Z		= $parameters{"e_ds_quad4_Z"};
my $e_ds_quad4_Theta		= $parameters{"e_ds_quad4_Theta"};
my $e_ds_quad5_length		= $parameters{"e_ds_quad5_length"};
my $e_ds_quad5_innerhalfaperture= $parameters{"e_ds_quad5_innerhalfaperture"};
my $e_ds_quad5_outerhalfaperture= $parameters{"e_ds_quad5_outerhalfaperture"};
my $e_ds_quad5_strength		= $parameters{"e_ds_quad5_strength"};
my $e_ds_quad5_X		= $parameters{"e_ds_quad5_X"};
my $e_ds_quad5_Z		= $parameters{"e_ds_quad5_Z"};
my $e_ds_quad5_Theta		= $parameters{"e_ds_quad5_Theta"};

my $e_us_quad1_length		= $parameters{"e_us_quad1_length"};
my $e_us_quad1_innerhalfaperture= $parameters{"e_us_quad1_innerhalfaperture"};
my $e_us_quad1_outerhalfaperture= $parameters{"e_us_quad1_outerhalfaperture"};
my $e_us_quad1_strength		= $parameters{"e_us_quad1_strength"};
my $e_us_quad1_X		= $parameters{"e_us_quad1_X"};
my $e_us_quad1_Z		= $parameters{"e_us_quad1_Z"};
my $e_us_quad1_Theta		= $parameters{"e_us_quad1_Theta"};
my $e_us_quad2_length		= $parameters{"e_us_quad2_length"};
my $e_us_quad2_innerhalfaperture= $parameters{"e_us_quad2_innerhalfaperture"};
my $e_us_quad2_outerhalfaperture= $parameters{"e_us_quad2_outerhalfaperture"};
my $e_us_quad2_strength		= $parameters{"e_us_quad2_strength"};
my $e_us_quad2_X		= $parameters{"e_us_quad2_X"};
my $e_us_quad2_Z		= $parameters{"e_us_quad2_Z"};
my $e_us_quad2_Theta		= $parameters{"e_us_quad2_Theta"};
my $e_us_quad3_length		= $parameters{"e_us_quad3_length"};
my $e_us_quad3_innerhalfaperture= $parameters{"e_us_quad3_innerhalfaperture"};
my $e_us_quad3_outerhalfaperture= $parameters{"e_us_quad3_outerhalfaperture"};
my $e_us_quad3_strength		= $parameters{"e_us_quad3_strength"};
my $e_us_quad3_X		= $parameters{"e_us_quad3_X"};
my $e_us_quad3_Z		= $parameters{"e_us_quad3_Z"};
my $e_us_quad3_Theta		= $parameters{"e_us_quad3_Theta"};


# my $file = $configuration{"detector_name"}."__geometry_".$varia.".txt";
my $NUM=24;
my @file = (
"det1_ion_downstream_dipole1_simple",
"det1_ion_downstream_dipole2_simple",
"det1_ion_downstream_dipole3_simple",
"det1_ion_downstream_quadrupole1_simple",
"det1_ion_downstream_quadrupole2_simple",
"det1_ion_downstream_quadrupole3_simple",
"det1_ion_downstream_quadrupole4_simple",
"det1_ion_upstream_quadrupole1_simple",
"det1_ion_upstream_quadrupole2_simple",
"det1_ion_upstream_quadrupole3_simple",
"det1_ele_downstream_dipole1_simple",
"det1_ele_downstream_dipole2_simple",
"det1_ele_downstream_dipole2a_simple",
"det1_ele_downstream_dipole3a_simple",
"det1_ele_downstream_dipole3_simple",
"det1_ele_downstream_dipole4_simple",
"det1_ele_downstream_quadrupole1_simple",
"det1_ele_downstream_quadrupole2_simple",
"det1_ele_downstream_quadrupole3_simple",
"det1_ele_downstream_quadrupole4_simple",
"det1_ele_downstream_quadrupole5_simple",
"det1_ele_upstream_quadrupole1_simple",
"det1_ele_upstream_quadrupole2_simple",
"det1_ele_upstream_quadrupole3_simple",
);
my @Npole=(
2,2,2,
4,4,4,4,
4,4,4,
2,2,2,2,2,2,
4,4,4,4,4,
4,4,4
);
my @scale=(
$i_ds_dipole1_strength,$i_ds_dipole2_strength,$i_ds_dipole3_strength,
$i_ds_quad1_strength,$i_ds_quad2_strength,$i_ds_quad3_strength,$i_ds_quad4_strength,
$i_us_quad1_strength,$i_us_quad2_strength,$i_us_quad3_strength,
$e_ds_dipole1_strength,$e_ds_dipole2_strength,$e_ds_dipole2a_strength,$e_ds_dipole3a_strength,$e_ds_dipole3_strength,$e_ds_dipole4_strength,
$e_ds_quad1_strength,$e_ds_quad2_strength,$e_ds_quad3_strength,$e_ds_quad4_strength,$e_ds_quad5_strength,
$e_us_quad1_strength,$e_us_quad2_strength,$e_us_quad3_strength,
);
my @x=(
$i_ds_dipole1_X,$i_ds_dipole2_X,$i_ds_dipole3_X,
$i_ds_quad1_X,$i_ds_quad2_X,$i_ds_quad3_X,$i_ds_quad4_X,
$i_us_quad1_X,$i_us_quad2_X,$i_us_quad3_X,
$e_ds_dipole1_X,$e_ds_dipole2_X,$e_ds_dipole2a_X,$e_ds_dipole3a_X,$e_ds_dipole3_X,$e_ds_dipole4_X,
$e_ds_quad1_X,$e_ds_quad2_X,$e_ds_quad3_X,$e_ds_quad4_X,$e_ds_quad5_X,
$e_us_quad1_X,$e_us_quad2_X,$e_us_quad3_X,
);
my @z=(
$i_ds_dipole1_Z,$i_ds_dipole2_Z,$i_ds_dipole3_Z,
$i_ds_quad1_Z,$i_ds_quad2_Z,$i_ds_quad3_Z,$i_ds_quad4_Z,
$i_us_quad1_Z,$i_us_quad2_Z,$i_us_quad3_Z,
$e_ds_dipole1_Z,$e_ds_dipole2_Z,$e_ds_dipole2a_Z,$e_ds_dipole3a_Z,$e_ds_dipole3_Z,$e_ds_dipole4_Z,
$e_ds_quad1_Z,$e_ds_quad2_Z,$e_ds_quad3_Z,$e_ds_quad4_Z,$e_ds_quad5_Z,
$e_us_quad1_Z,$e_us_quad2_Z,$e_us_quad3_Z,
);
my @rot=(
$i_ds_dipole1_Theta,$i_ds_dipole2_Theta,$i_ds_dipole3_Theta,
$i_ds_quad1_Theta,$i_ds_quad2_Theta,$i_ds_quad3_Theta,$i_ds_quad4_Theta,
$i_us_quad1_Theta,$i_us_quad2_Theta,$i_us_quad3_Theta,
$e_ds_dipole1_Theta,$e_ds_dipole2_Theta,$e_ds_dipole2a_Theta,$e_ds_dipole3a_Theta,$e_ds_dipole3_Theta,$e_ds_dipole4_Theta,
$e_ds_quad1_Theta,$e_ds_quad2_Theta,$e_ds_quad3_Theta,$e_ds_quad4_Theta,$e_ds_quad5_Theta,
$e_us_quad1_Theta,$e_us_quad2_Theta,$e_us_quad3_Theta,
);

for(my $n=0; $n<$NUM; $n++)
{
my $filename=sprintf("%s.dat",$file[$n]);
`rm -f $filename`;
print "Overwriting if existing: ", $filename, "\n";
open(INFO, ">>$filename");
printf INFO ("<mfield>\n");
printf INFO ("<description name=\"%s\" factory=\"ASCII\" comment=\"%s\"/>\n",$file[$n],$file[$n]);
printf INFO ("<symmetry type=\"multipole\" format=\"simple\" integration=\"RungeKutta\" minStep=\"1*mm\"/>\n");
printf INFO ("<dimension Npole=\"%i\" scale=\"%s\" Bunit=\"T\" x=\"%s\" y=\"0\" z=\"%s\" XYZunit=\"m\" rot=\"%s\" ROTunit=\"rad\" ROTaxis=\"Y\"/>\n",$Npole[$n],$scale[$n],$x[$n],$z[$n],$rot[$n]);
printf INFO ("<mfield>\n");
close(INFO);
}

