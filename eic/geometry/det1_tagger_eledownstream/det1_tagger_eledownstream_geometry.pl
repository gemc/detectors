use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

my $DetectorMother="root";

my $DetectorName = 'det1_tagger_eledownstream';

#length in m, halfaperture in cm, streng in T or T/m, X in m, Z in m, Theta in rad
my $e_ds_dipole1_length			= $parameters{"e_ds_dipole1_length"};
my $e_ds_dipole1_innerhalfaperture	= $parameters{"e_ds_dipole1_innerhalfaperture"};
my $e_ds_dipole1_outerhalfaperture	= $parameters{"e_ds_dipole1_outerhalfaperture"};
my $e_ds_dipole1_strength		= $parameters{"e_ds_dipole1_strength"};
my $e_ds_dipole1_X			= $parameters{"e_ds_dipole1_X"};
my $e_ds_dipole2_X			= $parameters{"e_ds_dipole2_X"};
my $e_ds_dipole3_X			= $parameters{"e_ds_dipole3_X"};
my $e_ds_dipole1_Z			= $parameters{"e_ds_dipole1_Z"};
my $e_ds_dipole2_Z			= $parameters{"e_ds_dipole2_Z"};
my $e_ds_dipole3_Z			= $parameters{"e_ds_dipole3_Z"};
my $e_ds_dipole1_Theta			= $parameters{"e_ds_dipole1_Theta"};

my $Dy=$e_ds_dipole1_outerhalfaperture;
my $Dz=0.5*$e_ds_dipole1_length;
my $X=$e_ds_dipole1_X-0.6;
#my $Z=$e_ds_dipole1_Z-2*$e_ds_dipole1_length;
my $Z=$e_ds_dipole1_Z-2;
my $Z2=$e_ds_dipole2_Z+2;
my $X2=$e_ds_dipole2_X-0.5;
my $Z3=$e_ds_dipole3_Z-2;
my $X3=$e_ds_dipole3_X-0.3;
# == id name ==============================================================
# digit     beamline                side          magnet      number          window
#        ion    1        upstream    1    dipole    1           n     front      1
#        ele    2       downstream   2  quadrupole  2           n     back       2
#                                         virtual   3 
#                                         compton   4 
#                                         tagger    5 
# =========================================================================


sub det1_tagger_eledownstream
{
    make_meic_det1_ele_tagger_side();
    make_meic_det1_ele_tagger_front();
    make_meic_det1_ele_tagger_back();

}

sub make_meic_det1_ele_tagger_side
{
	my %detector = init_det();
	$detector{"name"}        = "$DetectorName"."side";
	$detector{"mother"}      = "$DetectorMother" ;
	$detector{"description"} = "$DetectorName";
	$detector{"pos"}         = "$X*m 0*m $Z*m";
	$detector{"rotation"}    = "0*deg -$e_ds_dipole1_Theta*deg 0*deg";
	$detector{"color"}       = "880000";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "1*cm 10*cm 3*m";
	$detector{"material"}    = "Kryptonite";
	$detector{"mfield"}     = "no";
	$detector{"ncopy"}      = 1;
	$detector{"pMany"}       = 1;
	$detector{"exist"}       = 1;
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;	
	$detector{"sensitivity"} ="flux";
	$detector{"hit_type"}    ="flux";
	$detector{"identifiers"} ="id manual 22510";
	print_det(\%configuration, \%detector);	
}

sub make_meic_det1_ele_tagger_front
{
	my %detector = init_det();
	$detector{"name"}        = "$DetectorName"."front";
	$detector{"mother"}      = "$DetectorMother" ;
	$detector{"description"} = "$DetectorName";
	$detector{"pos"}         = "$X*m 0*m $Z2*m";
	$detector{"rotation"}    = "0*deg -$e_ds_dipole1_Theta*deg 0*deg";
	$detector{"color"}       = "880000";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "30*cm 10*cm 0.1*cm";
	$detector{"material"}    = "Kryptonite";
	$detector{"mfield"}     = "no";
	$detector{"ncopy"}      = 1;
	$detector{"pMany"}       = 1;
	$detector{"exist"}       = 1;
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;	
	$detector{"sensitivity"} ="flux";
	$detector{"hit_type"}    ="flux";
	$detector{"identifiers"} ="id manual 22511";
	print_det(\%configuration, \%detector);	
}

sub make_meic_det1_ele_tagger_back
{
	my %detector = init_det();
	$detector{"name"}        = "$DetectorName"."back";
	$detector{"mother"}      = "$DetectorMother" ;
	$detector{"description"} = "$DetectorName";
	$detector{"pos"}         = "$X3*m 0*m $Z3*m";
	$detector{"rotation"}    = "0*deg -$e_ds_dipole1_Theta*deg 0*deg";
	$detector{"color"}       = "880000";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "30*cm 10*cm 0.1*cm";
	$detector{"material"}    = "Kryptonite";
	$detector{"mfield"}     = "no";
	$detector{"ncopy"}      = 1;
	$detector{"pMany"}       = 1;
	$detector{"exist"}       = 1;
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;	
	$detector{"sensitivity"} ="flux";
	$detector{"hit_type"}    ="flux";
	$detector{"identifiers"} ="id manual 22512";
	print_det(\%configuration, \%detector);	
}
