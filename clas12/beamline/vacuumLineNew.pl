use strict;
use warnings;

our %configuration;


my $shieldStart = 877.4; # start of W shield
my $torusStart  = 2756;
my $torusEnd    = 4915.27;
my $pipeEnds    = 10000;

# temp backnose until CAD model
my $backNoseLength1 = 200;
my $backNoseLength2 = 200;
my $backNoseIR  = 110.0;
my $backNoseOR1 = 150.0;
my $backNoseOR2 = 125.0;

sub vacuumLine()
{
    # corrected physicists design vacuum line
    # straight aluminum pipe with vacucum inside
    

    my $nplanes = 6;

	#                       upstream-------inside torus-------------------------downstream
    my @iradius_vbeam  =  (  26.6,         26.6,        32.0,        32.0,      60.0,      60.0);
    my @oradius_vbeam  =  (  28.6,         28.6,        35.0,        35.0,      66.0,      66.0);
	my @z_plane_vbeam  =  ( $shieldStart,  $torusStart, $torusStart, $torusEnd, $torusEnd, $pipeEnds );


	if( $configuration{"variation"} eq "FTOn" {
		@iradius_vbeam  =  (  26.6,  26.6,  32.0,  32.0, 60.0,  60.0);
		@oradius_vbeam  =  (  28.6,  28.6,  35.0,  35.0, 66.0,  66.0);
		@z_plane_vbeam  =  ( 750.0, $tzs, $tzs, $tze, $tze, 11000 );
   }

    # sst pipe
    my %detector = init_det();
    $detector{"name"}        = "vacuumPipe";
    $detector{"mother"}      = "root";
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
	my @oradius_nose  =  (  $backNoseOR2,  $backNoseOR2,     $backNoseOR1,     $backNoseOR1);
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
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $@z_plane_nose[$i]*mm";}
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = "G4_Pb";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);


}

