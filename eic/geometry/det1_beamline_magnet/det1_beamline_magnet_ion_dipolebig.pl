use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_beamline_magnet_ion_dipolebig';

# i_ds_dipole1_length		| 1                 | m   | ion downstream dipole 1 length        | - |  - | - | - | - | -
# i_ds_dipole1_innerhalfaperture	| 17                | cm  | ion downstream dipole 1 innerhalfaperture | - |  - | - | - | - | -
# i_ds_dipole1_outerhalfaperture	| 24                | cm  | ion downstream dipole 1 outerhalfaperture | - |  - | - | - | - | -
# i_ds_dipole1_strength		| 1.200030206       | T   | ion downstream dipole 1 strength      | - |  - | - | - | - | -
# i_ds_dipole1_X			|-0.2763824454      | m   | ion downstream dipole 1 X center      | - |  - | - | - | - | -
# i_ds_dipole1_Z			| 5.4930492705      | m   | ion downstream dipole 1 Z center      | - 

sub det1_beamline_magnet_ion_dipolebig
{
    my %detector=init_det();
    $detector{"name"}        = "det1_beamline_magnet_ion_dipolebig";
    $detector{"mother"}      = "$DetectorMother" ;
    $detector{"description"} = "det1_beamline_magnet_ion_dipolebig";
    $detector{"pos"}        = "0*m 0*m 5.742698253*m";
    $detector{"rotation"}   = "0*rad 0*rad 0*rad";
    $detector{"color"}      = "00FF00"; 
    $detector{"type"}       = "Cons";
    $detector{"dimensions"} = "35*cm 39*cm 45*cm 49*cm 0.75*m 0*deg 360*deg";    
#     $detector{"type"}       = "Tube";
#     $detector{"dimensions"} = "45*cm 50*cm 0.75*m 0*deg 360*deg";
    $detector{"material"}   = "Kryptonite";
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
     
#     my %detector=init_det();
#     $detector{"name"}        = "det1_magnet_ion_dipolebig_outer";
#     $detector{"mother"}      = "$DetectorMother" ;
#     $detector{"description"} = "det1_magnet_ion_dipolebig_outer";
#     $detector{"pos"}        = "0*m 0*m 5.71*m";
#     $detector{"rotation"}   = "0*rad 0*rad 0*rad";
#     $detector{"color"}      = "00FF00"; 
#     $detector{"type"}       = "Tube";
#     $detector{"dimensions"} = "0*cm 50*cm 0.75*m 0*deg 360*deg";
#     $detector{"material"}   = "Kryptonite";
#     $detector{"mfield"}     = "no";
#     $detector{"ncopy"}      = 1;
#     $detector{"pMany"}       = 1;
#     $detector{"exist"}       = 1;
#     $detector{"visible"}     = 1;
#     $detector{"style"}       = 1;
#     $detector{"sensitivity"} = "no";
#     $detector{"hit_type"}    = "no";
#     $detector{"identifiers"} = "no";
#      print_det(\%configuration, \%detector);
     
#     $detector{"name"}        = "det1_magnet_ion_dipolebig_inner";
#     $detector{"mother"}      = "det1_magnet_ion_dipolebig_outer" ;
#     $detector{"description"} = "det1_magnet_ion_dipolebig_inner";
#     $detector{"pos"}        = "0*m 0*m 0*m";
#     $detector{"rotation"}   = "0*rad 0*rad 0*rad";
#     $detector{"color"}      = "CDE6FA"; 
#     $detector{"type"}       = "Tube";
#     $detector{"dimensions"} = "0*cm 45*cm 0.75*m 0*deg 360*deg";
#     $detector{"material"}   = "Vacuum";
#     $detector{"mfield"}     = "no";
#     $detector{"ncopy"}      = 1;
#     $detector{"pMany"}       = 1;
#     $detector{"exist"}       = 1;
#     $detector{"visible"}     = 1;
#     $detector{"style"}       = 1;
#     $detector{"sensitivity"} = "no";
#     $detector{"hit_type"}    = "no";
#     $detector{"identifiers"} = "no";
#      print_det(\%configuration, \%detector);     
}
