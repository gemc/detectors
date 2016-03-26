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

my $bankId    = 600;
my $bankname  = "htcc";

sub define_bank
{
	
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "sector",       1, "Di", "clas12 sector");
	insert_bank_variable(\%configuration, $bankname, "ring",         2, "Di", "theta index");
	insert_bank_variable(\%configuration, $bankname, "half",         3, "Di", "half-sector");
	insert_bank_variable(\%configuration, $bankname, "nphe",         4, "Di", "number of photoelectrons");
	insert_bank_variable(\%configuration, $bankname, "time",         5, "Dd", "average time of the hit");
	insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number");
}

