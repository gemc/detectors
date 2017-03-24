use strict;
our %detector;
our %configuration;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_tracker_iondownstream';

my $offset=70.9;

my $offset_inner=40.3;

sub det1_tracker_iondownstream
{
 my $NUM  = 3;
 my @z    = (450+$offset,500+$offset,550+$offset);
 my @Rin  = (10,10,10);
 my @Rout = (30,35,40);
 my @Dz   = (1,1,1);
 my @name = ("1","2","3"); 
 my @mother = ("$DetectorMother","$DetectorMother","$DetectorMother"); 
 my @mat  = ("Vacuum","Vacuum","Vacuum");
 my @rot  = (0);
 my @x    = (0);
 
 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "0*cm 0*cm $z[$n-1]*cm";
    $detector{"rotation"}   = "0*deg 0*deg 0*deg";   
    $detector{"color"}      = "FF8000";
    $detector{"type"}       = "Tube";
    $detector{"dimensions"} = "$Rin[$n-1]*cm $Rout[$n-1]*cm $Dz[$n-1]*cm -155*deg 310*deg";
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
