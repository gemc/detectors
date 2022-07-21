#!/usr/bin/perl -w

use strict;
#use lib ("$ENV{GEMC}/api/perl");
use lib ("$ENV{GEMC}/io");
use utils;
use materials;

# Help Message
sub help()
{
    print "\n Usage: \n";
    print "   materials.pl <configuration filename>\n";
    print "   Will create the bubble chamber materials\n";
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

# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);


sub print_materials
{
    # uploading the mat definition
    
    # Nitrous Oxide
    my %mat = init_mat();
    $mat{"name"}          = "C3F8";
    $mat{"description"}   = "Chamber active fluid material";
    $mat{"density"}       = "1.350";
    $mat{"ncomponents"}   = "2";
    $mat{"components"}    = "C 3 F 8";	
    print_mat(\%configuration, \%mat);
    
}

print_materials();

