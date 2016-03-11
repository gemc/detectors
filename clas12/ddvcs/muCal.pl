use strict;
use warnings;

our %configuration;




###########################################################################################
###########################################################################################
# Define the relevant parameters of FT Geometry
#
# the FT geometry will be defined starting from these parameters
# and the position on the torus inner ring
#
# all dimensions are in mm
#
# the geometry parameters are divided in 4 groups:
#     beamline and shield
#     calorimeter
#     hodoscope
#     tracker

my $degrad    = 57.27;
my $torus_z   = 2663.; # position of the front face of the Torus ring (set the limit in z)



###########################################################################################
# CALORIMETER
#
# Define the number, dimensions and position of the crystals
my $Nx = 22;                          # Number of crystals in horizontal directions
my $Ny = 22;                          # Number of crystals in horizontal directions
my $Cfront  =  1897.8;                # Position of the front face of the crystals
my $Cwidth  =    15.0;                # Crystal width in mm (side of the squared front face)
my $Clength =   200.0;                # Crystal length in mm
my $VM2000  =   0.130;                # Thickness of the VM2000 wrapping
my $AGap    =   0.170;                # Air Gap between Crystals, total wodth of crystal including wrapping and air gap is 15.3 mm
my $Flength =     8.0;                # Length of the crystal front support
my $Fwidth  = $Cwidth;                # Width of the crystal front support
my $Wwidth  = $Cwidth+$VM2000;        # Width of the wrapping volume
my $Vwidth  = $Cwidth+$VM2000+$AGap;  # Width of the crystal mother volume, total width of crystal including wrapping and air gap is 15.3 mm
my $Vlength = $Clength+$Flength;      # Length of the crystal mother volume
my $Vfront  = $Cfront-$Flength;       # z position of the volume front face
my $Slength =     7.0;                # Length of the sensor "box"
my $Swidth  = $Cwidth;                # Width of the sensor "box"
my $Sgap    =     1.0;                # Gap for flux detector
my $Sfront  = $Vfront+$Vlength+$Sgap; # z position of the sensor front face

# Define the copper thermal shield parameters
# back disk
my $Bdisk_TN = 4.;                                           # half thickness of the copper back disk
my $Bdisk_IR = 55.;                                          # inner radius of the copper back disk
my $Bdisk_OR = 178.5;                                        # outer radius of the copper back disk
my $Bdisk_Z  = $Sfront+$Slength+$Bdisk_TN+0.1;               # z position of the copper back disk
# front disk
my $Fdisk_TN = 1.;                                           # half thickness of the copper front disk supporting the crystal assemblies
my $Fdisk_IR = $Bdisk_IR;                                    # inner radius of the copper front disk
my $Fdisk_OR = $Bdisk_OR;                                    # outer radius of the copper front disk
my $Fdisk_Z  = $Vfront-$Fdisk_TN-0.1;                        # z position of the copper front disk
# space for preamps
my $BPlate_TN = 25.;                                         # half thickness of the preamps volume
my $BPlate_IR = $Bdisk_IR;                                   # inner radius of the preamps volume
my $BPlate_OR = $Bdisk_OR;                                   # outer radius of the preamps volume
my $BPlate_Z  = $Bdisk_Z+$Bdisk_TN+$BPlate_TN+0.1;           # z position of the preamps volume
# inner copper tube
my $Idisk_LT = ($BPlate_Z+$BPlate_TN-$Fdisk_Z+$Fdisk_TN)/2.; # length of the inner copper tube
my $Idisk_TN = 4;                                            # thickness of the inner copper tube
my $Idisk_OR = $Fdisk_IR;                                    # outer radius of the inner copper tube matches inner radius of front and back disks
my $Idisk_IR = $Fdisk_IR-$Idisk_TN;                          # inner radius of the inner copper tube
my $Idisk_Z  = ($BPlate_Z+$BPlate_TN+$Fdisk_Z-$Fdisk_TN)/2.; # z position of inner copper tube
# outer copper tube
my $Odisk_LT = ($BPlate_Z+$BPlate_TN-$Fdisk_Z+$Fdisk_TN)/2.; # length of the outer copper tube
my $Odisk_TN = 2;                                            # thickness of the outer copper tube
my $Odisk_IR = $Fdisk_OR;                                    # inner radius of the outer copper tube matches outer radius of front and back disks
my $Odisk_OR = $Fdisk_OR+$Odisk_TN;                          # outer radius of the outer copper tube
my $Odisk_Z  = $Idisk_Z;                                     # z position of the outer copper tube

# Define the motherboard parameters
my $Bmtb_TN = 1.;                                            # half thickness of the motherboard
my $Bmtb_IR = $Idisk_IR;                                     # inner radius of the motherboard
my $Bmtb_OR = $Odisk_OR;                                     # outer radius of the motherboard
my $Bmtb_Z  = $BPlate_Z + $BPlate_TN + $Bmtb_TN + 0.1;       # z position of the motherboard
my $Bmtb_hear_WD = 80./2.;                                   # half width of the motherboard extensions
my $Bmtb_hear_LN = 225./2;                                   # half length of the motherboard extensions
my $Bmtb_hear_D0 = 0.;                                       # displacement of the motherboard extensions
my @Bmtb_angle = ( 30., 150., 210., 330.);                   # angles of the motherboard extensions

# Define LED plate geometry parameters
my $LED_TN =   6.1;                                          # half thickness of the pcb and pastic plate hosting the LEDs
my $LED_IR = $Fdisk_IR;                                      # inner radius of the pcb and pastic plate hosting the LEDs
my $LED_OR = $Fdisk_OR;                                      # outer radius of the pcb and pastic plate hosting the LEDs
my $LED_Z  = $Fdisk_Z - $Fdisk_TN - $LED_TN - 0.1;           # z position of the pcb and pastic plate hosting the LEDs

# bline: tungsten pipe inside the ft_cal
my $BLine_IR = 30.;                                          # pipe inner radius;
my $BLine_SR = 33.5;                                         # pipe inner radius in steel case;
my $BLine_DR = 25.1;                                         # shield inner radius in steel case;
my $BLine_TN = 10.;                                          # pipe thickness
my $BLine_FR = $BLine_IR + $BLine_TN;                        # radius in the front part, connecting to moller shield
my $BLine_OR = 100.;                                         # radius of the back flange
my $BLine_BG = 1644.7;                                       # z location of the beginning of the beamline (to be matched to moller shield)
my $BLine_ML = 1760.0;                                       # z location of the end of the Moller shield


# back tungsten cup
my $BCup_tang = 0.0962;                                      # tangent of 5.5 degrees
my $BCup_TN = 5.;                                            # thickness of the flat part of the cup
my $BCup_ZM = $Bmtb_Z+$Bmtb_TN+0.1+43.4;                     # z of the downstream face of the cup
my $BCup_Z1 = $Bmtb_Z+$Bmtb_TN+0.1+1;                        # z of the side close to the motherboard (downstream)
my $BCup_Z2 = $Bmtb_Z-$Bmtb_TN-0.1-1;                        # z of the side close to the motherboard (upstream)
my $BCup_ZE = $BCup_ZM+$BCup_TN;                             # z of the downstream face of the cup
my $BCup_ZB = $BCup_ZM-120. ;                                # z beginning of the conical part
my $BCup_IRM = 190. ;                                        # inner radius at the beginning of the cone
my $BCup_ORB = $BCup_ZB*$BCup_tang;                          # outer radius at the beginning of the cone
my $BCup_OR1 = $BCup_Z1*$BCup_tang;                          # outer radius close to the MTB
my $BCup_OR2 = $BCup_Z2*$BCup_tang;                          # outer radius close to the MTB
my $BCup_ORM = $BCup_ZM*$BCup_tang;                          # outer radius at the front face of the plate
my $BCup_ORE = $BCup_ZE*$BCup_tang;                          # outer radius at the back face of the plate
my $BCup_angle = int(atan($Bmtb_hear_WD/$Bmtb_OR)*$degrad*10)/10+0.5;
my @BCup_iangle = (30.+$BCup_angle, 150.+$BCup_angle, 210.+$BCup_angle, 330.+$BCup_angle);
my @BCup_dangle = ((90.-$BCup_iangle[0])*2., (180.-$BCup_iangle[1])*2., (90.-$BCup_iangle[0])*2.,(180.-$BCup_iangle[1])*2.);

my $TPlate_TN= 20.; # thickness of the tungsten plate on the back of the FT-Cal



###########################################################################################
# OUTER INSULATION
my $O_Ins_TN  = 15.-0.01;
my $O_Ins_Z1  = $Fdisk_Z - $Fdisk_TN - $LED_TN*2 - 10.8 - $O_Ins_TN;  #1849.6
my $O_Ins_Z2  = $O_Ins_Z1 + $O_Ins_TN;
my $O_Ins_Z3  = $BCup_ZB;
my $O_Ins_Z4  = $BCup_Z2;
my $O_Ins_Z5  = $BCup_Z1;
my $O_Ins_Z6  = $BCup_ZM;
my $O_Ins_Z7  = $BCup_ZE;
my $O_Ins_Z8  = $BCup_ZE + 0.01;
my $O_Ins_Z9  = $O_Ins_Z8 + $O_Ins_TN;
my $O_Ins_Z10 = $O_Ins_Z9;
my $O_Ins_Z11 = $O_Ins_Z10 + $TPlate_TN;


my $O_Ins_I1  = $BLine_IR + $BLine_TN + 0.01;
my $O_Ins_I2  = $O_Ins_Z2*$BCup_tang +0.01;
my $O_Ins_I3  = $O_Ins_Z3*$BCup_tang +0.01;
my $O_Ins_I4  = $O_Ins_Z4*$BCup_tang +0.01;
my $O_Ins_I5  = $O_Ins_Z5*$BCup_tang +0.01;
my $O_Ins_I6  = $O_Ins_Z6*$BCup_tang +0.01;
my $O_Ins_I7  = $O_Ins_Z7*$BCup_tang +0.01;
my $O_Ins_I8  = $O_Ins_Z8*$BCup_tang +0.01;
my $O_Ins_I9  = $O_Ins_I1;
my $O_Ins_I10 = $O_Ins_Z10*$BCup_tang +0.01;
my $O_Ins_I11 = $O_Ins_I10;

my $O_Ins_O1  = $O_Ins_Z1*$BCup_tang +0.01 + $O_Ins_TN;
my $O_Ins_O2  = $O_Ins_I2 + $O_Ins_TN;
my $O_Ins_O3  = $O_Ins_I3 + $O_Ins_TN;
my $O_Ins_O4  = $O_Ins_I4 + $O_Ins_TN;
my $O_Ins_O5  = $O_Ins_I5 + $O_Ins_TN;
my $O_Ins_O6  = $O_Ins_I6 + $O_Ins_TN;
my $O_Ins_O7  = $O_Ins_I7 + $O_Ins_TN;
my $O_Ins_O8  = $O_Ins_I8 + $O_Ins_TN;
my $O_Ins_O9  = $O_Ins_Z9*$BCup_tang +0.01 + $O_Ins_TN;
my $O_Ins_O10 = $O_Ins_I10 + $O_Ins_TN;
my $O_Ins_O11 = $O_Ins_I11 + $O_Ins_TN;

$O_Ins_I4 = $O_Ins_Z4*$BCup_tang +0.5;
$O_Ins_I5 = $O_Ins_Z5*$BCup_tang +0.5;

###########################################################################################
# INNER INSULATION
my $I_Ins_LT = ($BCup_ZE - $O_Ins_Z2 -0.1)/2.;
my $I_Ins_OR =  $Idisk_IR - 0.1;
my $I_Ins_IR =  $O_Ins_I1;
my $I_Ins_Z  = ($BCup_ZE + $O_Ins_Z2)/2.;

###########################################################################################
# OUTER SHELL
my $O_Shell_TN = 2.-0.01;
my $O_Shell_Z1 = $O_Ins_Z1-$O_Shell_TN-0.01;
my $O_Shell_Z2 = $O_Shell_Z1+$O_Shell_TN;
my $O_Shell_Z3 = $O_Ins_Z3;
my $O_Shell_Z4 = $BCup_Z2;
my $O_Shell_Z5 = $BCup_Z1;
my $O_Shell_Z6 = $O_Ins_Z6 ;
my $O_Shell_Z7 = $O_Ins_Z7 ;
my $O_Shell_Z8 = $O_Ins_Z8 ;
my $O_Shell_Z9 = $O_Ins_Z9 ;
my $O_Shell_Z10 = $O_Ins_Z10;
my $O_Shell_Z11 = $O_Ins_Z11 + 0.01;
my $O_Shell_Z12 = $O_Shell_Z11;
my $O_Shell_Z13 = $O_Shell_Z12 + $O_Shell_TN;

my $O_Shell_I1 = $O_Ins_I1;
my $O_Shell_I2 = $O_Shell_Z2*$BCup_tang + $O_Ins_TN + 0.01;
my $O_Shell_I3 = $O_Shell_Z3*$BCup_tang + $O_Ins_TN + 0.01;
my $O_Shell_I4 = $O_Shell_Z4*$BCup_tang + $O_Ins_TN + 0.01;
my $O_Shell_I5 = $O_Shell_Z5*$BCup_tang + $O_Ins_TN + 0.01;
my $O_Shell_I6 = $O_Shell_Z6*$BCup_tang + $O_Ins_TN + 0.01;
my $O_Shell_I7 = $O_Shell_Z7*$BCup_tang + $O_Ins_TN + 0.01;
my $O_Shell_I8 = $O_Shell_Z8*$BCup_tang + $O_Ins_TN + 0.01;
my $O_Shell_I9 = $O_Shell_Z9*$BCup_tang + $O_Ins_TN + 0.01;
my $O_Shell_I10 = $O_Shell_Z10*$BCup_tang + $O_Ins_TN + 0.01;
my $O_Shell_I11 = $O_Shell_Z11*$BCup_tang + $O_Ins_TN + 0.01;
my $O_Shell_I12 = $O_Shell_I11 - $O_Ins_TN -5.;
my $O_Shell_I13 = $O_Shell_I12;

my $O_Shell_O1 = $O_Shell_Z1*$BCup_tang + $O_Ins_TN + 0.01 + $O_Shell_TN;
my $O_Shell_O2 = $O_Shell_I2 + $O_Shell_TN;
my $O_Shell_O3 = $O_Shell_I3 + $O_Shell_TN;
my $O_Shell_O4 = $O_Shell_I4 + $O_Shell_TN;
my $O_Shell_O5 = $O_Shell_I5 + $O_Shell_TN;
my $O_Shell_O6 = $O_Shell_I6 + $O_Shell_TN;
my $O_Shell_O7 = $O_Shell_I7 + $O_Shell_TN;
my $O_Shell_O8 = $O_Shell_I8 + $O_Shell_TN;
my $O_Shell_O9 = $O_Shell_I9 + $O_Shell_TN;
my $O_Shell_O10 = $O_Shell_I10 + $O_Shell_TN;
my $O_Shell_O11 = $O_Shell_I11 + $O_Shell_TN;
my $O_Shell_O12 = $O_Shell_O11;
my $O_Shell_O13 = $O_Shell_O12;

$O_Shell_I4 = $O_Shell_Z4*$BCup_tang + $O_Ins_TN + 0.7;
$O_Shell_I5 = $O_Shell_Z5*$BCup_tang + $O_Ins_TN + 0.7;

###########################################################################################
# FT BEAMLINE COMPONENTS

# ft to torus pipe
my $Tube_OR         =  75.0;
my $back_flange_OR  = 126.0;
my $front_flange_OR = 148.0;
my $flange_TN       =  15.0;


my $TPlate_Z1  = $O_Ins_Z9 + 0.01;
my $TPlate_Z2  = $TPlate_Z1 + $TPlate_TN-0.01;

my $BLine_MR  = $BLine_IR + $BLine_TN;    # outer radius in the calorimeter section
my $BLine_Z1  = $BLine_BG;
my $BLine_Z2  = $BLine_ML   + 0.2;
my $BLine_Z3  = $O_Shell_Z1 - 0.01;
my $BLine_Z4  = $TPlate_Z2  + 0.01;
my $BLine_Z5  = $BLine_Z4   - 0.01 + 20;


###########################################################################################
# Hodoscope Dimension and Parameters
my $VETO_TN = 38./2.; # thickness of the hodoscope volume
my $VETO_OR = 178.5;  # outer radius
my $VETO_IR = 40.;    # inner radius
my $VETO_Z  = $O_Shell_Z1 - $VETO_TN - 0.1; # position along z

my $VETO_RING_IR = $VETO_IR;
my $VETO_RING_OR = 105/2.;

my $LS_TN=5./2.;

my $p15_WW=15./2.;
my $p15_WT=10./2.;
#
my $p30_WW=30./2.;
my $p30_WT=$p15_WT;
#
my $p15_SW=$p15_WW-0.1;
my $p15_ST=$p15_WT-0.1;
#
my $p30_SW=$p30_WW-0.1;
my $p30_ST=$p30_WT-0.1;
#
my $p15_N = 11;
my @p15_X = (  7.5,  22.5,  37.5,  52.5,  52.5,  67.5,  67.5,  67.5,  67.5,  97.5, 127.5);
my @p15_Y = ( 67.5,  67.5,  67.5,  52.5,  67.5,   7.5,  22.5,  37.5,  52.5, 127.5,  97.5);
#
my $p30_N = 18;
my @p30_X = (  15.,  15.,  15.,  45.,  45.,  45.,  75.,  75.,  75.,  90.,  90., 105., 105., 120., 120., 135., 150., 150.);
my @p30_Y = (  90., 120., 150.,  90., 120., 150.,  75., 105., 135.,  15.,  45.,  75., 105.,  15.,  45.,  75.,  15.,  45.);
my @q_X = (1., -1., -1.,  1.);
my @q_Y = (1.,  1., -1., -1.);


###########################################################################################
# Tracker Dimension and Parameters

# Tracker
my @starting_point =();

my $ftm_ir 		= 64.0;
my $ftm_or 		= 161.0;
my $nlayer		= 2;
$starting_point[0] 	= 1773.0;
$starting_point[1] 	= 1793.0;
my $InnerRadius 	= 65.0;
my $OuterRadius 	= 142.0;
my $Epoxy_Dz 		= 0.5*0.3;
my $PCB_Dz 		= 0.5*0.1;
my $Strips_Dz 		= 0.5*0.015;
my $Gas1_Dz 		= 0.5*0.128;
my $Mesh_Dz 		= 0.5*0.030;
my $Gas2_Dz 		= 0.5*5.350;
my $Drift_Dz 		= 0.5*0.1;

# G4 materials
my $epoxy_material   = 'epoxy';
my $pcboard_material = 'epoxy';
my $strips_material  = 'mmstrips';
my $gas_material     = 'mmgas';
my $mesh_material    = 'mmmesh';
my $drift_material   = 'mmmylar';


# G4 colors
my $epoxy_color      = 'e200e1';
my $pcboard_color    = '0000ff';
my $strips_color     = '353540';
my $gas_color        = 'e10000';
my $mesh_color       = '252020';
my $drift_color      = 'fff600';

# FTM is a Tube containing all SLs
my $ftm_dz = ($starting_point[1] - $starting_point[0])/2.0 + $Epoxy_Dz*2.0 + $PCB_Dz*4.0 + $Strips_Dz*4.0 + $Gas1_Dz*4.0 + $Mesh_Dz*4.0 + $Gas2_Dz*4.0 + $Drift_Dz*4.0+1.0;
my $ftm_starting = ($starting_point[1] + $starting_point[0])/2.0;

#  FTM FEE Boxes
my $FEE_Disk_OR = 200.;
my $FEE_Disk_LN = 2.;
my $FEE_ARM_LN  = 530./2.-80;
my $FEE_ARM_WD  = 90./2.;

# size of crate
my $FEE_WD = 91./2.;
my $FEE_HT = 265.5/2.;
my $FEE_LN = 242./2.;
my $FEE_TN = 1.5;

my $FEE_PVT_TN=10.;

my $FEE_PVT_WD = $FEE_WD+$FEE_PVT_TN;
my $FEE_PVT_HT = $FEE_HT+$FEE_PVT_TN;
my $FEE_PVT_LN = $FEE_LN+$FEE_PVT_TN;

my $FEE_A_WD = $FEE_WD-$FEE_TN;
my $FEE_A_HT = $FEE_HT-$FEE_TN;
my $FEE_A_LN = $FEE_LN-$FEE_TN;
my @FEE_azimuthal_angle = (210., 270., 330.);
my $FEE_polar_angle = -22.;


# define crystals mother volume
my $nplanes_FT_CRY = 2;
my @z_plane_FT_CRY = ( $Idisk_Z-$Idisk_LT, $Idisk_Z+$Idisk_LT);
my @iradius_FT_CRY = (          $Idisk_IR,          $Idisk_IR);
my @oradius_FT_CRY = (          $Odisk_OR,          $Odisk_OR);






###########################################################################################
# Build Crystal Volume and Assemble calorimeter
###########################################################################################

sub make_mu_cal_crystals_volume
{
	my %detector = init_det();
	$detector{"name"}        = "ft_cal_crystal_volume";
	$detector{"mother"}      = "root";
	$detector{"description"} = "ft calorimeter crystal volume";
	$detector{"color"}       = "1437f4";
	$detector{"type"}        = "Polycone";
	my $dimen = "0.0*deg 360*deg $nplanes_FT_CRY*counts";
	for(my $i = 0; $i <$nplanes_FT_CRY; $i++) {$dimen = $dimen ." $iradius_FT_CRY[$i]*mm";}
	for(my $i = 0; $i <$nplanes_FT_CRY; $i++) {$dimen = $dimen ." $oradius_FT_CRY[$i]*mm";}
	for(my $i = 0; $i <$nplanes_FT_CRY; $i++) {$dimen = $dimen ." $z_plane_FT_CRY[$i]*mm";}
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = "Air";
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);
	
	
}

# Loop over all crystals and define their positions
sub make_mu_cal_crystals
{
	my $centX = ( int $Nx/2 )+0.5;
	my $centY = ( int $Ny/2 )+0.5;
	my $locX=0.;
	my $locY=0.;
	my $locZ=0.;
	my $dX=0.;
	my $dY=0.;
	my $dZ=0.;
	for ( my $iX = 1; $iX <= $Nx; $iX++ )
	{
		for ( my $iY = 1; $iY <= $Ny; $iY++ )
		{
			$locX=($iX-$centX)*$Vwidth;
			$locY=($iY-$centY)*$Vwidth;
			my $locR=sqrt($locX*$locX+$locY*$locY);
			if($locR>60. && $locR<$Vwidth*11)
			{
				# crystal mother volume
				my %detector = init_det();
				$detector{"name"}        = "ft_cr_volume_" . $iX . "_" . $iY ;
				$detector{"mother"}      = "ft_cal_crystal_volume";
				$detector{"description"} = "ft crystal mother volume (h:" . $iX . ", v:" . $iY . ")";
				$locZ=$Vfront+$Vlength/2.;
				$detector{"pos"}         = "$locX*mm $locY*mm $locZ*mm";
				$detector{"color"}       = "838EDE";
				$detector{"type"}        = "Box" ;
				$dX=$Vwidth/2.0;
				$dY=$Vwidth/2.0;
				$dZ=$Vlength/2.0;
				$detector{"dimensions"}  = "$dX*mm $dY*mm $dZ*mm";
				$detector{"material"}    = "G4_AIR";
				print_det(\%configuration, \%detector);
				
				# APD housing
				%detector = init_det();
				$detector{"name"}        = "ft_cr_apd_" . $iX . "_" . $iY ;
				$detector{"mother"}      = "ft_cal_crystal_volume";
				$detector{"description"} = "ft crystal apd (h:" . $iX . ", v:" . $iY . ")";
				$locZ=$Sfront+$Slength/2.;
				$detector{"pos"}         = "$locX*mm $locY*mm $locZ*mm";
				$detector{"color"}       = "99CC66";
				$detector{"type"}        = "Box" ;
				$dX=$Swidth/2.0;
				$dY=$Swidth/2.0;
				$dZ=$Slength/2.0;
				$detector{"dimensions"}  = "$dX*mm $dY*mm $dZ*mm";
				$detector{"material"}    = "G4_AIR";
				$detector{"style"}       = "1" ;
				print_det(\%configuration, \%detector);
				
				# Wrapping Volume;
				%detector = init_det();
				$detector{"name"}        = "ft_cr_wr_" . $iX . "_" . $iY ;
				$detector{"mother"}      = "ft_cr_volume_" . $iX . "_" . $iY ;
				$detector{"description"} = "ft wrapping (h:" . $iX . ", v:" . $iY . ")";
				$locX=0.;
				$locY=0.;
				$locZ=0.;
				$detector{"pos"}         = "$locX*mm $locY*mm $locZ*mm";
				$detector{"color"}       = "838EDE";
				$detector{"type"}        = "Box" ;
				$dX=$Wwidth/2.0;
				$dY=$Wwidth/2.0;
				$dZ=$Vlength/2.0;
				$detector{"dimensions"}  = "$dX*mm $dY*mm $dZ*mm";
				$detector{"material"}    = "G4_MYLAR";
				$detector{"style"}       = "1" ;
				print_det(\%configuration, \%detector);
				
				# PbWO4 Crystal;
				%detector = init_det();
				$detector{"name"}        = "ft_cr_" . $iX . "_" . $iY ;
				$detector{"mother"}      = "ft_cr_wr_" . $iX . "_" . $iY ;
				$detector{"description"} = "ft crystal (h:" . $iX . ", v:" . $iY . ")";
				$locX=0.;
				$locY=0.;
				$locZ=$Flength/2.;
				$detector{"pos"}         = "$locX*mm $locY*mm $locZ*mm";
				$detector{"color"}       = "836FFF";
				$detector{"type"}        = "Box" ;
				$dX=$Cwidth/2.0;
				$dY=$Cwidth/2.0;
				$dZ=$Clength/2.0;
				$detector{"dimensions"}  = "$dX*mm $dY*mm $dZ*mm";
				$detector{"material"}    = "G4_PbWO4";
				$detector{"style"}       = "1" ;
#				$detector{"sensitivity"} = "ft_cal";
#				$detector{"hit_type"}    = "ft_cal";
#				$detector{"identifiers"} = "ih manual $iX iv manual $iY";
				print_det(\%configuration, \%detector);
				
				# LED housing
				%detector = init_det();
				$detector{"name"}        = "ft_cr_led_" . $iX . "_" . $iY ;
				$detector{"mother"}      = "ft_cr_wr_" . $iX . "_" . $iY ;
				$detector{"description"} = "ft crystal led (h:" . $iX . ", v:" . $iY . ")";
				$locX=0.;
				$locY=0.;
				$locZ=-$Vlength/2.+$Flength/2.;
				$detector{"pos"}         = "$locX*mm $locY*mm $locZ*mm";
				$detector{"color"}       = "EEC900";
				$detector{"type"}        = "Box" ;
				$dX=$Fwidth/2.0;
				$dY=$Fwidth/2.0;
				$dZ=$Flength/2.0;
				$detector{"dimensions"}  = "$dX*mm $dY*mm $dZ*mm";
				$detector{"material"}    = "ft_peek";
				$detector{"style"}       = "1" ;
				#print_det(\%configuration, \%detector);
			}
		}
	}
}

sub make_mu_cal
{
	make_mu_cal_crystals_volume();
	make_mu_cal_crystals();
}


