#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use math;

use Math::Trig;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   micromegas.pl <configuration filename>\n";
 	print "   Will create the micromegas using the variation specified in the configuration file\n";
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

# To get the parameters proper authentication is needed.
our %parameters    = get_parameters(%configuration);

# Loading micromegas specific subroutines
require "./hit.pl";
require "./bank.pl";
require "./materials.pl";
#require "./FMT.pl";
#define_fmt();

require "./BMT.pl";
define_bmt();
#require "./FTM.pl";
#define_ftm();

define_micromegas_hits();
define_micromegas_banks();
print_materials();
