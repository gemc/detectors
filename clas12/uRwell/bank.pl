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

my $bankId   = 1300;
my $bankname = "uRwell";

sub define_bank
{
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");

	insert_bank_variable(\%configuration, $bankname, "sector",       1, "Di", "sector (10..63)");
	insert_bank_variable(\%configuration, $bankname, "layer",    3, "Di", "strip_layer number (1..2)");
    insert_bank_variable(\%configuration, $bankname, "component",    4, "Di", "strip_ID number (1..10000)");
    insert_bank_variable(\%configuration, $bankname, "ADC",    5, "Dd", "charge value");
	insert_bank_variable(\%configuration, $bankname, "time",    6, "Dd", "time value");
	insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number");
}


