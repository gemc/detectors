use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_beamline_magnet_ele';

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

sub det1_beamline_magnet_ele_quadrupole
{
my $NUM  =  8+8+16;
my @name =(
"upstream_quadrupole1_outer","upstream_quadrupole2_outer","upstream_quadrupole3_outer","downstream_quadrupole1_outer","downstream_quadrupole2_outer","downstream_quadrupole3_outer","downstream_quadrupole4_outer","downstream_quadrupole5_outer",
"upstream_quadrupole1_inner","upstream_quadrupole2_inner","upstream_quadrupole3_inner","downstream_quadrupole1_inner","downstream_quadrupole2_inner","downstream_quadrupole3_inner","downstream_quadrupole4_inner","downstream_quadrupole5_inner",
"upstream_quadrupole1_front","upstream_quadrupole2_front","upstream_quadrupole3_front","downstream_quadrupole1_front","downstream_quadrupole2_front","downstream_quadrupole3_front","downstream_quadrupole4_front","downstream_quadrupole5_front",
"upstream_quadrupole1_back","upstream_quadrupole2_back","upstream_quadrupole3_back","downstream_quadrupole1_back","downstream_quadrupole2_back","downstream_quadrupole3_back","downstream_quadrupole4_back","downstream_quadrupole5_back",
);
my @mother = (
"$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother",
"$DetectorName\_upstream_quadrupole1_outer","$DetectorName\_upstream_quadrupole2_outer","$DetectorName\_upstream_quadrupole3_outer","$DetectorName\_downstream_quadrupole1_outer","$DetectorName\_downstream_quadrupole2_outer","$DetectorName\_downstream_quadrupole3_outer","$DetectorName\_downstream_quadrupole4_outer","$DetectorName\_downstream_quadrupole5_outer",
"$DetectorName\_upstream_quadrupole1_inner","$DetectorName\_upstream_quadrupole2_inner","$DetectorName\_upstream_quadrupole3_inner","$DetectorName\_downstream_quadrupole1_inner","$DetectorName\_downstream_quadrupole2_inner","$DetectorName\_downstream_quadrupole3_inner","$DetectorName\_downstream_quadrupole4_inner","$DetectorName\_downstream_quadrupole5_inner",
"$DetectorName\_upstream_quadrupole1_inner","$DetectorName\_upstream_quadrupole2_inner","$DetectorName\_upstream_quadrupole3_inner","$DetectorName\_downstream_quadrupole1_inner","$DetectorName\_downstream_quadrupole2_inner","$DetectorName\_downstream_quadrupole3_inner","$DetectorName\_downstream_quadrupole4_inner","$DetectorName\_downstream_quadrupole5_inner",
);
my @mat  = (
"Kryptonite","Kryptonite","Kryptonite","Kryptonite","Kryptonite","Kryptonite","Kryptonite","Kryptonite",
"Vacuum","Vacuum","Vacuum","Vacuum","Vacuum","Vacuum","Vacuum","Vacuum",
"Vacuum","Vacuum","Vacuum","Vacuum","Vacuum","Vacuum","Vacuum","Vacuum",
"Vacuum","Vacuum","Vacuum","Vacuum","Vacuum","Vacuum","Vacuum","Vacuum",
);
my @z    = (
$e_us_quad1_Z,$e_us_quad2_Z,$e_us_quad3_Z,$e_ds_quad1_Z,$e_ds_quad2_Z,$e_ds_quad3_Z,$e_ds_quad4_Z,$e_ds_quad5_Z,
0,0,0,0,0,0,0,0,
0.5*$e_us_quad1_length-1e-10,0.5*$e_us_quad2_length-1e-10,0.5*$e_us_quad3_length-1e-10,0.5*$e_ds_quad1_length-1e-10,0.5*$e_ds_quad2_length-1e-10,0.5*$e_ds_quad3_length-1e-10,0.5*$e_ds_quad4_length-1e-10,0.5*$e_ds_quad5_length-1e-10,
-0.5*$e_us_quad1_length+1e-10,-0.5*$e_us_quad2_length+1e-10,-0.5*$e_us_quad3_length+1e-10,-0.5*$e_ds_quad1_length+1e-10,-0.5*$e_ds_quad2_length+1e-10,-0.5*$e_ds_quad3_length+1e-10,-0.5*$e_ds_quad4_length+1e-10,-0.5*$e_ds_quad5_length+1e-10,
);
my @x    = (
$e_us_quad1_X,$e_us_quad2_X,$e_us_quad3_X,$e_ds_quad1_X,$e_ds_quad2_X,$e_ds_quad3_X,$e_ds_quad4_X,$e_ds_quad5_X,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
);
my @Rin  = (
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,
);
my @Rout = (
$e_us_quad1_outerhalfaperture,$e_us_quad2_outerhalfaperture,$e_us_quad3_outerhalfaperture,$e_ds_quad1_outerhalfaperture,$e_ds_quad2_outerhalfaperture,$e_ds_quad3_outerhalfaperture,$e_ds_quad4_outerhalfaperture,$e_ds_quad5_outerhalfaperture,
$e_us_quad1_innerhalfaperture,$e_us_quad2_innerhalfaperture,$e_us_quad3_innerhalfaperture,$e_ds_quad1_innerhalfaperture,$e_ds_quad2_innerhalfaperture,$e_ds_quad3_innerhalfaperture,$e_ds_quad4_innerhalfaperture,$e_ds_quad5_innerhalfaperture,
$e_us_quad1_innerhalfaperture,$e_us_quad2_innerhalfaperture,$e_us_quad3_innerhalfaperture,$e_ds_quad1_innerhalfaperture,$e_ds_quad2_innerhalfaperture,$e_ds_quad3_innerhalfaperture,$e_ds_quad4_innerhalfaperture,$e_ds_quad5_innerhalfaperture,
$e_us_quad1_innerhalfaperture,$e_us_quad2_innerhalfaperture,$e_us_quad3_innerhalfaperture,$e_ds_quad1_innerhalfaperture,$e_ds_quad2_innerhalfaperture,$e_ds_quad3_innerhalfaperture,$e_ds_quad4_innerhalfaperture,$e_ds_quad5_innerhalfaperture,
);
my @Dz   = (
0.5*$e_us_quad1_length,0.5*$e_us_quad2_length,0.5*$e_us_quad3_length,0.5*$e_ds_quad1_length,0.5*$e_ds_quad2_length,0.5*$e_ds_quad3_length,0.5*$e_ds_quad4_length,0.5*$e_ds_quad5_length,
0.5*$e_us_quad1_length,0.5*$e_us_quad2_length,0.5*$e_us_quad3_length,0.5*$e_ds_quad1_length,0.5*$e_ds_quad2_length,0.5*$e_ds_quad3_length,0.5*$e_ds_quad4_length,0.5*$e_ds_quad5_length,
1e-10,1e-10,1e-10,1e-10,1e-10,1e-10,1e-10,1e-10,1e-10,1e-10,1e-10,
1e-10,1e-10,1e-10,1e-10,1e-10,1e-10,1e-10,1e-10,1e-10,1e-10,1e-10,
);
my @rot  = (
-1*$e_us_quad1_Theta,-1*$e_us_quad2_Theta,-1*$e_us_quad3_Theta,-1*$e_ds_quad1_Theta,-1*$e_ds_quad2_Theta,-1*$e_ds_quad3_Theta,-1*$e_ds_quad4_Theta,-1*$e_ds_quad5_Theta,
0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,
0,0,0,0,0,0,0,0,0,0,0,
);
my @field = (
"no","no","no","no","no","no","no","no",
"det1_ele_upstream_quadrupole1_simple","det1_ele_upstream_quadrupole2_simple","det1_ele_upstream_quadrupole3_simple","det1_ele_downstream_quadrupole1_simple","det1_ele_downstream_quadrupole2_simple","det1_ele_downstream_quadrupole3_simple","det1_ele_downstream_quadrupole4_simple","det1_ele_downstream_quadrupole5_simple",
"no","no","no","no","no","no","no","no",
"no","no","no","no","no","no","no","no",
);
# my @field = (
# "no","no","no","no","no","no","no","no",
# "no","no","no","no","no","no","no","no",
# "no","no","no","no","no","no","no","no",
# "no","no","no","no","no","no","no","no",
# );
my @color = (
"aa00ff","aa00ff","aa00ff","aa00ff","aa00ff","aa00ff","aa00ff","aa00ff",  #blue
"CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA", #background
"CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA",
"CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA",
);
my @sen = (
"no","no","no","no","no","no","no","no",
"no","no","no","no","no","no","no","no",
"flux","flux","flux","flux","flux","flux","flux","flux",
"flux","flux","flux","flux","flux","flux","flux","flux",
);
my @hit = (
"no","no","no","no","no","no","no","no",
"no","no","no","no","no","no","no","no",
"flux","flux","flux","flux","flux","flux","flux","flux",
"flux","flux","flux","flux","flux","flux","flux","flux",
);
my @id = (
"no","no","no","no","no","no","no","no",
"no","no","no","no","no","no","no","no",
"id manual 21211","id manual 21221","id manual 21231","id manual 22211","id manual 22221","id manual 22231","id manual 22241","id manual 22251",
"id manual 21212","id manual 21222","id manual 21232","id manual 22212","id manual 22222","id manual 22232","id manual 22242","id manual 22252",
);

# == id name ==============================================================
# digit     beamline                side          magnet      number          window
#        ion    1        upstream    1    dipole    1           n     front      1
#        ele    2       downstream   2  quadrupole  2                 back       2
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

