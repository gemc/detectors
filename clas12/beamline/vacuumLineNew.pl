use strict;
use warnings;

our %configuration;


my $shieldStart = 963; # start of vacuum pipe is 1mm downstream of target vac extension
my $pipeFirstStep = 2413;
my $torusStart    = 2754.17 ;
my $mediumPipeEnd = 5016; # added by hand by shooting geantino vertically to locate the point
my $bigPipeBegins = 5064; # added by hand by shooting geantino vertically to locate the point
my $pipeEnds      = 5732;
my $alcovePipeStarts = 5741;
my $alcovePipeEnds   = 9400;
my $mediumStarts  = $pipeFirstStep + 76.5; # added by hand by shooting geantino vertically to locate the point

# apex cad model not filled with lead.
my $apexIR = 140;
my $apexOR = 190;
my $apexLength = 1000;
my $apexPos = 5372;

sub vacuumLine()
{

	if( $configuration{"variation"} eq "FTOff") {
		$shieldStart = 503;
	}


	# in "root" the first part of the pipe is straight
	# 1.651mm thick
	my $pipeLength = ($pipeFirstStep - $shieldStart) / 2.0 - 0.1;
	my $zpos = $shieldStart + $pipeLength ;
	my $firstVacuumIR = 26.924;
	my $firstVacuumOR = 28.52;

	my %detector = init_det();
	# vacuum inside
	if( $configuration{"variation"} eq "rgfFTOff") {
		# create a empty space in the vacuumPipe1 to accommodate the helium pipe in rgf.
	# in "root" the first part of the pipe is straight
	# 1.651mm thick
	#	my $pipeLength = ($pipeFirstStep - $shieldStart) / 2.0 - 0.1;
	#my $zpos = $shieldStart + $pipeLength ;
	#my $firstVacuumIR = 26.924;
	#my $firstVacuumOR = 28.52;

	$detector{"name"}        = "vacuumPipe1";
	$detector{"mother"}      = "root";
	$detector{"description"} = "straightVacuumPipe";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "0*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	# vacuum inside
		%detector = init_det();
		$detector{"name"}        = "vacuumInPipe1";
		$detector{"mother"}      = "vacuumPipe1";
		$detector{"description"} = "straightVacuumPipe";
		$detector{"color"}       = "ff3349";
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "0*mm $firstVacuumIR*mm $pipeLength*mm 0*deg 360*deg";
		$detector{"material"}    = "Component";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
		
		$shieldStart = 503;
		my $emptyPipeLength = (794.3658 - $shieldStart)/2.0; # 794.3658(mother volume end of snout)
		my $empty_zpos = $shieldStart + $emptyPipeLength;
		#my $empty_zpos = -$zpos + $shieldStart + $emptyPipeLength;
		$emptyPipeLength = (794.3658 - $shieldStart)/2.0 + 0.001;

		print "empty z_pos = $empty_zpos, pipeLength = $emptyPipeLength\n";
	
		%detector = init_det();
		$detector{"name"}        = "emptyInPipe1_1";
		$detector{"mother"}      = "root";
		$detector{"description"} = "empty space inside the VacuumPipe";
		$detector{"color"}       = "ff3349";
		$detector{"type"}        = "Tube";
		$detector{"pos"}         = "0*mm 0*mm $empty_zpos*mm";
		$detector{"dimensions"}  = "0*mm 19.81202*mm $emptyPipeLength*mm 0*deg 360*deg";
		$detector{"material"}    = "Component";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	
		$empty_zpos = $empty_zpos - $zpos;
		%detector = init_det();
		$detector{"name"}        = "emptyInPipe1_2";
		$detector{"mother"}      = "vacuumPipe1_rgf";
		$detector{"description"} = "empty space inside the VacuumPipe";
		$detector{"color"}       = "ff3349";
		$detector{"type"}        = "Tube";
		$detector{"pos"}         = "0*mm 0*mm $empty_zpos*mm";
		$detector{"dimensions"}  = "0*mm 19.81202*mm $emptyPipeLength*mm 0*deg 360*deg";
		$detector{"material"}    = "Component";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);

	%detector = init_det();
	$detector{"name"}        = "vacuumPipe1_rgf";
	$detector{"mother"}      = "root";
	$detector{"description"} = "straightVacuumPipe";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Operation:@ vacuumPipe1 - emptyInPipe1_1";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "0";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

		# substract vacuumInPipe1
		%detector = init_det();
		$detector{"name"}        = "vacuumInPipe1_rgf";
		$detector{"mother"}      = "vacuumPipe1_rgf";
		$detector{"description"} = "straightVacuumPipe for rgf";
		$detector{"color"}       = "000000";
		$detector{"type"}        = "Operation:@ vacuumInPipe1 - emptyInPipe1_2";
		$detector{"dimensions"}  = "0";
		$detector{"material"}    = "G4_Galactic";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
	else {

	$detector{"name"}        = "vacuumPipe1";
	$detector{"mother"}      = "root";
	$detector{"description"} = "straightVacuumPipe";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "0*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

		%detector = init_det();
		$detector{"name"}        = "vacuumInPipe1";
		$detector{"mother"}      = "vacuumPipe1";
		$detector{"description"} = "straightVacuumPipe";
		$detector{"color"}       = "000000";
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "0*mm $firstVacuumIR*mm $pipeLength*mm 0*deg 360*deg";
		$detector{"material"}    = "G4_Galactic";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}

	# in "root" the second part of the pipe is straight until torus
	$pipeLength = ($torusStart - $mediumStarts) / 2.0 - 0.1;
	$zpos = $mediumStarts + $pipeLength ;
	my $secondVacuumIR = 33.275;
	my $secondVacuumOR = 34.925;

	%detector = init_det();
	$detector{"name"}        = "vacuumPipe2";
	$detector{"mother"}      = "root";
	$detector{"description"} = "straightVacuumPipe";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "0*mm $secondVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	# vacuum inside
	%detector = init_det();
	$detector{"name"}        = "vacuumInPipe2";
	$detector{"mother"}      = "vacuumPipe2";
	$detector{"description"} = "straightVacuumPipe";
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm $secondVacuumIR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Galactic";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	# added SST piece on top of Al junction
	$pipeLength = ($mediumStarts - $pipeFirstStep) / 2.0 - 0.1;
	$zpos = $pipeFirstStep + $pipeLength ;

	%detector = init_det();
	my $connectingIR = $secondVacuumIR + 0.1;
	$detector{"name"}        = "vacuumPipe3";
	$detector{"mother"}      = "root";
	$detector{"description"} = "straightVacuumPipe";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "$connectingIR*mm $secondVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	# vacuum inside,  this is inside ROOT
	%detector = init_det();
	$detector{"name"}        = "vacuumInPipe3";
	$detector{"mother"}      = "root";
	$detector{"description"} = "straightVacuumPipe";
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "0*mm $firstVacuumOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Galactic";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);


	# in "fc" the pipe gets bigger after the torus
	# 1.651mm thick

	my $nplanes = 4;

	#                        inside torus------------downstream
	my @iradius_vbeam  =  (  33.274,      33.274,         60.325        , 60.325);
	my @oradius_vbeam  =  (  34.925,      34.925,         63.5          , 63.5);
	my @z_plane_vbeam  =  (  $torusStart, $mediumPipeEnd, $bigPipeBegins, $pipeEnds );

	# sst pipe
	%detector = init_det();
	$detector{"name"}        = "vacuumPipe";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "vacuumPipe beampipe";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Polycone";
	my $dimen = "0.0*deg 360*deg $nplanes*counts";
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." 0.0*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $oradius_vbeam[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $z_plane_vbeam[$i]*mm";}
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	# vacuum inside
	%detector = init_det();
	$detector{"name"}        = "vacuumInPipe";
	$detector{"mother"}      = "vacuumPipe";
	$detector{"description"} = "vacuum inside vacuumPipe";
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Polycone";
	$dimen = "0.0*deg 360*deg $nplanes*counts";
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." 0.0*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $iradius_vbeam[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $z_plane_vbeam[$i]*mm";}
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = "G4_Galactic";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	# pipe to alcove
	$pipeLength = ($alcovePipeEnds - $alcovePipeStarts) / 2.0 - 0.1;
	$zpos = $alcovePipeStarts + $pipeLength ;
	my $thirdPipeIR = 64;
	my $thirdPipeOR = 68;

	%detector = init_det();
	$detector{"name"}        = "vacuumPipeToAlcove";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "straightVacuumPipe";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "0*mm $thirdPipeOR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	# vacuum inside,  this is inside ROOT
	%detector = init_det();
	$detector{"name"}        = "vacuumInPipeToAlcove";
	$detector{"mother"}      = "vacuumPipeToAlcove";
	$detector{"description"} = "vacuumInPipeToAlcove";
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm $thirdPipeIR*mm $pipeLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Galactic";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);


	# lead inside apex
	$zpos = $apexPos + $apexLength;

	%detector = init_det();
	$detector{"name"}        = "leadInsideApex";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "lead inside apex";
	$detector{"color"}       = "4499ff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm $zpos*mm";
	$detector{"dimensions"}  = "$apexIR*mm $apexOR*mm $apexLength*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Pb";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);


	my $gapZpos = 283;
	my $gapLength = 295;

	if ($configuration{"variation"} eq "FTOff") {
		$gapLength = 92.5;
	}

	my $gapLengthm = $gapLength + 1;
	my $ztart = $gapZpos ;


	# airpipes to account for change in volume size from target to "root" within a magnetic field
	#
	#
	my @oradius_airpipe  =  (  20,      55);
	my @z_plane_airpipe  =  (  0, 2*$gapLength );

	%detector = init_det();
	$detector{"name"}        = "airPipe";
	$detector{"mother"}      = "root";
	$detector{"description"} = "airgap between target and shield to limit e- steps";
	$detector{"color"}       = "aaffff";
	$detector{"pos"}         = "0*mm 0*mm $ztart*mm";
	$detector{"type"}        = "Polycone";
	$dimen = "0.0*deg 360*deg 2*counts";
	for(my $i = 0; $i <2; $i++) {$dimen = $dimen ." 0.0*mm";}
	for(my $i = 0; $i <2; $i++) {$dimen = $dimen ." $oradius_airpipe[$i]*mm";}
	for(my $i = 0; $i <2; $i++) {$dimen = $dimen ." $z_plane_airpipe[$i]*mm";}
	$detector{"dimensions"}  = $dimen;
	$detector{"style"}       = 1;
	$detector{"material"}    = "G4_AIR";
	print_det(\%configuration, \%detector);

	my $innerAirpipeDimension = $gapLength - 0.2;
	%detector = init_det();
	$detector{"name"}        = "airPipe2";
	$detector{"mother"}      = "airPipe";
	$detector{"description"} = "airgap between target and shield to limit e- steps";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm  $innerAirpipeDimension*mm";
	$detector{"dimensions"}  = "0*mm 10*mm $innerAirpipeDimension*mm 0*deg 360*deg";
	$detector{"style"}       = 1;
	$detector{"material"}    = "G4_AIR";
	print_det(\%configuration, \%detector);




}

