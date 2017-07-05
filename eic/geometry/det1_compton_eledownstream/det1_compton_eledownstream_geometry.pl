use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";
my $DetectorName = "meic_det1_magnet_ele";

#my $e_ds_dipole1_length =  $parameters{"e_ds_dipole1_length"};
my $e_ds_dipole1_X      =  $parameters{"e_ds_dipole1_X"};
my $e_ds_dipole1_Z      =  $parameters{"e_ds_dipole1_Z"};
my $e_ds_dipole1_Theta  = -$parameters{"e_ds_dipole1_Theta"}; 

#my $e_ds_dipole2_length =  $parameters{"e_ds_dipole2_length"};
my $e_ds_dipole2_X      =  $parameters{"e_ds_dipole2_X"};
my $e_ds_dipole2_Z      =  $parameters{"e_ds_dipole2_Z"};
my $e_ds_dipole2_Theta  = -$parameters{"e_ds_dipole2_Theta"};

#my $e_ds_dipole2a_length = $parameters{"e_ds_dipole2a_length"};
my $e_ds_dipole2a_X      = $parameters{"e_ds_dipole2a_X"};
my $e_ds_dipole2a_Z      = $parameters{"e_ds_dipole2a_Z"};
my $e_ds_dipole2a_Theta  = $parameters{"e_ds_dipole2a_Theta"};

#my $e_ds_dipole3_length = $parameters{"e_ds_dipole3_length"};
my $e_ds_dipole3_X      =  $parameters{"e_ds_dipole3_X"};
my $e_ds_dipole3_Z      =  $parameters{"e_ds_dipole3_Z"};
my $e_ds_dipole3_Theta  = -$parameters{"e_ds_dipole3_Theta"};

#my $e_ds_dipole3a_length = $parameters{"e_ds_dipole3a_length"};
my $e_ds_dipole3a_X      =  $parameters{"e_ds_dipole3a_X"};
my $e_ds_dipole3a_Z      =  $parameters{"e_ds_dipole3a_Z"};
my $e_ds_dipole3a_Theta  =  $parameters{"e_ds_dipole3a_Theta"};

#my $e_ds_dipole4_length = $parameters{"e_ds_dipole4_length"};
my $e_ds_dipole4_X      =  $parameters{"e_ds_dipole4_X"};
my $e_ds_dipole4_Z      =  $parameters{"e_ds_dipole4_Z"};
my $e_ds_dipole4_Theta  = -$parameters{"e_ds_dipole4_Theta"};

my $Dz_1  = 0.4099*$parameters{"e_ds_dipole1_length"};
my $Dz_2  = 0.4099*$parameters{"e_ds_dipole2_length"};
my $Dz_2a = 0.4099*$parameters{"e_ds_dipole2a_length"};
my $Dz_3  = 0.4099*$parameters{"e_ds_dipole3_length"};
my $Dz_3a = 0.4099*$parameters{"e_ds_dipole3a_length"};
my $Dz_4  = 0.4099*$parameters{"e_ds_dipole4_length"};

my $outer_radius = 7.6200;      #diameter 7.6200
my $inner_radius = 7.3025;      #diameter 7.3025

#my $outer_radius = 6.0000;      #diameter 7.6200
#my $inner_radius = 5.6825;      #diameter 7.3025

#my $outer_radius = 3.8100;      #diameter 7.6200
#my $inner_radius = 3.6513;      #diameter 7.3025

my @name = (
    "CV_1_2", 
    "CV_2_2a", 
    "CV_2a_3a", 
    "CV_3a_3", 
    "CV_3_4", 
    "CS_1_2",
    "CS_2_2a",
    "CS_2a_3a",
    "CS_3a_3",
    "CS_3_4",
    "DET_SHIELD",
    "Photon_DET");

my @field = (
    "no", 
    "no", 
    "no", 
    "no", 
    "no", 
    "no",
    "no",
    "no",
    "no",
    "no",
    "no",
    "no");

my @description = ( 
    "Compton Section Vacuum 1_2", 
    "Compton Section Vacuum 2_2a", 
    "Compton Section Vacuum 2a_3a", 
    "Compton Section Vacuum 3a_3", 
    "Compton Section Vacuum 3_4",
    "Compton Chicane Section 1_2",
    "Compton Chicane Section 2_2a",
    "Compton Chicane Section 2a_3a",
    "Compton Chicane Section 3a_3",
    "Compton Chicane Section 3_4",
    "Compton Electron Detector Shield",
    "Compton Photon Detector");

my @volume = (
    "root",
    "root",
    "root",
    "root",
    "root",
    "root",
    "root",
    "root",
    "root",
    "root",
    "root",
    "root");

my @position = (
    "-0.1439736019*m 0*m -15.18090970*m",
    "-0.2926339052*m 0*m -20.52855182*m",
    "-0.2929464046*m 0*m -22.87855065*m",
    "-0.2926339052*m 0*m -25.22854947*m",
    "-0.1455927300*m 0*m -30.50000880*m",
    "-0.1439736019*m 0*m -15.18090970*m",
    "-0.2926339052*m 0*m -20.52855182*m",
    "-0.2929464046*m 0*m -22.87855065*m",
    "-0.2926339052*m 0*m -25.22854947*m",
    "-0.1455927300*m 0*m -30.50000880*m",
    "-0.0253698000*m 0*m -32.59153180*m",   # Moved the target out of the beam from original 
    "-0.2929464046*m 0*m -32.69831180*m");      # position: "-0.0599960000*m 0*m -32.59831180*m"
                                                # New position: -0.0085657310*m
#    "-0*m 0*m -0.20*m");

my @rotation = (
    "0*rad -0.04*rad 0*rad",
    "0*rad -0.0037499912*rad 0*rad",
    "0*rad 0*rad 0*rad",
    "0*rad 0.0037499912*rad 0*rad",
    "0*rad 0.04*rad 0*rad",
    "0*rad -0.04*rad 0*rad",
    "0*rad -0.0037499912*rad 0*rad",
    "0*rad 0*rad 0*rad",
    "0*rad 0.0037499912*rad 0*rad",
    "0*rad 0.04*rad 0*rad",
    "0*rad 0.00*rad 0*rad",
    "0*rad 0.00*rad 0*rad");

my @color = ( 
    "000000",
    "000000",
    "000000",
    "000000",
    "000000",
    "C0C0C0",
    "C0C0C0",
    "C0C0C0",
    "C0C0C0",
    "C0C0C0",
    "CC0000",
    "AA00AA");

my @sens = ( 
    "no",
    "no",
    "no", #Central pipe
    "no",
    "no",
    "no",
    "no",
    "no",
    "no",
    "no",
    "no", # steel plate
    "no");

my @h_type = ( 
    "no",
    "no",
    "no", #Central pipe
    "no",
    "no",
    "no",
    "no",
    "no",
    "no",
    "no",
    "no", # steel plate
    "no");


my @id_number = ( 
    "no",
    "no",
    "no",
    "no",
    "no",
    "no",
    "no",
    "no",
    "no",
    "no",
    "no",
#    "id manual 20003");
    "no");

my @type_id = ( 
    "Tube",
    "Tube",
    "Tube",
    "Tube",
    "Tube",
    "Tube",
    "Tube",
    "Tube",
    "Tube",
    "Tube",
    "Box",
    "Box");

#my @visibility = (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1);
#my @visibility = (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1);
# my @visibility = (1, 1, 0, 1, 0, 1, 1, 0, 1, 0, 1, 1);
my @visibility = (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);

my @dimensions = (
    "0.0*cm $inner_radius*cm 2.08*m 0*deg 360*deg",   
    "0.0*cm $inner_radius*cm 0.23*m 0*deg 360*deg",
    "0.0*cm $inner_radius*cm 1.58*m 0*deg 360*deg",
    "0.0*cm $inner_radius*cm 0.23*m 0*deg 360*deg",
    "0.0*cm $inner_radius*cm 2.00*m 0*deg 360*deg",
    "$inner_radius*cm $outer_radius*cm 2.08*m 0*deg 360*deg",
    "$inner_radius*cm $outer_radius*cm 0.23*m 0*deg 360*deg",
    "$inner_radius*cm $outer_radius*cm 1.58*m 0*deg 360*deg",
    "$inner_radius*cm $outer_radius*cm 0.23*m 0*deg 360*deg",
    "$inner_radius*cm $outer_radius*cm 2.00*m 0*deg 360*deg",
    "2.5000*cm 0.5000*cm 0.15*cm", # 2.5000*cm 0.5000*cm 0.15*cm
    "3.0*cm 3.0*cm 10*cm");


my @material = (
#    "H_GAS_HD",     #11
#    "H_GAS_HD",     #12
#    "H_GAS_HD",     #13
#    "H_GAS_HD",     #14
#    "H_GAS_HD",     #15
    "G4_Galactic",     #11
    "G4_Galactic",     #12
    "G4_Galactic",     #13
    "G4_Galactic",     #14
    "G4_Galactic",     #15
    "StainlessSteel", #16
    "StainlessSteel", #17
    "StainlessSteel", #18
    "StainlessSteel", #19
    "StainlessSteel", #20
    "G4_Galactic", #21 Steel Plate/G4_Galactic
    "G4_GLASS_LEAD"); #22
#    "G4_Galactic");

sub make_det1_compton_eledownstream_geometry
{

    for(my $i = 0; $i < ($#name+1); $i++)
    {
    
	my %detector=init_det();
	$detector{"name"}        = "$name[$i]";
	$detector{"mother"}      = "$volume[$i]";
#	$detector{"mother"}      = "root";
	$detector{"description"} = "$description[$i]";
	$detector{"pos"}         = "$position[$i]";
	$detector{"rotation"}    = "$rotation[$i]";
	$detector{"color"}       = "$color[$i]"; 
	$detector{"type"}        = "$type_id[$i]";
	$detector{"dimensions"}  = "$dimensions[$i]";
	$detector{"material"}    = "$material[$i]";
        $detector{"mfield"}      = "$field[$i]";
#        $detector{"mfield"}      = "no";
	$detector{"ncopy"}       = 1;
	$detector{"pMany"}       = 1;
	$detector{"exist"}       = 1;
	$detector{"visible"}     = $visibility[$i];
	$detector{"style"}       = 1;
	$detector{"sensitivity"} = "$sens[$i]";
	$detector{"hit_type"}    = "$h_type[$i]";
	$detector{"identifiers"} = "$id_number[$i]";
	print_det(\%configuration, \%detector);
    }
}
