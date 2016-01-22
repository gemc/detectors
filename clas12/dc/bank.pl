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
	insert_bank_variable(\%configuration, $bankname, "superlayer",  2,  "Di", "superlayer index");
	insert_bank_variable(\%configuration, $bankname, "layer",       3,  "Di", "layer index");
	insert_bank_variable(\%configuration, $bankname, "wire",        4,  "Di", "wire index");
	insert_bank_variable(\%configuration, $bankname, "LR",          5,  "Di", "Left/Right: -1 (right) if the track is between the beam and the closest wire");
	insert_bank_variable(\%configuration, $bankname, "doca",        6,  "Dd", "2D distance between closest track step to the wire hit");
	insert_bank_variable(\%configuration, $bankname, "sdoca",       7,  "Dd", "smeared doca");
	insert_bank_variable(\%configuration, $bankname, "time",        8,  "Dd", "doca / drift velocity in each region 53, 26, 36 um/ns");
	insert_bank_variable(\%configuration, $bankname, "stime",       9,  "Dd", "sdoca / drift velocity in each region");
	insert_bank_variable(\%configuration, $bankname, "fired",      10,  "Di", "fired if passed efficiency");
	insert_bank_variable(\%configuration, $bankname, "nearPlates", 11,  "Di", "1 if the hit is near the endplates");
	insert_bank_variable(\%configuration, $bankname, "hitn",       99,  "Di", "hit number");
}


