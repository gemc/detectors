#!/usr/bin/perl -w

use strict;
use warnings;

our %configuration;
our %parameters;

my $inches = 2.54;

sub makeGammaBeamWindow()
{
    
    my $CollEndGap = 0.125*$inches;
    
    my $CollIR       = 0.420/2.0*$inches;
    my $CollOR       = 0.750/2.0*$inches;
    my $CollFlangeOR = 2.50 /2.0*$inches;
    my $CollFlangeTapOR = (2.50 /2.0 - 0.44)*$inches;
    my $CollEndGapOR = 0.500/2.9*$inches;

    my $ir1 = $CollIR;
    
    my $or1 = $CollOR;
    my $or2 = $CollFlangeOR;
    my $or3 = $CollFlangeTapOR;
    my $or4 = $CollEndGapOR;

    my $z1 = 1.00*$inches;
    my $z2 = 1.50*$inches;
    my $z3 = 1.50*$inches + $CollFlangeTapOR - $CollOR;
    my $z4 = 4.00*$inches;
    my $z5 = 4.125*$inches;
    
    my @GammaWindowIR = ( $ir1, $ir1, $ir1 , $ir1 , $ir1,  $ir1 , $ir1 , $ir1 , 0    );
    my @GammaWindowOR = ( $or1, $or1, $or2 , $or2 , $or3,  $or1 , $or1 , $or1 , $or4 );
    my @GammaWindowZ  = ( 0   , $z1 , $z1  , $z2  , $z2 ,  $z3  , $z4  , $z4  , $z5  );
    
    my $CollZpos = 25.0; # From front of radiator
    
    my $radNplanes = 9;
    my $dimen = "0.0*deg 360*deg $radNplanes*counts";
    
    for(my $i = 0; $i <$radNplanes ; $i++)
    {
	$dimen = $dimen ." $GammaWindowIR[$i]*cm";
    }
    for(my $i = 0; $i <$radNplanes ; $i++)
    {
	$dimen = $dimen ." $GammaWindowOR[$i]*cm";
    }
    for(my $i = 0; $i <$radNplanes ; $i++)
    {
	$dimen = $dimen ." $GammaWindowZ[$i]*cm";
    }
    
    my %detector = init_det();
    $detector{"name"}        = "gammaBeamWindow";
    $detector{"mother"}      = "root";
    $detector{"description"} = "Gamma Beam Window";
    $detector{"color"}       = "ffdd33";
    $detector{"type"}        = "Polycone";
    $detector{"dimensions"}  = $dimen;
    $detector{"material"}    = "G4_Cu";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"pos"}         = "0*cm 0*cm $CollZpos*cm";
    $detector{"style"}       = 1;
    print_det(\%configuration, \%detector);

}
