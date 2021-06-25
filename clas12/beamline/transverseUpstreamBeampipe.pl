use strict;
use warnings;

our %configuration;

sub transverseUpstreamBeampipe()
{
	my $pipeLength = 1000;
	my $zpos = -1025;
	my $firstVacuumOR = 35;

	my %detector = init_det();
	$detector{"name"}        = "upstreamTransverseMagnetVacuumPipe";
	$detector{"mother"}      = "root";
	$detector{"description"} = "upstreamTransverseMagnetVacuumPipe";
	$detector{"color"}       = "334488";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "0*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Galactic";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

}

