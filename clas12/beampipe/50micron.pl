use strict;
use warnings;

our %configuration;


sub build_50micron
{
	my %detector = init_det();
	$detector{"name"}        = "50micron";
	$detector{"mother"}      = "root";
	$detector{"description"} = "50 micron Al foil on Solid022";
	$detector{"color"}       = "555555";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm 1017.245*mm";
	$detector{"dimensions"}  = "0*mm 19.5*mm 25*um 0*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

