#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/io");
use lib ("$ENV{GEMC}/api/perl");
use utils;
use bank;

use strict;
use warnings;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   bank.pl <configuration filename>\n";
 	print "   Will create the CLAS12 Ring Imaging Cherenkov (rich) bank\n";
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

my $bankId    = 1800;
my $bankname  = "rich";


sub define_bank
{
	
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "sector",       1, "Di", "clas12 sector");
	insert_bank_variable(\%configuration, $bankname, "pmt",          2, "Di", "pmt number");
	insert_bank_variable(\%configuration, $bankname, "pixel",        3, "Di", "pixel");
	insert_bank_variable(\%configuration, $bankname, "nphotons",     4, "Di", "number of photons");
	insert_bank_variable(\%configuration, $bankname, "npe",          5, "Di", "number of detected photoelectrons");
	insert_bank_variable(\%configuration, $bankname, "nphotonsU",    6, "Di", "number of unconverted photons");
	insert_bank_variable(\%configuration, $bankname, "nphotonsO",    7, "Di", "number of out of QE range photons");
	insert_bank_variable(\%configuration, $bankname, "nphotonsD",    8, "Di", "number of dead area photons");
	insert_bank_variable(\%configuration, $bankname, "TDC1",         9, "Di", "TDC leading edge");
	insert_bank_variable(\%configuration, $bankname, "TDC2",        10, "Di", "TDC trailing edge");
 	insert_bank_variable(\%configuration, $bankname, "ADC",         11, "Di", "ADC analog");
	insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number");
}

define_bank();

1;
