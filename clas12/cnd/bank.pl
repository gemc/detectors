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

my $bankId   = 300;
my $bankname = "cnd";


sub define_bank
{
	
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid",   $bankId, "Di", "$bankname bank ID");
        insert_bank_variable(\%configuration, $bankname, "sector",         1, "Di", "sector number");
	insert_bank_variable(\%configuration, $bankname, "layer",          2, "Di", "layer number");
	insert_bank_variable(\%configuration, $bankname, "component",      3, "Di", "component number");
	insert_bank_variable(\%configuration, $bankname, "ADCL",           4, "Di", "ADC Left");
	insert_bank_variable(\%configuration, $bankname, "ADCR",           5, "Di", "ADC Right");
	insert_bank_variable(\%configuration, $bankname, "TDCL",           6, "Di", "TDC Left");
	insert_bank_variable(\%configuration, $bankname, "TDCR",           7, "Di", "TDC Right");
	insert_bank_variable(\%configuration, $bankname, "hitn",          99, "Di", "hit number");
}

