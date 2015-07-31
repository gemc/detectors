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

# FMT             450        superlayer  type  segment  strip                        2.0*KeV        132*ns        300*um   270*um
# BMT             460        superlayer  type  segment  strip                        2.0*KeV        132*ns        300*um   270*um
# FTM             470        superlayer  type  segment  strip                        2.0*KeV        132*ns        300*um   270*um

sub define_FMT_bank
{
	my $bankname = shift;
	my $bankID   = shift;
	
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid",   $bankID, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "layer",          1, "Di", "layer number");
	insert_bank_variable(\%configuration, $bankname, "sector",         2, "Di", "sector number");
	insert_bank_variable(\%configuration, $bankname, "strip",          3, "Di", "strip number");
	insert_bank_variable(\%configuration, $bankname, "hitn",          99, "Di", "hit number");
}

sub define_BMT_bank
{
	my $bankname = shift;
	my $bankID   = shift;
	
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid",   $bankID, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "layer",          1, "Di", "layer number");
	insert_bank_variable(\%configuration, $bankname, "sector",         2, "Di", "sector number");
	insert_bank_variable(\%configuration, $bankname, "strip",          3, "Di", "strip number");
	insert_bank_variable(\%configuration, $bankname, "hitn",          99, "Di", "hit number");
}

sub define_FTM_bank
{
	my $bankname = shift;
	my $bankID   = shift;
	
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid",   $bankID, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "layer",          1, "Di", "layer number");
	insert_bank_variable(\%configuration, $bankname, "sector",         2, "Di", "sector number");
	insert_bank_variable(\%configuration, $bankname, "strip",          3, "Di", "strip number");
	insert_bank_variable(\%configuration, $bankname, "hitn",          99, "Di", "hit number");
}


sub define_micromegas_banks
{
	define_FMT_bank("fmt", 500);
	define_BMT_bank("bmt", 200);
	define_FTM_bank("ftm", 470);
}


1;