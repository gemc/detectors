use strict;
our %detector;
our %configuration;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_ec_iondownstream';

my $offset=70.9;

my $offset_inner=40.3;

sub det1_ec_iondownstream
{
#  my $NUM  = 1;
# #  my @z    = (585+$offset);
#  my @z    = (592+$offset);
#  my @Rin  = (10);
# #  my @Rout = (50);
#  my @Rout = (55);
# #  my @Dz   = (9);
#  my @Dz   = (12.5);
#  my @name = (""); 
#  my @mother = ("$DetectorMother"); 
#  my @mat  = ("Kryptonite");
#  my @rot  = (0);
#  my @x    = (0);

 my $NUM  = 1;
 my @x    = (-35);
 my @z    = (665);
 my @Rin  = (12);
 my @Rout = (35);
 my @Dz   = (12.5);
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
    $detector{"color"}      = "80f9ff";
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
