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

sub define_ahdc_bank
{
	my $bankname = shift;
	my $bankId   = shift;
	
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid",   $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "superlayer",         1, "Di", "superlayer number from 0 to 4, circles in XY");
	insert_bank_variable(\%configuration, $bankname, "layer",          2, "Di", "layer number (0 or 1)");
	insert_bank_variable(\%configuration, $bankname, "wire",         3, "Di", "the AHDC cell number, from 1!");
	insert_bank_variable(\%configuration, $bankname, "doca",            4, "Dd", "DOCA in mm");
	insert_bank_variable(\%configuration, $bankname, "energy",            5, "Dd", "deposited energy in MeV");
	insert_bank_variable(\%configuration, $bankname, "time" ,           6, "Dd", "time");
	insert_bank_variable(\%configuration, $bankname, "hitn",          99, "Di", "hit number");
}

sub define_myatof_bank
{
	my $bankname = shift;
	my $bankId   = shift;
	
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid",   $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "sector",         1, "Di", "sector from 0 to 14, in XY plan");
	insert_bank_variable(\%configuration, $bankname, "superlayer",          2, "Di", "superlayer from 0 (smallest paddles) to 1 (biggest paddles), circles in XY plan");
	insert_bank_variable(\%configuration, $bankname, "layer",          3, "Di", "layer 0 for smallest paddles, form 0 to 9 for biggest paddles, in Z axis");
	insert_bank_variable(\%configuration, $bankname, "paddle",         4, "Di", "paddle number from (sectorId*4+1) to (sectorId*4+4)");
	insert_bank_variable(\%configuration, $bankname, "adc_front",            5, "Dd", "ADC front end, superlayer 0");
	insert_bank_variable(\%configuration, $bankname, "adc_back",            6, "Dd", "ADC back end, superlayer 0");
	insert_bank_variable(\%configuration, $bankname, "adc_top",            7, "Dd", "ADC SiPM on paddle, superlayer 1");
	insert_bank_variable(\%configuration, $bankname, "tdc_front" ,           8, "Dd", "TDC front end, superlayer 0");
	insert_bank_variable(\%configuration, $bankname, "tdc_back" ,           9, "Dd", "TDC back end, superlayer 0");
	insert_bank_variable(\%configuration, $bankname, "tdc_top" ,           10, "Dd", "TDC SiPM on paddle, superlayer 1");
	insert_bank_variable(\%configuration, $bankname, "hitn",          99, "Di", "hit number");
}

# I keep "ftof" bank ID 1000 to be able to launch gemc simulation
sub define_banks {
	#define_bank("ftof", 1000);
	define_ahdc_bank("ahdc", 2300);
	define_myatof_bank("myatof", 2200);
}

