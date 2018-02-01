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

my @allConfs = ("lead_thick50",    "lead_thick100",    "lead_thick200",
				 "sst_thick50",     "sst_thick100",     "sst_thick200",
				"zinc_thick50",    "zinc_thick100",    "zinc_thick200",
	 	  	  "copper_thick50",  "copper_thick100",  "copper_thick200",
			  "nickel_thick50",  "nickel_thick100",  "nickel_thick200");

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
	
	if($conf eq "lead_thick50") {
		$rmax = $rmin + 0.05;
		$detector{"material"}    = "G4_Pb";
	} elsif ($conf eq "lead_thick100") {
		$rmax = $rmin + 0.1;
		$detector{"material"}    = "G4_Pb";
	} elsif ($conf eq "lead_thick200") {
		$rmax = $rmin + 0.2;
		$detector{"material"}    = "G4_Pb";
	} elsif ($conf eq "sst_thick50") {
		$rmax = $rmin + 0.05;
		$detector{"material"}    = "G4_STAINLESS-STEEL";
	} elsif ($conf eq "sst_thick100") {
		$rmax = $rmin + 0.1;
		$detector{"material"}    = "G4_STAINLESS-STEEL";
	} elsif ($conf eq "sst_thick200") {
		$rmax = $rmin + 0.2;
		$detector{"material"}    = "G4_STAINLESS-STEEL";
	} elsif ($conf eq "zinc_thick50") {
		$rmax = $rmin + 0.05;
		$detector{"material"}    = "G4_Zn";
	} elsif ($conf eq "zinc_thick100") {
		$rmax = $rmin + 0.1;
		$detector{"material"}    = "G4_Zn";
	} elsif ($conf eq "zinc_thick200") {
		$rmax = $rmin + 0.2;
		$detector{"material"}    = "G4_Zn";
	} elsif ($conf eq "copper_thick50") {
		$rmax = $rmin + 0.05;
		$detector{"material"}    = "G4_Cu";
	} elsif ($conf eq "copper_thick100") {
		$rmax = $rmin + 0.1;
		$detector{"material"}    = "G4_Cu";
	} elsif ($conf eq "copper_thick200") {
		$rmax = $rmin + 0.2;
		$detector{"material"}    = "G4_Cu";
	} elsif ($conf eq "nickel_thick50") {
		$rmax = $rmin + 0.05;
		$detector{"material"}    = "G4_Ni";
	} elsif ($conf eq "nickel_thick100") {
		$rmax = $rmin + 0.1;
		$detector{"material"}    = "G4_Ni";
	}  elsif ($conf eq "nickel_thick200") {
		$rmax = $rmin + 0.2;
		$detector{"material"}    = "G4_Ni";
	}

	
	
	my $dimen = "$rmin*mm $rmax*mm $length*mm 0*deg 360*deg";

	$detector{"dimensions"}  = $dimen;
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


