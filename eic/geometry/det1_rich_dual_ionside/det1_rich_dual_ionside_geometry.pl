use strict;
use warnings;
use mirrors;
our %detector;
our %configuration;
our %parameters;

use Getopt::Long;
use Math::Trig;

my $DEG=180/3.1415916;
my $DetectorMother="root";

my $DetectorName = 'det1_rich_dual_ionside';

#my $offset=70.9;

#my $offset_inner=40.3;

# my $hittype="eic_rich";
my $hittype="no";

my $Rout_a=((200.-120.)/(415.-250.))*(4.)+120.; 


sub det1_rich_dual_ionside
{
 my $NUM  = 6;
 my $sector_start = -30;
 my $sector_angle = 60;
 my $mir_dx = 130;
 my $mir_r = 279.9;
 my $mir_rot = asin($mir_dx/$mir_r)*$DEG;
 my @z    = (250+82.5,252,254+80.5);
#  my @Rin1  = (10,10,10);
 my @Rin1  = (11,11,11);
 my @Rout1 = (220,120,$Rout_a);
 my @Rin2  = (10,10,10);
 my @Rout2 = (220,$Rout_a,200);
 my @Dz   = (82.5,2,80.5);
 my @name = ("box","aeo_rad","gas_rad"); 
 my @mother = ("$DetectorMother","$DetectorMother","$DetectorMother"); 
 my @mat  = ("MAT\_$DetectorName\_gas","MAT\_$DetectorName\_aerogel","MAT\_$DetectorName\_gas");
 my @color  = ("00FFCC","880000","008800");
 my @id  = ("no","id manual 1","id manual 2");
 my @rot  = (0,0,0);


 for(my $n=1; $n<=$NUM; $n++)
 {
     my $rot_phi = $sector_angle*($n -1);

     my %detector;
     
     %detector=init_det();
     $detector{"name"}        = "$DetectorName\_$name[0]_$n";
     $detector{"mother"}      = "$mother[0]";
     $detector{"description"} = "$DetectorName\_$name[0]_$n";
     $detector{"pos"}        = "0*cm 0*cm $z[0]*cm";
     $detector{"rotation"}   = "$rot[0]*deg 0*deg $rot_phi*deg";
     $detector{"color"}      = "$color[0]"; 
     $detector{"type"}       = "Cons";
     $detector{"dimensions"} = "$Rin1[0]*cm $Rout1[0]*cm $Rin2[0]*cm $Rout2[0]*cm $Dz[0]*cm $sector_start*deg $sector_angle*deg";
     $detector{"material"}   = $mat[0];
     $detector{"mfield"}     = "no";
     $detector{"ncopy"}      = 1;
     $detector{"pMany"}       = 1;
     $detector{"exist"}       = 1;
     $detector{"visible"}     = 1;
     $detector{"style"}       = 1;
     $detector{"sensitivity"} = "no";
     $detector{"hit_type"}    = "no";
     $detector{"identifiers"} = "no";
     print_det(\%configuration, \%detector);


     %detector=init_det();
     $detector{"name"}        = "$DetectorName\_$name[1]_$n";
     $detector{"mother"}      = "$DetectorName\_$name[0]_$n";
     #$detector{"mother"}      = "$mother[1]" ;
     $detector{"description"} = "$DetectorName\_$name[1]_$n";
     #$detector{"pos"}        = "0*cm 0*cm $z[1]*cm";
     $detector{"pos"}        = "0*cm 0*cm -80.5*cm";
     #$detector{"rotation"}   = "$rot[1]*deg 0*deg $rot_phi*deg";
     $detector{"rotation"}   = "$rot[1]*deg 0*deg 0*deg";
     $detector{"color"}      = "$color[1]"; 
     $detector{"type"}       = "Cons";
     $detector{"dimensions"} = "$Rin1[1]*cm $Rout1[1]*cm $Rin2[1]*cm $Rout2[1]*cm $Dz[1]*cm $sector_start*deg $sector_angle*deg";
     $detector{"material"}   = $mat[1];
     $detector{"mfield"}     = "no";
     $detector{"ncopy"}      = 1;
     $detector{"pMany"}       = 1;
     $detector{"exist"}       = 1;
     $detector{"visible"}     = 1;
     $detector{"style"}       = 1;
     $detector{"sensitivity"} = "$hittype";
     $detector{"hit_type"}    = "$hittype";
     #$detector{"identifiers"} = "$id[1]";
     $detector{"identifiers"} = "id manual 1$n";
     print_det(\%configuration, \%detector);


     %detector=init_det();
     $detector{"name"}        = "$DetectorName\_$name[2]_$n";
     $detector{"mother"}        = "$DetectorName\_$name[0]_$n";
     #$detector{"mother"}      = "$mother[2]" ;
     $detector{"description"} = "$DetectorName\_$name[2]_$n";
     #$detector{"pos"}        = "0*cm 0*cm $z[2]*cm";
     $detector{"pos"}        = "0*cm 0*cm 2*cm";
     #$detector{"rotation"}   = "$rot[2]*deg 0*deg $rot_phi*deg";
     $detector{"rotation"}   = "$rot[2]*deg 0*deg 0*deg";
     $detector{"color"}      = "$color[2]"; 
     $detector{"type"}       = "Cons";
     $detector{"dimensions"} = "$Rin1[2]*cm $Rout1[2]*cm $Rin2[2]*cm $Rout2[2]*cm $Dz[2]*cm $sector_start*deg $sector_angle*deg";
     $detector{"material"}   = $mat[2];
     $detector{"mfield"}     = "no";
     $detector{"ncopy"}      = 1;
     $detector{"pMany"}       = 1;
     $detector{"exist"}       = 1;
     $detector{"visible"}     = 0;
     $detector{"style"}       = 0;
     $detector{"sensitivity"} = "$hittype";
     $detector{"hit_type"}    = "$hittype";
     #$detector{"identifiers"} = "$id[2]";
     $detector{"identifiers"} = "id manual 2$n";
     print_det(\%configuration, \%detector);
 
	
     %detector = init_det();
     $detector{"name"}        = "mirror_$n";
     $detector{"mother"}      = "$DetectorName\_gas_rad_$n";
     #$detector{"mother"}      = "$DetectorMother";
     $detector{"description"} = "Spherical mirror";
     $detector{"pos"}         = "$mir_dx*cm 0*cm -210*cm";
     #$detector{"pos"}         = "0*cm 0*cm 80*cm";
     $detector{"rotation"}    = "0*deg $mir_rot*deg 0*deg";
     $detector{"color"}       = "ffaa88";
     $detector{"type"}        = "Sphere";
     $detector{"dimensions"}  = "279.9*cm 280*cm $sector_start*deg $sector_angle*deg 2*deg 40*deg";
     $detector{"material"}    = "G4_Al";
     $detector{"ncopy"}       = 1;
     $detector{"pMany"}       = 1;
     $detector{"exist"}       = 1;
     $detector{"visible"}     = 1;
     $detector{"style"}       = 1;  
     $detector{"sensitivity"} = "no";
     $detector{"hit_type"}    = "mirror";
     $detector{"identifiers"} = "id manual 3";
     print_det(\%configuration, \%detector);


     #my @photondet_pos  = ( 10.0, 0.0, 251.0);
     my @photondet_pos  = ( 0.0, 0.0, -88.0);
     %detector=init_det();
     $detector{"name"} = "photondet_$n";
     $detector{"mother"} = "$DetectorName\_box_$n";
     #$detector{"mother"} = "$DetectorMother";
     $detector{"description"} = "photondet_name_$n";
     $detector{"pos"} = "$photondet_pos[0]*cm $photondet_pos[1]*cm $photondet_pos[2]*cm";
     $detector{"rotation"} = "0*deg 15*deg 0*deg";
     $detector{"color"} = "0000A0";
     $detector{"type"} = "Cons";
     #$detector{"dimensions"} = "100*cm 160*cm 100*cm 160*cm 1*cm -15*deg 30*deg"; #small sector
     #$detector{"dimensions"} = "130*cm 220*cm 130*cm 220*cm 1*cm -20*deg 40*deg"; #plane sector
     $detector{"dimensions"} = "140*cm 220*cm 140*cm 220*cm 1*cm -15*deg 30*deg";
     #$detector{"type"}        = "Sphere";
     #$detector{"dimensions"}  = "299*cm 300*cm 0*deg 360*deg 25*deg 40*deg";
     $detector{"material"} = "Air_Opt";
     $detector{"mfield"} = "no";
     $detector{"ncopy"}      = 1;
     $detector{"pMany"}       = 1;
     $detector{"exist"}       = 1;
     $detector{"visible"}     = 1;
     $detector{"style"}       = 1;
     $detector{"sensitivity"} = "$hittype";
     $detector{"hit_type"}    = "$hittype";
     $detector{"identifiers"} = "id manual 4$n";
     print_det(\%configuration, \%detector);

 }
}
