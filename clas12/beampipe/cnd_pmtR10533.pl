use strict;
use warnings;

our %configuration;


sub build_cnd_pmtR10533
{
	my %detector = init_det();
	$detector{"name"}        = "cnd_pmtR10533";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Hamamatsu R10533 PMT";
	$detector{"color"}       = "111111";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm 0.0*mm";
	$detector{"dimensions"}  = "25.4*mm 25.5*mm 53.5*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

