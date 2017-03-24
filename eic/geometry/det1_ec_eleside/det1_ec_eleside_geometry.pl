use strict;
our %detector;
our %configuration;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_ec_eleside';

my $offset=70.9;

my $offset_inner=40.3;

# sub det1_ec_eleside
# {
#  my $NUM  = 1;
#  my @z    = (-412.5+30+$offset);
#  my @Rin  = (32);
#  my @Rout = (200);
#  my @Dz   = (29);
#  my @name = (""); 
#  my @mother = ("$DetectorMother"); 
#  my @mat  = ("Kryptonite");
#  my @rot  = (0);
# 
#  for(my $n=1; $n<=$NUM; $n++)
#  {
#     my %detector=init_det();
#     $detector{"name"}        = "$DetectorName\_$name[$n-1]";
#     $detector{"mother"}      = "$mother[$n-1]" ;
#     $detector{"description"} = "$DetectorName\_$name[$n-1]";
#     $detector{"pos"}        = "0*cm 0*cm $z[$n-1]*cm";
#     $detector{"rotation"}   = "$rot[$n-1]*deg 0*deg 0*deg";
#     $detector{"color"}      = "0000FF"; #blue
#     $detector{"type"}       = "Tube";
#     $detector{"dimensions"} = "$Rin[$n-1]*cm $Rout[$n-1]*cm $Dz[$n-1]*cm 0*deg 360*deg";
#     $detector{"material"}   = $mat[$n-1];
#     $detector{"mfield"}     = "no";
#     $detector{"ncopy"}      = 1;
#     $detector{"pMany"}       = 1;
#     $detector{"exist"}       = 1;
#     $detector{"visible"}     = 1;
#     $detector{"style"}       = 1;
#     $detector{"sensitivity"} = "no";
#     $detector{"hit_type"}    = "no";
#     $detector{"identifiers"} = "no";
#      print_det(\%configuration, \%detector);
#  }
# }

sub det1_ec_eleside
{
 my $NUM  = 1;
#  my @z    = (-30+$offset); 
 my @z    = (-10+$offset); 
 my @Rin  = (310);
 my @Rout = (365);
#  my @Dz   = (2);
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
    $detector{"color"}      = "0000FF"; 
    $detector{"type"}       = "Sphere";
    $detector{"dimensions"}  = "$Rin[$n-1]*cm $Rout[$n-1]*cm 0*deg 360*deg 150*deg 15*deg";
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
