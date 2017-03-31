use strict;
our %detector;
our %configuration;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'meic_det1_cher';

my $offset=70.9;

sub make_meic_det1_cher
{
 my $NUM  = 1;
 my @z    = (-412.5+60+5+32.5+$offset); 
 my @Rin1  = (15);
 my @Rout1 = (130); 
 my @Rin2  = (10);
 my @Rout2 = (100);
 my @Dz   = (32);
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
    $detector{"color"}      = "00FFFF"; #aqua
#     $detector{"type"}       = "Polycone";
#     $detector{"dimensions"} = "0*deg 360*deg 4*counts 25*cm 20*cm 20*cm 15*cm 225*cm 180*cm 100*cm 100*cm -52.5*cm 20*cm 20*cm 52.5*cm";    
    $detector{"type"}       = "Cons";
    $detector{"dimensions"} = "$Rin1[$n-1]*cm $Rout1[$n-1]*cm $Rin2[$n-1]*cm $Rout2[$n-1]*cm $Dz[$n-1]*cm 0*deg 360*deg";
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
