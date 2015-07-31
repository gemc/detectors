use strict;
use warnings;

our %configuration;
our %parameters;



sub quartz_pmt_hit
{
	my %hit = init_hit();
	$hit{"name"}            = "ltcc_pmt";
	$hit{"description"}     = "ltcc quartz PMT hit definition";
	$hit{"identifiers"}     = "sector side nphe_pmt";
	$hit{"signalThreshold"} = "0.1*eV";
	$hit{"timeWindow"}      = "100*ns";
	$hit{"prodThreshold"}   = "2*mm";
	$hit{"maxStep"}         = "10*cm";
	print_hit(\%configuration, \%hit);
}


sub mirrors_hit
{
	my %hit = init_hit();
	$hit{"name"}            = "ltcc_mirrors";
	$hit{"description"}     = "ltcc mirrors hit definition - this is a FLUX type detector";
	$hit{"identifiers"}     = "id";
	$hit{"signalThreshold"} = "0.0*eV";
	$hit{"timeWindow"}      = "0*ns";
	$hit{"prodThreshold"}   = "5*mm";
	$hit{"maxStep"}         = "5*mm";
	print_hit(\%configuration, \%hit);	
}




1;

















