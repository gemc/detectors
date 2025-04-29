#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use hit;
use bank;
use math;
use materials;

use Math::Trig;

# Help Message
sub help() {
    print "\n Usage: \n";
    print "   ax_n.pl <configuration filename>\n";
    print "   Will create the Test geometry, materials, bank and hit definitions\n";
    exit;
}

# Make sure the argument list is correct
if (scalar @ARGV != 1) {
    help();
    exit;
}


# Loading configuration file and parameters
our %configuration = load_configuration($ARGV[0]);


# Loading geo routines
require "./geometry.pl";

make_test_geo();
make_materials();
