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

# The ft banks id are:
#
# Tracker (trk):
# Tracker (hodo):
# Tracker (cal):

sub define_bdx_bank
{
	# uploading the hit definition
	my $bankId   = 100;
	my $bankname = "cormo";
	
	insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "sector",       1, "Di", "sector number");
	insert_bank_variable(\%configuration, $bankname, "layer",        2, "Di", "layer number");
	insert_bank_variable(\%configuration, $bankname, "paddle",       3, "Di", "paddle number");
	insert_bank_variable(\%configuration, $bankname, "adcl",         4, "Di", "adcl");
	insert_bank_variable(\%configuration, $bankname, "adcr",         5, "Di", "adcr");
	insert_bank_variable(\%configuration, $bankname, "tdcl",         6, "Di", "tdcl");
	insert_bank_variable(\%configuration, $bankname, "tdcr",         7, "Di", "tdcr");
	insert_bank_variable(\%configuration, $bankname, "adcb",         8, "Di", "adcb");
	insert_bank_variable(\%configuration, $bankname, "adcf",         9, "Di", "adcf");
	insert_bank_variable(\%configuration, $bankname, "tdcb",        10, "Di", "tdcb");
	insert_bank_variable(\%configuration, $bankname, "tdcf",        11, "Di", "tdcf");
	insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number");
	
	
	$bankId   = 200;
	$bankname = "veto";
	
	insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "sector",       1, "Di", "sector number");
	insert_bank_variable(\%configuration, $bankname, "veto",         2, "Di", "veto number");
	insert_bank_variable(\%configuration, $bankname, "channel",      3, "Di", "channel number");
	insert_bank_variable(\%configuration, $bankname, "adc1",         4, "Di", "adc1");
	insert_bank_variable(\%configuration, $bankname, "adc2",         5, "Di", "adc2");
    insert_bank_variable(\%configuration, $bankname, "adc3",         6, "Di", "adc3");
    insert_bank_variable(\%configuration, $bankname, "adc4",         7, "Di", "adc4");
	insert_bank_variable(\%configuration, $bankname, "tdc1",         8, "Di", "tdc1");
	insert_bank_variable(\%configuration, $bankname, "tdc2",         9, "Di", "tdc2");
    insert_bank_variable(\%configuration, $bankname, "tdc3",        10, "Di", "tdc3");
    insert_bank_variable(\%configuration, $bankname, "tdc4",        11, "Di", "tdc4");
	insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number");

    $bankId   = 300;
    $bankname = "crs";
    
    insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
    insert_bank_variable(\%configuration, $bankname, "sector",       1, "Di", "sector number");
    insert_bank_variable(\%configuration, $bankname, "xch",          2, "Di", "xch number");
    insert_bank_variable(\%configuration, $bankname, "ych",          3, "Di", "ych number");
    insert_bank_variable(\%configuration, $bankname, "adcl",         4, "Di", "adcl");
    insert_bank_variable(\%configuration, $bankname, "adcr",         5, "Di", "adcr");
    insert_bank_variable(\%configuration, $bankname, "tdcl",         6, "Di", "tdcl");
    insert_bank_variable(\%configuration, $bankname, "tdcr",         7, "Di", "tdcr");
    insert_bank_variable(\%configuration, $bankname, "adcb",         8, "Di", "adcb");
    insert_bank_variable(\%configuration, $bankname, "adcf",         9, "Di", "adcf");
    insert_bank_variable(\%configuration, $bankname, "tdcb",        10, "Di", "tdcb");
    insert_bank_variable(\%configuration, $bankname, "tdcf",        11, "Di", "tdcf");
    insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number"); 


}



sub define_banks
{
	define_bdx_bank();
}

1;










