use strict;
our %detector;
our %configuration;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_hc_ionside';

my $offset=70.9;

my $offset_inner=40.3;

sub det1_hc_ionside
{
 my $NUM  = 1;
#  my @z    = (412.5-30+$offset);
#  my @z    = (500+$offset);
 my @z    = (574.2698253);
#  my @Rin  = (50);
#   my @Rin  = (60);
#  my @Rout = (300);
#   my @Rin1  = (40);
  my @Rin1  = (0);
#   my @Rin1  = (80);
#  my @Rout1 = (250);
 my @Rout1 = (300);
  my @Rin2  = (0); 
#   my @Rin2  = (50);
#   my @Rin2  = (80);  
 my @Rout2 = (300); 
#  my @Dz   = (29);
 my @Dz   = (75);
 my @name = (""); 
 my @mother = ("$DetectorMother"); 
 my @mat  = ("Kryptonite");
 my @rot  = (0);

 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "0*cm 0*cm $z[$n-1]*cm";
    $detector{"rotation"}   = "$rot[$n-1]*deg 0*deg 0*deg";
#     $detector{"color"}      = "008080"; #blue
#     $detector{"color"}      = "9900CC";
    $detector{"color"}      = "9900ff";
    $detector{"type"}       = "Cons";
    $detector{"dimensions"} = "$Rin1[$n-1]*cm $Rout1[$n-1]*cm $Rin2[$n-1]*cm $Rout2[$n-1]*cm $Dz[$n-1]*cm 0*deg 360*deg";
    $detector{"material"}   = $mat[$n-1];
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
     
    $detector{"name"}        = "det1_hc_ionside_hole";
    $detector{"mother"}      = "$DetectorName\_$name[$n-1]" ;
    $detector{"description"} = "det1_hc_ionside_hole";
    $detector{"pos"}        = "-0.3*m 0*m 0*m";
    $detector{"rotation"}   = "0*rad 0*rad 0*rad";
    $detector{"color"}      = "CDE6FA"; 
    $detector{"type"}       = "Tube";
    $detector{"dimensions"} = "0*cm 65*cm $Dz[$n-1]*cm 0*deg 360*deg";  
    $detector{"material"}   = "G4_Galactic";
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
     
 }
}

