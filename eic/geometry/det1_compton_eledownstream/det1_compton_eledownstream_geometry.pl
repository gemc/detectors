use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

my $DetectorMother="root";

my $DetectorName = 'det1_compton_eledownstream';

#length in m, halfaperture in cm, streng in T or T/m, X in m, Z in m, Theta in rad
my $photonX			= $parameters{"e_ds_dipole3_X"};
my $photonZ			= $parameters{"e_ds_dipole3_Z"}-4;
my $ZDC_X			= $parameters{"e_ds_dipole1_X"};
my $ZDC_Z			= $parameters{"e_ds_dipole1_Z"}-4;
my $e_ds_compton7_halfaperture	= $parameters{"e_ds_dipole4_innerhalfaperture"};
my $edetX			= $parameters{"e_ds_dipole4_X"}+$e_ds_compton7_halfaperture/100;
my $edetZ			= $parameters{"e_ds_dipole4_Z"}+4;

# == id name ==============================================================
# digit     beamline                side          magnet      number          window
#        ion    1        upstream    1    dipole    1           n     front      1
#        ele    2       downstream   2  quadrupole  2           n     back       2
#                                         virtual   3 
#                                         compton   4 
#                                         tagger    5 
# =========================================================================


sub det1_compton_eledownstream
{
photondet();
edet();
ZDC();
}

sub photondet()
{
	my %detector = init_det();
	$detector{"name"}        = "$DetectorName\_photondet";
	$detector{"mother"}      = "$DetectorMother" ;
	$detector{"description"} = "$DetectorName\_photondet";
	$detector{"pos"}         = "$photonX*m 0*m $photonZ*m";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "880000";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "5*cm 5*cm 30*cm";
	$detector{"material"}    = "Kryptonite";
	$detector{"mfield"}     = "no";
	$detector{"ncopy"}      = 1;
	$detector{"pMany"}       = 1;
	$detector{"exist"}       = 1;
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;	
	$detector{"sensitivity"} ="flux";
	$detector{"hit_type"}    ="flux";
	$detector{"identifiers"} ="id manual 22410";
	print_det(\%configuration, \%detector);	
}

sub ZDC()
{
	my %detector = init_det();
	$detector{"name"}        = "$DetectorName\_ZDC";
	$detector{"mother"}      = "$DetectorMother" ;
	$detector{"description"} = "$DetectorName\_ZDC";
	$detector{"pos"}         = "$ZDC_X*m 0*m $ZDC_Z*m";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "880000";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "5*cm 5*cm 30*cm";
	$detector{"material"}    = "Kryptonite";
	$detector{"mfield"}     = "no";
	$detector{"ncopy"}      = 1;
	$detector{"pMany"}       = 1;
	$detector{"exist"}       = 1;
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;	
	$detector{"sensitivity"} ="flux";
	$detector{"hit_type"}    ="flux";
	$detector{"identifiers"} ="id manual 22430";
	print_det(\%configuration, \%detector);	
}


sub edet
{	
	my %detector = init_det();
	$detector{"name"}        = "$DetectorName\_edet";
	$detector{"mother"}      = "$DetectorMother" ;
	$detector{"description"} = "$DetectorName\_edet";
	$detector{"pos"}         = "$edetX*m 0*m $edetZ*m";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "339999";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "5*cm 5*cm 1*mm";
	$detector{"material"}    = "Kryptonite";
	$detector{"mfield"}     = "no";
	$detector{"ncopy"}      = 1;
	$detector{"pMany"}       = 1;
	$detector{"exist"}       = 1;
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;	
	$detector{"sensitivity"} ="flux";
	$detector{"hit_type"}    ="flux";
	$detector{"identifiers"} ="id manual 22420";
	print_det(\%configuration, \%detector);		
}
