use strict;
use warnings;

our %configuration;

# This places air beampipe between the target and the vacuum line

my $microgap = 0.1;
my $R = 15;

sub gapLine()
{
    
    my $zStart = 50 + $microgap;     # end of target
    my $zEnd   = 433.9 - $microgap;  # start of vacuum line
    
    if( $configuration{"variation"} eq "realityWithFT" || $configuration{"variation"} eq "realityWithFTWithInnerShield" || $configuration{"variation"} eq "realityWithFTWithHeliumBag" )
    {
        $zEnd = 750.0;
    }
    if( $configuration{"variation"} eq "FTOnINFN" || $configuration{"variation"} eq "FTOn_mount_is_W" )
    {
        $zEnd = 850.0;
    }
    if( $configuration{"variation"} eq "FTOff" )
    {
        $zEnd = 458.2;
    }
    if( $configuration{"variation"} eq "FTOn" )
    {
        $zEnd = 877.4;
    }
    my $length = ($zEnd - $zStart) / 2.0;
    my $zpos   = $zStart + $length;
    
    # air pipe
    my %detector = init_det();
    $detector{"name"}        = "airPipe";
    $detector{"mother"}      = "root";
    $detector{"description"} = "air line from target to vacuum line";
    $detector{"pos"}         = "0*mm 0.0*mm $zpos*mm";
    $detector{"color"}       = "eeeeff";
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "0*mm $R*mm $length*mm 0*deg 360*deg";
    $detector{"material"}    = "G4_AIR";
    if( $configuration{"variation"} eq "realityWithFTNotUsedHeliumBag" || $configuration{"variation"} eq "realityWithFTWithHeliumBag")
    {
        $detector{"material"}    = "G4_He";
        $detector{"name"}        = "heliumPipe";
    }
    
    $detector{"style"}       = 1;
    print_det(\%configuration, \%detector);
    
    
}

