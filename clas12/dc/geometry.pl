#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use math;

use Math::Trig;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   geometry.pl <configuration filename>\n";
 	print "   Will create the CLAS12 Drift Chambers (dc) using the variation specified in the configuration file\n";
 	print "   Note: The passport and .visa files must be present to connect to MYSQL. \n\n";
	exit;
}

# Make sure the argument list is correct
# If not pring the help
if( scalar @ARGV != 1)
{
	help();
	exit;
}

# Loading configuration file from argument
our %configuration = load_configuration($ARGV[0]);

# One can change the "variation" here if one is desired different from the config.dat
# $configuration{"variation"} = "myvar";

# Load the parameters
our %parameters    = get_parameters(%configuration);

require "./utils.pl";
calculate_dc_parameters();

require "./basePlates.pl";

our @mother_dx1;
our @mother_dx2;
our @mother_dy;
our @mother_dz;
our @mother_xcent;
our @mother_ycent;
our @mother_zcent;

our @daughter_dx1;
our @daughter_dx2;
our @daughter_dy;
our @daughter_dz;
our @daughter_palp;
our @daughter_xcent;
our @daughter_ycent;
our @daughter_zcent;
our @daughter_tilt;




sub make_region
{
	my $iregion = shift;

	# enlargement of the mother volumes (cm) to accomodate DC base plates from basePlates.pl (y)
	# and prevent torus clipping (z), dx_shift preserves dc opening angle in case of y-enlargement
	my $y_enlargement =  3.69;
	my $z_enlargement = -2.75;
	my $dx_shift      = fstr( $y_enlargement * tan(rad(29.5)));

	# placement parameters for the mother region volume
	my $mpDX1   = $mother_dx1[$iregion] - $dx_shift;
	my $mpDX2   = $mother_dx2[$iregion] + $dx_shift;
	my $mpDX3   = $mpDX1;
	my $mpDX4   = $mpDX2;
	my $mpDY1   = $mother_dy[$iregion]  + $y_enlargement;
	my $mpDY2   = $mpDY1;
	my $mpDZ    = $mother_dz[$iregion]  + $z_enlargement;
	my $mpALP1  = 0.0;
	my $mpALP2  = $mpALP1;
	my $mtheta  = -25.0;
	my $mphi    =  90.0;

	my $region = $iregion + 1;
	
	for(my $s=1; $s<=6; $s++)
	{
		my %detector = init_det();
		$detector{"name"}        = "region$region"."_s$s";
		$detector{"mother"}      = "fc";
		$detector{"description"} = "CLAS12 Drift Chambers, Sector $s Region $iregion";
		$detector{"pos"}         = region_pos($s, $iregion);
		$detector{"rotation"}    = region_rot($s, $iregion);
		$detector{"color"}       = "aa0000";
		$detector{"type"}        = "G4Trap";
		$detector{"dimensions"}  = "$mpDZ*cm $mtheta*deg $mphi*deg $mpDY1*cm $mpDX1*cm $mpDX2*cm $mpALP1*deg $mpDY2*cm $mpDX3*cm $mpDX4*cm $mpALP2*deg";
		$detector{"material"}    = "dcgas";
		#$detector{"visible"}     = 0;
		print_det(\%configuration, \%detector);
	}
}

# Layers
# fixed placement parameters for the daughter (layer) volume

my $microgap = 0.01;  # 100 microns microgap between layers

sub make_layers
{
	
	my $iregion = shift;
	my $region = $iregion + 1;
	
	my $superlayer_min = $region*2 - 1;
	my $superlayer_max = $region*2;
	
	my $dxrot = 0.0;
	my $dyrot = 0.0;
	for (my $isup = $superlayer_min; $isup < $superlayer_max+1 ; $isup++)
	{
		for (my $ilayer = 1; $ilayer < 7 ; $ilayer++)
		{
			for(my $s=1; $s<=6; $s++)
			{
				my $dxplace = $daughter_xcent[$isup][$ilayer];
				my $dyplace = $daughter_ycent[$isup][$ilayer];
				my $dzplace = $daughter_zcent[$isup][$ilayer];
				
				my $dpDX1   = $daughter_dx1[$isup][$ilayer];
				my $dpDX2   = $daughter_dx2[$isup][$ilayer];
				my $dpDX3   = $dpDX1;
				my $dpDX4   = $dpDX2;
				my $dpDY1   = $daughter_dy[$isup][$ilayer];
				my $dpDY2   = $dpDY1;
				my $dpDZ    = $daughter_dz[$isup][$ilayer] - $microgap;
				my $dpALP1  = $daughter_palp[$isup][$ilayer];
				my $dpALP2  = $dpALP1;
				my $dzrot   = $daughter_tilt[$isup][$ilayer];
				my $dtheta  = -25.0;
				my $dphi    =  90.0;
				
				#if ($isup == $superlayer_min){$dzrot = 6.0};
				#if ($isup == $superlayer_max){$dzrot = -6.0};
				
				# names
				my $nlayer               = $ilayer;
				my %detector = init_det();
				$detector{"name"}        = "sl$isup"."_layer$nlayer"."_s$s";
				$detector{"mother"}      = "region$region"."_s$s";
				$detector{"description"} = "Region $iregion, Super Layer $isup, layer $ilayer, Sector $s";
				$detector{"pos"}         = "$dxplace*cm $dyplace*cm $dzplace*cm";
				$detector{"rotation"}    = "$dxrot*deg $dyrot*deg $dzrot*deg";
				$detector{"color"}       = "99aaff2";
				
				$detector{"type"}        = "G4Trap";
				$detector{"dimensions"}  = "$dpDZ*cm $dtheta*deg $dphi*deg $dpDY1*cm $dpDX1*cm $dpDX2*cm $dpALP1*deg $dpDY2*cm $dpDX3*cm $dpDX4*cm $dpALP2*deg";
				$detector{"material"}    = "dcgas";
				$detector{"style"}       = 1;
				$detector{"sensitivity"} = "dc";
				$detector{"hit_type"}    = "dc";
				$detector{"identifiers"} = "sector manual $s superlayer manual $isup layer manual $nlayer wire manual 1";
				print_det(\%configuration, \%detector);
			}
		}
	}
}




sub make_dc
{
	make_region(0);
	make_region(1);
	make_region(2);
	
	make_layers(0);
	make_layers(1);
	make_layers(2);
}

$configuration{"variation"} = "original";
make_dc();
make_plates();






























