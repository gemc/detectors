use strict;
use warnings;

our %configuration;

our $TorusZpos;
our $SteelFrameLength;
our $tungstenColor;

my $torusZstart = $TorusZpos - $SteelFrameLength;

sub torusBeamShield()
{
	# original physicists design of the a beamline shielding
	# that starts inside the torus
	# common to all configurations
	
	
	my $microgap = 0.2;
	my $totalLength  = $SteelFrameLength;   # total beamline semi-length
	my $bpipeTorusZ  = $torusZstart + $totalLength ;  # z position - to place the pipe inside torus
	my $pipeIR       = 40 + $microgap;
	my $pipeOR       = 60 - $microgap;
	
	
	# Tungsten Cone
	my %detector = init_det();
	$detector{"name"}        = "tungstenTorusBeamShield";
	$detector{"mother"}      = "root";
	$detector{"description"} = "tungsten beampipe shield inside torus";
	$detector{"color"}       = $tungstenColor;
	$detector{"pos"}         = "0*mm 0.0*mm $bpipeTorusZ*mm";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$pipeIR*mm $pipeOR*mm $totalLength*mm 0.0*deg 360*deg";
	$detector{"material"}    = "beamline_W";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
}

sub SSlayer_out_torusBeamShield()
{
	# original physicists design of the a beamline shielding
	# that starts inside the torus
	# common to all configurations
	
	
	my $microgap = 0.2;
	my $totalLength  = $SteelFrameLength;   # total beamline semi-length
	my $bpipeTorusZ  = $torusZstart + $totalLength ;  # z position - to place the pipe inside torus
	my $pipeIR       = 57.15;
	my $pipeOR       = 60.325;
	
	
	# Tungsten Cone
	my %detector = init_det();
	$detector{"name"}        = "SSlayer_out_tungstenTorusBeamShield";
	$detector{"mother"}      = "root";
	$detector{"description"} = "tungsten beampipe shield inside torus";
	$detector{"color"}       = "3333ff";
	$detector{"pos"}         = "0*mm 0.0*mm $bpipeTorusZ*mm";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$pipeIR*mm $pipeOR*mm $totalLength*mm 0.0*deg 360*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
}

sub Wlayer_mid_torusBeamShield()
{
	# original physicists design of the a beamline shielding
	# that starts inside the torus
	# common to all configurations
	
	
	my $microgap = 0.2;
	my $totalLength  = $SteelFrameLength;   # total beamline semi-length
	my $bpipeTorusZ  = $torusZstart + $totalLength ;  # z position - to place the pipe inside torus
	my $pipeIR       = 37.55;
	my $pipeOR       = 57.15;
	
	
	# Tungsten Cone
	my %detector = init_det();
	$detector{"name"}        = "Wlayer_mid_tungstenTorusBeamShield";
	$detector{"mother"}      = "root";
	$detector{"description"} = "tungsten beampipe shield inside torus";
	$detector{"color"}       = $tungstenColor;
	$detector{"pos"}         = "0*mm 0.0*mm $bpipeTorusZ*mm";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$pipeIR*mm $pipeOR*mm $totalLength*mm 0.0*deg 360*deg";
	$detector{"material"}    = "beamline_W";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
}

sub SSlayer_in_torusBeamShield()
{
	# original physicists design of the a beamline shielding
	# that starts inside the torus
	# common to all configurations
	
	
	my $microgap = 0.2;
	my $totalLength  = $SteelFrameLength;   # total beamline semi-length
	my $bpipeTorusZ  = $torusZstart + $totalLength ;  # z position - to place the pipe inside torus
	my $pipeIR       = 34.55;
	my $pipeOR       = 37.55;
	
	
	# Tungsten Cone
	my %detector = init_det();
	$detector{"name"}        = "SSlayer_in_tungstenTorusBeamShield";
	$detector{"mother"}      = "root";
	$detector{"description"} = "tungsten beampipe shield inside torus";
	$detector{"color"}       = "3333ff";
	$detector{"pos"}         = "0*mm 0.0*mm $bpipeTorusZ*mm";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$pipeIR*mm $pipeOR*mm $totalLength*mm 0.0*deg 360*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
}
