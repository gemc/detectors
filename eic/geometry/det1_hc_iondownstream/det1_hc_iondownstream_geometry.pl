use strict;
our %detector;
our %configuration;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_hc_iondownstream';

my $offset=70.9;

my $offset_inner=40.3;

sub det1_hc_iondownstream
{
#  my $NUM  = 1;
# #  my @z    = (610+$offset);
#  my @z    = (680+$offset);
#  my @Rin  = (12);
#  my @Rout = (65);
# #  my @Dz   = (15);
#  my @Dz   = (75);
#  my @name = (""); 
#  my @mother = ("$DetectorMother"); 
#  my @mat  = ("Kryptonite");
#  my @rot  = (0);
#  my @x    = (0);

 my $NUM  = 1;
#  my @z    = (610+$offset);
 my @x    = (-40);
 my @z    = (760); 
 my @Rin  = (20);
 my @Rout = (65);
 my @Dz   = (75);
 my @name = (""); 
 my @mother = ("$DetectorMother"); 
 my @mat  = ("Kryptonite");
 my @rot  = (0.05599600898);
 
 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "$x[$n-1]*cm 0*cm $z[$n-1]*cm";
    $detector{"rotation"}   = "0*deg $rot[$n-1]*rad 0*deg";   
#     $detector{"color"}      = "80f9ff";
    $detector{"color"}      = "9900CC";    
    $detector{"type"}       = "Tube";
    $detector{"dimensions"} = "$Rin[$n-1]*cm $Rout[$n-1]*cm $Dz[$n-1]*cm 15*deg 330*deg";
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
