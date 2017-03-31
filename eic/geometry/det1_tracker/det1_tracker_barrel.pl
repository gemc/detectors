use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_tracker_barrel';

my $offset=70.9;

my $offset_inner=40.3;

sub det1_tracker_barrel
{
 my $NUM  = 4;
 my @z    = ($offset_inner,$offset_inner,$offset_inner,$offset_inner);
# my @z    = (0,0,0,0);
 my @Rin  = (40,60,75,98);
 my @Rout = (41,61,86,99);
 my @Dz   = (90,125,150,180);
 my @name = ("1","2","3","4"); 
 my @mother = ("$DetectorMother","$DetectorMother","$DetectorMother","$DetectorMother"); 
 my $mat  = ("Vacuum");

 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "0*cm 0*cm $z[$n-1]*cm";
    $detector{"rotation"}   = "0*deg 0*deg 0*deg";
    $detector{"color"}      = "fff4e7"; 
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
    my $id=51000+$n*100;
    $detector{"identifiers"} = "id manual $id";
     print_det(\%configuration, \%detector);
 }
}
