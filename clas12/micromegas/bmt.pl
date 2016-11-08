# use strict;
use warnings;

our %configuration;
our %parameters;

my $envelope = 'BMT';

# All dimensions in mm

my @radius =();
my @starting_point =();
my @Dz_halflength =();
my @starting_theta =();
my @Inactivtheta =();
my @dtheta =();
my @dtheta_start =();

my $bmt_ir 		= $parameters{"BMT_mothervol_InnerRadius"}; # 140
my $bmt_or 		= $parameters{"BMT_mothervol_OutRadius"};   # 240
my $bmt_dz 		= $parameters{"BMT_mothervol_HalfLength"};  # 385
#my $bmt_z               = $parameters{"BMT_mothervol_zpos"};
# Mother volume middle position: 
my $bmt_z               = $parameters{"FMT_mothervol_zmin"} - $bmt_dz;      # 302-385 = -83
my $bmt_zpcb            = $parameters{"BMT_endPCB_zpos"} - $bmt_z;          # 290.3+83 = 373.3 end pcb in MV frame

my $nlayer		= $parameters{"BMT_nlayer"};
my $ntile		= $parameters{"BMT_ntile"};

$radius[0] 	        = $parameters{"BMT_radius_layer1"};
$radius[1] 	        = $parameters{"BMT_radius_layer2"};
$radius[2] 	        = $parameters{"BMT_radius_layer3"};
$radius[3] 	        = $parameters{"BMT_radius_layer4"};
$radius[4] 	        = $parameters{"BMT_radius_layer5"};
$radius[5] 	        = $parameters{"BMT_radius_layer6"};

$starting_point[0] 	= $parameters{"BMT_zpos_layer1"};
$starting_point[1] 	= $parameters{"BMT_zpos_layer2"};
$starting_point[2] 	= $parameters{"BMT_zpos_layer3"};
$starting_point[3] 	= $parameters{"BMT_zpos_layer4"};
$starting_point[4] 	= $parameters{"BMT_zpos_layer5"};
$starting_point[5] 	= $parameters{"BMT_zpos_layer6"};

$Dz_halflength[0] 	= 0.5*$parameters{"BMT_zlength_layer1"};
$Dz_halflength[1] 	= 0.5*$parameters{"BMT_zlength_layer2"};
$Dz_halflength[2] 	= 0.5*$parameters{"BMT_zlength_layer3"};
$Dz_halflength[3] 	= 0.5*$parameters{"BMT_zlength_layer4"};
$Dz_halflength[4] 	= 0.5*$parameters{"BMT_zlength_layer5"};
$Dz_halflength[5] 	= 0.5*$parameters{"BMT_zlength_layer6"};

$starting_theta[0] 	= $parameters{"BMT_theta_layer1"};
$starting_theta[1] 	= $parameters{"BMT_theta_layer2"};
$starting_theta[2] 	= $parameters{"BMT_theta_layer3"};
$starting_theta[3] 	= $parameters{"BMT_theta_layer4"};
$starting_theta[4] 	= $parameters{"BMT_theta_layer5"};
$starting_theta[5] 	= $parameters{"BMT_theta_layer6"};

my $Coverlay_Width	        = $parameters{"BMT_Coverlay_width"};
my $CuGround_Width	        = 0.132*$parameters{"BMT_CuGround_width"};
                                  #0.082 from gerber : 1 - 4.6*4.6/(4.6+0.2)*(4.6+0.2) = 0.082 for Z-layers
                                  #0.056 + 0.126 (return strips) for C-layers
                                  #since this is a small contribution, we adopt a mean value of 0.132
my $PCB_Width 	    	        = $parameters{"BMT_PCBGround_width"};
my $CuStrips_Width 	        = $parameters{"BMT_CuStrips_width"};
                                  #opacity taken into account in the density of the material
my $KaptonStrips_Width 		= $parameters{"BMT_KaptonStrips_width"};
my $ResistStrips_Width 		= $parameters{"BMT_ResistStrips_width"};
                                  #opacity taken into account in the density of the material
my $Gas1_Width 	    		= $parameters{"BMT_Gas1_width"};
my $Mesh_Width 	    		= $parameters{"BMT_Mesh_width"};
                                  #opacity taken into account in the density of the material
my $Gas2_Width 	    		= $parameters{"BMT_Gas2_width"};
my $DriftZCuElectrode_Width	= 0.024*$parameters{"BMT_DriftCuElectrode_width"};
                                  #0.024 from gerber : 1 - 10*10/(10+0.12)*(10+0.12) = 0.024
my $DriftCCuElectrode_Width	= $parameters{"BMT_DriftCuElectrode_width"};
                                  #for CRnC, the Cu electrode is not a mesh
my $DriftKapton_Width 		= $parameters{"BMT_DriftKapton_width"};
my $DriftCuGround_Width 	= 0.082*$parameters{"BMT_DriftCuGround_width"};
                                  #0.082 from gerber : 1 - 4.6*4.6/(4.6+0.2)*(4.6+0.2) = 0.082

my $Dtheta               = 360.0/$ntile; # rotation angle for other tiles

$Inactivtheta[0]	 = (20/$radius[0])*(180./3.14159265358); 
                          # = 7.863 not in activ area (in degrees) (20 mm taken by mechanics)
$Inactivtheta[1]	 = (20/$radius[1])*(180./3.14159265358); # = 7.129
$Inactivtheta[2]	 = (20/$radius[2])*(180./3.14159265358); # = 6.521
$Inactivtheta[3]	 = (20/$radius[3])*(180./3.14159265358); # = 6.008
$Inactivtheta[4]	 = (20/$radius[4])*(180./3.14159265358); # = 5.570
$Inactivtheta[5]	 = (20/$radius[5])*(180./3.14159265358); # = 5.191

$dtheta[0]               = $Dtheta-$Inactivtheta[0]; # angle covered by one tile (active area) (in degrees)
$dtheta[1]               = $Dtheta-$Inactivtheta[1];
$dtheta[2]               = $Dtheta-$Inactivtheta[2];
$dtheta[3]               = $Dtheta-$Inactivtheta[3];
$dtheta[4]               = $Dtheta-$Inactivtheta[4];
$dtheta[5]               = $Dtheta-$Inactivtheta[5];

$dtheta_start[0]	 = $Inactivtheta[0]/2.0; # slight rotation to keep symmetry.
$dtheta_start[1]	 = $Inactivtheta[1]/2.0;
$dtheta_start[2]	 = $Inactivtheta[2]/2.0;
$dtheta_start[3]	 = $Inactivtheta[3]/2.0;
$dtheta_start[4]	 = $Inactivtheta[4]/2.0;
$dtheta_start[5]	 = $Inactivtheta[5]/2.0;

# materials
my $air_material	     = 'myAir';
my $copper_material	     = 'myCopper';
my $pcb_material      	     = 'myFR4';
my $bmtz4_strips_material    = 'mybmtz4MMStrips';#taking into account pitch/opacity
my $bmtz5_strips_material    = 'mybmtz5MMStrips';#taking into account pitch/opacity
my $bmtz6_strips_material    = 'mybmtz6MMStrips';#taking into account pitch/opacity
my $bmtc4_strips_material    = 'mybmtc4MMStrips';#taking into account pitch/opacity
my $bmtc5_strips_material    = 'mybmtc5MMStrips';#taking into account pitch/opacity
my $bmtc6_strips_material    = 'mybmtc6MMStrips';#taking into account pitch/opacity
my $kapton_material    	     = 'myKapton';
my $bmtz4_resist_material    = 'mybmtz4ResistPaste';#taking into account pitch/opacity
my $bmtz5_resist_material    = 'mybmtz5ResistPaste';#taking into account pitch/opacity
my $bmtz6_resist_material    = 'mybmtz6ResistPaste';#taking into account pitch/opacity
my $bmtc4_resist_material    = 'mybmtc4ResistPaste';#taking into account pitch/opacity
my $bmtc5_resist_material    = 'mybmtc5ResistPaste';#taking into account pitch/opacity
my $bmtc6_resist_material    = 'mybmtc6ResistPaste';#taking into account pitch/opacity
my $gas_material       	     = 'mybmtMMGas';
my $mesh_material      	     = 'mybmtMMMesh';
my $Cfiber_material          = 'myCfiber';
my $Cstraight_material       = 'myCstraight';
my $inox_material            = 'myInox';
my $peek_material   	     = 'myPeek';
#define myGlue...

# G4 colors
# (colors random)
# 'rrggbb(t)' (transparency from 0 opaque to 5 fully transparent)
my $air_color	       = 'e200e15';
my $copper_color       = '6666004';
my $pcb_color          = '0000ff4';
my $strips_color       = '3535404';
my $kapton_color       = 'fff6004';
my $resist_color       = '0000004';
my $gas_color          = 'a100002';
my $mesh_color         = '2520204';
my $structure_color    = 'ffffff2';
my $alu_color          = '4444444';     # dark grey
my $carbon_color       = '0044444';

$pi = 3.141592653589793238;
# sub rad { $_[0]*$pi/180.0  }
# sub atan {atan2($_[0],1)}

sub segnumber
{
 my $s = shift;
 my $zeros = "";
 if($s < 9) { $zeros = "0"; }
 my $segment_n = $s + 1;
 return "$zeros$segment_n";
}

sub rot
{
 my $l = shift;
 my $s = shift;
 my $theta_rot = $starting_theta[$l] - $s*$Dtheta;
 return "0*deg 0*deg $theta_rot*deg";
}

my @SL_ir = ($radius[0]-1.0, $radius[1]-1.0, $radius[2]-1.0, $radius[3]-1.0, $radius[4]-1.0, $radius[5]-1.0);
my @SL_or = ($radius[0]+5.0, $radius[1]+5.0, $radius[2]+5.0, $radius[3]+5.0, $radius[4]+5.0, $radius[5]+5.0);
#my $SL_dz = $bmt_dz;
my $SL_dz = 295.0;
my $SL_z  = -$bmt_z; # center of superlayer wrt BMT  mother volume

sub define_bmt
{
	make_bmt();
#	make_sl(1);
#	make_sl(2);
#	make_sl(3);
#	make_sl(4);
#	make_sl(5);
#	make_sl(6);

	# Active zones (Remi's tables):
	for(my $l = 0; $l < $nlayer; $l++)
	{    	
		place_coverlay($l);
		place_cuGround($l);
		place_pcb($l);
		place_strips($l);
		place_kapton($l);
		place_resist($l);
		place_gas1($l);
		place_mesh($l);
		place_gas2($l);
		place_driftCuElectrode($l);
		place_driftKapton($l);
		place_driftCuGround($l);
	}

	# detector frame (Sedi drawings):

	# detector downstream extensions (Sedi drawings):
	place_straightC();        # drawing 6 2075 DM- 1500 201
	place_Arc1onPCB();
	place_Arc2onPCB();

	# supporting structure (SIS drawings):
	place_innertube();        # drawing 71 2075 DM- 1302 001 
	place_stiffeners();       #                          005
	place_arcs();             #                          007
	place_cover();            #                          008
	place_rods();             #                          010 & 011
	place_overcover();        #                          013
	place_forwardinterface(); #                          003  
	place_closingplate();     #                          004
}

sub make_bmt
{
# Mother volume will include detectors and support structure,
# Not centered on CLAS12 target anymore
 	my %detector = init_det();
 	$detector{"name"}        = $envelope;
 	$detector{"mother"}      = "root";
 	$detector{"description"} = "Barrel Micromegas Vertex Tracker";
 	$detector{"pos"}         = "0*mm 0*mm $bmt_z*mm";
 	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
 	$detector{"color"}       = "aaaaff3";
 	$detector{"type"}        = "Tube";
 	$detector{"dimensions"}  = "$bmt_ir*mm $bmt_or*mm $bmt_dz*mm 0*deg 360*deg";
 	$detector{"material"}    = "myAir";
 	$detector{"visible"}     = 0;
 	$detector{"style"}       = 0;
 	print_det(\%configuration, \%detector);
}

sub make_sl
{
# Superlayers volumes still centered on CLAS12 target, hence not on mother volume
# not used anymore (MG Sept. 2016)
 	my $slnumber = shift;
 	my $slindex  = $slnumber - 1;

 	my %detector = init_det();
 	$detector{"name"}        = "SL2_$slnumber";
 	$detector{"mother"}      = $envelope;
 	$detector{"description"} = "Super Layer $slnumber";
 	$detector{"pos"}         = "0*cm 0*cm $SL_z*mm";
 	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
 	$detector{"color"}       = "aaaaff";
 	$detector{"type"}        = "Tube";
 	$detector{"dimensions"}  = "$SL_ir[$slindex]*mm $SL_or[$slindex]*mm $SL_dz*mm 0*deg 360*deg";
 	$detector{"material"}    = "myAir";
 	$detector{"visible"}     = 0;
 	$detector{"style"}       = 0;	
	print_det(\%configuration, \%detector);
}

sub place_coverlay
{
    my $l          = shift;
    my $layer_no   = $l + 1; 
    my $vname      = 0;
    my $descriptio = 0;

    if($l == 0 || $l == 3 || $l == 5)
    {
		$vname      = "BMT_coverlay_C_Layer";
		$descriptio = "coverlay C, Layer $layer_no, ";
    }
    if($l == 1 || $l == 2 || $l == 4)
    {
		$vname      = "BMT_coverlay_Z_Layer";
		$descriptio = "coverlay Z, Layer $layer_no, ";
    }
    
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
		my $snumber   = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l] - $bmt_z;
		my $PRMin     = $radius[$l];
		my $PRMax     = $radius[$l] + $Coverlay_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; 
		my $PDPhi     = $dtheta[$l];

		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio Segment $snumber";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = rot($l, $s);
		$detector{"color"}       = $kapton_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"material"}    = $kapton_material;
		$detector{"ncopy"}       = $s + 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);

    } 
}

sub place_cuGround
{
    my $l          = shift;
    my $layer_no   = $l + 1; 
    my $vname      = 0;
    my $descriptio = 0;

    if($l == 0 || $l == 3 || $l == 5)
    {
		$vname      = "BMT_CuGround_C_Layer";
		$descriptio = "CuGround C, Layer $layer_no, ";
    }
    if($l == 1 || $l == 2 || $l == 4)
    {
		$vname      = "BMT_CuGround_Z_Layer";
		$descriptio = "CuGround Z, Layer $layer_no, ";
    }
    
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
		my $snumber   = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l] - $bmt_z;
		my $PRMin     = $radius[$l] + $Coverlay_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; 
		my $PDPhi     = $dtheta[$l];

		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio Segment $snumber";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = rot($l, $s);
		$detector{"color"}       = $copper_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"material"}    = $copper_material;
		$detector{"ncopy"}       = $s + 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);

    } 
}

sub place_pcb
{
    my $l          = shift;
    my $layer_no   = $l + 1; 
    my $vname      = 0;
    my $descriptio = 0;

    if($l == 0 || $l == 3 || $l == 5)
    {
		$vname      = "BMT_PCB_C_Layer";
		$descriptio = "PCB C, Layer $layer_no, ";
    }
    if($l == 1 || $l == 2 || $l == 4)
    {
		$vname      = "BMT_PCB_Z_Layer";
		$descriptio = "PCB Z, Layer $layer_no, ";
    }
    
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
		my $snumber   = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l] - $bmt_z;
		my $PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; 
		my $PDPhi     = $dtheta[$l];

		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      =  $envelope;
		$detector{"description"} = "$descriptio Segment $snumber";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = rot($l, $s);
		$detector{"color"}       = $pcb_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"material"}    = $pcb_material;
		$detector{"ncopy"}       = $s + 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);

    } 
}

sub place_strips
{
    my $l          = shift;
    my $layer_no   = $l + 1;
    my $vname      = 0;
    my $descriptio = 0;

    if($l == 0 || $l == 3 || $l == 5)
    {
		$vname      = "BMT_CuStrips_C_Layer";
		$descriptio = "CuStrips C, Layer $layer_no, ";
    }
    if($l == 1 || $l == 2 || $l == 4)
    {
		$vname      = "BMT_CuStrips_Z_Layer";
		$descriptio = "CuStrips Z, Layer $layer_no, ";
    }
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
                my $snumber   = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l] - $bmt_z;
		my $PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; 
		my $PDPhi     = $dtheta[$l];

		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      =  $envelope;
		$detector{"description"} = "$descriptio Segment $snumber";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = rot($l, $s);
		$detector{"color"}       = $strips_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		if($l == 0) {$detector{"material"} = $bmtc4_strips_material;}
		if($l == 3) {$detector{"material"} = $bmtc5_strips_material;}
		if($l == 5) {$detector{"material"} = $bmtc6_strips_material;}
		if($l == 1) {$detector{"material"} = $bmtz4_strips_material;}
		if($l == 2) {$detector{"material"} = $bmtz5_strips_material;}	
		if($l == 4) {$detector{"material"} = $bmtz6_strips_material;}
		$detector{"ncopy"}       = $s + 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	
    } 
}

sub place_kapton
{
    my $l          = shift;
    my $layer_no   = $l + 1; 
    my $vname      = 0;
    my $descriptio = 0;

    if($l == 0 || $l == 3 || $l == 5)
    {
		$vname      = "BMT_KaptonStrips_C_Layer";
		$descriptio = "KaptonStrips C, Layer $layer_no, ";
    }
    if($l == 1 || $l == 2 || $l == 4)
    {
		$vname      = "BMT_KaptonStrips_Z_Layer";
		$descriptio = "KaptonStrips Z, Layer $layer_no, ";
    }
    
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
		my $snumber   = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l] - $bmt_z;
		my $PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; 
		my $PDPhi     = $dtheta[$l];

		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio Segment $snumber";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = rot($l, $s);
		$detector{"color"}       = $kapton_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"material"}    = $kapton_material;
		$detector{"ncopy"}       = $s + 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);

    } 
}

sub place_resist
{
    my $l          = shift;
    my $layer_no   = $l + 1;
    my $vname      = 0;
    my $descriptio = 0;

    if($l == 0 || $l == 3 || $l == 5)
    {
		$vname      = "BMT_ResistStrips_C_Layer";
		$descriptio = "ResistStrips C, Layer $layer_no, ";
    }
    if($l == 1 || $l == 2 || $l == 4)
    {
		$vname      = "BMT_ResistStrips_Z_Layer";
		$descriptio = "ResistStrips Z, Layer $layer_no, ";
    }
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
                my $snumber     = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l] - $bmt_z;
		my $PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; # to be defined, in degres
		my $PDPhi     = $dtheta[$l];

		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio Segment $snumber";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = rot($l, $s);
		$detector{"color"}       = $resist_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		if($l == 0) {$detector{"material"} = $bmtc4_resist_material;}
		if($l == 3) {$detector{"material"} = $bmtc5_resist_material;}
		if($l == 5) {$detector{"material"} = $bmtc6_resist_material;}
	        if($l == 1) {$detector{"material"} = $bmtz4_resist_material;}
	        if($l == 2) {$detector{"material"} = $bmtz5_resist_material;}
		if($l == 4) {$detector{"material"} = $bmtz6_resist_material;}
		$detector{"ncopy"}       = $s + 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	
    } 
}

sub place_gas1
{
    my $l          = shift;
    my $layer_no   = $l + 1;
    my $vname      = 0;
    my $descriptio = 0;

    if($l == 0 || $l == 3 || $l == 5)
    {
		$vname      = "BMT_Gas1_C_Layer";
		$descriptio = "Gas1 C, Layer $layer_no, ";
    }
    if($l == 1 || $l == 2 || $l == 4)
    {
		$vname      = "BMT_Gas1_Z_Layer";
		$descriptio = "Gas1 Z, Layer $layer_no, ";
    }
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
                my $snumber   = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l] - $bmt_z;
		my $PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; 
		my $PDPhi     = $dtheta[$l];

		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio Segment $snumber";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = rot($l, $s);
		$detector{"color"}       = $gas_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"material"}    = $gas_material;
		$detector{"ncopy"}       = $s + 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);

    } 
}

sub place_mesh
{
    my $l          = shift;
    my $layer_no   = $l + 1;
    my $vname      = 0;
    my $descriptio = 0;

    if($l == 0 || $l == 3 || $l == 5)
    {
		$vname      = "BMT_Mesh_C_Layer";
		$descriptio = "Mesh C, Layer $layer_no, ";
    }
    if($l == 1 || $l == 2 || $l == 4)
    {
		$vname      = "BMT_Mesh_Z_Layer";
		$descriptio = "Mesh Z, Layer $layer_no, ";
    }
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
                my $snumber     = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l] - $bmt_z;
		my $PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; # to be defined, in degres
		my $PDPhi     = $dtheta[$l];

		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      =  $envelope;
		$detector{"description"} = "$descriptio Segment $snumber";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = rot($l, $s);
		$detector{"color"}       = $mesh_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"material"}    = $mesh_material;
		$detector{"mfield"}      = "no";
		$detector{"ncopy"}       = $s + 1;
		$detector{"pMany"}       = 1;
		$detector{"exist"}       = 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		$detector{"sensitivity"} = "no";
		$detector{"hit_type"}    = "no";
		$detector{"identifiers"} = "no";
		print_det(\%configuration, \%detector);

    } 
}

sub place_gas2
{
    my $l          = shift;
    my $layer_no   = $l + 1;
    my $vname      = 0;
    my $descriptio = 0;
    my $type       = 0;

    if($l == 0 || $l == 3 || $l == 5)
    {
		$vname      = "BMT_Gas2_C_Layer";
		$descriptio = "Gas2 C, Layer $layer_no, ";
		$type = 1;
    }
    if($l == 1 || $l == 2 || $l == 4)
    {
		$vname      = "BMT_Gas2_Z_Layer";
		$descriptio = "Gas2 Z, Layer $layer_no, ";
		$type = 2;
    }
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
                my $snumber     = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l] - $bmt_z;
		my $PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; 
		my $PDPhi     = $dtheta[$l];

		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio  Segment $snumber";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = rot($l, $s);
		$detector{"color"}       = $gas_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"material"}    = $gas_material;
		$detector{"ncopy"}       = $s + 1;
		$detector{"pMany"}       = 1;
		$detector{"exist"}       = 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		$detector{"sensitivity"} = "bmt";
		$detector{"hit_type"}    = "bmt";
		$detector{"identifiers"} ="superlayer manual $layer_no type manual $type segment manual $detector{'ncopy'} strip manual 1";
		print_det(\%configuration, \%detector);

    } 
}

sub place_driftCuElectrode
{
    my $l          = shift;
    my $layer_no   = $l + 1;
    my $vname      = 0;
    my $descriptio = 0;

    if($l == 0 || $l == 3 || $l == 5)
    {
		$vname      = "BMT_DriftCuElectrode_C_Layer";
		$descriptio = "DriftCuElectrode C, Layer $layer_no, ";
    }
    if($l == 1 || $l == 2 || $l == 4)
    {
		$vname      = "BMT_DriftCuElectrode_Z_Layer";
		$descriptio = "DriftCuElectrode Z, Layer $layer_no, ";
    }
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
                my $snumber     = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l] - $bmt_z;
		my $PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width + $DriftCCuElectrode_Width;
		
		if($l == 0 || $l == 3 || $l == 5)
		{
			$PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width + $DriftCCuElectrode_Width;
		}
		if($l == 1 || $l == 2 || $l == 4)
		{
			$PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width + $DriftZCuElectrode_Width;
		}
		
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; # to be defined, in degres
		my $PDPhi     = $dtheta[$l];

		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio Segment $snumber";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = rot($l, $s);
		$detector{"color"}       = $copper_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"mfield"}      = "no";
		$detector{"material"}    = $copper_material;
		$detector{"ncopy"}       = $s + 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	
    } 
}

sub place_driftKapton
{
    my $l          = shift;
    my $layer_no   = $l + 1;
    my $vname      = 0;
    my $descriptio = 0;

    if($l == 0 || $l == 3 || $l == 5)
    {
		$vname      = "BMT_DriftKapton_C_Layer";
		$descriptio = "DriftKapton C, Layer $layer_no, ";
    }
    if($l == 1 || $l == 2 || $l == 4)
    {
		$vname      = "BMT_DriftKapton_Z_Layer";
		$descriptio = "DriftKapton Z, Layer $layer_no, ";
    }
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
                my $snumber   = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l] - $bmt_z;
		my $PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width + $DriftCCuElectrode_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width + $DriftCCuElectrode_Width + $DriftKapton_Width;
		
		if($l == 0 || $l == 3 || $l == 5)
		{
			$PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width + $DriftCCuElectrode_Width;
			$PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width + $DriftCCuElectrode_Width + $DriftKapton_Width;
		}
		if($l == 1 || $l == 2 || $l == 4)
		{
			$PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width + $DriftZCuElectrode_Width;
			$PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width + $DriftZCuElectrode_Width + $DriftKapton_Width;
		}
		
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; 
		my $PDPhi     = $dtheta[$l];

		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio Segment $snumber";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = rot($l, $s);
		$detector{"color"}       = $kapton_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"mfield"}      = "no";
		$detector{"material"}    = $kapton_material;
		$detector{"ncopy"}       = $s + 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	
    } 
}

sub place_driftCuGround
{
    my $l          = shift;
    my $layer_no   = $l + 1;
    my $vname      = 0;
    my $descriptio = 0;

    if($l == 0 || $l == 3 || $l == 5)
    {
		$vname      = "BMT_DriftCuGround_C_Layer";
		$descriptio = "DriftCuGround C, Layer $layer_no, ";
    }
    if($l == 1 || $l == 2 || $l == 4)
    {
		$vname      = "BMT_DriftCuGround_Z_Layer";
		$descriptio = "DriftCuGround Z, Layer $layer_no, ";
    }
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
                my $snumber   = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l] - $bmt_z;
		my $PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width + $DriftCCuElectrode_Width + $DriftKapton_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width + $DriftCCuElectrode_Width + $DriftKapton_Width + $DriftCuGround_Width;
		
		if($l == 0 || $l == 3 || $l == 5)
		{
			$PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width + $DriftCCuElectrode_Width + $DriftKapton_Width;
			$PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width + $DriftCCuElectrode_Width + $DriftKapton_Width + $DriftCuGround_Width;
		}
		if($l == 1 || $l == 2 || $l == 4)
		{
			$PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width + $DriftZCuElectrode_Width + $DriftKapton_Width;
			$PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width + $DriftZCuElectrode_Width + $DriftKapton_Width + $DriftCuGround_Width;
		}
		
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; # to be defined, in degres
		my $PDPhi     = $dtheta[$l];

		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      = $envelope;     ;
		$detector{"description"} = "$descriptio Segment $snumber";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = rot($l, $s);
		$detector{"color"}       = $copper_color;
		$detector{"type"}        = "Tube";
                $detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
                $detector{"mfield"}      = "no";
		$detector{"material"}    = $copper_material;
                $detector{"ncopy"}       = $s + 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);	
    } 
}

sub place_straightC
{
                my $vname      = "BMT_straightC";
                my $descriptio = "BMT_straightC";
		
		my $Px        =   3.0/2.0;
	        my $Py        =   3.0/2.0;
                my $Pz        = 710.0/2.0;
		my $z         = $bmt_zpcb - $Pz;          
		@radii       = (146.0, 161.0, 176.0, 191.0, 206.1, 221.1);
	for(my $l = 0; $l < $nlayer; $l++)
	{
	my $layer_no = $l + 1;
	for(my $s = 0; $s < $ntile; $s++)
	{
	my $tile_no= $s + 1;
	        my $sphi      = ((3.0 + $Px)/$radii[$l])*180.0/$pi;
	        my $dphi      = $Dtheta - 2.0*$sphi;
	for(my $r = 0; $r < 2; $r++)
	{
	my $rod_no= $r + 1;
	
	        my $theta_rot = 30.0 + $sphi + $s*120. + $r*$dphi;
		my $x         = ($radii[$l] + $Px)*cos($theta_rot*$pi/180.0); 
		my $y         = ($radii[$l] + $Px)*sin($theta_rot*$pi/180.0); 
	        my %detector = init_det();
		$detector{"name"}        = "$vname\_$layer_no\_$tile_no\_$rod_no";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio";
		$detector{"pos"}         = "$x*mm $y*mm $z*mm";
		$detector{"rotation"}    = "0*deg 0*deg -$theta_rot*deg";
		$detector{"color"}       = $carbon_color;
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$Px*mm $Py*mm $Pz*mm";
	       	$detector{"material"}    = $Cstraight_material;
		$detector{"ncopy"}       = 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
	}
	}
}

sub place_Arc1onPCB
{
                my $vname      = "BMT_Arc1onPCB";
                my $descriptio = "BMT_Arc1onPCB";
	
		my @radii     = (146.0, 161.0, 176.0, 191.0, 206.1, 221.1);
                my @distPCB   = (1.0, 1.0, 1.0, 1.0, 1.0, 1.0);
	        my $PDz       = 3.0/2.0; 
		
		

	for(my $l = 0; $l < $nlayer; $l++)
	{
	my $layer_no = $l + 1;
	        my $z         = $bmt_zpcb - $distPCB[$l] - $PDz;
	        my $PRMin     = $radii[$l];
 	        my $PRMax     = $PRMin + 3.0;
	        my $PDPhi     = $Dtheta - (180./$pi)*2.*6.0/$PRMin;
	for(my $s = 0; $s < $ntile; $s++)
	{
	my $tile_no= $s + 1;
        	my $element_no = $s + 1;	
	        my $PSPhi      = 30.0 + (180./$pi)*6.0/$PRMin + $s*$Dtheta;
	
		my %detector = init_det();
		$detector{"name"}        = "$vname\_$layer_no\_$element_no";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = $carbon_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"material"}    = $Cfiber_material;
		$detector{"ncopy"}       = 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
	}
}

sub place_Arc2onPCB
{
                my $vname      = "BMT_Arc2onPCB";
                my $descriptio = "BMT_Arc2onPCB";
	
		my @radii     = (146.0, 161.0, 176.0, 191.0, 206.1, 221.1);
                my @distPCB   = (32.0, 32.0, 9.4, 9.4, 7.0, 7.0);
	        my $PDz       = 3.0/2.0; 
		
		

	for(my $l = 0; $l < $nlayer; $l++)
	{
	my $layer_no = $l + 1;
	        my $z         = $bmt_zpcb - $distPCB[$l] - $PDz;
	        my $PRMin     = $radii[$l];
 	        my $PRMax     = $PRMin + 3.0;
	        my $PDPhi     = $Dtheta - (180./$pi)*2.*6.0/$PRMin;
	for(my $s = 0; $s < $ntile; $s++)
	{
	my $tile_no= $s + 1;
        	my $element_no = $s + 1;	
	        my $PSPhi      = 30.0 + (180./$pi)*6.0/$PRMin + $s*$Dtheta;
	
		my %detector = init_det();
		$detector{"name"}        = "$vname\_$layer_no\_$element_no";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = $carbon_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"material"}    = $Cstraight_material;
		$detector{"ncopy"}       = 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
	}
}

sub place_innertube
{
                my $vname      = "BMT_InnerTube";
                my $descriptio = "BMT_InnerTube";
	
		my $PRMin     = 140.0;
		my $PRMax     = 141.0;
		my $PDz       = 732.0/2.0;
		my $z         = $bmt_zpcb - 7.0 - $PDz;
		my $PSPhi     = 0.; 
		my $PDPhi     = 360.;

		my %detector = init_det();
		$detector{"name"}        = "$vname";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = $structure_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"material"}    = $Cfiber_material;
		$detector{"ncopy"}       = 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
}

sub place_stiffeners
# each stiffener is one 2mm thick rectangle 736 x 92.5,
#     ignoring holders and screws 
#     divided in ctr + downstrm + upstrm to model interference with end plates
#     upstrm will have to be introduced and ctr revisited when introducing upstream endplate 002 -> temporary
{
                my $vname      = "BMT_Stiffeners_ctr";
                my $descriptio = "BMT_Stiffeners_ctr";
	
		my $Px        =  92.496/2.0;  # not 92.5 to avoid overlap with cover
		my $Py        =  2.0/2.0;
   		my $Pz        =  719.0/2.0;   # 736-17(downstream)
                my $z         =  $bmt_zpcb - 17.0 - $Pz;

	for(my $s = 0; $s < $ntile; $s++)
	{
	my $element_no= $s + 1;	
	        my $theta_rot = 30.0 + $s*120.0;
		my $x         = (141.5 + $Px)*cos($theta_rot*$pi/180.0);
		my $y         = (141.5 + $Px)*sin($theta_rot*$pi/180.0);

		my %detector = init_det();
		$detector{"name"}        = "$vname\_$element_no";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio";
		$detector{"pos"}         = "$x*mm $y*mm $z*mm";
		$detector{"rotation"}    = "0*deg 0*deg -$theta_rot*deg";
		$detector{"color"}       = $structure_color;
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$Px*mm $Py*mm $Pz*mm";
		$detector{"material"}    = $Cfiber_material;
		$detector{"ncopy"}       = 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
                $vname      = "BMT_Stiffeners_dwnstrm";
                $descriptio = "BMT_Stiffeners_dwnstrm";
	
		$Px        =  89.496/2.0; # 92.5 - 3, with 3 = 144.5-141.5 (see first 2 rings of forward interface)
		$Py        =  2.0/2.0;
		$Pz        =  7.75/2.0;   # adjusted to match with the branch extension
                $z         =  $bmt_zpcb - 17.0 + $Pz;

	for($s = 0; $s < $ntile; $s++)
	{
        $element_no= $s + 1;	
	        $theta_rot = 30.0 + $s*120.0;
		$x         = (144.5 + $Px)*cos($theta_rot*$pi/180.0);
		$y         = (144.5 + $Px)*sin($theta_rot*$pi/180.0);

		%detector = init_det();
		$detector{"name"}        = "$vname\_$element_no";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio";
		$detector{"pos"}         = "$x*mm $y*mm $z*mm";
		$detector{"rotation"}    = "0*deg 0*deg -$theta_rot*deg";
		$detector{"color"}       = $structure_color;
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$Px*mm $Py*mm $Pz*mm";
		$detector{"material"}    = $Cfiber_material;
		$detector{"ncopy"}       = 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
}

sub place_arcs
{
                my $vname      = "BMT_Arcs";
                my $descriptio = "BMT_Arcs";
	
		
		my $PRMin     = 229.0;
		my $PRMax     = 234.0;
		my $PDz       = 15.0/2.0; 
		my $z         = $bmt_zpcb - 729.0 - $PDz;
		my $PDPhi     = $Dtheta - (180./$pi)*2.*7.5/$PRMin;

	for(my $s = 0; $s < $ntile; $s++)
	{
	        my $element_no = $s + 1;	
	        my $PSPhi      = 30.0 + (180./$pi)*7.5/$PRMin + $s*$Dtheta;
	
		my %detector = init_det();
		$detector{"name"}        = "$vname\_$element_no";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = $structure_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"material"}    = $inox_material;
		$detector{"ncopy"}       = 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
}

sub place_cover
{
                my $vname      = "BMT_Cover";
                my $descriptio = "BMT_Cover";
	
		
		my $PRMin     = 234.0;
		my $PRMax     = 235.0; 
		my $PDz       = 744.0/2.0;
		my $z         = $bmt_zpcb - $PDz;
		my $PSPhi     = 0.; 
		my $PDPhi     = 360.;

		my %detector = init_det();
		$detector{"name"}        = "$vname";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = $structure_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"material"}    = $Cfiber_material;
		$detector{"ncopy"}       = 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
}

sub place_rods
# The actual placement of these rods must be measured after glueing
{
                my $vname      = "BMT_Rods";
                my $descriptio = "BMT_Rods";
		
		my $Px        =   3.0/2.0;
		my $Px_gas    =   4.0/2.0;
		my $Py        =   3.0/2.0;
                my $Py_gas    =   4.0/2.0;
		my $Pz        = 655.0/2.0;
		my $z         = $bmt_zpcb - 69.0 - $Pz;          
		my $sphi      =   10.909090;                 
                # on drawing 000, looks like sphi~2*dphi; this yields sphi = 120°/11 , temporary
		my $dphi      = ($Dtheta - 2.*$sphi)/18.0;   # = 5.45°, temporary
		#my $dphi      = 6.6;   # there must be room for the 24mm flat cables: $dphi > (24+2*Px)/235, temporary
		#my $sphi      = ($Dtheta - 18.0*$dphi - (180./$pi)*6.0/235.0)/2.; # gives 0 !! 

	for(my $s = 0; $s < $ntile; $s++)
	{
	my $tile_no= $s + 1;
	for(my $r = 0; $r < 19; $r++)
	{
	my $rod_no= $r + 1;	
	        my $theta_rot = 30.0 + $sphi + $s*120. + $r*$dphi;
		my $x         = (235.0 + $Px)*cos($theta_rot*$pi/180.0); 
		my $y         = (235.0 + $Px)*sin($theta_rot*$pi/180.0); 
	        if ($r > 16){
		   $x         = (235.0 + $Px_gas)*cos($theta_rot*$pi/180.0); 
		   $y         = (235.0 + $Px_gas)*sin($theta_rot*$pi/180.0);  
		}
		my %detector = init_det();
		$detector{"name"}        = "$vname\_$tile_no\_$rod_no";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio";
		$detector{"pos"}         = "$x*mm $y*mm $z*mm";
		$detector{"rotation"}    = "0*deg 0*deg -$theta_rot*deg";
		$detector{"color"}       = $structure_color;
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$Px*mm $Py*mm $Pz*mm";
	        if ($r > 16) {$detector{"dimensions"}  = "$Px_gas*mm $Py_gas*mm $Pz*mm";}
		$detector{"material"}    = $Cfiber_material;
		$detector{"ncopy"}       = 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
	}
}

sub place_overcover
{
                my $vname      = "BMT_OverCover";
                my $descriptio = "BMT_OverCover";
	
		my $PRMin     = 239.01; 
		my $PRMax     = $PRMin + 0.2; 
		my $PDz       = 724.0/2.0;
		my $z         = $bmt_zpcb - $PDz;
		my $PSPhi     = 0.; 
		my $PDPhi     = 360.;

		my %detector = init_det();
		$detector{"name"}        = "$vname";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = $structure_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"material"}    = $pcb_material;
		$detector{"ncopy"}       = 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
}

sub place_forwardinterface
{
                my $vname      = "BMT_ForwardInterface";
                my $descriptio = "BMT_ForwardInterface";
		
	   # rings :

                my $PSPhi     = 0.; 
		my $PDPhi     = 360.;
		my @rmin      = (140.0, 141.5, 144.5, 215.0);
		my @rmax      = (141.5, 144.5, 148.0, 234.0);
		my @dz        = ( 15.0,  25.0,   8.0,   8.0);
		my @z         = (  0.5,  -4.5,   4.0,   4.0);
		for(my $r = 0; $r < 4; $r++)
		{
	        my $ring_no = $r + 1;
		my $PRMin   = $rmin[$r];
		my $PRMax   = $rmax[$r];
		my $PDz     = 0.5*$dz[$r];
		$z[$r]      = $bmt_zpcb + $z[$r]; 

		my %detector = init_det();
		$detector{"name"}        = "$vname\_ring$ring_no";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio";
		$detector{"pos"}         = "0*mm 0*mm $z[$r]*mm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = $structure_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"material"}    = $peek_material;
		$detector{"ncopy"}       = 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
		}

	   # attachments for stiffeners:
		# this is modeled by a full peek volume of 6 x 89.5 x 9.25 mm3
		# 9.25 mm thickness was calculated to be equivalent to the 12 plots + last part of the stiffener (see MG notebook p. 148); 9.25 + 7.75 (Stiffeners_dwnstrm) = 17 mm.
                
		my $Py        =  6.0/2.0;               
		my $Px        =  (233.96 - 144.5)/2.0;  # not 234 to avoid overlap with cover 
		my $Pz        =  9.25/2.0;                 
		my $z         =  $bmt_zpcb - $Pz;    

		for(my $s = 0; $s < $ntile; $s++)
		{
		my $element_no= $s + 1;	
	        my $theta_rot = 30.0 + $s*120.0;
		my $x         = (144.5 + $Px)*cos($theta_rot*$pi/180.0);
		my $y         = (144.5 + $Px)*sin($theta_rot*$pi/180.0);

		my %detector = init_det();
		$detector{"name"}        = "$vname\_attStiff$element_no";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio";
		$detector{"pos"}         = "$x*mm $y*mm $z*mm";
		$detector{"rotation"}    = "0*deg 0*deg -$theta_rot*deg";
		$detector{"color"}       = $structure_color;
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$Px*mm $Py*mm $Pz*mm";
		$detector{"material"}    = $peek_material;
		$detector{"ncopy"}       = 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
		}

           # 3 branches:
		                
		$Py        =  24.0/2.0;                
		$Px        =  (214.76 - 148.0)/2.0; # not 215 in order to avoid overlap with 4th ring above; 
		$Pz        =  8.0/2.0;                
		$z         =  $bmt_zpcb + $Pz;   

		for(my $s = 0; $s < $ntile; $s++)
		{
		my $element_no= $s + 1;	
	        my $theta_rot = 30.0 + $s*120.0;
		my $x         = (148.0 + $Px)*cos($theta_rot*$pi/180.0);
		my $y         = (148.0 + $Px)*sin($theta_rot*$pi/180.0);

		my %detector = init_det();
		$detector{"name"}        = "$vname\_branch$element_no";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio";
		$detector{"pos"}         = "$x*mm $y*mm $z*mm";
		$detector{"rotation"}    = "0*deg 0*deg -$theta_rot*deg";
		$detector{"color"}       = $structure_color;
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$Px*mm $Py*mm $Pz*mm";
		$detector{"material"}    = $peek_material;
		$detector{"ncopy"}       = 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
		}

	   # attachments for FMT (?) :
		$PRMin        = 234.0;
		$PRMax        = 240.0;
                $PDz          = 0.5*6.0;                       # temporary
	        $z            = $bmt_zpcb + 8.0 - $PDz;        # temporary
	       	my @phi       = (0.75, 29.25, 180.75, 209.25); # temporary
		$PDPhi        = 7.0;                           # temporary
		
		for(my $a = 0; $a < 4; $a++)
		{
	        my $attfmt_no = $a + 1;
		$PSPhi        = $phi[$a] - 0.5*$PDPhi;
	

		my %detector = init_det();
		$detector{"name"}        = "$vname\_attFMT$attfmt_no";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = $structure_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"material"}    = $peek_material;
		$detector{"ncopy"}       = 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
		}
}

sub place_closingplate
{
                my $vname      = "BMT_ClosingPlate";
                my $descriptio = "BMT_ClosingPlate";
	
		my $PRMin     = 146.0; 
		my $PRMax     = 217.0; 
		my $PDz       = 0.5;
                my $z         = $bmt_zpcb + 8.0 + $PDz; 
		my $PSPhi     = 0.; 
		my $PDPhi     = 360.;

		my %detector = init_det();
		$detector{"name"}        = "$vname";
		$detector{"mother"}      = $envelope;
		$detector{"description"} = "$descriptio";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = $structure_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		$detector{"material"}    = $Cfiber_material;
		$detector{"ncopy"}       = 1;
		$detector{"visible"}     = 0;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
}

1;
