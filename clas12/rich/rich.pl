#!/usr/bin/perl -w

use strict;
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
	print "   rich.pl <configuration filename>\n";
 	print "   Will create the CLAS12 Ring Imaging Cherenkov (rich) using the variation specified in the configuration file\n";
 	print "   Note: The passport and .visa files must be present to connect to MYSQL. \n\n";
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


# One can change the "variation" here if one is desired different from the config.dat
# $configuration{"variation"} = "myvar";

# To get the parameters proper authentication is needed.
our %parameters    = get_parameters(%configuration);

# Loading RICH specific subroutines
require "./geometry/box.pl";
require "./geometry/gap.pl";
require "./geometry/premirror.pl";
require "./geometry/radiator.pl";
require "./geometry/dummy_trap.pl";
require "./geometry/mapmt.pl";
require "./geometry/box_mirror.pl";
require "./geometry/mirrors.pl";
require "./geometry/cut.pl";

build_rich();

sub build_rich
{
	for(my $s=1; $s<=6; $s++)
	{
		build_rich_box($s);
		build_rich_gap($s);
		build_rich_premirror($s);
		build_rich_radiator($s);
		build_dummy_trap($s);
		build_mapmt($s);
		build_box_mirror($s);
		build_rich_mirror_a($s);
		build_rich_mirror_b($s);
		build_rich_mirror_c($s);
		build_rich_mirror($s);
		build_rich_cutbox($s);
		build_rich_cutgap($s);
		build_rich_cut($s);
	}
}
