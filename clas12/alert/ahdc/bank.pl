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
#	insert_bank_variable(\%configuration, $bankname, "bankid",   $bankId, "Di", "$bankname bank ID");
#	insert_bank_variable(\%configuration, $bankname, "superlayer",         1, "Di", "superlayer number from 0 to 4, circles in XY");
#	insert_bank_variable(\%configuration, $bankname, "layer",          2, "Di", "layer number (0 or 1)");
#	insert_bank_variable(\%configuration, $bankname, "wire",         3, "Di", "the AHDC cell number, from 1!");
#	insert_bank_variable(\%configuration, $bankname, "doca",            4, "Dd", "DOCA in mm");
#	insert_bank_variable(\%configuration, $bankname, "subcell",            5, "Di", "subcell 1 or 2, right or left of the signal wire");
#	insert_bank_variable(\%configuration, $bankname, "adc_energy",            6, "Dd", "ADC energy in MeV");
#	insert_bank_variable(\%configuration, $bankname, "wire_energy",            7, "Dd", "wire deposited energy in MeV");
#	insert_bank_variable(\%configuration, $bankname, "totEdep_MC",            8, "Dd", "MC truth totEdep in MeV");
#	insert_bank_variable(\%configuration, $bankname, "signal" ,           9, "Dd", "signal");
#	insert_bank_variable(\%configuration, $bankname, "time" ,           10, "Dd", "time");
#	insert_bank_variable(\%configuration, $bankname, "hitn",          99, "Di", "hit number");


	insert_bank_variable(\%configuration, $bankname, "bankid",   $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "sector",       1, "Di", "sector (1-6)");
	insert_bank_variable(\%configuration, $bankname, "layer",        2, "Di", "layer (1: 1A, 2: 1B, 3: 2B)");
	insert_bank_variable(\%configuration, $bankname, "component",    3, "Di", "paddle");
	insert_bank_variable(\%configuration, $bankname, "ADC_order",    4, "Di", "side: 0 - ADCL , 1 - ADCR");
	insert_bank_variable(\%configuration, $bankname, "ADC_ADC",      5, "Di", "ADC integral from pulse fit");
	insert_bank_variable(\%configuration, $bankname, "ADC_time" ,    6, "Dd", "time from pulse fit");
	insert_bank_variable(\%configuration, $bankname, "ADC_ped" ,     7, "Di", "pedestal from pulse analysis");
	insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number");

	

}

sub define_myatof_bank
{
	my $bankname = shift;
	my $bankId   = shift;
	
	# uploading the hit definition
	insert_bank_variable(\%configuration, $bankname, "bankid",   $bankId, "Di", "$bankname bank ID");
	insert_bank_variable(\%configuration, $bankname, "sector",	1, "Di", "sector from 0 to 14, in XY plan");
	insert_bank_variable(\%configuration, $bankname, "superlayer",	2, "Di", "superlayer from 0 (smallest paddles) to 1 (biggest paddles), circles in XY plan");
	insert_bank_variable(\%configuration, $bankname, "layer",	3, "Di", "layer 0 for smallest paddles, form 0 to 9 for biggest paddles, in Z axis");
	insert_bank_variable(\%configuration, $bankname, "paddle",	4, "Di", "paddle number from (sectorId*4+1) to (sectorId*4+4)");
	insert_bank_variable(\%configuration, $bankname, "adc_front",	5, "Dd", " ADC SiPM front end, SL0");
	insert_bank_variable(\%configuration, $bankname, "adc_back",	6, "Dd", " ADC SiPM back end, SL0");
	insert_bank_variable(\%configuration, $bankname, "adc_top",	7, "Dd", " ADC SiPM top side, SL1"); 
	insert_bank_variable(\%configuration, $bankname, "tdc_front",	8, "Dd", " TDC SiPM front end, SL0");
	insert_bank_variable(\%configuration, $bankname, "tdc_back",	9, "Dd", " TDC SiPM back end, SL0");
	insert_bank_variable(\%configuration, $bankname, "tdc_top",	10, "Dd", " TDC SiPM top side, SL1"); 
	insert_bank_variable(\%configuration, $bankname, "time_front",	11, "Dd", " Time SiPM front end, SL0");
	insert_bank_variable(\%configuration, $bankname, "time_back",	12, "Dd", " Time SiPM back end, SL0");
	insert_bank_variable(\%configuration, $bankname, "time_top",	13, "Dd", " Time SiPM top side, SL1"); 
	insert_bank_variable(\%configuration, $bankname, "E_tot_Front",	14, "Dd", " E deposit into SiPM front end, SL0");
	insert_bank_variable(\%configuration, $bankname, "E_tot_Back",	15, "Dd", " E deposit into SiPM back end, SL0");
	insert_bank_variable(\%configuration, $bankname, "E_tot_Top",	16, "Dd", " E deposit into SiPM top side, SL1"); 
	insert_bank_variable(\%configuration, $bankname, "totEdep_MC",	17, "Dd", " MC totEdep output"); 
	insert_bank_variable(\%configuration, $bankname, "hitn",	99, "Di", "hit number");
}

sub define_banks {
	define_ahdc_bank("alrtdc", 2400);
	define_myatof_bank("myatof", 2500);
}

