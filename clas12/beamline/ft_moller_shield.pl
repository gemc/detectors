use strict;
use warnings;

our %configuration;

our $TorusZpos;
our $SteelFrameLength;



###########################################################################################
# Define the relevant parameters for the moller shield in the configguration with FT
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
# Tungsten Cone
my $nplanes_cone = 4;
my @zplane_cone   = (  750.0, 1750.0, 1750.0, 1809.2);
my @oradius_cone  = (   32.0,   76.0,   59.0,   59.0);
my @iradius_cone  = (   30.0,   30.0,   30.0,   30.0);


# Aluminum Beam Pipe
my $al_tube_TN=1.0;
my $al_tube_IR=25.4;
my $al_tube_OR=$al_tube_IR+$al_tube_TN;
my $al_tube_LT=($zplane_cone[3]-($zplane_cone[0]+300.))/2.;
my $al_tube_Z =($zplane_cone[3]+($zplane_cone[0]+300.))/2.;

# Aluminum Beam Pipe Window
my $al_window_TN=0.05;
my $al_window_OR=$al_tube_OR;
my $al_window_Z =$al_tube_Z-$al_tube_LT-$al_window_TN;

# HTCC Moller Cup
my $nplanes_cup = 4;
my @zplane_cup   = (350.0, 1318.4, 1415.2, 1724.1);
my @oradius_cup  = ( 30.0,  114.8,  114.8,  139.0);
my @iradius_cup  = ( 29.0,  113.8,  113.8,  138.0);


# Mother Volume
my $nplanes_mv  = $nplanes_cone;
my @zplane_mv   = ( $zplane_cone[0],  $zplane_cone[1],  $zplane_cone[2],  $zplane_cone[3]);
my @oradius_mv  = ($oradius_cone[0], $oradius_cone[1], $oradius_cone[2], $oradius_cone[3]);
my @iradius_mv  = (            0.0,             0.0,             0.0,             0.0);



sub make_moller_cone_ft
{

#############################
# Mother Volume
#############################
	my %detector = init_det();
	$detector{"name"}        = "ft_shield";
	$detector{"mother"}      = "root";
	$detector{"description"} = "ft shield mother volume";
	$detector{"color"}       = "F88017";
	$detector{"type"}        = "Polycone";
	my $dimen = "0.0*deg 360*deg $nplanes_mv*counts";
	for(my $i = 0; $i <$nplanes_mv ; $i++)
	{
		$dimen = $dimen ." $iradius_mv[$i]*mm";
	}
	for(my $i = 0; $i <$nplanes_mv ; $i++)
	{
		$dimen = $dimen ." $oradius_mv[$i]*mm";
	}
	for(my $i = 0; $i <$nplanes_cone ; $i++)
	{
		$dimen = $dimen ." $zplane_mv[$i]*mm";
	}
	$detector{"dimensions"} = $dimen;
	$detector{"material"}   = "G4_AIR";
	$detector{"style"}       = 1;
	
	print_det(\%configuration, \%detector);


#############################
# Tungsten Cone
#############################
	%detector = init_det();
	$detector{"name"}        = "ft_moller_cone";
	$detector{"mother"}      = "ft_shield";
	$detector{"description"} = "ft tungsten cone";
	$detector{"color"}       = "F88017";
	$detector{"type"}        = "Polycone";
	$dimen = "0.0*deg 360*deg $nplanes_cone*counts";
	for(my $i = 0; $i <$nplanes_cone ; $i++)
	{
		$dimen = $dimen ." $iradius_cone[$i]*mm";
	}
	for(my $i = 0; $i <$nplanes_cone ; $i++)
	{
		$dimen = $dimen ." $oradius_cone[$i]*mm";
	}
	for(my $i = 0; $i <$nplanes_cone ; $i++)
	{
		$dimen = $dimen ." $zplane_cone[$i]*mm";
	}
	$detector{"dimensions"} = $dimen;
	$detector{"material"}   = "beamline_W";
	$detector{"style"}       = 1;
	
	print_det(\%configuration, \%detector);


#############################
#       Aluminum Tube
#############################
	%detector = init_det();
	$detector{"name"}        = "ft_al_tube";
	$detector{"mother"}      = "ft_shield";
	$detector{"description"} = "ft aluminum beam pipe";
	$detector{"pos"}         = "0*mm 0.0*mm $al_tube_Z*mm";
	$detector{"color"}       = "F2F2F2";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$al_tube_IR*mm $al_tube_OR*mm $al_tube_LT*mm 0.*deg 360.*deg";
	$detector{"material"}    = "G4_Al";	
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);


#############################
# Aluminum Window
#############################
	%detector = init_det();
	$detector{"name"}        = "ft_al_window";
	$detector{"mother"}      = "ft_shield";
	$detector{"description"} = "ft aluminum beam pipe window";
	$detector{"pos"}         = "0*mm 0.0*mm $al_window_Z*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "F2F2F2";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0.0*mm $al_window_OR*mm $al_window_TN*mm 0.*deg 360.*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);


#############################
# Vacuum inside the cone
#############################
	%detector = init_det();
	$detector{"name"}        = "ft_albpipe_vacuum";
	$detector{"mother"}      = "ft_shield";
	$detector{"description"} = "ft aluminum beam pipe vacuum";
	$detector{"pos"}         = "0*mm 0.0*mm $al_tube_Z*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "ffffff";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0.0*mm $al_tube_IR*mm $al_tube_LT*mm 0.*deg 360.*deg";
	$detector{"material"}    = "G4_Galactic";
	$detector{"visible"}     = 0;
	print_det(\%configuration, \%detector);

}