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

sub define_dirc_bank
{
	my $bankname = "dirc";
	my $bankID   = 500;
	
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid",   $bankID, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "hitn",           0, "Di", "hit number");
	insert_bank_variable(\%configuration, $bankname, "sector",         1, "Di", "sector number");
	insert_bank_variable(\%configuration, $bankname, "stack",          2, "Di", "stack number");
	insert_bank_variable(\%configuration, $bankname, "view",           3, "Di", "view");
	insert_bank_variable(\%configuration, $bankname, "strip",          4, "Di", "strip number");
	insert_bank_variable(\%configuration, $bankname, "ADC",            5, "Di", "ADC Left");
	insert_bank_variable(\%configuration, $bankname, "TDC",            6, "Di", "TDC Right");
}





1;