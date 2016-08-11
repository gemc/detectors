use strict;
use warnings;

our %configuration;

our $TorusZpos;
our $SteelFrameLength;
our $tungstenColor;

my $torusZend = $TorusZpos + $SteelFrameLength;


sub afterTorusShielding()
{
	# physicists design shielding downstream of the torus
	# the length, thickness and material of the nose are parameters
	
	my($nose_l1, $nose_l2, $nose_or, $nose_material) = @_;
	
	my $microgap = 0.1;

	my $gapTorusShield = 17.65*$inches;
	
	if($nose_l1 > $gapTorusShield) {$nose_l1 = $gapTorusShield}
	$nose_l2 = $nose_l2 + $nose_l1;
	
	# downstream shield
	# Actually there is lead inside SST
	my $downstreamShieldRThickness = 40;
	my $downstreamShieldOR         = 350.0/2.0;
	my $downstreamShieldIR         = $downstreamShieldOR - $downstreamShieldRThickness;
	my $downstreamShieldLength     = 1000;
	my $downstreamShieldZpos       = $torusZend + $downstreamShieldLength + 2*$microgap + $nose_l1;

	my %detector = init_det();
	$detector{"name"}        = "downstreamShield";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Shielding pipe after the torus";
	$detector{"color"}       = "993333";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0.0*mm $downstreamShieldZpos*mm";
	$detector{"dimensions"}  = "$downstreamShieldIR*mm $downstreamShieldOR*mm $downstreamShieldLength*mm 0.0*deg 360*deg";
	$detector{"material"}    = "G4_Pb";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
	
	# nose after torus ($gapTorusShield in room to work with for the first part)
	my $ColdHubIR =  62.0 ;     # Warm bore tube ID is 124 as from DK drawing
	my $nplanes   = 4;
	my @zplane    = ( 0.0        , $nose_l1   , $nose_l1 + $microgap            , $nose_l2                        );
	my @iradius   = ( $ColdHubIR , $ColdHubIR , $ColdHubIR                      , $ColdHubIR                      );
	my @oradius   = ( $nose_or   , $nose_or   , $downstreamShieldIR - $microgap , $downstreamShieldIR - $microgap );
	
	my $noseZStart   = $torusZend + $microgap;
	
	%detector = init_det();
	$detector{"name"}        = "downstreamNose";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Shielding nose after the torus";
	$detector{"pos"}         = "0*mm 0.0*mm $noseZStart*mm";
	$detector{"color"}       = "0000ff";
	if($nose_material eq "beamline_W")
	{
		$detector{"color"}       = $tungstenColor;
	}
	
	$detector{"type"}        = "Polycone";
	my $dimen = "0.0*deg 360*deg $nplanes*counts";
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $iradius[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $oradius[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $zplane[$i]*mm";}
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = $nose_material;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

}

