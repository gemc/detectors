use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_beamline_magnet_ion';

# there are 2 solenoid in ion beamline

#length in m, halfaperture in cm, streng in T or T/m, X in m, Z in m, Theta in rad
my $i_us_sol1_length		= $parameters{"i_us_sol1_length"};
my $i_us_sol1_innerhalfaperture	= $parameters{"i_us_sol1_innerhalfaperture"};
my $i_us_sol1_outerhalfaperture	= $parameters{"i_us_sol1_outerhalfaperture"};
my $i_us_sol1_strength		= $parameters{"i_us_sol1_strength"};
my $i_us_sol1_X			= $parameters{"i_us_sol1_X"};
my $i_us_sol1_Z			= $parameters{"i_us_sol1_Z"};
my $i_us_sol1_Theta		= $parameters{"i_us_sol1_Theta"};
my $i_ds_sol1_length		= $parameters{"i_ds_sol1_length"};
my $i_ds_sol1_innerhalfaperture	= $parameters{"i_ds_sol1_innerhalfaperture"};
my $i_ds_sol1_outerhalfaperture	= $parameters{"i_ds_sol1_outerhalfaperture"};
my $i_ds_sol1_strength		= $parameters{"i_ds_sol1_strength"};
my $i_ds_sol1_X			= $parameters{"i_ds_sol1_X"};
my $i_ds_sol1_Z			= $parameters{"i_ds_sol1_Z"};
my $i_ds_sol1_Theta		= $parameters{"i_ds_sol1_Theta"};

sub det1_beamline_magnet_ion_solenoid
{
my $NUM  = 2+2+2+2;
my @name =(
"upstream_solenoid1_outer","downstream_solenoid1_outer",
"upstream_solenoid1_inner","downstream_solenoid1_inner",
"upstream_solenoid1_front","downstream_solenoid1_front",
"upstream_solenoid1_back","downstream_solenoid1_back",
);
my @mother = (
"$DetectorMother","$DetectorMother",
"$DetectorName\_upstream_solenoid1_outer","$DetectorName\_downstream_solenoid1_outer",
"$DetectorName\_upstream_solenoid1_inner","$DetectorName\_downstream_solenoid1_inner",
"$DetectorName\_upstream_solenoid1_inner","$DetectorName\_downstream_solenoid1_inner",
);
my @mat  = (
"Kryptonite","Kryptonite",
"Vacuum","Vacuum",
"Vacuum","Vacuum",
"Vacuum","Vacuum",
);
my @z    = (
$i_us_sol1_Z,$i_ds_sol1_Z,
0,0,
-0.5*$i_us_sol1_length+1e-10,-0.5*$i_ds_sol1_length+1e-10,
0.5*$i_us_sol1_length-1e-10,0.5*$i_ds_sol1_length-1e-10,
);
my @x    = (
$i_us_sol1_X,$i_ds_sol1_X,
0,0,
0,0,
0,0,
);
my @Rin  = (
0,0,
0,0,
0,0,
0,0,
);
my @Rout = (
$i_us_sol1_outerhalfaperture,$i_ds_sol1_outerhalfaperture,
$i_us_sol1_innerhalfaperture,$i_ds_sol1_innerhalfaperture,
$i_us_sol1_innerhalfaperture,$i_ds_sol1_innerhalfaperture,
$i_us_sol1_innerhalfaperture,$i_ds_sol1_innerhalfaperture,
);
my @Dz   = (
0.5*$i_us_sol1_length,0.5*$i_ds_sol1_length,
0.5*$i_us_sol1_length,0.5*$i_ds_sol1_length,
1e-10,1e-10,
1e-10,1e-10,
);
my @rot  = (
-1*$i_us_sol1_Theta,-1*$i_ds_sol1_Theta,
0,0,
0,0,
0,0,
);
my @field = (
"no","no",
# "det1_ion_upstream_solenoid1_simple","det1_ion_upstream_solenoid2_simple","det1_ion_downstream_solenoid1_simple","det1_ion_downstream_solenoid2_simple",
"no","no",
"no","no",
"no","no",
);
my @color = (
"ffaaff","ffaaff",  #
"CDE6FA","CDE6FA", #background
"CDE6FA","CDE6FA",
"CDE6FA","CDE6FA",
);
my @sen = (
"no","no",
"no","no",
"flux","flux",
"flux","flux",
);
my @hit = (
"no","no",
"no","no",
"flux","flux",
"flux","flux",
);
my @id = (
"no","no",
"no","no",
"id manual 11311","id manual 12311",
"id manual 11312","id manual 12312",
);


# == id name ==============================================================
# digit     beamline                side          magnet      number          window
#        ion    1        upstream    1    dipole    1           n     front      1
#        ele    2       downstream   2  quadrupole  2                 back       2
#                                         solenoid  3
#                                          virtual  9
# =========================================================================


 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "$x[$n-1]*m 0*m $z[$n-1]*m";
    $detector{"rotation"}   = "0*rad $rot[$n-1]*rad 0*rad";
    $detector{"color"}      = $color[$n-1]; 
    $detector{"type"}       = "Tube";
    $detector{"dimensions"} = "$Rin[$n-1]*cm $Rout[$n-1]*cm $Dz[$n-1]*m 0*deg 360*deg";
    $detector{"material"}   = $mat[$n-1];
    $detector{"mfield"}     = $field[$n-1];
    $detector{"ncopy"}      = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = $sen[$n-1];
    $detector{"hit_type"}    = $hit[$n-1];
    $detector{"identifiers"} = $id[$n-1];
     print_det(\%configuration, \%detector);
 }
}
1;