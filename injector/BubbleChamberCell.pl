#!/usr/bin/perl -w

use strict;
use warnings;

our %configuration;
our %parameters;

my $inches = 2.54;

sub makeBubbleChamberCell()
{
    
    my $glassCellBaseLength = 1;
    my $glassCellNeckLength = 1;
    my $glassCellLength     = 5;
    
    my $glassThickness     = 0.1;
    
    my $glassCellBaseIR = 0.5;
    my $glassCellIR     = 1.5;
    
    my $ir1 = $glassCellBaseIR;
    my $ir2 = $glassCellBaseIR;
    my $ir3 = $glassCellIR;
    
    my $or1 = $ir1 + $glassThickness;
    my $or2 = $ir2 + $glassThickness;
    my $or3 = $ir3 + $glassThickness;
    
    my $z1 = $glassCellBaseLength;
    my $z2 = $glassCellBaseLength + $glassCellNeckLength;
    my $z3 = $glassCellBaseLength + $glassCellNeckLength + $glassCellLength;
    
    
    
    
    my @glassCellIR = ( $ir1, $ir2  , $ir3   , $ir3   , 0                    );
    my @glassCellOR = ( $or1, $or2  , $or3   , $or3   , $or3                 );
    my @glassCellZ  = ( 0   , $z1   , $z2,   , $z3    , $z3 + $glassThickness);
    
    
    my $glassCellZpos = 42.0; # From center of radiator
    
    
    my $radNplanes = 5;
    my $dimen = "0.0*deg 360*deg $radNplanes*counts";
    
    for(my $i = 0; $i <$radNplanes ; $i++)
    {
	$dimen = $dimen ." $glassCellIR[$i]*cm";
    }
    for(my $i = 0; $i <$radNplanes ; $i++)
    {
	$dimen = $dimen ." $glassCellOR[$i]*cm";
    }
    for(my $i = 0; $i <$radNplanes ; $i++)
    {
	$dimen = $dimen ." $glassCellZ[$i]*cm";
    }
    
    my $yshift = $glassCellLength / 2 + $glassCellNeckLength + $glassCellNeckLength;
    
    my %detector = init_det();
    $detector{"name"}        = "glassCell";
    $detector{"mother"}      = "root";
    $detector{"description"} = "Bubble Chamber";
    $detector{"color"}       = "aaaaaa4";
    $detector{"type"}        = "Polycone";
    $detector{"dimensions"}  = $dimen;
    $detector{"material"}    = "G4_GLASS_PLATE";
    $detector{"rotation"}    = "-90*deg 0*deg 0*deg";
    $detector{"pos"}         = "0*cm $yshift*cm $glassCellZpos*cm";
    $detector{"style"}       = 1;
    print_det(\%configuration, \%detector);

}
