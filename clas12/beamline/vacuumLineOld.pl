use strict;
use warnings;

our %configuration;

our $TorusZpos;
our $SteelFrameLength;
our $mountTotalLength;            # total length of the torus Mount

my $torusZstart = $TorusZpos - $SteelFrameLength;
my $torusZEnd   = $TorusZpos + $SteelFrameLength;

my $microgap = 0.1;

sub vacuumLine()
{
    # corrected physicists design vacuum line
    # straight aluminum pipe with vacucum inside
    
    # the beampipe is 0.125" (3mm) thick up to the torus downstream nose end, then 5mm thick
    
    my $nplanes = 6;
    my $tzs     = $torusZstart + $microgap;
    my $tze     = $torusZEnd   + 655;
    
    my @iradius_vbeam  =  ( 26.68, 26.68, 36.68, 36.68, 126,  126);
    my @oradius_vbeam  =  (  29.8,  29.8,  39.8,  39.8, 132,  132);
    if( $configuration{"variation"} eq "FTOn_mount_is_W" || $configuration{"variation"} eq "FTOff_mount_is_W")
    {
        @iradius_vbeam  =  ( 26.68, 26.68, 31.03, 31.03, 126,  126);
        @oradius_vbeam  =  (  29.8,  29.8,  34.15,  34.15, 132,  132);
    }
    my @z_plane_vbeam  =  ( 433.9,  $tzs, $tzs, $tze, $tze, 11000 );
    
    
    
    if( $configuration{"variation"} eq "realityWithFT" || $configuration{"variation"} eq "realityWithFTWithInnerShield" || $configuration{"variation"} eq "realityWithFTWithHeliumBag" )
    {
        @z_plane_vbeam  =  ( 750.0, $tzs, $tzs, $tze, $tze, 11000 );
    }
    if( $configuration{"variation"} eq "FTOnINFN" || $configuration{"variation"} eq "FTOn_mount_is_W") {
        @z_plane_vbeam  =  ( 850.0, $tzs, $tzs, $tze, $tze, 11000 );
    }
    if( $configuration{"variation"} eq "FTOn") {
        @z_plane_vbeam  =  ( 877.4, $tzs, $tzs, $tze, $tze, 11000 );
    }
    if( $configuration{"variation"} eq "FTOff") {
        @z_plane_vbeam  =  ( 458.2, $tzs, $tzs, $tze, $tze, 11000 );
    }
    if( $configuration{"variation"} eq "KPP") {
        @z_plane_vbeam  =  (-100.0, $tzs, $tzs, $tze, $tze, 11000 );
        @oradius_vbeam  =  ( 27.68,  27.68,  39.8,  39.8, 132,  132);
    }
    
    if( $configuration{"variation"} eq "realityWithFTNotUsedWithInnerShield" || $configuration{"variation"} eq "realityWithFTWithInnerShield")
    {
        @iradius_vbeam  =  ( 21.88, 21.88, 36.68, 36.68, 126,  126);
        @oradius_vbeam  =  ( 25.00, 25.00,  39.8,  39.8, 132,  132);
    }
    
    
    # aluminum pipe
    my %detector = init_det();
    $detector{"name"}        = "aluminumBeamPipe";
    $detector{"mother"}      = "root";
    $detector{"description"} = "aluminum beampipe";
    $detector{"color"}       = "aaffff";
    $detector{"type"}        = "Polycone";
    my $dimen = "0.0*deg 360*deg $nplanes*counts";
    for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." 0.0*mm";}
    for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $oradius_vbeam[$i]*mm";}
    for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $z_plane_vbeam[$i]*mm";}
    $detector{"dimensions"}  = $dimen;
    if($configuration{"variation"} eq "KPP") {
        $detector{"material"}    = "G4_STAINLESS-STEEL";
    }
    else {
        $detector{"material"}    = "G4_Al";
    }
    $detector{"style"}       = 1;
    print_det(\%configuration, \%detector);
    
    # vacuum pipe
    %detector = init_det();
    $detector{"name"}        = "vacuumBeamPipe";
    $detector{"mother"}      = "aluminumBeamPipe";
    $detector{"description"} = "vacuum inside aluminum beampipe";
    $detector{"color"}       = "000000";
    $detector{"type"}        = "Polycone";
    $dimen = "0.0*deg 360*deg $nplanes*counts";
    for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." 0.0*mm";}
    for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $iradius_vbeam[$i]*mm";}
    for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $z_plane_vbeam[$i]*mm";}
    $detector{"dimensions"}  = $dimen;
    $detector{"material"}    = "G4_Galactic";
    $detector{"style"}       = 1;
    print_det(\%configuration, \%detector);
    
    if( $configuration{"variation"} eq "KPP") {
        # carbon disk (Harp Wire)
        %detector = init_det();
        $detector{"name"}        = "CarbonHarpFoil";
        $detector{"mother"}      = "vacuumBeamPipe";
        $detector{"description"} = "Carbon Harp Foil";
        $detector{"color"}       = "cccccc";
        $detector{"type"}        = "Tube";
        $detector{"pos"}         = "0.0*mm 0.0*mm 0.0*mm";
        $detector{"dimensions"}  = "0*mm 10.*mm 0.13*mm 0*deg 360*deg";
        $detector{"material"}    = "G4_C";
        $detector{"style"}       = 1;
        print_det(\%configuration, \%detector);
    }
    
    
}

