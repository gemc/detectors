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
	print "   vacuumExtension.pl <configuration filename>\n";
 	print "   Will create the CLAS12 vacuumExtension in various configurations\n";
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

my @allConfs = ( "original");

my $pos = 625;

# Adding the neoprene insulation Heat Shield

my $VErmin   = 50.8;
my $VErmax   = $VErmin + 2;  # 2mm thickness
my $VElength = 250.0;

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;
	
	my %detector = init_det();
	
	$detector{"name"}        = "extensionVacuumCarbonShell";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Vacuum extension made of carbon fiber";
	$detector{"color"}       = "88aaff";
	$detector{"type"}        = "Tube";
	$detector{"material"}    = "carbonFiber";
		
	$detector{"pos"}         =  "0*mm 0*mm $pos*mm" ;
	
	my $dimen = "0*mm $VErmax*mm $VElength*mm 0*deg 360*deg";

	$detector{"dimensions"}  = $dimen;
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
	%detector = init_det();

	$detector{"name"}        = "extensionVacuum";
	$detector{"mother"}      = "extensionVacuumCarbonShell";
	$detector{"description"} = "Vacuum inside";
	$detector{"color"}       = "ff8888";
	$detector{"type"}        = "Tube";


	$dimen = "0*mm $VErmin*mm $VElength*mm 0*deg 360*deg";

	$detector{"dimensions"}  = $dimen;
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	$detector{"material"}    = "G4_Galactic";
	print_det(\%configuration, \%detector);

	
}




