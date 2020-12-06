use strict;
use warnings;

our %configuration;

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

my $bankId   = 2100;
my $bankname = "band";

sub define_bank
{
	
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid",   $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "sector",         1, "Di", "sector number");
	insert_bank_variable(\%configuration, $bankname, "layer",          2, "Di", "layer number");
	insert_bank_variable(\%configuration, $bankname, "component",      3, "Di", "component number");
	insert_bank_variable(\%configuration, $bankname, "ADCL",            4, "Di", "ADC");
	insert_bank_variable(\%configuration, $bankname, "amplitudeL",      5, "Di", "amplitude");
	insert_bank_variable(\%configuration, $bankname, "ADCtimeL",        6, "Dd", "time from FADC");
	insert_bank_variable(\%configuration, $bankname, "TDCL",            7, "Di", "time from TDC");
	insert_bank_variable(\%configuration, $bankname, "ADCR",            8, "Di", "ADC");
	insert_bank_variable(\%configuration, $bankname, "amplitudeR",      9, "Di", "amplitude");
	insert_bank_variable(\%configuration, $bankname, "ADCtimeR",        10, "Dd", "time from FADC");
	insert_bank_variable(\%configuration, $bankname, "TDCR",            11, "Di", "time from TDC");
	insert_bank_variable(\%configuration, $bankname, "hitn",          99, "Di", "hit number");}
