#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/io");
use utils;
use bank;

use strict;
use warnings;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   bank.pl <configuration filename>\n";
 	print "   Will create the CLAS12 Barrel Silicon Tracker (bst)  bank\n";
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

# Variable Type is two chars.
# The first char:
#  R for raw integrated variables
#  D for dgt integrated variables
#  S for raw step by step variables
#  M for digitized multi-hit variables
#  V for voltage(time) variables
#
# Notice: for hit process routines, only D is allowed.
#
# The second char:
# i for integers
# d for doubles

my $bankId   = 100;
my $bankname = "bst";

sub define_bank
{
	
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "layer",        1, "Di", "layer number");
	insert_bank_variable(\%configuration, $bankname, "sector",       2, "Di", "sector number");
	insert_bank_variable(\%configuration, $bankname, "strip",        3, "Di", "strip number");
	insert_bank_variable(\%configuration, $bankname, "ADC",          4, "Di", "3 bit ADC");
	insert_bank_variable(\%configuration, $bankname, "bco",          5, "Di", "Time information");
	insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number");
}

define_bank();

1;
