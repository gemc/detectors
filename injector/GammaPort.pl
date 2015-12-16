#!/usr/bin/perl -w

use strict;
use warnings;

our %configuration;
our %parameters;

my $inches = 2.54;

sub makeGammaPort()
{
    my $gPortIR = 0.800/2.0*$inches;
    
    my $ir1 = $gPortIR;
    
    my $or1 = 10.0/2.0*$inches;    
    my $or2 =  5.4/2.0*$inches;
    
    my $z1 = 1.0*$inches;
    my $z2 = 3.0*$inches;
    
    my @gPortIR = ( $ir1, $ir1, $ir1 , $ir1 );
    my @gPortOR = ( $or1, $or1, $or2 , $or2 );
    my @gPortZ  = ( 0   , $z1 , $z1  , $z2  );
    
    my $gPortZpos = 19.75; # From front of radiator
    
    my $radNplanes = 4;
    my $dimen = "0.0*deg 360*deg $radNplanes*counts";
    
    for(my $i = 0; $i <$radNplanes ; $i++)
    {
	$dimen = $dimen ." $gPortIR[$i]*cm";
    }
    for(my $i = 0; $i <$radNplanes ; $i++)
    {
	$dimen = $dimen ." $gPortOR[$i]*cm";
    }
    for(my $i = 0; $i <$radNplanes ; $i++)
    {
	$dimen = $dimen ." $gPortZ[$i]*cm";
    }
    
    my %detector = init_det();
    $detector{"name"}        = "gammaPort";
    $detector{"mother"}      = "root";
    $detector{"description"} = "Gamma Port";
    $detector{"color"}       = "ccbbdd";
    $detector{"type"}        = "Polycone";
    $detector{"dimensions"}  = $dimen;
    $detector{"material"}    = "G4_STAINLESS-STEEL";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"pos"}         = "0*cm 0*cm $gPortZpos*cm";
    $detector{"style"}       = 1;
    print_det(\%configuration, \%detector);

}
