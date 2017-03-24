use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_beamline_magnet_ion';

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

sub det1_beamline_magnet_ion_dipole
{
 my $NUM  = 3+3+6;
#  my @z    = (549.3049269,1977.32-10*sin(1.49/180*3.1416),0,0,-50+0.001,-200+0.001,50-0.001,200-0.001);
#  my @x    = (27.6382445,101.53+10*cos(1.49/180*3.1416),0,0,0,0,0,0);

#  my @z    = (5.493049269,19.77317656,0,0,-0.50+0.00001,-2+0.00001,0.50-0.00001,2-0.00001);
#  my @x    = (0.276382445,1.015262863,0,0,0,0,0,0);
#  my @Dx  = (21,41,20,40,20,40,20,40);
#  my @Dy = (21,41,20,40,20,40,20,40);
#  my @Dz   = (50,200,50,200,0.001,0.001,0.001,0.001);
#  my @rot  = (-0.052998004/3.1415926*180,-0.025996009/3.1415926*180,0,0,0,0,0,0);
my @name = ("downstream_dipole1_outer","downstream_dipole2_outer","downstream_dipole3_outer","downstream_dipole1_inner","downstream_dipole2_inner","downstream_dipole3_inner","downstream_dipole1_front","downstream_dipole2_front","downstream_dipole3_front","downstream_dipole1_back","downstream_dipole2_back","downstream_dipole3_back");
my @mother = ("$DetectorMother","$DetectorMother","$DetectorMother","$DetectorName\_downstream_dipole1_outer","$DetectorName\_downstream_dipole2_outer","$DetectorName\_downstream_dipole3_outer","$DetectorName\_downstream_dipole1_inner","$DetectorName\_downstream_dipole2_inner","$DetectorName\_downstream_dipole3_inner","$DetectorName\_downstream_dipole1_inner","$DetectorName\_downstream_dipole2_inner","$DetectorName\_downstream_dipole3_inner"); 
my @mat  = ("Kryptonite","Kryptonite","Kryptonite","Vacuum","Vacuum","Vacuum","Vacuum","Vacuum","Vacuum","Vacuum","Vacuum","Vacuum");
#dipole 2 has addtional shift by 0.1m to outside while keep its tilting angle, so z is shift by either positive or negative amount depending on tilting angle is postive or negative, x is shift by negative amount
# my @z  = (
# $i_ds_dipole1_Z,$i_ds_dipole2_Z+0.1*sin($i_ds_dipole2_Theta),
# 0,0,
# -0.5*$i_ds_dipole1_length+1e-10,-0.5*$i_ds_dipole2_length+1e-10,
# 0.5*$i_ds_dipole1_length-1e-10,0.5*$i_ds_dipole2_length-1e-10
# );
my @z  = (
$i_ds_dipole1_Z,$i_ds_dipole2_Z,$i_ds_dipole3_Z,
0,0,0,
-0.5*$i_ds_dipole1_length+1e-10,-0.5*$i_ds_dipole2_length+1e-10,-0.5*$i_ds_dipole3_length+1e-10,
0.5*$i_ds_dipole1_length-1e-10,0.5*$i_ds_dipole2_length-1e-10,0.5*$i_ds_dipole3_length-1e-10
);
my @x  = ($i_ds_dipole1_X,$i_ds_dipole2_X,$i_ds_dipole3_X,0,0,0,0,0,0,0,0,0);
# my @x  = ($i_ds_dipole1_X,$i_ds_dipole2_X-0.1*cos($i_ds_dipole2_Theta),0,0,0,0,0,0);
my @Rin  = (
0,0,0,
5,0,0,
5,0,0,
5,0,0,
);
my @Rout = (
$i_ds_dipole1_outerhalfaperture,$i_ds_dipole2_outerhalfaperture,$i_ds_dipole3_outerhalfaperture,
$i_ds_dipole1_innerhalfaperture,$i_ds_dipole2_innerhalfaperture,$i_ds_dipole3_innerhalfaperture,
$i_ds_dipole1_innerhalfaperture,$i_ds_dipole2_innerhalfaperture,$i_ds_dipole3_innerhalfaperture,
$i_ds_dipole1_innerhalfaperture,$i_ds_dipole2_innerhalfaperture,$i_ds_dipole3_innerhalfaperture,
);
my @Dz = (
0.5*$i_ds_dipole1_length,0.5*$i_ds_dipole2_length,0.5*$i_ds_dipole3_length,
0.5*$i_ds_dipole1_length,0.5*$i_ds_dipole2_length,0.5*$i_ds_dipole3_length,
1e-10,1e-10,1e-10,
1e-10,1e-10,1e-10,
);
my @rot  = (-1*$i_ds_dipole1_Theta,-1*$i_ds_dipole2_Theta,-1*$i_ds_dipole3_Theta,0,0,0,0,0,0,0,0,0);
my @color = ("00FF00","00FF00","00FF00","CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA");#lime and bg
my @field = ("no","no","no","det1_ion_downstream_dipole1_simple","det1_ion_downstream_dipole2_simple","det1_ion_downstream_dipole3_simple","no","no","no","no","no","no");
my @sen = ("no","no","no","no","no","no","flux","flux","flux","flux","flux","flux");
my @hit = ("no","no","no","no","no","no","flux","flux","flux","flux","flux","flux");
my @id = ("no","no","no","no","no","no","id manual 12111","id manual 12121","id manual 12131","id manual 12112","id manual 12122","id manual 12132");

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
#     $detector{"visible"}     = 1;
    if ($n%3==1) {     $detector{"visible"}     = 0;}
    else       {     $detector{"visible"}     = 1;}
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = $sen[$n-1];
    $detector{"hit_type"}    = $hit[$n-1];
    $detector{"identifiers"} = $id[$n-1];
     print_det(\%configuration, \%detector);
 }
}
