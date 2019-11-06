use strict;
use warnings;

our %configuration;


sub build_manifoldsupportring
{
	my %detector = init_det();
	$detector{"name"}        = "manifoldsupportring";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Manifold Support Ring";
	$detector{"color"}       = "557777";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 36.9336*mm 36.9336*mm 52.9276*mm 52.9276*mm 2214.32*mm 2217.32*mm";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

