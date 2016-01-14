use strict;
use warnings;

our %configuration;

our $TorusZpos;
our $SteelFrameLength;
our $mountTotalLength;            # total length of the torus Mount

sub tungstenCone()
{
	my $microgap = 0.1;

	# original physicists design of the moeller shield:
	# tapered tungsten with tapered aluminum vacuum pipe inside
	# corrected physicists design of the moeller shield:
	# tapered tungsten with straight aluminum beam inside

	if($configuration{"variation"} eq "physicistsBaselineNoFT" || $configuration{"variation"} eq "physicistsCorrectedBaselineNoFT")
	{
		my $nplanes_tcone = 3;
		my $Tube_LT = 400;  # length of original mount, different from $mountTotalLength

		
		# shield is a tapered pipe (G4 polycone)
		my @oradius_vbeam  = ( 24.0, 41.0,  41.0 );
		my @oradius_tcone  = ( 30.0, 90.0,  90.0 );
		
		my @iradius_tcone;
		for(my $i = 0; $i <$nplanes_tcone; $i++) {$iradius_tcone[$i] = $oradius_vbeam[$i] + $microgap;}

		if($configuration{"variation"} eq "physicistsCorrectedBaselineNoFT")
		{
			@iradius_tcone  = (        29.6,           29.6,         29.6 );
			@oradius_tcone  = (        33.0,           90.0,         90.0 );
		}
	
		my $pipeZstart    = 420.0;    # start of cone
		my $taperedLength = 1390.0;   # length of tapered part
		my $totalLength   = $TorusZpos - $SteelFrameLength - $Tube_LT - $microgap;   # total cone length
	
		my @z_plane_tcone  = ( $pipeZstart, $taperedLength, $totalLength );
		
		# Tungsten Cone
		my %detector = init_det();
		$detector{"name"}        = "tungstenConeNoFT";
		$detector{"mother"}      = "root";
		$detector{"description"} = "tungsten moller shield - no FT configuration";
		$detector{"color"}       = "ffff9b";
		$detector{"type"}        = "Polycone";
		my $dimen = "0.0*deg 360*deg $nplanes_tcone*counts";
		for(my $i = 0; $i <$nplanes_tcone; $i++) {$dimen = $dimen ." $iradius_tcone[$i]*mm";}
		for(my $i = 0; $i <$nplanes_tcone; $i++) {$dimen = $dimen ." $oradius_tcone[$i]*mm";}
		for(my $i = 0; $i <$nplanes_tcone; $i++) {$dimen = $dimen ." $z_plane_tcone[$i]*mm";}
		$detector{"dimensions"}  = $dimen;
		$detector{"material"}    = "beamline_W";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}

	
	if($configuration{"variation"} eq "physicistsBaselineWithFT")
	{
		my $nplanes_tcone = 4;
		
		# shield is a tapered pipe (G4 polycone)
		
		my @z_plane_tcone  = (  750.0, 1750.0, 1750.0, 1809.2);
		my @oradius_tcone  = (   32.0,   76.0,   59.0,   59.0);
		
		# to contain the vacuum pipe.
		# adding the microgap
		my @iradius_cone  = (   30.0,   30.0,   30.0,   30.0);
		my @iradius_tcone;
		for(my $i = 0; $i <$nplanes_tcone; $i++) {$iradius_tcone[$i] = $iradius_cone[$i] + $microgap;}
		
		# Tungsten Cone
		my %detector = init_det();
		$detector{"name"}        = "tungstenConeWithFT";
		$detector{"mother"}      = "root";
		$detector{"description"} = "tungsten moller shield with FT";
		$detector{"color"}       = "ffff9b";
		$detector{"type"}        = "Polycone";
		my $dimen = "0.0*deg 360*deg $nplanes_tcone*counts";
		for(my $i = 0; $i <$nplanes_tcone; $i++) {$dimen = $dimen ." $iradius_tcone[$i]*mm";}
		for(my $i = 0; $i <$nplanes_tcone; $i++) {$dimen = $dimen ." $oradius_tcone[$i]*mm";}
		for(my $i = 0; $i <$nplanes_tcone; $i++) {$dimen = $dimen ." $z_plane_tcone[$i]*mm";}
		$detector{"dimensions"}  = $dimen;
		$detector{"material"}    = "beamline_W";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}

	if($configuration{"variation"} eq "realityNoFT" || $configuration{"variation"} eq "realityWithFT" || $configuration{"variation"} eq "realityWithFTNotUsed" )
	{
		my $zConeStart           = 430.0;  # htcc starts at 384 with ID 60.96
		
		# Tungsten Cone
		my $totalShieldLength    = 1012;
		my $partialShieldLength  = 110.9;
		my $partialShieldLengthI = $totalShieldLength - $partialShieldLength;
		my $shieldIR1            = 59.5/2.0;
		my $shieldIR2            = 79.5/2.0;
		my $tgTheta              = $shieldIR2 / $totalShieldLength;
		my $shieldOR1            = 65.2/2.0;
		my $shieldOR3            = 180.9/2.0;
		my $shieldOR2            = $shieldOR3 - $partialShieldLength*$tgTheta;
		
		
		my $nplanes_tcone = 4;
		my @iradius_tcone  = ( $shieldIR1,            $shieldIR1,            $shieldIR2,         $shieldIR2 );
		my @oradius_tcone  = ( $shieldOR1,            $shieldOR2,            $shieldOR2,         $shieldOR3 );
		my @z_plane_tcone  = (          0, $partialShieldLengthI, $partialShieldLengthI, $totalShieldLength );

		my %detector = init_det();
		$detector{"name"}        = "tungstenConeNoFT";
		$detector{"mother"}      = "root";
		$detector{"description"} = "tungsten moller shield - no FT configuration";
		$detector{"color"}       = "bbbbbb";
		$detector{"pos"}         = "0*mm 0.0*mm $zConeStart*mm";
		$detector{"type"}        = "Polycone";
		my $dimen = "0.0*deg 360*deg $nplanes_tcone*counts";
		for(my $i = 0; $i <$nplanes_tcone; $i++) {$dimen = $dimen ." $iradius_tcone[$i]*mm";}
		for(my $i = 0; $i <$nplanes_tcone; $i++) {$dimen = $dimen ." $oradius_tcone[$i]*mm";}
		for(my $i = 0; $i <$nplanes_tcone; $i++) {$dimen = $dimen ." $z_plane_tcone[$i]*mm";}
		$detector{"dimensions"}  = $dimen;
		$detector{"material"}    = "beamline_W";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);

		
		
		# Shield after cone - LEAD
		my $coneTubeShieldLength = 801.8 / 2.0;
		if($configuration{"variation"} eq "realityWithFT" )
		{
			$coneTubeShieldLength = 333.0 / 2.0;
		}
		
		my $coneTubeIR           = 88.4/2;
		my $coneTubeOR           = 241.1/2;
		
		my $coneTubeZpos         = $zConeStart + $totalShieldLength + $coneTubeShieldLength;
		
		%detector = init_det();
		$detector{"name"}        = "leadShieldAfterCone";
		$detector{"mother"}      = "root";
		$detector{"description"} = "lead Tube after shield";
		$detector{"color"}       = "999999";
		$detector{"pos"}         = "0*mm 0.0*mm $coneTubeZpos*mm";
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$coneTubeIR*mm $coneTubeOR*mm $coneTubeShieldLength*mm 0.0*deg 360*deg";
		$detector{"material"}    = "G4_Pb";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
		
		
		# Stainless steel pipe supporting the cone
		my $nplanes_ssts = 8;
		my $sstsIR       = $shieldIR1;
		my $sstsOR1      = $shieldIR2  - $microgap ;
		my $sstsOR2      = $coneTubeIR - $microgap;
		my $sstsOR3      = 100.0;
		my $sstsOR4      = 40.0 - $microgap;
		my $sstsz2       = 108.0;
		my $sstsz3       = $sstsz2 + $coneTubeShieldLength*2;
		my $sstsz4       = $sstsz3 + 20;
		my $sstsz5       = $sstsz4 + 40;
		
		my $sstsPos         = $zConeStart + $totalShieldLength - $sstsz2;

		my @iradius_ssts  = ( $sstsIR,   $sstsIR,  $sstsIR,  $sstsIR,  $sstsIR,  $sstsIR,  $sstsIR,  $sstsIR );
		my @oradius_ssts  = ( $sstsOR1, $sstsOR1, $sstsOR2, $sstsOR2, $sstsOR3, $sstsOR3, $sstsOR4, $sstsOR4 );
		my @z_plane_ssts  = (        0,  $sstsz2,  $sstsz2,  $sstsz3,  $sstsz3,  $sstsz4,  $sstsz4,  $sstsz5 );
		
		%detector = init_det();
		$detector{"name"}        = "sstShieldSupport";
		$detector{"mother"}      = "root";
		$detector{"description"} = "Stainless Steel support for tungsten cone and shield";
		$detector{"pos"}         = "0*mm 0.0*mm $sstsPos*mm";
		$detector{"color"}       = "bbbbbb";
		$detector{"type"}        = "Polycone";
		$dimen = "0.0*deg 360*deg $nplanes_ssts*counts";
		for(my $i = 0; $i <$nplanes_ssts; $i++) {$dimen = $dimen ." $iradius_ssts[$i]*mm";}
		for(my $i = 0; $i <$nplanes_ssts; $i++) {$dimen = $dimen ." $oradius_ssts[$i]*mm";}
		for(my $i = 0; $i <$nplanes_ssts; $i++) {$dimen = $dimen ." $z_plane_ssts[$i]*mm";}
		$detector{"dimensions"}  = $dimen;
		$detector{"color"}       = "3333ff";
		$detector{"material"}    = "G4_STAINLESS-STEEL";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
	
	
}

















