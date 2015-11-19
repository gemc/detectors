use strict;
use warnings;
use hit;

our %configuration;
our %parameters;

# FMT             450        superlayer  type  segment  strip                        2.0*KeV        132*ns        300*um   270*um
# BMT             460        superlayer  type  segment  strip                        2.0*KeV        132*ns        300*um   270*um
# FTM             470        superlayer  type  segment  strip                        2.0*KeV        132*ns        300*um   270*um


sub define_FMT_hit
{
	# uploading the hit definition
	my %hit = init_hit();
	$hit{"name"}            = "fmt";
	$hit{"description"}     = "micromegas FMT";
# 	$hit{"identifiers"}     = "superlayer  type  segment  strip";
	$hit{"identifiers"}     = "layer sector strip";
	$hit{"signalThreshold"} = "2.0*KeV";
	$hit{"timeWindow"}      = "132*ns";
	$hit{"prodThreshold"}   = "1*mm";
	$hit{"maxStep"}         = "270*um";
	$hit{"delay"}           = "50*ns";
	$hit{"riseTime"}        = "1*ns";
	$hit{"fallTime"}        = "2*ns";
	$hit{"mvToMeV"}         = 100;
	$hit{"pedestal"}        = -20;
	print_hit(\%configuration, \%hit);
}

sub define_BMT_hit
{
	# uploading the hit definition
	my %hit = init_hit();
	$hit{"name"}            = "bmt";
	$hit{"description"}     = "micromegas BMT";
# 	$hit{"identifiers"}     = "superlayer  type  segment  strip";
	$hit{"identifiers"}     = "layer sector strip";
	$hit{"signalThreshold"} = "2.0*KeV";
	$hit{"timeWindow"}      = "132*ns";
	$hit{"prodThreshold"}   = "1*mm";
	$hit{"maxStep"}         = "270*um";
	$hit{"delay"}           = "50*ns";
	$hit{"riseTime"}        = "1*ns";
	$hit{"fallTime"}        = "2*ns";
	$hit{"mvToMeV"}         = 100;
	$hit{"pedestal"}        = -20;
	print_hit(\%configuration, \%hit);
}

sub define_FTM_hit
{
	# uploading the hit definition
	my %hit = init_hit();
	$hit{"name"}            = "ftm";
	$hit{"description"}     = "micromegas FTM";
# 	$hit{"identifiers"}     = "superlayer  type  segment  strip";
	$hit{"identifiers"}     = "layer sector strip";
	$hit{"signalThreshold"} = "2.0*KeV";
	$hit{"timeWindow"}      = "132*ns";
	$hit{"prodThreshold"}   = "300*um";
	$hit{"maxStep"}         = "270*um";
	$hit{"delay"}           = "50*ns";
	$hit{"riseTime"}        = "1*ns";
	$hit{"fallTime"}        = "2*ns";
	$hit{"mvToMeV"}         = 100;
	$hit{"pedestal"}        = -20;
	print_hit(\%configuration, \%hit);
}

sub define_micromegas_hits
{
	define_FMT_hit();
	define_BMT_hit();
	define_FTM_hit();
}

1;

