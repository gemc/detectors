use strict;
use warnings;

our %configuration;

our $TorusZpos;
our $SteelFrameLength;


###########################################################################################
# Define the relevant parameters for the moller shield in the configguration without FT
#
# the moller shield geometry will be defined starting from these parameters 
# and the position on the torus inner ring
#
# all dimensions are in mm
#
# the geometry parameters are divided in 2 groups:
#     pipe between the torus and the cone
#     Moller Cone and Vacuum Inside

#my $torus_z   = 2663.; # position of the front face of the Torus ring (set the limit in z)
my $torus_z   = $TorusZpos - $SteelFrameLength; # position of the front face of the Torus ring (set the limit in z)





###########################################################################################
# Define the tube between moller cone and Torus Inner Ring

my $ATube_IR         =  30.0;
my $ATube_OR         =  41.0;

my $TTube_OR         =  60.0;
my $FTube_OR         =  80.0;
my $FTube_FR         =  90.0;


my $Tube_LT         = 365.6;
my $flange_TN       =  15.0;

# define positions based on z of torus inner ring front face
my $Tube_end  = $torus_z-0.5;    # leave 0.5 mm to avoid overlaps
my $Tube_z1   = $Tube_end - $flange_TN;

my $Tube_z2   = $Tube_z1 - $Tube_LT;

my $Tube_beg  = $Tube_z2 - $flange_TN;


my $Tube_Z    =($Tube_end+$Tube_beg)/2.;
my $Tube_LZ   =($Tube_end-$Tube_beg)/2.;

my $nplanes_Tube = 6;
my @z_plane_Tube = ( $Tube_beg,  $Tube_z2,  $Tube_z2,  $Tube_z1,  $Tube_z1, $Tube_end);
my @oradius_Tube = ( $FTube_FR, $FTube_FR, $FTube_OR, $FTube_OR, $FTube_FR, $FTube_FR);

###########################################################################################
# Moller Cone and Vacuum Inside
my $oz_Cone = 122.4;
my $otheta_Cone = 2.*acos(-1.)/180.;
my $otantheta  = (int tan($otheta_Cone)*10000.)/10000;
#my $iz_cone = 18.2;
my $iz_Cone = 18.2-500.;
my $itheta_Cone = 0.75*acos(-1.)/180.;
my $itantheta  = (int tan($itheta_Cone)*10000.)/10000;

my $nplanes_Cone = 3;
my @z_plane_Cone    = ( 420.0,    1390.0, $Tube_beg-0.1 );
my @oradius_Cone_T  = (  30.0, $FTube_FR,      $FTube_FR);
my @oradius_Cone_A  = (  24.0, $ATube_OR,      $ATube_OR);
my @oradius_Cone_V  = (  23.0, $ATube_IR,      $ATube_IR); 




sub make_tube
{
# Stainless Steel Tube with Flanges
	my %detector = init_det();
	$detector{"name"}        = "moller_shield_tube";
	$detector{"mother"}      = "root";
	$detector{"description"} = "flanged tube from moller cone to torus";
	$detector{"color"}       = "ff8883";
	$detector{"type"}        = "Polycone";
	my $dimen = "0.0*deg 360*deg $nplanes_Tube*counts";
	for(my $i = 0; $i <$nplanes_Tube; $i++) {$dimen = $dimen ." 0.0*mm";}
	for(my $i = 0; $i <$nplanes_Tube; $i++) {$dimen = $dimen ." $oradius_Tube[$i]*mm";}
	for(my $i = 0; $i <$nplanes_Tube; $i++) {$dimen = $dimen ." $z_plane_Tube[$i]*mm";}
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# Tungsten Tube
	%detector = init_det();
	$detector{"name"}        = "moller_shield_tube_w";
	$detector{"mother"}      = "moller_shield_tube";
	$detector{"description"} = "tungsten tube from moller cone to torus";
	$detector{"color"}       = "ffff9b";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0.0*cm 0.0*cm $Tube_Z*mm";
	$detector{"dimensions"}  = "0.0*mm $TTube_OR*mm $Tube_LZ*mm 0.*deg 360.*deg";
	$detector{"material"}    = "beamline_W";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
# Aluminum Tube 
	%detector = init_det();
	$detector{"name"}        = "moller_shield_tube_a";
	$detector{"mother"}      = "moller_shield_tube_w";
	$detector{"description"} = "aluminum tube from moller cone to torus";
	$detector{"color"}       = "ffffff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0.0*cm 0.0*cm 0.0*mm";
	$detector{"dimensions"}  = "0.0*mm $ATube_OR*mm $Tube_LZ*mm 0.*deg 360.*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

# Vacuum Tube 
	%detector = init_det();
	$detector{"name"}        = "moller_shield_tube_v";
	$detector{"mother"}      = "moller_shield_tube_a";
	$detector{"description"} = "vacumm tube from moller cone to torus";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0.0*cm 0.0*cm 0.0*mm";
	$detector{"dimensions"}  = "0.0*mm $ATube_IR*mm $Tube_LZ*mm 0.*deg 360.*deg";
	$detector{"material"}    = "G4_Galactic";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}




