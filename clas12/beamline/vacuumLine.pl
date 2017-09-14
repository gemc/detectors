use strict;
use warnings;

our %configuration;

# the vacuum line ia actually hardcoded in beamlinePipes__geometry_FTOff.txt, beamlinePipes__geometry_FTOff.txt
# grep aluminumBeamPipe beamline__geometry_FTOn.txt and copy where necessary

sub vacuumLine()
{
	# straight aluminum pipe with vacucum inside

	# the beampipe is 0.125" (3mm) thick up to the torus downstream nose end, then 5mm thick

	my $iradius  = 26.68;
	my $oradius  = 29.8;
	my $starLine = 433.9;
	my $length   = 4000;

	if( $configuration{"variation"} eq "FTOn") {
		$starLine = 879;
	}


	my $zstart = $starLine + $length;

	# aluminum pipe
	my %detector = init_det();
	$detector{"name"}        = "aluminumBeamPipe";
	$detector{"mother"}      = "root";
	$detector{"description"} = "aluminum beampipe";
	$detector{"color"}       = "aaffff";
	$detector{"pos"}         = "0*mm 0*mm $zstart*mm";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm $oradius*mm $length*mm 0*deg 360*deg";
	$detector{"style"}       = 1;
	$detector{"material"}    = "G4_Al";
	print_det(\%configuration, \%detector);

	# vacuum pipe
	%detector = init_det();
	$detector{"name"}        = "vacuumBeamPipe";
	$detector{"mother"}      = "aluminumBeamPipe";
	$detector{"description"} = "aluminum beampipe";
	$detector{"color"}       = "aaffff";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm $iradius*mm $length*mm 0*deg 360*deg";
	$detector{"style"}       = 1;
	$detector{"material"}    = "G4_Galactic";
	print_det(\%configuration, \%detector);

}

