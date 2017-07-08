use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";
my $DetectorName = "meic_det1_flu_monitor_ele";


my $zpos = "-0.2929464046*m 0*m -22.87855065*m";

sub make_det1_compton_flux_monitor_geometry
{

    my %detector=init_det();
    $detector{"name"}        = "flux_monitor";
    $detector{"mother"}      = "root";
    $detector{"description"} = "Flux Monitor";
    $detector{"pos"}         = "$zpos";
    $detector{"rotation"}    = "0.0*rad 0.0*rad 0.0*rad";
    $detector{"color"}       = "FF33FF"; 
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "0*cm 7.3024*cm 1.25*cm 0*deg 360*deg";
    $detector{"material"}    = "H_GAS_HD";
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"}    = "flux";
    $detector{"identifiers"} = "id manual 20013";
    print_det(\%configuration, \%detector);
}
1;
