use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_beamline_magnet_ion_focus';


# == id name ==============================================================
# digit     beamline                side          magnet      number          window
#        ion    1        upstream    1    dipole    1           n     front      1
#        ele    2       downstream   2  quadrupole  2                 back       2
#                                         solenoid  3
#                                         focus     4
#                                          virtual  9
# =========================================================================


sub det1_beamline_magnet_ion_focus
{
    my $x=-1.305503544;
    my $z=42.45558577;
    my $theta=0.05599600898;
    
    my %detector=init_det();
    $detector{"name"}        = "det1_beamline_magnet_ion_focus";
    $detector{"mother"}      = "$DetectorMother" ;
    $detector{"description"} = "det1_beamline_magnet_ion_focus";
    $detector{"pos"}        = "$x*m 0*m $z*m";
    $detector{"rotation"}   = "0*rad $theta*rad 0*rad";
    $detector{"color"}      = "00FF00"; 
    $detector{"type"}       = "Tube";
    $detector{"dimensions"} = "0*cm 50*cm 0.00001*cm 0*deg 360*deg";
    $detector{"material"}   = "G4_Galactic";
    $detector{"mfield"}     = "no";
    $detector{"ncopy"}      = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 0;
    $detector{"sensitivity"} = "flux";
    $detector{"hit_type"}    = "flux";
    $detector{"identifiers"} = "id manual 12411";
     print_det(\%configuration, \%detector); 
}
