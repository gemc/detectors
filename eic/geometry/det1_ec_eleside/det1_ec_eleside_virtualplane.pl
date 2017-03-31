use strict;
our %detector;
our %configuration;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_ec_eleside_virtualplane';

my $offset=70.9;

my $offset_inner=40.3;

sub det1_ec_eleside_virtualplane
{
 my $NUM  = 1;
#  my @z    = (-30+$offset); 
 my @z    = (-10+$offset); 
 my @Rin  = (310-0.01);
 my @Rout = (310-0.01+0.001);
#  my @Dz   = (2);
 my @name = (""); 
 my @mother = ("$DetectorMother"); 
 my @mat  = ("Vacuum");
 my @rot  = (0);

 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "0*cm 0*cm $z[$n-1]*cm";
    $detector{"rotation"}   = "$rot[$n-1]*deg 0*deg 0*deg";
    $detector{"color"}      = "000000"; 
    $detector{"type"}       = "Sphere";
    $detector{"dimensions"}  = "$Rin[$n-1]*cm $Rout[$n-1]*cm 0*deg 360*deg 150*deg 15*deg";
    $detector{"material"}   = $mat[$n-1];
    $detector{"mfield"}     = "no";
    $detector{"ncopy"}      = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 0;
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"}    = "flux";
    $detector{"identifiers"} = "id manual 34000";
    print_det(\%configuration, \%detector);
 }
}
