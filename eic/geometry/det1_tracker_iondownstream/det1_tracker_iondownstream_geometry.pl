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
 my @x    = ((450+$offset)*tan(-50e-3),(500+$offset)*tan(-50e-3),(550+$offset)*tan(-50e-3)); 
 my @Rin  = (7,8.5,10);
 my @Rout = (15,18,21);
 my @Dz   = (1,1,1);
 my @name = ("1","2","3"); 
 my @mother = ("$DetectorMother","$DetectorMother","$DetectorMother"); 
 my @mat  = ("Vacuum","Vacuum","Vacuum");
 my @rot  = (50e-3,50e-3,50e-3);
 
 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "$x[$n-1]*cm 0*cm $z[$n-1]*cm";
    $detector{"rotation"}   = "0*deg $rot[$n-1]*rad 0*deg";   
    $detector{"color"}      = "FF8000";
    $detector{"type"}       = "Tube";
    $detector{"dimensions"} = "$Rin[$n-1]*cm $Rout[$n-1]*cm $Dz[$n-1]*cm 0*deg 360*deg";
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
