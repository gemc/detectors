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
        insert_bank_variable(\%configuration, $bankname, "side",         2, "Di", "side of PMT");
	insert_bank_variable(\%configuration, $bankname, "ADC",          3, "Di", "ADC");
	insert_bank_variable(\%configuration, $bankname, "TDC",          4, "Di", "TDC");
	insert_bank_variable(\%configuration, $bankname, "ADCu",         5, "Di", "ADC Unsmeared");
	insert_bank_variable(\%configuration, $bankname, "TDCu",         6, "Di", "TDC Unsmeared");
	insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number");
}
