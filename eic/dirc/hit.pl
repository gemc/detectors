use strict;
use warnings;

our %configuration;
our %parameters;


sub define_dirc_hit
{
	# uploading the hit definition
	my %hit = init_hit();
	$hit{"name"}            = "dirc";
	$hit{"description"}     = "dirc hit definitions";
	$hit{"identifiers"}     = "sector paddle";
	$hit{"signalThreshold"} = "0.5*MeV";
	$hit{"timeWindow"}      = "5*ns";
	$hit{"prodThreshold"}   = "1*mm";
	$hit{"maxStep"}         = "1*cm";
	$hit{"delay"}           = "50*ns";
	$hit{"riseTime"}        = "1*ns";
	$hit{"fallTime"}        = "2*ns";
	$hit{"mvToMeV"}         = 100;
	$hit{"pedestal"}        = -20;
	print_hit(\%configuration, \%hit);
}



1;