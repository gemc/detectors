#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use hit;
use bank;
use mirrors;
use math;
use materials;
use POSIX;

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

# geometry                                                                                                                                                                    
require "./geometry.pl";


my $javaCadDir = "cad_sector4";
my $sector = 4;
system(join(' ', 'groovy -cp "$COATJAVA/lib/clas/coat-libs-9.0.0-SNAPSHOT.jar" factory.groovy', $javaCadDir, $sector));
our @volumes = get_volumes(%configuration);
coatjava::makeRICHcad($javaCadDir,$sector);


$javaCadDir = "cad_sector1";
$sector = 1;
system(join(' ', 'groovy -cp "$COATJAVA/lib/clas/coat-libs-9.0.0-SNAPSHOT.jar" factory.groovy', $javaCadDir, $sector));
coatjava::makeRICHcad($javaCadDir,$sector);

# materials
require "./materials.pl";

# banks definitions
require "./bank.pl";

# hits definitions
require "./hit.pl";

#mirror material
require "./mirrors.pl";

# all the scripts must be run for every configuration
my @allConfs = ("sector4","sector4and1");

# bank definitions
#define_bank();

$configuration{"variation"} = "sector4";

define_aerogels("4");
define_MAPMT();
define_CFRP();
define_hit();
buildMirrorsSurfaces("4");
coatjava::makeRICHtext("4");

$configuration{"variation"} = "sector4and1";
define_aerogels("4");
define_aerogels("1");
define_MAPMT();
define_CFRP();
define_hit();
buildMirrorsSurfaces("4");
buildMirrorsSurfaces("1");
coatjava::makeRICHtext("1");
coatjava::makeRICHtext("4");
