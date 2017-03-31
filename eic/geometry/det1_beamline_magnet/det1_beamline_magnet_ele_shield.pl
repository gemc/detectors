use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";

my $DetectorName = 'det1_beamline_magnet_ele_shield';

my $i_ds_dipole1_length			= $parameters{"i_ds_dipole1_length"};
my $i_ds_dipole1_innerhalfaperture	= $parameters{"i_ds_dipole1_innerhalfaperture"};
my $i_ds_dipole1_outerhalfaperture	= $parameters{"i_ds_dipole1_outerhalfaperture"};
my $i_ds_dipole1_strength		= $parameters{"i_ds_dipole1_strength"};
my $i_ds_dipole1_X			= $parameters{"i_ds_dipole1_X"};
my $i_ds_dipole1_Z			= $parameters{"i_ds_dipole1_Z"};
my $i_ds_dipole1_Theta			= $parameters{"i_ds_dipole1_Theta"};

my $Dz=0.5*$i_ds_dipole1_length;

sub det1_beamline_magnet_ele_shield
{
    my %detector=init_det();
    $detector{"name"}        = "det1_beamline_magnet_ele_shield";
    $detector{"mother"}      = "det1_beamline_magnet_ion_downstream_dipole1_outer" ;
    $detector{"description"} = "det1_beamline_magnet_ele_shield";
    $detector{"pos"}        = "0*m 0*m 0*m";
    $detector{"rotation"}   = "0*rad 0*rad 0*rad";
    $detector{"color"}      = "000000"; 
    $detector{"type"}       = "Tube";
    $detector{"dimensions"} = "0*cm 5*cm $Dz*m 0*deg 360*deg";
    $detector{"material"}   = "Vacuum";
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
