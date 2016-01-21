use strict;
use warnings;

our %configuration;

our $TorusZpos;
our $SteelFrameLength;
our $mountTotalLength;            # total length of the torus Mount
our $tungstenColor;

my $torusZstart = $TorusZpos - $SteelFrameLength;


sub torusFrontMount()
{
	
	my $microgap = 0.1;
	
	# engineering design of the mounts to connect
	# both FT and noFT configurations to the torus
	# One nose plate connects to the torus
	# The second nose connects to the upstream beamline
	# and goes inside the first nose
	
	my $nplanes = 4;
	
	# These measurements come from STP file
	my $noseShieldIR       = 30.0;
	my $noseShieldOR       = 49.0;
	my $noseShieldLength   = $mountTotalLength/2.;  # empirical
	my $noseShield_z_start = $torusZstart - $noseShieldLength;
	
	my @iradius_nose1  = (  50.0,  50.0,  50.0,  50.0 );
	my @oradius_nose1  = ( 100.0, 100.0,  63.5,  63.5 );
	my @nose1_z        = (   0.0,  25.0,  25.0, 433.0 );
	
	my @iradius_nose2  = (  76.1,  76.1,  76.1,  76.1 );
	my @oradius_nose2  = (  88.8,  88.8, 126.9, 126.9 );
	my @nose2_z        = (   0.0, 382.3, 382.3, 395.0 );
	
	
	#		my $nose1_nose2_gap = 95.4;
	my $nose1_z_start   = $torusZstart - $mountTotalLength;
	my $nose2_z_start   = $torusZstart - $nose2_z[3] - $microgap;
	
	
	
	# First mount, to torus
	my %detector = init_det();
	$detector{"name"}        = "mountToTorus";
	$detector{"mother"}      = "root";
	$detector{"pos"}         = "0*mm 0.0*mm $nose2_z_start*mm";
	$detector{"description"} = "mount to torus";
	$detector{"color"}       = "55ff55";
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
	$detector{"color"}       = "ffff55";
	$detector{"type"}        = "Polycone";
	$dimen = "0.0*deg 360*deg $nplanes*counts";
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $iradius_nose1[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $oradius_nose1[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $nose1_z[$i]*mm";}
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
	
	# inner shield made of tungsten
	%detector = init_det();
	$detector{"name"}        = "mountInnerShielding";
	$detector{"mother"}      = "root";
	$detector{"pos"}         = "0*mm 0.0*mm $noseShield_z_start*mm";
	$detector{"description"} = "beamline mount to torus beamline shield";
	$detector{"color"}       = $tungstenColor;
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$noseShieldIR*mm $noseShieldOR*mm $noseShieldLength*mm 0.*deg 360.*deg";
	$detector{"material"}    = "beamline_W";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
}


