#!/usr/bin/perl -w

use strict;
use warnings;

our %configuration;
our %parameters;


my $blength = $parameters{"beamPipeLength"};
my $brmin   = $parameters{"beamPipeRmin"};
my $brmax   = $parameters{"beamPipeRmax"};

# still need to define pipe position in respect to center

sub makeBeamline()
{

	my %detector = init_det();
	$detector{"name"}        = "beamPipeVol";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Bubble Beam Pipe";
	$detector{"color"}       = "003399";
	$detector{"pos"}         = "0*cm 0*cm ";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$brmin*cm $brmax*cm $blength*cm 0*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);



}
