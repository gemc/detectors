use strict;
use warnings;
use bank;

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

my $bankId   = 1400;
my $bankname = "ltcc";

sub define_ltcc_bank
{
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "sector",       1, "Di", "sector number");
	insert_bank_variable(\%configuration, $bankname, "side",         3, "Di", "left or right looking downstream");
	insert_bank_variable(\%configuration, $bankname, "pmtn",         3, "Di", "pmt ID");
	insert_bank_variable(\%configuration, $bankname, "nphe",         4, "Di", "number of photoelectrons");
	insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number");
}




1;