use strict;
our %detector;
our %configuration;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_ec_barrel';

my $offset=70.9;

my $offset_inner=40.3;

sub det1_ec_barrel
{
 my $NUM  = 1;
 my @z    = (-20+$offset_inner);
#  my @z    = (-10+$offset_inner);
 my @Rin  = (115);
 my @Rout = (140);
#  my @Dz   = (220);
#  my @Dz   = (200);
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
    $detector{"color"}      = "0000FF"; #blue
#     $detector{"type"}       = "Tube";
#     $detector{"dimensions"} = "$Rin[$n-1]*cm $Rout[$n-1]*cm $Dz[$n-1]*cm 0*deg 360*deg";
    $detector{"type"}       = "Polycone";    
    $detector{"dimensions"} = "0*deg 360*deg 4*counts 140*cm 115*cm 115*cm 140*cm 140*cm 140*cm 140*cm 140*cm -220*cm -200*cm 200*cm 230*cm";        
#     $detector{"dimensions"} = "0*deg 360*deg 4*counts 140*cm 115*cm 115*cm 140*cm 140*cm 140*cm 140*cm 140*cm -200*cm -180*cm 200*cm 230*cm";    
#     $detector{"dimensions"} = "0*deg 360*deg 4*counts 140*cm 115*cm 115*cm 140*cm 140*cm 140*cm 140*cm 140*cm -230*cm -200*cm 200*cm 230*cm";
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
 }
}
