#!/usr/bin/perl -w


use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use math;
use materials;

use Math::Trig;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   beamline.pl <configuration filename>\n";
 	print "   Will create the CLAS12 beamline and materials\n";
 	print "   Note: The passport and .visa files must be present if connecting to MYSQL. \n\n";
	exit;
}

# Make sure the argument list is correct
if( scalar @ARGV != 1)
{
	help();
	exit;
}

# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);


# Global pars - these should be read by the load_parameters from file or DB

# General:
our $inches = 25.4;

# Torus
our $TorusZpos            = 3947.6;           # center of the torus position (include its semilengt). Value from M. Zarecky, R. Miller PDF file on 1/13/16
our $SteelFrameLength     = 94.*$inches/2.0;  # 1/2 length of torus
our $torusFrontNoseLength = 365.6;            # nose

# materials
require "./materials.pl";


# vacuum line throughout the shields, torus and downstream
require "./vacuumLine.pl";

# moeller shield
require "./tungstenCone.pl";

# connection of moeller shield / FT to torus
require "./torusFrontMount.pl";

# shielding around the torus beamline
require "./torusBeamShield.pl";

# shielding downstream of the torus
require "./afterTorusShielding.pl";

# shielding blocks on the torus
# require "./torusShielding.pl";


# all the scripts must be run for every configuration
my @allConfs = ("physicistsBaselineNoFT", "physicistsBaselineWithFT", "physicistsCorrectedBaselineNoFT", "realityNoFT", "realityWithFT");

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;
	
	# materials
	materials();
	
	# vacuum line throughout the shields, torus and downstream
	vacuumLine();
	
	# moeller shield
	tungstenCone();
	
	# connection of moeller shield / FT to torus
	torusFrontMount();
	
	# shielding around the torus beamline
	torusBeamShield();

	# shielding blocks 
	# torusShield();

	# shielding downstream of the torus
	# parameters: length of first part, length of second part, outer radius (mm), material
	afterTorusShielding(350.0, 300.0, 195.4, "beamline_W");
}













# OLD STUFF

#require "./downstream.pl";
#require "./noft_moller_shield.pl";
#require "./ft_moller_shield.pl";
#require "./tagger.pl";

# these are nominal values
#$configuration{"variation"} = "noft" ;
#make_moller_shield();
#make_downstream_shielding(300.0,170.0, "beamline_W");
#make_beamline_torus();

#$configuration{"variation"} = "ft" ;
#make_tagger();

# 10" depth, extra thick
#$configuration{"variation"} = "noft-l254-r195.4";
#make_moller_shield();
#make_beamline_torus();
#make_downstream_shielding(254.0,195.4, "beamline_W");

# without nose
#$configuration{"variation"} = "baseline";
#make_moller_shield();
#make_beamline_torus();
#make_orig();




