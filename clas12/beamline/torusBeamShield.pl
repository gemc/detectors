use strict;
use warnings;

our %configuration;

our $TorusZpos;
our $SteelFrameLength;

my $torusZstart = $TorusZpos - $SteelFrameLength;

sub torusBeamShield()
{
	# original physicists design of the a beamline shielding
	# that starts inside the torus
	# common to all configurations
	
	
	my $microgap = 0.2;
	my $totalLength  = 4000.0;   # total beamline semi-length
	my $bpipeTorusZ  = $torusZstart + $totalLength ;  # z position - to place the pipe inside torus
	my $pipeIR       = 40 + $microgap;
	my $pipeOR       = 60 - $microgap;
	
	
	# Tungsten Cone
	my %detector = init_det();
	$detector{"name"}        = "tungstenTorusBeamShield";
	$detector{"mother"}      = "root";
	$detector{"description"} = "tungsten beampipe shield inside torus";
	$detector{"color"}       = "999999";
	$detector{"pos"}         = "0*mm 0.0*mm $bpipeTorusZ*mm";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$pipeIR*mm $pipeOR*mm $totalLength*mm 0.0*deg 360*deg";
	$detector{"material"}    = "beamline_W";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
}


