use strict;
our %detector;
our %configuration;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_ec_iondownstream_virtualplane';

my $offset=70.9;

my $offset_inner=40.3;

sub det1_ec_iondownstream_virtualplane
{
 my $NUM  = 1;
#  my @z    = (585+$offset-9-0.01);
#  my @z    = (592+$offset-12.5-0.01);
 my @z    = (650);
 my @Rin  = (10);
#  my @Rout = (50);
 my @Rout = (55);
#  my @Dz   = (10); 
 my @Dz   = (0.001);
 my @name = (""); 
 my @mother = ("$DetectorMother"); 
 my @mat  = ("Vacuum");
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
    $detector{"color"}      = "000000";
    $detector{"type"}       = "Tube";
    $detector{"dimensions"} = "$Rin[$n-1]*cm $Rout[$n-1]*cm $Dz[$n-1]*cm -155*deg 310*deg";
    $detector{"material"}   = $mat[$n-1];
    $detector{"mfield"}     = "no";
    $detector{"ncopy"}      = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 0;
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"}    = "flux";
    $detector{"identifiers"} = "id manual 33000";
    print_det(\%configuration, \%detector);
 }
}
