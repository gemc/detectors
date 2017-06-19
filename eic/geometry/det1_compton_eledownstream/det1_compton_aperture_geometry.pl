use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";
my $DetectorName = "meic_det1_aperture_ele";

my $aps = 2;

my @zpos = (
    "0.0*m 0*m -0.625*m",
    "0.0*m 0*m  0.625*m");

sub make_det1_compton_aperture_geometry
{

    %detector = init_det();
    $detector{"name"}        = "ap_disc";
    $detector{"mother"}      = "root";
    $detector{"description"} = "Outer disc of aperture";
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "0*cm 7.3024*cm 1.25*cm 0*deg 360*deg";
    $detector{"material"}    = "Component";
    print_det(\%configuration, \%detector);

    %detector = init_det();
    $detector{"name"}        = "ap_slit";
    $detector{"mother"}      = "root";
    $detector{"description"} = "Inner slit of aperture";
    $detector{"type"}        = "Box";
    $detector{"dimensions"}  = "2.0*cm 0.25*cm 1.26*cm";
    $detector{"material"}    = "Component";
    print_det(\%configuration, \%detector);

    for(my $i = 0; $i < ($aps); $i++)
    {

    my %detector=init_det();
    $detector{"name"}        = "aperture_$i";
    $detector{"mother"}      = "CV_2a_3a";
    $detector{"description"} = "Apertures ${i}";
    $detector{"pos"}         = "$zpos[$i]";
    $detector{"rotation"}    = "0.0*rad 0.0*rad 0.0*rad";
    $detector{"color"}       = "FF33FF"; 
    $detector{"type"}        = "Operation: ap_disc - ap_slit";
    $detector{"material"}    = "G4_STAINLESS-STEEL";
#    $detector{"material"}    = "G4_Galactic";
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "id manual 2001${i}";
    print_det(\%configuration, \%detector);
    }
}
1;
