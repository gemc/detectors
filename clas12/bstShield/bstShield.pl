#!/usr/bin/perl -w


use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use geometry;

use Math::Trig;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   bstShield.pl <configuration filename>\n";
 	print "   Will create the CLAS12 bst shield in various configurations\n";
	exit;
}

# Make sure the argument list is correct
if( scalar @ARGV != 1) 
{
	help();
	exit;
}

# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);

my @allConfs = ("thick50", "thick100", "thick150", "thick200", "thick300", "thick500");

my $rmin   = 50.3;
my $length = 180;
my $pos    = "0*mm 0*mm -50*mm";

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;
	
	my %detector = init_det();
	
	$detector{"name"}        = "bstShield";
	$detector{"mother"}      = "root";
	$detector{"description"} = "bst shielding";
	$detector{"color"}       = "88aaff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         =  $pos ;

	my $rmax = 0;
	
	if($conf eq "thick50")
	{
		$rmax = $rmin + 0.05;
	} elsif ($conf eq "thick100")
	{		
		$rmax = $rmin + 0.1;
	} elsif ($conf eq "thick150")
	{
		$rmax = $rmin + 0.15;
	} elsif ($conf eq "thick200")
	{
		$rmax = $rmin + 0.2;
	} elsif ($conf eq "thick300")
	{
		$rmax = $rmin + 0.3;
	} elsif ($conf eq "thick500")
	{
		$rmax = $rmin + 0.5;
	}
		
	my $dimen = "$rmin*mm $rmax*mm $length*mm 0*deg 360*deg";

	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = "G4_Pb";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


