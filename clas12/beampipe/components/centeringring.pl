use strict;
use warnings;

our %configuration;


sub build_centeringring
{
	my %detector = init_det();
	$detector{"name"}        = "centeringring";
	$detector{"mother"}      = "root";
	$detector{"description"} = "centeringring";
	$detector{"color"}       = "557777";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 800*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 13*mm 13*mm 30*mm 30*mm 1547.88*mm 1559.88*mm";
	$detector{"material"}    = "G10";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub build_centeringringtube
{
	my %detector = init_det();
	$detector{"name"}        = "fibercollar";
	$detector{"mother"}      = "root";
	$detector{"description"} = "fibercollar";
	$detector{"color"}       = "557777";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 800*mm 1553.88*mm";
	$detector{"dimensions"}  = "13*mm 30*mm 6*mm 0*deg 360*deg";
	$detector{"material"}    = "G10";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

