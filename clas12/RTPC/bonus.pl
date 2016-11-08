#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use geometry;
use math;

use Math::Trig;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   bonus.pl <configuration filename>\n";
	print "   Will create the CLAS12 Bonus using the variation specified in the configuration file\n";
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



###########################################################################################
# All dimensions in mm

my @radius  = (20.0,   30.0,  60.0,  63.0,  66.0, 69.0);   # Inner radii of Bonus 6 Layers: 2 mylar + aluminum, 3 gem, kapton
my @phispan = (180.0, 170.0, 170.0, 165.0, 160.0, 155.0);  # Phi Span of layers
my $z_half  = 105.0036;

my @first_layer_thick = (     0.006,  0.0001);
my @first_layer_mater = ('G4_MYLAR', 'G4_Al');
my @first_layer_color = ('330099', 'aaaaff', '330099', 'aaaaff');

my @gem_thick = (   0.005,        0.05,  0.005);
my @gem_mater = ( 'G4_Cu', 'G4_KAPTON', 'G4_Cu');
my @gem_color = ('661122',  '335566', '661122');

my $microgap_width = 0.001;


# mother volume
sub make_bonus
{
	my %detector = init_det();
	$detector{"name"}        = "bonus";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Bonus Detector";
	$detector{"color"}       = "eeeeff";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "19.5*mm 70*mm 110.0*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_He";
	$detector{"visible"}     = 0;
	print_det(\%configuration, \%detector);
}

# first two layers
sub make_first_layers
{
	my $which = shift;
	my $layer = shift;
	
	my $rmin  = 0;
	my $rmax  = 0;
	my $pspan = 0;
	my $mate  = "G4_AIR";
	my %detector = init_det();
	
	
	if($layer == 0)
	{
		$rmin  = $radius[0];
		$rmax  = $rmin + $first_layer_thick[0];
		$pspan = $phispan[0];
		$mate  = $first_layer_mater[0];
 	}
	
	if($layer == 1)
	{
		$rmin  = $radius[0] + $first_layer_thick[0] + $microgap_width;
		$rmax  = $rmin + $first_layer_thick[1];
		$pspan = $phispan[0];
		$mate  = $first_layer_mater[1];
	}
	
	if($layer == 2)
	{
		$rmin  = $radius[1];
		$rmax  = $rmin + $first_layer_thick[0];
		$pspan = $phispan[1];
		$mate  = $first_layer_mater[0];
	}
	
	if($layer == 3)
	{
		$rmin  = $radius[1] + $first_layer_thick[0] + $microgap_width;
		$rmax  = $rmin + $first_layer_thick[1];
		$pspan = $phispan[1];
		$mate  = $first_layer_mater[1];
	}
	
	my $phistart = 0;
	
	if($which == 0)
	{
		$phistart =  90 + (180 - $pspan)/2.0;
		$detector{"name"} = "first_layer_left_".$layer;
 	}
	
 	if($which == 1)
	{
		$phistart = 270 + (180 - $pspan)/2.0;
		$detector{"name"} = "first_layer_right_".$layer;
	}
	
	$detector{"mother"}      =  "bonus";
	$detector{"description"} = "Layer ".$layer;
	$detector{"color"}       = $first_layer_color[$layer];
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_half*mm $phistart*deg $pspan*deg";
	$detector{"material"}    = $mate;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


# three gem
sub make_gems
{
	my $which = shift;
	my $layer = shift;
	
	my $rmin  = 0;
	my $rmax  = 0;
	my $pspan = 0;
	my $color = "000000";
	my $mate  = "G4_AIR";
	
	# first gem
	if($layer == 0)
	{
		$rmin  = $radius[2];
		$rmax  = $rmin + $gem_thick[0];
		$pspan = $phispan[2];
		$color = $gem_color[0];
		$mate  = $gem_mater[0];
	}
	
 	if($layer == 1)
 	{
		$rmin  = $radius[2] + $gem_thick[0] + $microgap_width;
		$rmax  = $rmin + $gem_thick[1];
		$pspan = $phispan[2];
		$color = $gem_color[1];
		$mate  = $gem_mater[1];
	}
	
	if($layer == 2)
	{
		$rmin  = $radius[2] + $gem_thick[0] + $microgap_width + $gem_thick[1] + $microgap_width;
		$rmax  = $rmin + $gem_thick[2];
		$pspan = $phispan[2];
		$color = $gem_color[2];
		$mate  = $gem_mater[2];
	}
	
	# second gem
	if($layer == 3)
	{
		$rmin  = $radius[3];
		$rmax  = $rmin + $gem_thick[0];
		$pspan = $phispan[3];
		$color = $gem_color[0];
		$mate  = $gem_mater[0];
	}
	
	if($layer == 4)
	{
		$rmin  = $radius[3] + $gem_thick[0] + $microgap_width;
		$rmax  = $rmin + $gem_thick[1];
		$pspan = $phispan[3];
		$color = $gem_color[1];
		$mate  = $gem_mater[1];
	}
	
	if($layer == 5)
	{
		$rmin  = $radius[3] + $gem_thick[0] + $microgap_width + $gem_thick[1] + $microgap_width;
		$rmax  = $rmin + $gem_thick[2];
		$pspan = $phispan[3];
		$color = $gem_color[2];
		$mate  = $gem_mater[2];
	}
	
 # third gem
	if($layer == 6)
	{
		$rmin  = $radius[4];
		$rmax  = $rmin + $gem_thick[0];
		$pspan = $phispan[4];
		$color = $gem_color[0];
		$mate  = $gem_mater[0];
	}
	
	if($layer == 7)
	{
		$rmin  = $radius[4] + $gem_thick[0] + $microgap_width;
		$rmax  = $rmin + $gem_thick[1];
		$pspan = $phispan[4];
		$color = $gem_color[1];
		$mate  = $gem_mater[1];
	}
	
	if($layer == 8)
	{
		$rmin  = $radius[4] + $gem_thick[0] + $microgap_width + $gem_thick[1] + $microgap_width;
		$rmax  = $rmin + $gem_thick[2];
		$pspan = $phispan[4];
		$color = $gem_color[2];
		$mate  = $gem_mater[2];
	}
	
	
	my $phistart = 0;
	my %detector = init_det();
	
	if($which == 0)
	{
		$phistart =  90 + (180 - $pspan)/2.0;
		$detector{"name"} = "gem_left_".$layer;
	}
	
	if($which == 1)
	{
		$phistart = 270 + (180 - $pspan)/2.0;
		$detector{"name"} = "gemc_right_".$layer;
	}
	
	$detector{"mother"}      = "bonus";
	$detector{"description"} = "gem layer ".$layer;
	$detector{"color"}       = $color;
	$detector{"type"}        = "Tube";
	$detector{"style"}       = 1;
	
	$detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_half*mm $phistart*deg $pspan*deg";
	$detector{"material"}    = $mate;
	print_det(\%configuration, \%detector);
	
}

# not sensitive for now
sub make_sensitive_he
{
	my $which = shift;
	
	my $rmin  = $radius[1] + $first_layer_thick[0] + $microgap_width + $first_layer_thick[1] + $microgap_width;
	my $rmax  = $radius[2] - $microgap_width;
	my $pspan = $phispan[1];
	
	my $phistart = 0;
	my %detector = init_det();
	
	if($which == 1)
	{
		$phistart =  90 + (180 - $pspan)/2.0;
		$detector{"name"} = "sensitive_he_left";
	}
	
	if($which == 2)
	{
		$phistart = 270 + (180 - $pspan)/2.0;
		$detector{"name"} = "sensitive_he_right";
	}
	
	$detector{"mother"}      = "bonus";
	$detector{"description"} = "Sensitive He";
	$detector{"color"}       = "ff88994";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_half*mm $phistart*deg $pspan*deg";
	$detector{"material"}    = "G4_He";
	$detector{"style"}       = 1;

	$detector{"sensitivity"}  = "bonus";
	$detector{"hit_type"}     = "bonus";
	$detector{"identifiers"}  = "id manual $which";
	print_det(\%configuration, \%detector);
}


make_bonus();

for(my $l = 0; $l < 4; $l++)
{
	make_first_layers(0, $l);
	make_first_layers(1, $l);
}

for(my $l = 0; $l < 9; $l++)
{
	make_gems(0, $l);
	make_gems(1, $l);
}

make_sensitive_he(1);
make_sensitive_he(2);





