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
	insert_bank_variable(\%configuration, $bankname, "paddle",         2, "Di", "paddle number");
	insert_bank_variable(\%configuration, $bankname, "ADCL",           3, "Di", "ADC Left");
	insert_bank_variable(\%configuration, $bankname, "ADCR",           4, "Di", "ADC Right");
	insert_bank_variable(\%configuration, $bankname, "TDCL",           5, "Di", "TDC Left");
	insert_bank_variable(\%configuration, $bankname, "TDCR",           6, "Di", "TDC Right");
	insert_bank_variable(\%configuration, $bankname, "ADCLu",          7, "Di", "ADC Left  - unsmeared");
	insert_bank_variable(\%configuration, $bankname, "ADCRu",          8, "Di", "ADC Right - unsmeared");
	insert_bank_variable(\%configuration, $bankname, "TDCLu",          9, "Di", "TDC Left  - unsmeared");
	insert_bank_variable(\%configuration, $bankname, "TDCRu",         10, "Di", "TDC Right - unsmeared");
	insert_bank_variable(\%configuration, $bankname, "hitn",          99, "Di", "hit number");
}


sub define_banks
{
	define_bank("ftof_p1a", 1000);
	define_bank("ftof_p1b", 1100);
	define_bank("ftof_p2",  1200);
}

