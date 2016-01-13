use strict;
use warnings;

our %configuration;

our $TorusZpos;
our $SteelFrameLength;

my $torusZstart = $TorusZpos - $SteelFrameLength;


sub vacuumLine()
{
	# original physicists design vacuum line
	# tapered aluminum pipe with vacucum inside
	if($configuration{"variation"} eq "physicistsBaselineNoFT")
	{
		# up to the torus the beampipe is 11mm thick.
		# inside the torus is 3mm thick
		my $nplanes_vbeam = 5;
	
		my @iradius_vbeam  = ( 23.0, 30.0, 30.0, 37.0, 37.0 );
		my @oradius_vbeam  = ( 24.0, 41.0, 41.0, 40.0, 40.0 );
		
		my $pipeZstart    = 420.0;    # start of cone
		my $taperedLength = 1390.0;   # start of cone + length of tapered part
		
		my $totalLength  = 10000.0;   # start of cone + total beamline semi-length
		
		my @z_plane_vbeam  = ( $pipeZstart, $taperedLength, $torusZstart, $torusZstart, $totalLength );
		
		
		# aluminum pipe
		my %detector = init_det();
		$detector{"name"}        = "aluminumBeamPipe";
		$detector{"mother"}      = "root";
		$detector{"description"} = "aluminum beampipe";
		$detector{"color"}       = "aaffff";
		$detector{"type"}        = "Polycone";
		my $dimen = "0.0*deg 360*deg $nplanes_vbeam*counts";
		for(my $i = 0; $i <$nplanes_vbeam; $i++) {$dimen = $dimen ." 0.0*mm";}
		for(my $i = 0; $i <$nplanes_vbeam; $i++) {$dimen = $dimen ." $oradius_vbeam[$i]*mm";}
		for(my $i = 0; $i <$nplanes_vbeam; $i++) {$dimen = $dimen ." $z_plane_vbeam[$i]*mm";}
		$detector{"dimensions"}  = $dimen;
		$detector{"material"}    = "G4_Al";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
		
		# vacuum pipe
		%detector = init_det();
		$detector{"name"}        = "vacuumBeamPipe";
		$detector{"mother"}      = "aluminumBeamPipe";
		$detector{"description"} = "vacuum inside aluminum beampipe";
		$detector{"color"}       = "000000";
		$detector{"type"}        = "Polycone";
		$dimen = "0.0*deg 360*deg $nplanes_vbeam*counts";
		for(my $i = 0; $i <$nplanes_vbeam; $i++) {$dimen = $dimen ." 0.0*mm";}
		for(my $i = 0; $i <$nplanes_vbeam; $i++) {$dimen = $dimen ." $iradius_vbeam[$i]*mm";}
		for(my $i = 0; $i <$nplanes_vbeam; $i++) {$dimen = $dimen ." $z_plane_vbeam[$i]*mm";}
		$detector{"dimensions"}  = $dimen;
		$detector{"material"}    = "G4_Galactic";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
	
	# corrected physicists design vacuum line
	# straight aluminum pipe with vacucum inside
	if($configuration{"variation"} eq "physicistsCorrectedBaselineNoFT")
	{
		# up to the torus the beampipe is 11mm thick.
		# inside the torus is 3mm thick
		
		my $iradius_vbeam  =  27.0;
		my $oradius_vbeam  =  29.4;
		
		my $totalLength  = 5000.0;                   # total beamline semi-length
		my $pipeZstart    = 420.0 + $totalLength;    # start of cone
		
		# aluminum pipe
		my %detector = init_det();
		$detector{"name"}        = "aluminumBeamPipe";
		$detector{"mother"}      = "root";
		$detector{"description"} = "aluminum beampipe";
		$detector{"color"}       = "aaffff";
		$detector{"pos"}         = "0*mm 0.0*mm $pipeZstart*mm";
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "0*mm $oradius_vbeam*mm $totalLength*mm 0.0*deg 360*deg";
		$detector{"material"}    = "G4_Al";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
		
		# vacuum pipe
		%detector = init_det();
		$detector{"name"}        = "vacuumBeamPipe";
		$detector{"mother"}      = "aluminumBeamPipe";
		$detector{"description"} = "vacuum inside aluminum beampipe";
		$detector{"color"}       = "000000";
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "0.0*mm $iradius_vbeam*mm $totalLength*mm 0.0*deg 360*deg";
		$detector{"material"}    = "G4_Galactic";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}

	if($configuration{"variation"} eq "physicistsBaselineWithFT")
	{
		# Aluminum Beam Pipe
		my $al_tube_TN = 1.0;
		my $al_tube_IR = 25.4;
		my $al_tube_OR = $al_tube_IR + $al_tube_TN;
		
		# up to the torus the beampipe is 11mm thick.
		# inside the torus is 3mm thick
		my $nplanes_vbeam = 5;

		my @iradius_vbeam  = ( $al_tube_IR, $al_tube_IR, $al_tube_IR, 37.0, 37.0 );
		my @oradius_vbeam  = ( $al_tube_OR, $al_tube_OR, $al_tube_OR, 40.0, 40.0 );
		
		my $pipeZstart    = 750.0;    # start of cone
		my $taperedLength = 1750.0;   # start of cone + length of tapered part
		
		my $totalLength  = 10000.0;   # start of cone + total beamline semi-length
		
		my @z_plane_vbeam  = ( $pipeZstart, $taperedLength, $torusZstart, $torusZstart, $totalLength );
		
		
		# aluminum pipe
		my %detector = init_det();
		$detector{"name"}        = "aluminumBeamPipe";
		$detector{"mother"}      = "root";
		$detector{"description"} = "aluminum beampipe";
		$detector{"color"}       = "aaffff";
		$detector{"type"}        = "Polycone";
		my $dimen = "0.0*deg 360*deg $nplanes_vbeam*counts";
		for(my $i = 0; $i <$nplanes_vbeam; $i++) {$dimen = $dimen ." 0.0*mm";}
		for(my $i = 0; $i <$nplanes_vbeam; $i++) {$dimen = $dimen ." $oradius_vbeam[$i]*mm";}
		for(my $i = 0; $i <$nplanes_vbeam; $i++) {$dimen = $dimen ." $z_plane_vbeam[$i]*mm";}
		$detector{"dimensions"}  = $dimen;
		$detector{"material"}    = "G4_Al";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
		
		# vacuum pipe
		%detector = init_det();
		$detector{"name"}        = "vacuumBeamPipe";
		$detector{"mother"}      = "aluminumBeamPipe";
		$detector{"description"} = "vacuum inside aluminum beampipe";
		$detector{"color"}       = "000000";
		$detector{"type"}        = "Polycone";
		$dimen = "0.0*deg 360*deg $nplanes_vbeam*counts";
		for(my $i = 0; $i <$nplanes_vbeam; $i++) {$dimen = $dimen ." 0.0*mm";}
		for(my $i = 0; $i <$nplanes_vbeam; $i++) {$dimen = $dimen ." $iradius_vbeam[$i]*mm";}
		for(my $i = 0; $i <$nplanes_vbeam; $i++) {$dimen = $dimen ." $z_plane_vbeam[$i]*mm";}
		$detector{"dimensions"}  = $dimen;
		$detector{"material"}    = "G4_Galactic";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
	
	
	
	
	
}


