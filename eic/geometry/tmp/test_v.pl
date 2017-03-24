#!/usr/bin/perl -w

use strict;
our %detector;
our %configuration;

my $DetectorName = 'test_v';

my $rmin      = 1;
my $rmax      = 1000000;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

sub make_test_v
{
 my $NUM  = 2;
 my @z    = (900,5000);
 my @x    = (0,0);
 my @Dz   = (0.001,0.001);
 my @name = ("1","2");
 my @mother = ("$DetectorMother","$DetectorMother"); 
 my @mat  = ("Vacuum","Vacuum");
 my @rot  = (0,0);
 my @color = ("00FF00","00FF00");
 my @field = ("no","no");
 my @sen = ("flux","flux");
 my @hit = ("flux","flux");
 my @id = ("id manual 1","id manual 2");

 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "$x[$n-1]*cm 0*cm $z[$n-1]*cm";
    $detector{"rotation"}   = "0*deg $rot[$n-1]*deg 0*deg";
    $detector{"color"}      = $color[$n-1]; 
    $detector{"type"}       = "Tube";
    $detector{"dimensions"} = "0*cm 1000*cm $Dz[$n-1]*cm 0*deg 360*deg";
    $detector{"material"}   = $mat[$n-1];
    $detector{"mfield"}     = $field[$n-1];
    $detector{"ncopy"}      = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = $sen[$n-1];
    $detector{"hit_type"}    = $hit[$n-1];
    $detector{"identifiers"} = $id[$n-1];
     print_det(\%configuration, \%detector);
 }
}
