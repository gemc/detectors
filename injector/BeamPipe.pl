#!/usr/bin/perl -w

use strict;
use warnings;

our %configuration;
our %parameters;

my $inches = 2.54;

sub makeBeamPipe()
{
    
    my $pipeIR = 1.37/2.0*$inches;
    
    my $ir1 = $pipeIR;

    my $or1 = 2.7/2.0*$inches;    
    my $or2 = 1.5/2.0*$inches;

    my $z1 = 0.44*$inches;
    my $z2 = 2.16*$inches;

    my @pipeIR = ( $ir1, $ir1, $ir1 , $ir1 );
    my @pipeOR = ( $or1, $or1, $or2 , $or2 );
    my @pipeZ  = ( 0   , $z1 , $z1  , $z2  );
        
    my $pipeZpos = -($parameters{"RadiatorLength"}*$inches + $z2); # From front of radiator
    
    my $radNplanes = 4;
    my $dimen = "0.0*deg 360*deg $radNplanes*counts";
    
    for(my $i = 0; $i <$radNplanes ; $i++)
    {
	$dimen = $dimen ." $pipeIR[$i]*cm";
    }
    for(my $i = 0; $i <$radNplanes ; $i++)
    {
	$dimen = $dimen ." $pipeOR[$i]*cm";
    }
    for(my $i = 0; $i <$radNplanes ; $i++)
    {
	$dimen = $dimen ." $ pipeZ[$i]*cm";
    }
    
    my %detector = init_det();
    $detector{"name"}        = "beampipe";
    $detector{"mother"}      = "root";
    $detector{"description"} = "Beam Pipe";
    $detector{"color"}       = "aabbcc";
    $detector{"type"}        = "Polycone";
    $detector{"dimensions"}  = $dimen;
    $detector{"material"}    = "G4_STAINLESS-STEEL";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"pos"}         = "0*cm 0*cm $pipeZpos*cm";
    $detector{"style"}       = 1;
    print_det(\%configuration, \%detector);

}
