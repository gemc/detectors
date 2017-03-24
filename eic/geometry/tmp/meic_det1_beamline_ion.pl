use strict;
our %detector;
our %configuration;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'meic_det1_beamline_ion';

sub make_meic_det1_beamline_ion
{
 my $NUM  = 2;
 my @z    = (0,0);
 my @Rin  = (0,0);
 my @Rout = (2.54,2.24);
 my @Dz   = (3000,3000);
 my @name = ("BMP1","BMV1"); 
 my @mother = ("$DetectorMother","$DetectorName\_BMP1"); 
 my @mat  = ("Aluminum","Vacuum");
 my @rot  = (-50e-3/3.1415926*180,0);

 for(my $n=1; $n<=$NUM; $n++)
 {
    my %detector=init_det();
    $detector{"name"}        = "$DetectorName\_$name[$n-1]";
    $detector{"mother"}      = "$mother[$n-1]" ;
    $detector{"description"} = "$DetectorName\_$name[$n-1]";
    $detector{"pos"}        = "0*cm -0.1*cm $z[$n-1]*cm";
    $detector{"rotation"}   = "0*deg $rot[$n-1]*deg 0*deg";
    $detector{"color"}      = "0000FF";  #blue
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
# make_eic_beamline_p();