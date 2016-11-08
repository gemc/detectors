#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/io");
use utils;
use bank;
use materials;

use strict;
use warnings;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   bank.pl <configuration filename>\n";
 	print "   Will create the CLAS12 rtpc
 bank\n";
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
# The second char:
# i for integers
# d for doubles

my $bankId   = 1700;
my $bankname = "rtpc";

sub define_bank
{
	
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "CellID",       1, "Di", "Pad CellId");
	insert_bank_variable(\%configuration, $bankname, "ADC",          2, "Dd", "ADC");
	insert_bank_variable(\%configuration, $bankname, "TDC",          3, "Dd", "TDC");
	insert_bank_variable(\%configuration, $bankname, "step",         4, "Di", "nstep");
	insert_bank_variable(\%configuration, $bankname, "EDep",         5, "Dd", "EDep");
        insert_bank_variable(\%configuration, $bankname, "hitn",         6, "Di", "hit number");
	insert_bank_variable(\%configuration, $bankname, "PosX",         7, "Dd", "PosX");
	insert_bank_variable(\%configuration, $bankname, "PosY",         8, "Dd", "PosY");
        insert_bank_variable(\%configuration, $bankname, "PosZ",         9, "Dd", "PosZ");
        insert_bank_variable(\%configuration, $bankname, "phiRad",      10, "Dd", "phiRad");
    
}

define_bank();

1;
