#!/usr/bin/perl -w

use strict;
use warnings;

our %configuration;
our %parameters;

my $inches = 2.54;

sub makeRadiator()
{
    
    my $radiatorIRInside = $parameters{"radiatorOR"}*$inches - $parameters{"copperPlugThickness"};
    my $radiatorORInside = $parameters{"radiatorOR"}*$inches;
    
    my @radiatorIR = ( 0                   , $radiatorIRInside                  , $radiatorIRInside);
    my @radiatorOR = ( $radiatorORInside   , $radiatorORInside                  , $radiatorORInside);
    my @radiatorZ  = ( 0                   , $parameters{"copperPlugThickness"} , 3*$inches );
    
    
    my $radNplanes = 3;
    my $dimen = "0.0*deg 360*deg $radNplanes*counts";
    
    for(my $i = 0; $i <$radNplanes ; $i++)
    {
	$dimen = $dimen ." $radiatorIR[$i]*cm";
    }
    for(my $i = 0; $i <$radNplanes ; $i++)
    {
	$dimen = $dimen ." $radiatorOR[$i]*cm";
    }
    for(my $i = 0; $i <$radNplanes ; $i++)
    {
	$dimen = $dimen ." $radiatorZ[$i]*cm";
    }
    
    
    my %detector = init_det();
    $detector{"name"}        = "radiator";
    $detector{"mother"}      = "root";
    $detector{"description"} = "Bubble Radiator";
    $detector{"color"}       = "aaaa44";
    $detector{"type"}        = "Polycone";
    $detector{"dimensions"}  = $dimen;
    $detector{"material"}    = "G4_Cu";
    $detector{"rotation"}    = "0*deg 180*deg 0*deg";
    $detector{"style"}       = 1;
    print_det(\%configuration, \%detector);

}
