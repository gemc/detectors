use strict;
use warnings;

our %configuration;


my $shieldStart = 943; # start of vacuum pipe is 1mm downstream of target vac extension
my $torusStart  = 2754.17 ;
my $torusEnd    = 4915.27 ;
my $pipeEnds    = 9400;

# temp backnose until CAD model
my $backNoseLength1 = $torusEnd + 300;
my $backNoseLength2 = $backNoseLength1 + 400;
my $backNoseIR  =  68.0;
my $backNoseOR1 = 170.0;
my $backNoseOR2 = 115.0;
my $oneWSleeve = 307.7;

# apex cad model not filled with lead.
my $apexIR = 140;
my $apexOR = 190;
my $apexLength = 1000;
my $apexPos = 5372;

sub vacuumLine()
{
	# in "root" the first part of the pipe is straight
	my $pipeLength = ($torusStart - $shieldStart) / 2.0 - 0.1;
	my $zpos = $shieldStart + $pipeLength ;
	my $firstVacuumIR = 26.6;
	my $firstVacuumOR = 28.6;

	my %detector = init_det();
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

	# vacuum inside
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




    # sst pipe inside torus has steps

    my $nplanes = 4;

	#                        inside torus------------downstream
    my @iradius_vbeam  =  (  32.0,        32.0,      60.0,      60.0);
    my @oradius_vbeam  =  (  35.0,        35.0,      66.0,      66.0);
	my @z_plane_vbeam  =  (  $torusStart, $torusEnd, $torusEnd, $pipeEnds );

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

	# temp backnose until CAD model
	$nplanes = 4;
	#                       big------------------------------small------------------------
	my @iradius_nose  =  (  $backNoseIR,   $backNoseIR,      $backNoseIR,      $backNoseIR);
	my @oradius_nose  =  (  $backNoseOR1,  $backNoseOR1,     $backNoseOR2,     $backNoseOR2);
	my @z_plane_nose  =  (  $torusEnd,     $backNoseLength1, $backNoseLength1, $backNoseLength2 );

	# lead nose
	%detector = init_det();
	$detector{"name"}        = "torusBackNose";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "torus back nose";
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Polycone";
	$dimen = "0.0*deg 360*deg $nplanes*counts";
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $iradius_nose[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $oradius_nose[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $z_plane_nose[$i]*mm";}
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = "G4_Pb";
	$detector{"color"}       = "ff4444";
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



	# airgap still needed
	%detector = init_det();
	$detector{"name"}        = "airPipe";
	$detector{"mother"}      = "root";
	$detector{"description"} = "airgap between target and shield to limit e- steps";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0*mm 625*mm";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm 45*mm 250*mm 0*deg 360*deg";
	$detector{"style"}       = 1;
	$detector{"material"}    = "G4_AIR";
	print_det(\%configuration, \%detector);

	%detector = init_det();
	$detector{"name"}        = "airPipe2";
	$detector{"mother"}      = "airPipe";
	$detector{"description"} = "airgap between target and shield to limit e- steps";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm 10*mm 249*mm 0*deg 360*deg";
	$detector{"style"}       = 1;
	$detector{"material"}    = "G4_AIR";
	print_det(\%configuration, \%detector);

}

