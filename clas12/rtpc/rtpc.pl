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
my $z_half = 200.0;
my @zhalf = ($z_half + 23.0, $z_half, $z_half);
my $gap = 0.001;

#  Target, Ground foil, Cathod foil
my @radius  = (3.0, 20.0, 30.0); # mm
my @thickness = (0.055, 0.006, 0.004); # mm (i.e. 55 um, 6 um, 4 um)

# Target, Ground foil, Cathod foil (al layer neglected)
my @layer_mater = ('G4_KAPTON', 'G4_MYLAR', 'G4_MYLAR');
my @layer_color = ('330099', 'aaaaff', 'aaaaff');

# GEM Layer parameters
my @gem_radius = (70.0, 73.0, 76.0); # mm
my @gem_thick = (0.005, 0.05, 0.005); # 5um, 50um, 5um
my @gem_mater = ( 'G4_Cu', 'G4_KAPTON', 'G4_Cu');
my @gem_color = ('661122',  '330099', '661122');

# Readout pad parameters
my $pad_layer_radius = 80.0; # mm
my @pad_layer_color = ('aaafff');
my $pad_layer_thick = 0.2794; # 11 mils  = 0.2794 mm

# Electronics/Ribs/Spines (ERS) Layer
my $ers_layer_radius = $gap + $pad_layer_radius + $pad_layer_thick; # mm
my $ers_layer_thick = 5.0; # mm
my @ers_layer_color = ('ffd56f');

# protection circuits
my $prot_radius = $gap + $ers_layer_radius + $ers_layer_thick; # mm
my $prot_length = 35.5; # mm
my $prot_thick = 0.5; # mm        <===- NEEDS TO BE CHANGED/VERIFIED
my @prot_color = ('000000');

# Translation board parameters
my $Tboard_radius = $gap + $ers_layer_radius + $ers_layer_thick; # mm
my $Tboard_length = 106.8; # mm
my $Tboard_thick = 0.279; # mm (11 mils)
my @Tboard_color = ('ace4d2');

# Downstream end-plate assembly parameters
# layer
# 1 Target support block 1
# 2 Target support block 2
# 3 Cathode assembly inner ring
# 4 Cathode assembly outer ring
# 5 Field cage
# 6 Field cage spacer
# 7 GEM Rings
# 8 DS plate
# 9 DS plate inner ring
# 10 DS plate outer ring
my @dsep_rmin = (16.764,    3.0555, 20.07,  30.06,  32.01,  36.80,  67.10,  32.01,  32.01,  76.0); # mm
my @dsep_rmax = (20.06,     25.44,  30.05,  32.0,   67.09,  40.00,  75.90,  84.0,   33.0,   78.0); # mm
my @dsep_thick = (9.63,     3.05,   16.0,   16.0,   1.0,    7.21,   4.0,    2.00,   1.0,    2.0); # mm
my @dsep_zloc = (16.0-$dsep_thick[0]/2.0,
                16.0+$dsep_thick[1]/2.0+$gap,
                $dsep_thick[2]/2.0+$gap,
                $dsep_thick[3]/2.0+$gap,
                $dsep_thick[4]/2.0+$gap,
                $dsep_thick[4]+$dsep_thick[5]/2.0+$gap,
                $dsep_thick[6]/2.0+$gap,
                6.0 + $dsep_thick[7]/2.0+$dsep_thick[9]+$gap,
                6.0 + $dsep_thick[7]+$dsep_thick[9]+$dsep_thick[8]/2.0+$gap,
                6.0 + $dsep_thick[9]/2.0+$gap); # mm
my @dsep_color = ('fff933', 'fff933', 'ff3349', '808080', '078542', 'fff933', '808080', "99ff33", "99ff33", "99ff33");
my @dsep_mat = ('Rohacell', 'Rohacell', 'Rohacell', 'Ultem', 'G10', 'Rohacell', 'Ultem', 'G10', 'G10', 'G10');

# Upstream end-plate
my @usep_radius = (3.056, 84.0); # mm
my $usep_thick = 2.00; # mm
my $usep_zloc = -$zhalf[1]-$usep_thick/2.0-8.0; # mm
my @usep_color = ('99ff33');
my @usep_mat = ("G10");

# Snout
# layer
# 1 He from target end cap to wall
# 2 He from end cap to end of snout
# 3 Kapton wall

my $snout_endz = 824.2;
my @snout_rmin = (3.156, 0, 22.06); # mm
my @snout_rmax = (22.54, 22.54, 22.55); # mm
my @snout_thick = (2.11, $snout_endz-$zhalf[1] + $dsep_thick[2] + 2.11,$snout_endz-$zhalf[1] + $dsep_thick[2]); # mm
my @snout_zloc = ($zhalf[1] + $dsep_zloc[1] + $dsep_thick[1]/2.0 + $snout_thick[0]/2.0 + $gap,
                  $zhalf[1] + $dsep_zloc[1] + $dsep_thick[1]/2.0 + $snout_thick[1]/2.0 + $gap,
                  $zhalf[1] + $dsep_zloc[1] + $dsep_thick[1]/2.0 + $snout_thick[2]/2.0 + $gap); # mm
my @snout_color = ('ffffff', 'ffffff', 'fb06ff');
my @snout_mat = ("G4_He", "G4_He", "G4_KAPTON");



# mother volume
sub make_rtpc
{
	my %detector = init_det();
	$detector{"name"}        = "rtpc";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Radial Time Projecion Chamber";
	$detector{"color"}       = "eeeegg";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm 190.0*mm 255.0*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_He";
	$detector{"visible"}     = 0;
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
    my $z_lay = $zhalf[$layer];
    
	$detector{"name"} = "layer_".$layer;
	$detector{"mother"}      =  "rtpc";
	$detector{"description"} = "Layer ".$layer;
	$detector{"color"}       = $layer_color[$layer];
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_lay*mm $phistart*deg $pspan*deg";
	$detector{"material"}    = $mate;
	$detector{"style"}       = 1;
    #$detector{"sensitivity"}  = "rtpc"; ## HitProcess definition
    #$detector{"hit_type"}     = "rtpc"; ## HitProcess definition
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
    my $mate  = "BONuSGas";
    
    $detector{"name"} = "buffer_layer";
    $detector{"mother"}      = "rtpc";
    $detector{"description"} = "Buffer volume";
    $detector{"color"}       = "f0f8ff";
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_half*mm $phistart*deg $pspan*deg";
    $detector{"material"}    = $mate;
    $detector{"style"}       = 1;
    #$detector{"sensitivity"}  = "rtpc"; ## HitProcess definition
    #$detector{"hit_type"}     = "rtpc"; ## HitProcess definition
    print_det(\%configuration, \%detector);
}


# Buffer volume between ground foil and cathode (30mm)
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
    $detector{"color"}       = "e0ffff";
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_half*mm $phistart*deg $pspan*deg";
    $detector{"material"}    = $mate;
    $detector{"style"}       = 1;
    #$detector{"sensitivity"}  = "rtpc"; ## HitProcess definition
    #$detector{"hit_type"}     = "rtpc"; ## HitProcess definition
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
	
	$rmin  = $gem_radius[$gemN];
    
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
    #$detector{"sensitivity"}  = "rtpc"; ## HitProcess definition
    #$detector{"hit_type"}     = "rtpc"; ## HitProcess definition
	$detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_half*mm $phistart*deg $pspan*deg";
	$detector{"material"}    = $mate;
	print_det(\%configuration, \%detector);
	
}

# make drift volume from cathode to first GEM (30-70 mm)
sub make_drift_volume
{	
	my $rmin  = $radius[2] + $thickness[2];
	my $rmax  = $gem_radius[0] - $gap;
	my $pspan = 360.;	
	my $phistart = 0;
	my %detector = init_det();
	my $mate  = "BONuSGas";

	$detector{"name"} = "sensitive_drift_volume";	
	$detector{"mother"}      = "rtpc";
	$detector{"description"} = "Sensitive drift volume";
	$detector{"color"}       = "ff88994";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_half*mm $phistart*deg $pspan*deg";
	$detector{"material"}    = $mate;
	$detector{"style"}       = 1;
    $detector{"sensitivity"}  = "rtpc"; ## HitProcess definition
    $detector{"hit_type"}     = "rtpc"; ## HitProcess definition
	print_det(\%configuration, \%detector);
}

# readout pad layer
sub make_readout_layer
{
	my $rmin  = $pad_layer_radius;
	my $rmax  = $pad_layer_radius+$pad_layer_thick;
	my $phistart = 0;
	my $pspan = 360;
    my $zmax_half = $z_half+8.0;
	my %detector = init_det();
	my $mate  = "PCB";
	
	$detector{"name"} = "pad_layer";
	
	$detector{"mother"}      = "rtpc";
	$detector{"description"} = "Readout pad layer";
	$detector{"color"}       = $pad_layer_color[0];
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$rmin*mm $rmax*mm $zmax_half*mm $phistart*deg $pspan*deg";
	$detector{"material"}    = $mate;
	$detector{"style"}       = 1;
    #$detector{"sensitivity"}  = "rtpc"; ## HitProcess definition
    #$detector{"hit_type"}     = "rtpc"; ## HitProcess definition
	print_det(\%configuration, \%detector);
}

# ERS layer - meant to simulate a smearing of material
# from readout pads to translation boards
sub make_ers_layer
{
    my $rmin  = $ers_layer_radius;
    my $rmax  = $ers_layer_radius+$ers_layer_thick;
    my $phistart = 0;
    my $pspan = 360;
    my %detector = init_det();
    my $mate  = "ERS";
    
    $detector{"name"} = "ers_layer";
    
    $detector{"mother"}      = "rtpc";
    $detector{"description"} = "Electronics/Ribs/Spine layer";
    $detector{"color"}       = $ers_layer_color[0];
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_half*mm $phistart*deg $pspan*deg";
    $detector{"material"}    = $mate;
    $detector{"style"}       = 1;
    #$detector{"sensitivity"}  = "rtpc"; ## HitProcess definition
    #$detector{"hit_type"}     = "rtpc"; ## HitProcess definition
    print_det(\%configuration, \%detector);
}

# translation boards
sub make_boards
{
    my $boardN = shift;
    
    my $rmin  = $Tboard_radius;
    my $rmax  = $Tboard_radius + $Tboard_length;
    my $pspan = ($Tboard_thick/(2*3.14*$Tboard_radius))*360;
    my $color = $Tboard_color[0];
    my $mate  = "PCB";
    my $phistart = $boardN*8;
    my %detector = init_det();
    
    $detector{"name"} = "board_".$boardN;
    $detector{"mother"}      = "rtpc";
    $detector{"description"} = "board_".$boardN;
    $detector{"color"}       = $color;
    $detector{"type"}        = "Tube";
    $detector{"style"}       = 1;
    $detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_half*mm $phistart*deg $pspan*deg";
    $detector{"material"}    = $mate;
    #$detector{"sensitivity"}  = "rtpc"; ## HitProcess definition
    #$detector{"hit_type"}     = "rtpc"; ## HitProcess definition
    print_det(\%configuration, \%detector);
}

# protection circuits on translation boards
sub make_protcircuit
{
    my $cirN = shift;
    
    my $rmin  = $prot_radius;
    my $rmax  = $prot_radius + $prot_length;
    my $pspan = ($prot_thick/(2*3.14*$prot_radius))*360;
    my $color = $prot_color[0];
    my $mate  = "protectionCircuit";
    my $phistart = ($Tboard_thick/(2*3.14*$Tboard_radius))*360 + $cirN*8;
    my %detector = init_det();
    
    $detector{"name"} = "cir_".$cirN;
    $detector{"mother"}      = "rtpc";
    $detector{"description"} = "cir_".$cirN;
    $detector{"color"}       = $color;
    $detector{"type"}        = "Tube";
    $detector{"style"}       = 1;
    $detector{"dimensions"}  = "$rmin*mm $rmax*mm $z_half*mm $phistart*deg $pspan*deg";
    $detector{"material"}    = $mate;
    #$detector{"sensitivity"}  = "rtpc"; ## HitProcess definition
    #$detector{"hit_type"}     = "rtpc"; ## HitProcess definition
    print_det(\%configuration, \%detector);
}

# Down Stream End Plates (DSEP)
sub make_dsep
{
    # layer
    # 1 Target support block
    # 2 Cathode assembly inner ring
    # 3 DS plate
    
    my $dsepL = shift;
    
    my $dsep_zpos = $zhalf[1] + $dsep_zloc[$dsepL] + $gap;
    my $rmin  = $dsep_rmin[$dsepL];
    my $rmax  = $dsep_rmax[$dsepL];
    my $phistart = 0;
    my $pspan = 360;
    my %detector = init_det();
    my $mate  = $dsep_mat[$dsepL];
    my $dsepThick = $dsep_thick[$dsepL]/2.0;
    my $dsepColor = $dsep_color[$dsepL];
    
    $detector{"name"} = "dsep_".$dsepL;
    
    $detector{"mother"}      = "rtpc";
    $detector{"description"} = "Down Stream End Plate Layer ".$dsepL;
    $detector{"color"}       = $dsepColor;
    $detector{"type"}        = "Tube";
    $detector{"pos"}         = "0*mm 0*mm $dsep_zpos*mm";
    $detector{"dimensions"}  = "$rmin*mm $rmax*mm $dsepThick*mm $phistart*deg $pspan*deg";
    $detector{"material"}    = $mate;
    $detector{"style"}       = 1;
    #$detector{"sensitivity"}  = "rtpc"; ## HitProcess definition
    #$detector{"hit_type"}     = "rtpc"; ## HitProcess definition
    print_det(\%configuration, \%detector);
}

# Up Stream End-plate
sub make_usep
{
    my $usep_zpos = $usep_zloc + $gap;
    my $rmin  = $usep_radius[0];
    my $rmax  = $usep_radius[1];
    my $phistart = 0;
    my $pspan = 360;
    my %detector = init_det();
    my $mate  = $usep_mat[0];
    my $usepThick = $usep_thick/2.0;
    my $usepColor = $usep_color[0];
    
    $detector{"name"} = "usep";
    
    $detector{"mother"}      = "rtpc";
    $detector{"description"} = "Up Stream End Plate Layer";
    $detector{"color"}       = $usepColor;
    $detector{"type"}        = "Tube";
    $detector{"pos"}         = "0*mm 0*mm $usep_zpos*mm";
    $detector{"dimensions"}  = "$rmin*mm $rmax*mm $usepThick*mm $phistart*deg $pspan*deg";
    $detector{"material"}    = $mate;
    $detector{"style"}       = 1;
    #$detector{"sensitivity"}  = "rtpc"; ## HitProcess definition
    #$detector{"hit_type"}     = "rtpc"; ## HitProcess definition
    print_det(\%configuration, \%detector);
}

# RTPC to FT Snout
sub make_snout
{
    # 1 = Helium around target end cap
    # 2 = Helium from end cap to snout end
    # 3 = Snout wall
    
    my $snoutN = shift;
    
    my $snout_zpos = $snout_zloc[$snoutN];
    my $rmin  = $snout_rmin[$snoutN];
    my $rmax  = $snout_rmax[$snoutN];
    my $phistart = 0;
    my $pspan = 360;
    my %detector = init_det();
    my $mate  = $snout_mat[$snoutN];
    my $snoutThick = $snout_thick[$snoutN]/2.0;
    my $snoutColor = $snout_color[$snoutN];
    
    $detector{"name"} = "snout_".$snoutN;
    
    $detector{"mother"}      = "rtpc";
    $detector{"description"} = "RTPC to FT buffer volume ".$snoutN;
    $detector{"color"}       = $snoutColor;
    $detector{"type"}        = "Tube";
    $detector{"pos"}         = "0*mm 0*mm $snout_zpos*mm";
    $detector{"dimensions"}  = "$rmin*mm $rmax*mm $snoutThick*mm $phistart*deg $pspan*deg";
    $detector{"material"}    = $mate;
    $detector{"style"}       = 1;
    #$detector{"sensitivity"}  = "rtpc"; ## HitProcess definition
    #$detector{"hit_type"}     = "rtpc"; ## HitProcess definition
    print_det(\%configuration, \%detector);
}


make_rtpc();


for(my $l = 1; $l < 3; $l++)
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

make_readout_layer();

make_ers_layer();

for(my $board = 0; $board < 45; $board++){
    make_boards($board);
}

for(my $circuit = 0; $circuit < 45; $circuit++){
    make_protcircuit($circuit);
}

for(my $dsep_layer = 0; $dsep_layer < 10; $dsep_layer++){
    make_dsep($dsep_layer);
}

make_usep();

for(my $ftb_layer = 0; $ftb_layer < 3; $ftb_layer++){
    make_snout($ftb_layer);
}

