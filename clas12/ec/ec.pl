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
    print "   ec.pl <configuration filename>\n";
    print "   Will create the CLAS12 EC geometry, materials, bank and hit definitions\n";
    exit;
}

# Make sure the argument list is correct
if (scalar @ARGV != 1) {
    help();
    exit;
}

# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);

# Global pars - these should be read by the load_parameters from file or DB
# line commented out as parameters mechanism is not used for EC
#our %parameters = get_parameters(%configuration);

# materials
require "./materials.pl";

# banks definitions
require "./bank.pl";

# hits definitions
# these include the pcal now
require "./hit.pl";

# sensitive geometry
require "./geometry_java.pl";


# subroutines create_ec with arguments (variation, run number)
sub create_ec {
    my $variation = shift;
    my $runNumber = shift;

    # materials
    materials();

    # hits
    define_hit();

    # run EC factory from COATJAVA to produce volumes
   system("groovy -cp '../*:..' factory.groovy --variation $variation --runnumber $runNumber");

    # Global pars - these should be read by the load_parameters from file or DB
    our @volumes = get_volumes(%configuration);

    coatjava::makeEC();
}

# TEXT Factory
$configuration{"factory"} = "TEXT";
define_bank();

my @variations = ("default", "rga_fall2018");
my $runNumber = 11;

foreach my $variation (@variations) {
    $configuration{"variation"} = $variation;
   # create_ec($variation, $runNumber);
}

# SQLITE Factory
$configuration{"factory"} = "SQLITE";
define_bank();

my $variation = "default";
my @runs = (11, 101);

foreach my $run (@runs) {
    $configuration{"variation"} = $variation;
    $configuration{"run_number"} = $run;
    create_ec($variation, $run);
}


