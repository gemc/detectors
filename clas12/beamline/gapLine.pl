use strict;
use warnings;

our %configuration;

# This places air beampipe between the target and the vacuum line

my $microgap = 0.1;
my $R = 15;

sub gapLine()
{
	
	my $zStart = 50 + $microgap;     # end of target
	my $zEnd   = 433.9 - $microgap;  # start of vacuum line
	my $length = ($zEnd - $zStart) / 2.0;
	my $zpos   = $zStart + $length;
	
	if( $configuration{"variation"} eq "realityWithFT" )
	{
		$zEnd = 750.0;
	}
	
	# air pipe
	my %detector = init_det();
	$detector{"name"}        = "airPipe";
	$detector{"mother"}      = "root";
	$detector{"description"} = "air line from target to vacuum line";
	$detector{"pos"}         = "0*mm 0.0*mm $zpos*mm";
	$detector{"color"}       = "eeeeff";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm $R*mm $length*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_AIR";
	if( $configuration{"variation"} eq "realityWithFTNotUsedHeliumBag" )
	{
		$detector{"material"}    = "G4_He";
		$detector{"name"}        = "heliumPipe";
	}
	
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
}


