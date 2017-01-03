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
	insert_bank_variable(\%configuration, $bankname, "ADCL",           4, "Di", "ADC Left");
	insert_bank_variable(\%configuration, $bankname, "ADCR",           5, "Di", "ADC Right");
	insert_bank_variable(\%configuration, $bankname, "TDCL",           6, "Di", "TDC Left");
	insert_bank_variable(\%configuration, $bankname, "TDCR",           7, "Di", "TDC Right");
	insert_bank_variable(\%configuration, $bankname, "ADCLu",          8, "Di", "ADC Left  - unsmeared");
	insert_bank_variable(\%configuration, $bankname, "ADCRu",          9, "Di", "ADC Right - unsmeared");
	insert_bank_variable(\%configuration, $bankname, "TDCLu",         10, "Di", "TDC Left  - unsmeared");
	insert_bank_variable(\%configuration, $bankname, "TDCRu",         11, "Di", "TDC Right - unsmeared");
	insert_bank_variable(\%configuration, $bankname, "hitn",          99, "Di", "hit number");
}


sub define_banks
{
	define_bank("ftof", 1000);
}

