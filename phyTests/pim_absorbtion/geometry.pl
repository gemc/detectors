use strict;
use warnings;

our %configuration;


sub make_test_geo
{
	
	
	my $DetectorRadius=60.;
	my $DetectorLength=205.;
	my $DumpRadius=50.;
	my $DumpLength=200.;
	
	
	my %detector = init_det();
	
	$detector{"name"}        = "fluxDet";
	$detector{"mother"}      = "root";
	$detector{"description"} = "vacuum Detector";
	$detector{"color"}       = "ff80002";
	$detector{"style"}       = 1;
	$detector{"visible"}     = 1;
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*cm $DetectorRadius*cm $DetectorLength*cm 0.*deg 360.*deg";
	$detector{"material"}    = "G4_Galactic";
	$detector{"sensitivity"} = "flux";
	$detector{"hit_type"}    = "flux";
	$detector{"identifiers"} = "id manual 1";
	print_det(\%configuration, \%detector);

	%detector = init_det();
	
	$detector{"name"}        = "BeamDump";
	$detector{"mother"}      = "fluxDet";
	$detector{"description"} = "Aluminum BeamDump";
	$detector{"color"}       = "f00000";
	$detector{"style"}       = 1;
	$detector{"visible"}     = 1;
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*cm $DumpRadius*cm $DumpLength*cm 0.*deg 360.*deg";
	$detector{"material"}    = "G4_Al";
	print_det(\%configuration, \%detector);
}


1;


