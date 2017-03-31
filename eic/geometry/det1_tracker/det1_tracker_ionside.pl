use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_tracker_ionside';

my $offset=70.9;

my $offset_inner=40.3;

sub det1_tracker_ionside
{
 my $NUM  = 9;
 my @z    = (40,50,60,140,150,160,225,235,245);
#  my @Rin  = (0.7,1.4,2.1,9.1,9.8,10.5,12,13,14);
 my @Rin  = (5,6,7,15,17,18,18,19,20);
 my @Rout = (30,32,33,53,57,60,95,100,110);
 my @Dz   = (1,1,1,1,1,1,1,1,1);
 my @name = ("1","2","3","4","5","6","7","8","9"); 
 my @mother = ("$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother"); 
 my $mat  = ("Vacuum");

 for(my $n=7; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "0*cm 0*cm $z[$n-1]*cm";
    $detector{"rotation"}   = "0*deg 0*deg 0*deg";
    $detector{"color"}      = "FF8000"; 
    $detector{"type"}       = "Tube";
    $detector{"dimensions"} = "$Rin[$n-1]*cm $Rout[$n-1]*cm $Dz[$n-1]*cm 0*deg 360*deg";
    $detector{"material"}   = $mat;
    $detector{"mfield"}     = "no";
    $detector{"ncopy"}      = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"}    = "flux";
    my $id=52000+$n*100;
    $detector{"identifiers"} = "id manual $id";
     print_det(\%configuration, \%detector);
 }
}
