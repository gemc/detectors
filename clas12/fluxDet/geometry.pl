use strict;
use warnings;

our %configuration;


sub makeFlux
{

	my $minAngle = 7;   # degrees
	my $maxAngle = 45;  # degrees
	my $zpos     = 100; # cm
	my $thick    = 1;   # cm

	my $IR = $zpos*tan(rad($minAngle));
	my $OR = $zpos*tan(rad($maxAngle));

	my %detector = init_det();
	$detector{"name"}        = "clasFlux";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Flux detector at z=1m";
	$detector{"pos"}         = "0*cm 0*cm $zpos*cm";
	$detector{"color"}       = "33bb99";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$IR*cm $OR*cm $thick*cm 0*deg 360*deg";
	$detector{"material"}    = "G4_AIR";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	$detector{"sensitivity"} = "flux";
	$detector{"hit_type"}    = "flux";
	$detector{"identifiers"} = "id manual 1";
	print_det(\%configuration, \%detector);
}

