#!/usr/bin/perl -w

use strict;
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
    print "   pcal.pl <configuration filename>\n";
    print "   Will create the CLAS12 PCAL geometry, materials, bank and hit definitions\n";
    print "   Note: if the sqlite file does not exist, create one with:  \$GEMC/api/perl/sqlite.py -n ../clas12.sqlite\n";
    exit;
}

# Make sure the argument list is correct
if (scalar @ARGV != 1) {
    help();
    exit;
}

# Loading configuration file and parameters
our %configuration = load_configuration($ARGV[0]);

# import scripts
require "./materials.pl";
require "./hit.pl";
require "./geometry_java.pl";


# all the scripts must be run for every configuration
my @allConfs = ("default", "rga_fall2018");

# hits, bank defined for ecal (ec subdir) apply to this geometry as well
# define_bank();

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;

	# materials
	materials();

	# hits
	define_hit();

	# run PCAL factory from COATJAVA to produce volumes
	system("groovy -cp '../*:..' factory.groovy --variation $configuration{variation} --runnumber 11");

	# Global pars - these should be read by the load_parameters from file or DB
	our @volumes = get_volumes(%configuration);

	coatjava::makePCAL();

}
