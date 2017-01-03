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
	insert_bank_variable(\%configuration, $bankname, "paddle",         3, "Di", "paddle number");
	insert_bank_variable(\%configuration, $bankname, "ADCD",           4, "Di", "ADC Direct");
	insert_bank_variable(\%configuration, $bankname, "ADCN",           5, "Di", "ADC Neighbor");
	insert_bank_variable(\%configuration, $bankname, "TDCD",           6, "Di", "TDC Direct");
	insert_bank_variable(\%configuration, $bankname, "TDCN",           7, "Di", "TDC Neighbor");
	insert_bank_variable(\%configuration, $bankname, "hitn",          99, "Di", "hit number");
}

