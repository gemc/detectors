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
my $bankname = "dc";

sub define_bank
{
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "sector",      1,  "Di", "sector index");
	insert_bank_variable(\%configuration, $bankname, "layer",       2,  "Di", "layer index");
	insert_bank_variable(\%configuration, $bankname, "wire",        3,  "Di", "wire index");
	insert_bank_variable(\%configuration, $bankname, "tdc",         4,  "Di", "tdc value");
	insert_bank_variable(\%configuration, $bankname, "LR",          5,  "Di", "Left/Right: -1 (right) if the track is between the beam and the closest wire");
	insert_bank_variable(\%configuration, $bankname, "doca",        6,  "Dd", "2D distance between closest track step to the wire hit");
	insert_bank_variable(\%configuration, $bankname, "sdoca",       7,  "Dd", "smeared doca");
	insert_bank_variable(\%configuration, $bankname, "time",        8,  "Dd", "doca / drift velocity in each region");
	insert_bank_variable(\%configuration, $bankname, "stime",       9,  "Dd", "sdoca / drift velocity in each region");
	insert_bank_variable(\%configuration, $bankname, "hitn",       99,  "Di", "hit number");
}


