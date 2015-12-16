#!/usr/bin/perl -w

use strict;
#use lib ("$ENV{GEMC}/api/perl");
use lib ("$ENV{GEMC}/io");
use utils;
use parameters;
use geometry;
use math;

use Math::Trig;

# Help Message
sub help()
{
    print "\n Usage: \n";
    print "   geometry.pl <configuration filename>\n";
    print "   Will create the bubble chamber geometry using the variation specified in the configuration file\n";
    exit;
}

# Make sure the argument list is correct
# If not pring the help
if( scalar @ARGV != 1)
{
    help();
    exit;
}

# Loading configuration file from argument
our %configuration = load_configuration($ARGV[0]);

# One can change the "variation" here if one is desired different from the config.dat
# $configuration{"variation"} = "myvar";

# To get the parameters proper authentication is needed.
our %parameters    = get_parameters(%configuration);

require "./BeamPipe.pl";
require "./Radiator.pl";
require "./Collimator.pl";
require "./GammaPort.pl";
require "./GammaBeamWindow.pl";
require "./BubbleChamberCell.pl";
require "./PhotonDump.pl";

makeBeamPipe();
makeRadiator();
makeCollimator();
makeGammaPort();
makeGammaBeamWindow();
makeBubbleChamberCell();
makePhotonDump();

