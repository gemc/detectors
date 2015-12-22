#!/usr/bin/perl -w

use strict;
use warnings;

our %configuration;
our %parameters;

my $inches = 2.54;

sub makeRadiator()
{

    my $radLength = $parameters{"RadiatorLength"}*$inches;
    
    my $radiatorIRInside = $parameters{"radiatorOR"}*$inches - $parameters{"copperPlugThickness"};
    my $radiatorORInside = $parameters{"radiatorOR"}*$inches;
    
    my @radiatorIR = ( $radiatorIRInside   , $radiatorIRInside                               , 0                                              , 0                 );
    my @radiatorOR = ( $radiatorORInside   , $radiatorORInside                               , $radiatorORInside                               , $radiatorORInside);
    my @radiatorZ  = ( 0                   , $radLength - $parameters{"copperPlugThickness"} , $radLength - $parameters{"copperPlugThickness"} , $radLength       ); # Radiator front is zero Z
    
    my $radNplanes = 4;
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
    my $zpos = -$radLength;
    
    $detector{"name"}        = "radiator";
    $detector{"mother"}      = "root";
    $detector{"description"} = "Bubble Radiator";
    $detector{"pos"}         = "0*cm 0*cm $zpos*cm";
    $detector{"color"}       = "aaaa44";
    $detector{"type"}        = "Polycone";
    $detector{"dimensions"}  = $dimen;
    $detector{"material"}    = "G4_Cu";
    $detector{"style"}       = 1;
    print_det(\%configuration, \%detector);
    
    %detector = init_det();
    $detector{"name"}        = "radiatorVacuum";
    $detector{"mother"}      = "root";
    $detector{"description"} = "Bubble Radiator Vacuum";
    $detector{"color"}       = "ffffff3";
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "0*cm  $radiatorIRInside*cm 1.5*inches 0*deg 360*deg";
    $detector{"material"}    = "G4_Galactic";
    
    $zpos = -1.5*$inches - $parameters{"copperPlugThickness"};

    $detector{"pos"}         = "0*cm 0*cm $zpos*cm";
    $detector{"style"}       = 1;
    print_det(\%configuration, \%detector);
    
    # flux to record particles coming out of radiator
    %detector = init_det();
    $detector{"name"}        = "radiatorFlux";
    $detector{"mother"}      = "root";
    $detector{"description"} = "Bubble Radiator Flux";
    $detector{"color"}       = "ff0000";
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "0*cm  10*cm 0.1*mm 0*deg 360*deg";
    $detector{"material"}    = "G4_AIR";
    $detector{"pos"}         = "0*cm 0*cm 0.2*mm";
    $detector{"visible"}     = 0; # 1
    $detector{"sensitivity"} = "bubble";
    $detector{"hit_type"}    = "bubble";
    $detector{"identifiers"} = "detId manual 1";
    
    print_det(\%configuration, \%detector);	
	
}
