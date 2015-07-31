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
 	print "   Will define the CLAS12 Pre-shower Calorimeter (pcal) banks\n";
 	print "   Note: The passport and .visa files must be present to connect to MYSQL. \n\n";
	exit;
}

# If not pring the help
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

my $bankId   = 1500;
my $bankname = "pcal";

sub define_bank
{
	
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid",   $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "sector",         1, "Di", "sector number");
	insert_bank_variable(\%configuration, $bankname, "module",         2, "Di", "module number");
	insert_bank_variable(\%configuration, $bankname, "view",           3, "Di", "view");
	insert_bank_variable(\%configuration, $bankname, "strip",          4, "Di", "strip number");
	insert_bank_variable(\%configuration, $bankname, "ADC",            5, "Di", "ADC");
	insert_bank_variable(\%configuration, $bankname, "TDC",            6, "Di", "TDC");
	insert_bank_variable(\%configuration, $bankname, "hitn",          99, "Di", "hit number");
}

define_bank();


1;