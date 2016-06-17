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

my $bankId   = 400;
my $bankname = "ctof";

sub define_bank
{
	
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "paddle",       1, "Di", "paddle number");
	insert_bank_variable(\%configuration, $bankname, "ADCU",         2, "Di", "ADC Upstream");
	insert_bank_variable(\%configuration, $bankname, "ADCD",         3, "Di", "ADC Downstream");
	insert_bank_variable(\%configuration, $bankname, "TDCU",         4, "Di", "TDC Upstream");
	insert_bank_variable(\%configuration, $bankname, "TDCD",         5, "Di", "TDC Downstream");
	insert_bank_variable(\%configuration, $bankname, "ADCUu",        6, "Di", "ADC Upstream Unsmeared");
	insert_bank_variable(\%configuration, $bankname, "ADCDu",        7, "Di", "ADC Downstream Unsmeared");
	insert_bank_variable(\%configuration, $bankname, "TDCUu",        8, "Di", "TDC Upstream Unsmeared");
	insert_bank_variable(\%configuration, $bankname, "TDCDu",        9, "Di", "TDC Downstream Unsmeared");
	insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number");
}
