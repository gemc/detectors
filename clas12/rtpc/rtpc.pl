#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use geometry;
use math;
use materials;
use bank;
use hit;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   rtpc.pl <configuration filename>\n";
	print "   Will create the CLAS12 RTPC using the variation specified in the configuration file\n";
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

#materials
require "./materials.pl";
materials();

#bank
require "./bank.pl";
define_bank();

#bank
require "./hit.pl";
define_hit();

###########################################################################################
# All dimensions in mm
#  Target, Ground foil, Cathod foil, First GEM, second GEM, third GEM
my @radius  = (3.0, 20.0,   30.0,  70.0,  73.0,  76.0); # mm
my @thickness = (0.055, 0.006, 0.004); # mm, GEM thicknesses are defined below

my $z_half = 200.0;

# Target, Ground foil, Cathod foil (al layer neglected)
my @layer_mater = ('G4_KAPTON', 'G4_MYLAR', 'G4_MYLAR');
my @layer_color = ('330099', 'aaaaff', 'aaaaff');

my @gem_thick = (0.005, 0.05, 0.005); # 5um, 50um, 5um
my @gem_mater = ( 'G4_Cu', 'G4_KAPTON', 'G4_Cu');
my @gem_color = ('661122',  '330099', '661122');

my @pcb_layer_color = ('aaafff');

# mother volume
sub make_rtpc
{
	my %detector = init_det();
	$detector{"name"}        = "rtpc";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Radial Time Projecion Chamber";
	$detector{"color"}       = "eeeegg";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm 82.5*mm 210.0*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_He";
	$detector{"visible"}     = 0;
	print_det(\%configuration, \%detector);
}


sub make_target
{
        my $rmin = 0.;
	my $rmax  = $radius[0];
        my $phistart = 0;
	my $pspan = 360;
	my $mate  = "DeuteriumTargetGas";
	my %detector = init_det();

	$detector{"name"} = "DeuteriumTarget";
	$detector{"mother"}      = "rtpc";
	$detector{"description"} = "7 atm deuterium target gas";
	$detector{"color"}       = "egegege";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_half*mm $phistart*deg $pspan*deg";
	$detector{"material"}    = $mate;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

}


sub make_layers
{
	my $layer = shift;
	
	my $rmin  = 0;
	my $rmax  = 0;
        my $phistart = 0;
	my $pspan = 360;
	my $mate  = "G4_He";
	my %detector = init_det();
	
	# target wall $layer==0
        # ground foil $layer==1
        # cathode $layer==2
	$rmin  = $radius[$layer];
	$rmax  = $rmin + $thickness[$layer];
	$mate  = $layer_mater[$layer];		
	
	$detector{"name"} = "layer_".$layer;
	$detector{"mother"}      =  "rtpc";
	$detector{"description"} = "Layer ".$layer;
	$detector{"color"}       = $layer_color[$layer];
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_half*mm $phistart*deg $pspan*deg";
	$detector{"material"}    = $mate;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


# three gem
sub make_gems
{
        my $gemN = shift;
	my $layer = shift;
	
	my $rmin  = 0;
	my $rmax  = 0;
	my $pspan = 360;
	my $color = "000000";
	my $mate  = "Air";
	my $phistart = 0;
	my %detector = init_det();
	
	$rmin  = $radius[3+$gemN];
        for(my $l = $layer-1; $l > -1; $l--){
	  $rmin +=  $gem_thick[$layer];
        } 
	$rmax  = $rmin + $gem_thick[$layer];
	$color = $gem_color[$layer];
	$mate  = $gem_mater[$layer];
		
	
	$detector{"name"} = "gem_".$gemN."_layer_".$layer;	
	$detector{"mother"}      = "rtpc";
	$detector{"description"} = "gem_".$gemN."_layer_".$layer;
	$detector{"color"}       = $color;
	$detector{"type"}        = "Tube";
	$detector{"style"}       = 1;	
	$detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_half*mm $phistart*deg $pspan*deg";
	$detector{"material"}    = $mate;
	print_det(\%configuration, \%detector);
	
}


# Buffer volume between target and ground foil (20mm)
sub make_buffer_volume
{
	my $rmin  = $radius[0] + $thickness[0];
	my $rmax  = $radius[1];
	my $phistart = 0;
	my $pspan = 360;
	my %detector = init_det();
	my $mate  = "G4_He";	

	$detector{"name"} = "buffer_layer";	
	$detector{"mother"}      = "rtpc";
	$detector{"description"} = "Buffer volume";
	$detector{"color"}       = "ff88994";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_half*mm $phistart*deg $pspan*deg";
	$detector{"material"}    = $mate;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


# Buffer volume between target and ground foil (20mm)
sub make_buffer2_volume
{
	my $rmin  = $radius[1] + $thickness[1];
	my $rmax  = $radius[2];
	my $phistart = 0;
	my $pspan = 360;
	my %detector = init_det();
	my $mate  = "BONuSGas";	

	$detector{"name"} = "buffer2_layer";	
	$detector{"mother"}      = "rtpc";
	$detector{"description"} = "Buffer volume";
	$detector{"color"}       = "ff88994";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_half*mm $phistart*deg $pspan*deg";
	$detector{"material"}    = $mate;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}



sub make_drift_volume
{	
	my $rmin  = $radius[2] + $thickness[2];
	my $rmax  = $radius[3];
	my $pspan = 360.;	
	my $phistart = 0;
	my %detector = init_det();

	$detector{"name"} = "sensitive_drift_volume";	
	$detector{"mother"}      = "rtpc";
	$detector{"description"} = "Sensitive drift volume";
	$detector{"color"}       = "ff88994";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_half*mm $phistart*deg $pspan*deg";
	$detector{"material"}    = "BONuSGas";
	$detector{"style"}       = 1;
	$detector{"sensitivity"}  = "rtpc"; ## HitProcess definition
	$detector{"hit_type"}     = "rtpc"; ## HitProcess definition
	print_det(\%configuration, \%detector);
}






# electronics readout layer, external radius is random but it does not matter so far
sub make_electronics_layer
{
	my $rmin  = 80;
	my $rmax  = 82.5;
	my $phistart = 0;
	my $pspan = 360;
	my %detector = init_det();
	my $mate  = "PCB";
	
	$detector{"name"} = "pcb_layer";	
	
	$detector{"mother"}      = "rtpc";
	$detector{"description"} = "PCB layer";
	$detector{"color"}       = $pcb_layer_color[0];
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_half*mm $phistart*deg $pspan*deg";
	$detector{"material"}    = $mate;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}



make_rtpc();

make_target();

for(my $l = 0; $l < 3; $l++)
{
	make_layers($l);
}

make_buffer_volume();
make_buffer2_volume();
make_drift_volume();

for(my $gem = 0; $gem < 3; $gem++)
{
  for(my $l = 0; $l < 3; $l++)
  {
     make_gems($gem,$l);
  }
}


make_electronics_layer();







