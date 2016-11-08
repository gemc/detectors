use strict;
use warnings;

our %configuration;

sub define_hit
{

		# uploading the hit definition
		my %hit = init_hit();
		$hit{"name"}            = "rtpc";
		$hit{"description"}     = "RTPC hit definitions";
		$hit{"identifiers"}     = "rtpc";
		$hit{"signalThreshold"} = "0.0*MeV";
		$hit{"timeWindow"}      = "0.00001*ns";
		$hit{"prodThreshold"}   = "0.1*mm";
		$hit{"maxStep"}         = "1*cm";
		$hit{"delay"}           = "0*ns";
		$hit{"riseTime"}        = "1*ns";
		$hit{"fallTime"}        = "1*ns";
		$hit{"mvToMeV"}         = 100;
		$hit{"pedestal"}        = -20;
		print_hit(\%configuration, \%hit);

}
