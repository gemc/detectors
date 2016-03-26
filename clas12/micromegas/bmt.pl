# use strict;
use warnings;

our %configuration;
our %parameters;


# All dimensions in mm

my @radius =();
my @starting_point =();
my @Dz_halflength =();
my @starting_theta =();
my @Inactivtheta =();
my @dtheta =();
my @dtheta_start =();

my $bmt_ir 		= $parameters{"BMT_mothervol_InnerRadius"};
my $bmt_or 		= $parameters{"BMT_mothervol_OutRadius"};
my $bmt_dz 		= $parameters{"BMT_mothervol_HalfLength"};
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
my $Coverlay_Width			= $parameters{"BMT_Coverlay_width"};
my $CuGround_Width			= 0.082*$parameters{"BMT_CuGround_width"};#0.082 from gerber : 1 - 4.6*4.6/(4.6+0.2)*(4.6+0.2) = 0.082
my $PCB_Width 	    		= $parameters{"BMT_PCBGround_width"};
my $CuStrips_Width 			= $parameters{"BMT_CuStrips_width"};#opacity taken into account in the density of the material
my $KaptonStrips_Width 		= $parameters{"BMT_KaptonStrips_width"};
my $ResistStrips_Width 		= $parameters{"BMT_ResistStrips_width"};#opacity taken into account in the density of the material
my $Gas1_Width 	    		= $parameters{"BMT_Gas1_width"};
my $Mesh_Width 	    		= $parameters{"BMT_Mesh_width"};#opacity taken into account in the density of the material
my $Gas2_Width 	    		= $parameters{"BMT_Gas2_width"};
my $DriftZCuElectrode_Width	= 0.024*$parameters{"BMT_DriftCuElectrode_width"};#0.024 from gerber : 1 - 10*10/(10+0.12)*(10+0.12) = 0.024
my $DriftCCuElectrode_Width	= $parameters{"BMT_DriftCuElectrode_width"};#for CRnC, the Cu electrode is not a mesh
my $DriftKapton_Width 		= $parameters{"BMT_DriftKapton_width"};
my $DriftCuGround_Width 	= 0.082*$parameters{"BMT_DriftCuGround_width"};#0.024 from gerber : 1 - 4.6*4.6/(4.6+0.2)*(4.6+0.2) = 0.082

my $Dtheta               = 360.0/$ntile; # rotation angle for other tiles
$Inactivtheta[0]		 = (20/$radius[0])*(180./3.14159265358); # =7.863 #not in activ area (in degrees) (20 mm taken by mecanics, not activ area)
$Inactivtheta[1]		 = (20/$radius[1])*(180./3.14159265358); # =7.129
$Inactivtheta[2]		 = (20/$radius[2])*(180./3.14159265358); # =6.521
$Inactivtheta[3]		 = (20/$radius[3])*(180./3.14159265358); # =6.008
$Inactivtheta[4]		 = (20/$radius[4])*(180./3.14159265358); # =5.570
$Inactivtheta[5]		 = (20/$radius[5])*(180./3.14159265358); # =5.191
$dtheta[0]               = $Dtheta-$Inactivtheta[0]; # angle covered by one tile (active area) (in degrees)
$dtheta[1]               = $Dtheta-$Inactivtheta[1];
$dtheta[2]               = $Dtheta-$Inactivtheta[2];
$dtheta[3]               = $Dtheta-$Inactivtheta[3];
$dtheta[4]               = $Dtheta-$Inactivtheta[4];
$dtheta[5]               = $Dtheta-$Inactivtheta[5];
$dtheta_start[0]		 = $Inactivtheta[0]/2.0; # slight rotation to keep symetry.
$dtheta_start[1]		 = $Inactivtheta[1]/2.0;
$dtheta_start[2]		 = $Inactivtheta[2]/2.0;
$dtheta_start[3]		 = $Inactivtheta[3]/2.0;
$dtheta_start[4]		 = $Inactivtheta[4]/2.0;
$dtheta_start[5]		 = $Inactivtheta[5]/2.0;

# materials
my $air_material	 		  = 'myAir';
my $copper_material	     = 'myCopper';
my $pcb_material      	  = 'myFR4';
my $bmtz4_strips_material = 'mybmtz4MMStrips';#taking into account pitch/opacity
my $bmtz5_strips_material = 'mybmtz5MMStrips';#taking into account pitch/opacity
my $bmtz6_strips_material = 'mybmtz6MMStrips';#taking into account pitch/opacity
my $bmtc4_strips_material = 'mybmtc4MMStrips';#taking into account pitch/opacity
my $bmtc5_strips_material = 'mybmtc5MMStrips';#taking into account pitch/opacity
my $bmtc6_strips_material = 'mybmtc6MMStrips';#taking into account pitch/opacity
my $kapton_material    	  = 'myKapton';
my $bmtz4_resist_material = 'mybmtz4ResistPaste';#taking into account pitch/opacity
my $bmtz5_resist_material = 'mybmtz5ResistPaste';#taking into account pitch/opacity
my $bmtz6_resist_material = 'mybmtz6ResistPaste';#taking into account pitch/opacity
my $bmtc4_resist_material = 'mybmtc4ResistPaste';#taking into account pitch/opacity
my $bmtc5_resist_material = 'mybmtc5ResistPaste';#taking into account pitch/opacity
my $bmtc6_resist_material = 'mybmtc6ResistPaste';#taking into account pitch/opacity
my $gas_material       	  = 'mybmtMMGas';
my $mesh_material      	  = 'mybmtMMMesh';
#define myGlue...

# G4 colors
# (colors random)
my $air_color		   = 'e200e1';
my $copper_color	   = '666600';
my $pcb_color        = '0000ff';
my $strips_color     = '353540';
my $kapton_color	   = 'fff600';
my $resist_color	   = '000000';
my $gas_color        = 'e10000';
my $mesh_color       = '252020';

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
my $SL_dz = $bmt_dz;

sub build_bmt
{
	make_bmt();
	make_sl(1);
	make_sl(2);
	make_sl(3);
	make_sl(4);
	make_sl(5);
	make_sl(6);
	
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
}

sub make_bmt
{
	my %detector = init_det();
	$detector{"name"}        = "bmt";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Barrel Micromegas Vertex Tracker";
	$detector{"pos"}         = "0*cm 0*cm 0*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "aaaaff";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$bmt_ir*mm $bmt_or*mm $bmt_dz*mm 0*deg 360*deg";
	$detector{"material"}    = "Air";
	$detector{"visible"}     = 0;
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);
}

sub make_sl
{
	my $slnumber = shift;
	my $slindex  = $slnumber - 1;
	
	my %detector = init_det();
	$detector{"name"}        = "SL2_$slnumber";
	$detector{"mother"}      = "bmt";
	$detector{"description"} = "Super Layer $slnumber";
	$detector{"pos"}         = "0*cm 0*cm 0*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "aaaaff";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$SL_ir[$slindex]*mm $SL_or[$slindex]*mm $SL_dz*mm 0*deg 360*deg";
	$detector{"material"}    = "Air";
	$detector{"visible"}     = 0;
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);
}

sub place_coverlay
{
	my $l    = shift;
	my $layer_no       = $l + 1;
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
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
		my $PRMin     = $radius[$l];
		my $PRMax     = $radius[$l] + $Coverlay_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; # to be defined, in degres
		my $PDPhi     = $dtheta[$l];
		
		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      =  "SL2_$layer_no";
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
	my $l    = shift;
	my $layer_no       = $l + 1;
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
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
		my $PRMin     = $radius[$l] + $Coverlay_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; # to be defined, in degres
		my $PDPhi     = $dtheta[$l];
		
		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      =  "SL2_$layer_no";
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
	my $l    = shift;
	my $layer_no       = $l + 1;
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
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
		my $PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; # to be defined, in degres
		my $PDPhi     = $dtheta[$l];
		
		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      =  "SL2_$layer_no";
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
	my $l    = shift;
	my $layer_no       = $l + 1;
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
		my $snumber     = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
		my $PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; # to be defined, in degres
		my $PDPhi     = $dtheta[$l];
		
		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      =  "SL2_$layer_no";
		$detector{"description"} = "$descriptio Segment $snumber";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = rot($l, $s);
		$detector{"color"}       = $strips_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		if($l == 0)
		{
			$detector{"material"}    = $bmtc4_strips_material;
		}
		if($l == 3)
		{
			$detector{"material"}    = $bmtc5_strips_material;
		}
		if($l == 5)
		{
			$detector{"material"}    = $bmtc6_strips_material;
		}
		if($l == 1)
		{
			$detector{"material"}    = $bmtz4_strips_material;
		}
		if($l == 2)
		{
			$detector{"material"}    = $bmtz5_strips_material;
		}
		if($l == 4)
		{
			$detector{"material"}    = $bmtz6_strips_material;
		}
		$detector{"ncopy"}       = $s + 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
		
	}
}

sub place_kapton
{
	my $l    = shift;
	my $layer_no       = $l + 1;
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
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
		my $PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; # to be defined, in degres
		my $PDPhi     = $dtheta[$l];
		
		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      =  "SL2_$layer_no";
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
	my $l    = shift;
	my $layer_no       = $l + 1;
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
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
		my $PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; # to be defined, in degres
		my $PDPhi     = $dtheta[$l];
		
		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      =  "SL2_$layer_no";
		$detector{"description"} = "$descriptio Segment $snumber";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = rot($l, $s);
		$detector{"color"}       = $resist_color;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
		if($l == 0)
		{
			$detector{"material"}    = $bmtc4_resist_material;
		}
		if($l == 3)
		{
			$detector{"material"}    = $bmtc5_resist_material;
		}
		if($l == 5)
		{
			$detector{"material"}    = $bmtc6_resist_material;
		}
		if($l == 1)
		{
			$detector{"material"}    = $bmtz4_resist_material;
		}
		if($l == 2)
		{
			$detector{"material"}    = $bmtz5_resist_material;
		}
		if($l == 4)
		{
			$detector{"material"}    = $bmtz6_resist_material;
		}
		$detector{"ncopy"}       = $s + 1;
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
		
	}
}

sub place_gas1
{
	my $l    = shift;
	my $layer_no       = $l + 1;
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
		my $snumber     = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
		my $PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; # to be defined, in degres
		my $PDPhi     = $dtheta[$l];
		
		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      =  "SL2_$layer_no";
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
	my $l    = shift;
	my $layer_no = $l + 1;
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
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
		my $PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; # to be defined, in degres
		my $PDPhi     = $dtheta[$l];
		
		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      =  "SL2_$layer_no";
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
	my $l    = shift;
	my $layer_no = $l + 1;
	my $vname      = 0;
	my $descriptio = 0;
	my $type = 0;
	
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
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
		my $PRMin     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width;
		my $PRMax     = $radius[$l] + $Coverlay_Width + $CuGround_Width + $PCB_Width + $CuStrips_Width + $KaptonStrips_Width + $ResistStrips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = $dtheta_start[$l]; # to be defined, in degres
		my $PDPhi     = $dtheta[$l];
		
		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      = "SL2_$layer_no";
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
	my $l = shift;
	my $layer_no = $l + 1;
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
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
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
		$detector{"mother"}      = "SL2_$layer_no";
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
	my $l = shift;
	my $layer_no = $l + 1;
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
		my $snumber     = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
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
		my $PSPhi     = $dtheta_start[$l]; # to be defined, in degres
		my $PDPhi     = $dtheta[$l];
		
		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      = "SL2_$layer_no";
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
	my $l = shift;
	my $layer_no = $l + 1;
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
		my $snumber     = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
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
		$detector{"mother"}      = "SL2_$layer_no";
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


