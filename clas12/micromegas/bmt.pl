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
my $PCB_Width 	        = $parameters{"BMT_PCB_width"};
my $Strips_Width 	= $parameters{"BMT_Strips_width"};
my $Gas1_Width 	        = $parameters{"BMT_Gas1_width"};
my $Mesh_Width 	        = $parameters{"BMT_Mesh_width"};
my $Gas2_Width 	        = $parameters{"BMT_Gas2_width"};
my $Drift_Width 	= $parameters{"BMT_Drift_width"};

my $Dtheta              = 360.0/$ntile; # rotation angle for other tiles
my $dtheta               = $Dtheta-0.1;  # angle covered by one tile

# G4 materials
my $pcboard_material   = 'Epoxy';
my $strips_material    = 'MMStrips';
my $gas_material       = 'MMGas';
my $mesh_material      = 'MMMesh';
my $drift_material     = 'Epoxy';

# G4 colors
my $pcboard_color      = '0000ff';
my $strips_color       = '353540';
my $gas_color          = 'e10000';
my $mesh_color         = '252020';
my $drift_color        = 'fff600';

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

sub define_bmt
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
    
    	place_pcboard($l);
    	place_strips($l);
    	place_gas1($l);
    	place_mesh($l);
    	place_gas2($l);
		place_drift($l);
	}
}

sub make_bmt
{
 	my %detector = init_det();
 	$detector{"name"}        = $envelope;
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
 	$detector{"mother"}      = $envelope;
 	$detector{"description"} = "Super Layer $slnumber";
 	$detector{"pos"}         = "0*cm 0*cm 0*cm";
 	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
 	$detector{"color"}       = "aaaaff";
 	$detector{"type"}        = "Tube";
 	$detector{"dimensions"}  = "$SL_ir[$slindex]*mm $SL_or[$slindex]*mm $SL_dz*mm 0*deg 360*deg";
 	$detector{"material"}    = "Air";
	print_det(\%configuration, \%detector);
}

sub place_pcboard
{
    my $l    = shift;
    my $layer_no       = $l + 1; 
    my $vname      = 0;
    my $descriptio = 0;

    if(($l % 2) == 0)
    {
	$vname      = "BMT_PCB_V_Layer";
	$descriptio = "PCB V, Layer $layer_no, ";
    }
    if(($l % 2) == 1)
    {
	$vname      = "BMT_PCB_W_Layer";
	$descriptio = "PCB W, Layer $layer_no, ";
    }
    
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
		my $snumber   = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
		my $PRMin     = $radius[$l];
		my $PRMax     = $radius[$l] + $PCB_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = 0.0; # to be defined, in degres
		my $PDPhi     = $dtheta;

		my %detector = init_det();
        $detector{"name"}        = "$vname$layer_no\_Segment$snumber";
        $detector{"mother"}      =  "SL2_$layer_no";
        $detector{"description"} = "$descriptio Segment $snumber";
        $detector{"pos"}         = "$0*mm 0*mm $z*mm";
        $detector{"rotation"}    = rot($l, $s);
        $detector{"color"}       = $pcboard_color;
        $detector{"type"}        = "Tube";
        $detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
        $detector{"material"}    = $pcboard_material;
        $detector{"ncopy"}       = $s + 1;
		print_det(\%configuration, \%detector);

    } 
}

sub place_strips
{
    my $l    = shift;
    my $layer_no       = $l + 1;
    my $vname      = 0;
    my $descriptio = 0;

    if(($l % 2) == 0)
    {
	$vname      = "BMT_Strips_V_Layer";
	$descriptio = "Strips V, Layer $layer_no, ";
    }
    if(($l % 2) == 1)
    {
	$vname      = "BMT_Strips_W_Layer";
	$descriptio = "Strips W, Layer $layer_no, ";
    }
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
        my $snumber     = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
		my $PRMin     = $radius[$l] + $PCB_Width;
		my $PRMax     = $radius[$l] + $PCB_Width + $Strips_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = 0.0; # to be defined, in degres
		my $PDPhi     = $dtheta;

		my %detector = init_det();
        $detector{"name"}        = "$vname$layer_no\_Segment$snumber";
        $detector{"mother"}      =  "SL2_$layer_no";
        $detector{"description"} = "$descriptio Segment $snumber";
        $detector{"pos"}         = "0*mm 0*mm $z*mm";
        $detector{"rotation"}    = rot($l, $s);
        $detector{"color"}       = $strips_color;
        $detector{"type"}        = "Tube";
        $detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
        $detector{"material"}    = $strips_material;
        $detector{"ncopy"}       = $s + 1;
		print_det(\%configuration, \%detector);
	
    } 
}

sub place_gas1
{
    my $l    = shift;
    my $layer_no       = $l + 1;
    my $vname      = 0;
    my $descriptio = 0;

    if(($l % 2) == 0)
    {
		$vname      = "BMT_Gas1_V_Layer";
		$descriptio = "Gas1 V, Layer $layer_no, ";
    }
        if(($l % 2) == 1)
    {
		$vname      = "BMT_Gas1_W_Layer";
		$descriptio = "Gas1 W, Layer $layer_no, ";
    }
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
        my $snumber     = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
		my $PRMin     = $radius[$l] + $PCB_Width + $Strips_Width;
		my $PRMax     = $radius[$l] + $PCB_Width + $Strips_Width + $Gas1_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = 0.0; # to be defined, in degres
		my $PDPhi     = $dtheta;

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
		print_det(\%configuration, \%detector);

    } 
}

sub place_mesh
{
    my $l    = shift;
    my $layer_no = $l + 1;
    my $vname      = 0;
    my $descriptio = 0;

    if(($l % 2) == 0)
    {
		$vname      = "BMT_Mesh_V_Layer";
		$descriptio = "Mesh V, Layer $layer_no, ";
    }
    if(($l % 2) == 1)
    {
		$vname      = "BMT_Mesh_W_Layer";
		$descriptio = "Mesh W, Layer $layer_no, ";
    }
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
        my $snumber     = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
		my $PRMin     = $radius[$l] + $PCB_Width + $Strips_Width + $Gas1_Width;
		my $PRMax     = $radius[$l] + $PCB_Width + $Strips_Width + $Gas1_Width + $Mesh_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = 0.0; # to be defined, in degres
		my $PDPhi     = $dtheta;

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

    if(($l % 2) == 0)
    {
		$vname      = "BMT_Gas2_V_Layer";
		$descriptio = "Gas2 V, Layer $layer_no, ";
		$type = 1;
    }
    if(($l % 2) == 1)
    {
		$vname      = "BMT_Gas2_W_Layer";
		$descriptio = "Gas2 W, Layer $layer_no, ";
		$type = 2;
    }
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
        my $snumber     = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
		my $PRMin     = $radius[$l] + $PCB_Width + $Strips_Width + $Gas1_Width + $Mesh_Width;
		my $PRMax     = $radius[$l] + $PCB_Width + $Strips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = 0.0; # to be defined, in degres
		my $PDPhi     = $dtheta;

		my %detector = init_det();
        $detector{"name"}        = "$vname$layer_no\_Segment$snumber";
        $detector{"mother"}      = "SL2_$layer_no";
        $detector{"description"} = "$descriptio  Segment $snumber";
        $detector{"pos"}         = "0*mm 0*mm $z*mm";
        $detector{"rotation"}    = rot($l, $s);
        $detector{"color"}       = $gas_color;
        $detector{"type"}        = "Tube";
        $detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
        $detector{"material"}    =  $gas_material;
        $detector{"ncopy"}       = $s + 1;
		$detector{"sensitivity"} = "bmt";
        $detector{"hit_type"}    = "bmt";
        $detector{"identifiers"} ="superlayer manual $layer_no type manual $type segment manual $detector{'ncopy'} strip manual 1";

        print_det(\%configuration, \%detector);

    } 
}

sub place_drift
{
    my $l = shift;
    my $layer_no = $l + 1;
    my $vname      = 0;
    my $descriptio = 0;

    if(($l % 2) == 0)
    {
		$vname      = "BMT_Drift_V_Layer";
		$descriptio = "Drift V, Layer $layer_no, ";
    }
    if(($l % 2) == 1)
    {
		$vname      = "BMT_Drift_W_Layer";
		$descriptio = "Drift W, Layer $layer_no, ";
    }
    for(my $s = 0; $s < $ntile; $s++)
    {
		# names
        my $snumber     = segnumber($s);
		my $z         = $starting_point[$l] + $Dz_halflength[$l];
		my $PRMin     = $radius[$l] + $PCB_Width + $Strips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width;
		my $PRMax     = $radius[$l] + $PCB_Width + $Strips_Width + $Gas1_Width + $Mesh_Width + $Gas2_Width + $Drift_Width;
		my $PDz       = $Dz_halflength[$l];
		my $PSPhi     = 0.0; # to be defined, in degres
		my $PDPhi     = $dtheta;

		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      = "SL2_$layer_no";
		$detector{"description"} = "$descriptio Segment $snumber";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = rot($l, $s);
		$detector{"color"}       = $drift_color;
		$detector{"type"}        = "Tube";
        $detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm $PSPhi*deg $PDPhi*deg";
        $detector{"mfield"}      = "no";
        $detector{"ncopy"}       = $s + 1;
		print_det(\%configuration, \%detector);
	
    } 
}


1;