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

sub define_bank
{
	my $bankname = shift;
	my $bankId   = shift;
	
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid",   $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "sector",         1, "Di", "sector number");
	insert_bank_variable(\%configuration, $bankname, "layer",          2, "Di", "layer number (1: 1A, 2: 1B, 3: 2B)");
	insert_bank_variable(\%configuration, $bankname, "paddle",         3, "Di", "paddle number");
	insert_bank_variable(\%configuration, $bankname, "side",           4, "Di", "PMT side (0 Left, 1 Right)");
	insert_bank_variable(\%configuration, $bankname, "ADC",            5, "Di", "ADC");
	insert_bank_variable(\%configuration, $bankname, "TDC" ,           6, "Di", "TDC");
	insert_bank_variable(\%configuration, $bankname, "ADCu",           7, "Di", "ADC unsmeared");
	insert_bank_variable(\%configuration, $bankname, "TDCu",           8, "Di", "TDC unsmeared");
	insert_bank_variable(\%configuration, $bankname, "hitn",          99, "Di", "hit number");
}


sub define_banks {
	define_bank("atof", 2200);
}

