use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_beamline_magnet_ele';

# there are 6 dipole in ion downstream

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

sub det1_beamline_magnet_ele_dipole
{
my $NUM  = 6+6+12;
my @name = (
"downstream_dipole1_outer","downstream_dipole2_outer","downstream_dipole2a_outer","downstream_dipole3a_outer","downstream_dipole3_outer","downstream_dipole4_outer",
"downstream_dipole1_inner","downstream_dipole2_inner","downstream_dipole2a_inner","downstream_dipole3a_inner","downstream_dipole3_inner","downstream_dipole4_inner",
"downstream_dipole1_front","downstream_dipole2_front","downstream_dipole2a_front","downstream_dipole3a_front","downstream_dipole3_front","downstream_dipole4_front",
"downstream_dipole1_back","downstream_dipole2_back","downstream_dipole2a_back","downstream_dipole3a_back","downstream_dipole3_back","downstream_dipole4_back",
);
my @mother = (
"$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother",
"$DetectorName\_downstream_dipole1_outer","$DetectorName\_downstream_dipole2_outer","$DetectorName\_downstream_dipole2a_outer","$DetectorName\_downstream_dipole3a_outer","$DetectorName\_downstream_dipole3_outer","$DetectorName\_downstream_dipole4_outer",
"$DetectorName\_downstream_dipole1_inner","$DetectorName\_downstream_dipole2_inner","$DetectorName\_downstream_dipole2a_inner","$DetectorName\_downstream_dipole3a_inner","$DetectorName\_downstream_dipole3_inner","$DetectorName\_downstream_dipole4_inner",
"$DetectorName\_downstream_dipole1_inner","$DetectorName\_downstream_dipole2_inner","$DetectorName\_downstream_dipole2a_inner","$DetectorName\_downstream_dipole3a_inner","$DetectorName\_downstream_dipole3_inner","$DetectorName\_downstream_dipole4_inner",
); 
my @mat  = (
"Kryptonite","Kryptonite","Kryptonite","Kryptonite","Kryptonite","Kryptonite",
"Vacuum","Vacuum","Vacuum","Vacuum","Vacuum","Vacuum",
"Vacuum","Vacuum","Vacuum","Vacuum","Vacuum","Vacuum",
"Vacuum","Vacuum","Vacuum","Vacuum","Vacuum","Vacuum",
);
my @z  = (
$e_ds_dipole1_Z,$e_ds_dipole2_Z,$e_ds_dipole2a_Z,$e_ds_dipole3a_Z,$e_ds_dipole3_Z,$e_ds_dipole4_Z,
0,0,0,0,0,0,
0.5*$e_ds_dipole1_length-1e-10,0.5*$e_ds_dipole2_length-1e-10,0.5*$e_ds_dipole2a_length-1e-10,0.5*$e_ds_dipole3a_length-1e-10,0.5*$e_ds_dipole3_length-1e-10,0.5*$e_ds_dipole4_length-1e-10,
-0.5*$e_ds_dipole1_length+1e-10,-0.5*$e_ds_dipole2_length+1e-10,-0.5*$e_ds_dipole2a_length+1e-10,-0.5*$e_ds_dipole3a_length+1e-10,-0.5*$e_ds_dipole3_length+1e-10,-0.5*$e_ds_dipole4_length+1e-10,
);
my @x  = (
$e_ds_dipole1_X,$e_ds_dipole2_X,$e_ds_dipole2a_X,$e_ds_dipole3a_X,$e_ds_dipole3_X,$e_ds_dipole4_X,
0,0,0,0,0,0,
0,0,0,0,0,0,
0,0,0,0,0,0,
);
my @Dx = (
$e_ds_dipole1_outerhalfaperture,$e_ds_dipole2_outerhalfaperture,$e_ds_dipole2a_outerhalfaperture,$e_ds_dipole3a_outerhalfaperture,$e_ds_dipole3_outerhalfaperture,$e_ds_dipole4_outerhalfaperture,
$e_ds_dipole1_innerhalfaperture,$e_ds_dipole2_innerhalfaperture,$e_ds_dipole2a_innerhalfaperture,$e_ds_dipole3a_innerhalfaperture,$e_ds_dipole3_innerhalfaperture,$e_ds_dipole4_innerhalfaperture,
$e_ds_dipole1_innerhalfaperture,$e_ds_dipole2_innerhalfaperture,$e_ds_dipole2a_innerhalfaperture,$e_ds_dipole3a_innerhalfaperture,$e_ds_dipole3_innerhalfaperture,$e_ds_dipole4_innerhalfaperture,
$e_ds_dipole1_innerhalfaperture,$e_ds_dipole2_innerhalfaperture,$e_ds_dipole2a_innerhalfaperture,$e_ds_dipole3a_innerhalfaperture,$e_ds_dipole3_innerhalfaperture,$e_ds_dipole4_innerhalfaperture,
);
my @Dy = (
$e_ds_dipole1_outerhalfaperture,$e_ds_dipole2_outerhalfaperture,$e_ds_dipole2a_outerhalfaperture,$e_ds_dipole3a_outerhalfaperture,$e_ds_dipole3_outerhalfaperture,$e_ds_dipole4_outerhalfaperture,
$e_ds_dipole1_innerhalfaperture,$e_ds_dipole2_innerhalfaperture,$e_ds_dipole2a_innerhalfaperture,$e_ds_dipole3a_innerhalfaperture,$e_ds_dipole3_innerhalfaperture,$e_ds_dipole4_innerhalfaperture,
$e_ds_dipole1_innerhalfaperture,$e_ds_dipole2_innerhalfaperture,$e_ds_dipole2a_innerhalfaperture,$e_ds_dipole3a_innerhalfaperture,$e_ds_dipole3_innerhalfaperture,$e_ds_dipole4_innerhalfaperture,
$e_ds_dipole1_innerhalfaperture,$e_ds_dipole2_innerhalfaperture,$e_ds_dipole2a_innerhalfaperture,$e_ds_dipole3a_innerhalfaperture,$e_ds_dipole3_innerhalfaperture,$e_ds_dipole4_innerhalfaperture,
);
my @Dz = (
0.5*$e_ds_dipole1_length,0.5*$e_ds_dipole2_length,0.5*$e_ds_dipole2a_length,0.5*$e_ds_dipole3a_length,0.5*$e_ds_dipole3_length,0.5*$e_ds_dipole4_length,
0.5*$e_ds_dipole1_length,0.5*$e_ds_dipole2_length,0.5*$e_ds_dipole2a_length,0.5*$e_ds_dipole3a_length,0.5*$e_ds_dipole3_length,0.5*$e_ds_dipole4_length,
1e-10,1e-10,1e-10,1e-10,1e-10,1e-10,
1e-10,1e-10,1e-10,1e-10,1e-10,1e-10,
);
my @rot  = (
-1*$e_ds_dipole1_Theta,-1*$e_ds_dipole2_Theta,-1*$e_ds_dipole2a_Theta,-1*$e_ds_dipole3a_Theta,-1*$e_ds_dipole3_Theta,-1*$e_ds_dipole4_Theta,
0,0,0,0,0,0,
0,0,0,0,0,0,
0,0,0,0,0,0,
);
my @color = (
"00FF00","00FF00","00FF00","00FF00","00FF00","00FF00",
"CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA",
"CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA",
"CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA","CDE6FA",
);
my @field = (
"no","no","no","no","no","no",
"det1_ele_downstream_dipole1_simple","det1_ele_downstream_dipole2_simple","det1_ele_downstream_dipole2a_simple","det1_ele_downstream_dipole3a_simple","det1_ele_downstream_dipole3_simple","det1_ele_downstream_dipole4_simple",
"no","no","no","no","no","no",
"no","no","no","no","no","no",
);
# my @field = (
# "no","no","no","no",
# "no","no","no","no",
# "no","no","no","no",
# "no","no","no","no",
# );
my @sen = (
"no","no","no","no","no","no",
"no","no","no","no","no","no",
"flux","flux","flux","flux","flux","flux",
"flux","flux","flux","flux","flux","flux",
);
my @hit = (
"no","no","no","no","no","no",
"no","no","no","no","no","no",
"flux","flux","flux","flux","flux","flux",
"flux","flux","flux","flux","flux","flux",
);
my @id = (
"no","no","no","no","no","no",
"no","no","no","no","no","no",
"id manual 22111","id manual 22121","id manual 22131","id manual 22141","id manual 22151","id manual 22161",
"id manual 22112","id manual 22122","id manual 22132","id manual 22142","id manual 22152","id manual 22162",
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
    $detector{"type"}       = "Box";
    $detector{"dimensions"} = "$Dx[$n-1]*cm $Dy[$n-1]*cm $Dz[$n-1]*m";
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
 
  {
    my $skin_half=0.5*($e_ds_dipole1_outerhalfaperture - $e_ds_dipole1_innerhalfaperture);
    my $x_pos= -($e_ds_dipole1_innerhalfaperture + $skin_half);        
    
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_downstream_dipole1_side";
    $detector{"mother"}      = "$DetectorName\_downstream_dipole1_outer" ;
    $detector{"description"} = "$DetectorName\_downstream_dipole1_side";    
    $detector{"pos"}        = "$x_pos*cm 0*cm 0*cm";    
    $detector{"rotation"}   = "0*rad 0*rad 0*rad";
    $detector{"color"}      = "CDE6FA"; 
    $detector{"type"}       = "Box";
    $detector{"dimensions"} = "$skin_half*cm $e_ds_dipole1_innerhalfaperture*cm $Dz[0]*m";
    $detector{"material"}   = "Vacuum";
    $detector{"mfield"}     = "no";
    $detector{"ncopy"}      = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"}    = "flux";
    $detector{"identifiers"} = "id manual 22113";
     print_det(\%configuration, \%detector);
 }
  
}

