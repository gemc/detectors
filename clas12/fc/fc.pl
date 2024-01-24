#!/usr/bin/perl -w

use strict;
use warnings;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use hit;
use bank;
use materials;
use Math::Trig;

# Help Message
sub help() {
    print "\n Usage: \n";
    print "   fc.pl <configuration filename>\n";
    print "   Will create the CLAS12 forward carriage envelope that contains the various detectors\n";
    exit;
}

# Make sure the argument list is correct
if (scalar @ARGV != 1) {
    help();
    exit;
}

# Loading configuration file
our %configuration = load_configuration($ARGV[0]);

my $microgap = 0.1;
my $torusZstart = 2754.17 - $microgap; # from drawings
my $fcend = 9500;
my $fcMaxRadius = 5000;
my $nplanes_Cone = 6;

# Notice:
# The FC coordinates are the same as CLAS12 target center
my @z_plane_Cone = (1206.0, 1556.0, 2406.0, $torusZstart, $torusZstart, $fcend);
my @iradius_Cone = (2575.0, 2000.0, 132.0, 132.0, 0, 0);
my @oradius_Cone = (2575.0, $fcMaxRadius, $fcMaxRadius, $fcMaxRadius, $fcMaxRadius, $fcMaxRadius);

sub build_fc {
    my $variation = shift;
    my $runNumber = shift;
    my %detector = init_det();

    $detector{"name"} = "fc";
    $detector{"mother"} = "root";
    $detector{"description"} = "Forward Carriage (FC) detector envelope to hold the torus magnet and the FC detectors";
    $detector{"pos"} = "0*mm 0.0*mm 0*mm";
    $detector{"rotation"} = "0*deg 0*deg 0*deg";
    $detector{"color"} = "88aa88";
    $detector{"type"} = "Polycone";
    $detector{"material"} = "G4_AIR";
    $detector{"visible"} = 0;
    $detector{"style"} = 0;

    my $dimen = "0.0*deg 360*deg $nplanes_Cone*counts";
    for (my $i = 0; $i < $nplanes_Cone; $i++) {$dimen = $dimen . " $iradius_Cone[$i]*mm";}
    for (my $i = 0; $i < $nplanes_Cone; $i++) {$dimen = $dimen . " $oradius_Cone[$i]*mm";}
    for (my $i = 0; $i < $nplanes_Cone; $i++) {$dimen = $dimen . " $z_plane_Cone[$i]*mm";}
    $detector{"dimensions"} = $dimen;

    if ($variation eq "TorusSymmetric") {
        $detector{"mfield"} = "TorusSymmetric";
    }
    else {
        $detector{"mfield"} = "no";
    }
    print_det(\%configuration, \%detector);

}


# TEXT Factory
my @variations = ("default", "TorusSymmetric");
my @factories = ("TEXT", "SQLITE");
my $runNumber = 11;

foreach my $variation (@variations) {
    foreach my $factory (@factories) {
        $configuration{"variation"} = $variation;
        $configuration{"factory"} = $factory;
        build_fc($variation, $runNumber);
    }
}
















