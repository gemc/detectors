use strict;
use warnings;

our %configuration;


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

my $bankId   = 400;
my $bankname = "ctof";

sub define_bank
{
	
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "paddle",       1, "Di", "paddle number");
	insert_bank_variable(\%configuration, $bankname, "ADCL",         2, "Di", "ADC Left");
	insert_bank_variable(\%configuration, $bankname, "ADCR",         3, "Di", "ADC Right");
	insert_bank_variable(\%configuration, $bankname, "TDCL",         4, "Di", "TDC Left");
	insert_bank_variable(\%configuration, $bankname, "TDCR",         5, "Di", "TDC Right");
	insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number");
}
