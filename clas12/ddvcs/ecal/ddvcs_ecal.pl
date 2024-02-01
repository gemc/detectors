#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use math;
use materials;
use bank;
use hit;

use Math::Trig;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   geometry.pl <configuration filename>\n";
 	print "   Will create the DDVS setup using the variation specified in the configuration file\n";
 	print "   Note: The passport and .visa files must be present to connect to MYSQL. \n\n";
	exit;
}

# Make sure the argument list is correct
# If not pring the help
if( scalar @ARGV != 1)
{
	help();
	exit;
}

our $pi    = 3.141592653589793238;
our $toRad = $pi/180.0;


# Loading configuration file from argument
our %configuration = load_configuration($ARGV[0]);

# materials
require "./materials.pl";


# materials
materials();

buildEcal_motherVolume();

sub buildEcal_motherVolume
{
 
    my $nplanes = 4;
    my @ecal_iradius = (301, 77.1, 85.7, 101 );
    my @ecal_oradius = (301.1, 360.6, 401, 101.1 );
    my @ecal_zpos_root = (520, 625, 696, 836);

    
    my $dimen = "0.0*deg 360*deg $nplanes*counts";
    
    for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $ecal_iradius[$i]*mm";}
    for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $ecal_oradius[$i]*mm";}
    for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $ecal_zpos_root[$i]*mm";}
    
    
    my %detector = init_det();
    $detector{"name"}        = "ddvcs_ecal";
    $detector{"mother"}      = "root";
    $detector{"description"} = "volume containing PbWO4";
    $detector{"color"}       = "e30e0e";
    $detector{"type"}        = "Polycone";
    $detector{"dimensions"}  = $dimen;
    my $X=0.;
    my $Y=0.;
    my $Z=0.;
    $detector{"pos"}         = "$X*mm $Y*mm $Z*mm ";
    $detector{"material"}    = "G4_PbWO4";
    $detector{"style"}       = "1";
   print_det(\%configuration, \%detector);

    
}







