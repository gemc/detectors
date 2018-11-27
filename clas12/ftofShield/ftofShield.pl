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
	print "   ftofShield.pl <configuration filename>\n";
	print "   Will create the CLAS12 ftof shield in various configurations\n";
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

my @allConfs = ("pb0.2", "pb0.5", "pb1", "pb3");

my $rmin   = 240;
my $length = 420;
my $pos    = "0*mm 0*mm -80*mm";

foreach my $conf ( @allConfs )
{
	$configuration{"variation"} = $conf ;

	my $panel1b_mother_dx1 = 4.81343;
	my $panel1b_mother_dx2 = 81.719055;
	my $panel1b_mother_dz  = 74.8269;

	my $pos = "0*inches 1.33948*inches 0*inches";

	# thickness in mm
	my $panel1b_mother_dy  = 0.2/25.4; # 0.2 mm

	# loop over sectors
	for (my $isect = 0; $isect < 6; $isect++)
	{
		my $sector = $isect +1;

		my %detector = init_det();
		$detector{"name"}         = "ftof_shield_sector$sector";
		$detector{"mother"}       = "ftof_p1b_s$sector";
		$detector{"description"}  = "Layer of lead - Sector $sector";
		$detector{"pos"}          = $pos;
		$detector{"rotation"}     = "0*deg 0*deg 0*deg";
		$detector{"color"}        = "dc143c";
		$detector{"type"}         = "Trd";
		$detector{"dimensions"}   = "$panel1b_mother_dx1*inches $panel1b_mother_dx2*inches $panel1b_mother_dy*inches $panel1b_mother_dy*inches $panel1b_mother_dz*inches";
		$detector{"material"}     = "G4_Pb";
		$detector{"visible"}      = 1;
		$detector{"style"}        = 1;
		print_det(\%configuration, \%detector);
	}
}



