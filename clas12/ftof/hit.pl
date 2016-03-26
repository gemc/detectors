use strict;
use warnings;

our %configuration;

sub define_p1a_hit
{
	# uploading the hit definition
	my %hit = init_hit();
	$hit{"name"}            = "ftof_p1a";
	$hit{"description"}     = "ftof hit definitions for panel 1A";
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

sub define_p1b_hit
{
	# uploading the hit definition
	my %hit = init_hit();
	$hit{"name"}            = "ftof_p1b";
	$hit{"description"}     = "ftof hit definitions for panel 1B";
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

sub define_p2_hit
{
	# uploading the hit definition
	my %hit = init_hit();
	$hit{"name"}            = "ftof_p2";
	$hit{"description"}     = "ftof hit definitions for panel 2";
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


sub define_hit
{
	define_p1a_hit();
	define_p1b_hit();
	define_p2_hit();
}

