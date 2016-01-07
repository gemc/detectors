use strict;
use warnings;

our %configuration;

our $TorusZpos;
our $SteelFrameLength;

my $torusZstart = $TorusZpos - $SteelFrameLength;


sub torusFrontMount()
{
	
	if($configuration{"variation"} eq "physicistsBaselineNoFT" || $configuration{"variation"} eq "physicistsBaselineWithFT")
	{

		my $microgap = 0.2;

		my $flange_TN       =  15.0;
		my $Tube_LT         = 365.6;

		my $TTube_OR         =  60.0;
		my $FTube_OR         =  80.0;
		my $FTube_FR         =  90.0;

		my $Tube_end  = $torusZstart - $microgap;
		my $Tube_z1   = $Tube_end - $flange_TN;
		my $Tube_z2   = $Tube_z1 - $Tube_LT;
		my $Tube_beg  = $Tube_z2 - $flange_TN;
		my $Tube_Z    =($Tube_end+$Tube_beg)/2.;
		my $Tube_LZ   =($Tube_end-$Tube_beg)/2.;
		
		my $nplanes_Tube = 6;
		my @z_plane_Tube = ( $Tube_beg,  $Tube_z2,  $Tube_z2,  $Tube_z1,  $Tube_z1, $Tube_end);
		my @oradius_Tube = ( $FTube_FR, $FTube_FR, $FTube_OR, $FTube_OR, $FTube_FR, $FTube_FR);

		my $iradiusBeamPipe = 41.0 + $microgap;
		
		# Stainless Steel Tube with Flanges
		my %detector = init_det();
		$detector{"name"}        = "moller_shield_mount";
		$detector{"mother"}      = "root";
		$detector{"description"} = "flanged tube from moller cone to torus";
		$detector{"color"}       = "ff8883";
		$detector{"type"}        = "Polycone";
		my $dimen = "0.0*deg 360*deg $nplanes_Tube*counts";
		for(my $i = 0; $i <$nplanes_Tube; $i++) {$dimen = $dimen ." $iradiusBeamPipe*mm";}
		for(my $i = 0; $i <$nplanes_Tube; $i++) {$dimen = $dimen ." $oradius_Tube[$i]*mm";}
		for(my $i = 0; $i <$nplanes_Tube; $i++) {$dimen = $dimen ." $z_plane_Tube[$i]*mm";}
		$detector{"dimensions"}  = $dimen;
		$detector{"material"}    = "G4_STAINLESS-STEEL";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
		
		# Tungsten Tube
		%detector = init_det();
		$detector{"name"}        = "moller_shield_mountShield";
		$detector{"mother"}      = "moller_shield_mount";
		$detector{"description"} = "tungsten tube from moller cone to torus";
		$detector{"color"}       = "ffff9b";
		$detector{"type"}        = "Tube";
		$detector{"pos"}         = "0.0*cm 0.0*cm $Tube_Z*mm";
		$detector{"dimensions"}  = "$iradiusBeamPipe*mm $TTube_OR*mm $Tube_LZ*mm 0.*deg 360.*deg";
		$detector{"material"}    = "beamline_W";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
	
	if($configuration{"variation"} eq "realityNoFT" || $configuration{"variation"} eq "realityWithFT")
	{
		
		
		# engineering design of the mounts to connect
		# both FT and noFT configurations to the torus
		# One nose plate connects to the torus
		# The second nose connects to the upstream beamline
		# and goes inside the first nose
		
		my $nplanes = 4;
		
		# These measurements come from STP file
		my @iradius_nose1  = (  55.8,  55.8,  55.8,  55.8 );
		my @oradius_nose1  = ( 100.0, 100.0,  63.5,  63.5 );
		my @nose1_z        = (   0.0,  25.0,  25.0, 433.0 );
		
		my @iradius_nose2  = (  76.1,  76.1,  76.1,  76.1 );
		my @oradius_nose2  = (  88.8,  88.8, 126.9, 126.9 );
		my @nose2_z        = (   0.0, 382.3, 382.3, 395.0 );
		
		
		my $nose1_nose2_gap = 95.4;
		my $nose2_z_start   = $torusZstart - $nose2_z[3];
		my $nose1_z_start   = $nose2_z_start - $nose1_nose2_gap;
		
		
		# First mount, to torus
		my %detector = init_det();
		$detector{"name"}        = "mountToTorus";
		$detector{"mother"}      = "root";
		$detector{"pos"}         = "0*mm 0.0*mm $nose2_z_start*mm";
		$detector{"description"} = "mount to torus";
		$detector{"color"}       = "55aabb";
		$detector{"type"}        = "Polycone";
		my $dimen = "0.0*deg 360*deg $nplanes*counts";
		for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $iradius_nose2[$i]*mm";}
		for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $oradius_nose2[$i]*mm";}
		for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $nose2_z[$i]*mm";}
		$detector{"dimensions"}  = $dimen;
		$detector{"material"}    = "G4_STAINLESS-STEEL";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
		
		
		# second mount, to first mount
		%detector = init_det();
		$detector{"name"}        = "mountToMount";
		$detector{"mother"}      = "root";
		$detector{"pos"}         = "0*mm 0.0*mm $nose1_z_start*mm";
		$detector{"description"} = "beamline mount to torus mount";
		$detector{"color"}       = "aaaaaa";
		$detector{"type"}        = "Polycone";
		$dimen = "0.0*deg 360*deg $nplanes*counts";
		for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $iradius_nose1[$i]*mm";}
		for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $oradius_nose1[$i]*mm";}
		for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $nose1_z[$i]*mm";}
		$detector{"dimensions"}  = $dimen;
		$detector{"material"}    = "G4_STAINLESS-STEEL";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
	
	
	
}


