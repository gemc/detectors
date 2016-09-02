use strict;
use warnings;

our %configuration;
our %parameters;

# General description
# The BST is not symmetric around z=0
# So we need to introduce a shift to the mother volume
# that needs to be subtracted from all placements
my $zshift = 50;


our @nsegments = ( $parameters{"nsegments_r1"},
$parameters{"nsegments_r2"},
$parameters{"nsegments_r3"},
$parameters{"nsegments_r4"} );   # Number of segments in each layer

my @starting_point = ( $parameters{"starting_z_r1"} + $zshift,
$parameters{"starting_z_r2"} + $zshift,
$parameters{"starting_z_r3"} + $zshift,
$parameters{"starting_z_r4"} + $zshift);   # Z starting_point of the sensor in each region

our $nregions = $parameters{"nregions"};




my $l1c_spacing = 250;  # spacing between the chip and the l1c

my @number_of_modules  = (3        , 3         , 3         , 3       );   # Number of modules for each layer
my @bst_copper_length  = (105.99   , 145.36    , 184.32    , 242.44  );   # From the Pitch Adapter to the Cold Plate


my $bst_ir = 50;         # Mother Volume IR
my $bst_or = 174;        # Mother Volume OR
my $bst_dz = 831.0/2.0;  # Mother Volume half length


my @SL_ir = (60, 85,  112, 154);    # Individual superlayers IR, OR
my @SL_or = (75, 103, 130, 171);
my $SL_dz = 325.0;



#######################
# Dimensions:
# Each segment is a Box
#######################
my $rohacell_length       = 353.07;          # Rohacell support length 3xsensor + 3xgap + 2mm end + 13.5 plastic + 2mm pitch adapter = 352.705
my $rohacell_height       = 38.00;           # Rohacell support transverse dimension
my $plastic_length        = 13.50;           # Plastic Tab length
my $plastic_height        = 20.00;           # Palstic Tab transverse dimension
my $roh_carbon_gap        = 4.0;             # Z Gap between rohacell and carbon fiber (Pitch Adapter)
my $module_length         = 111.625;         # Module length
our $module_height        = 42.02;           # Module transverse dimension
my $silicon_height        = $module_height;  # Module transverse dimension
my $carbon_fiber_length   = 401.900;         # Carbon Fiber support length
my $readout_plate_length  = 41.00;           # Readout plate length
my $pcboard_length        = 37.00;           # HFCB length
my $pcboard_height        = 36.75;           # HFCB transverse dimension
my $wirebond_length       = 3.00;            # Wirebond length
my $chip_length           = 5.0;             # chip length
my $chip_height           = 8.0;             # chip transverse dimension
our $chip_displacement    = 8.0;             # chip displacement from center
my $pitch_adapter_length  = 4;               # Pitch Adapter Length
my $bst_support_height    = 42;
my $silicon_gap_width     = 0.11;

# widths
our $silicon_width      = 0.320;    # Silicon sensor width
our $epoxy_width        = 0.100;    # Total Epoxy glue width - this is TDR 1100 - it does not go above the pads
our $bus_cable_width    = 0.031;    # Bus Cable width
our $carbon_fiber_width = 0.250;    # Carbon fiber 190 width + 60 microns scotch , overall 250 microns
our $rohacell_width     = 2.500;    # Rohacell width
my $plastic_width       = 2.490;    # Rohacell width
my $pcboard_width       = 0.500;    # PC Board width
my $chip_width          = 0.500;    # chip width
my $wirebond_width      = 0.300;    # Wirebond width
my $bst_support_width   = 2.500;    # Support Copper width


# 1/2 micron of gap between all layers
# this should be present to avoid overlaps between volumes
our $microgap_width = 0.002;


### Bus cable study
# Bus Cable width, this does NOT include the rail or the pads (even though the
# bus cable include those)
# 25.4 microns of polyimide
# 3 microns of mesh, at 25.4% surface it correspond to 0.7 microns. However we'll make it 1um - that should account for the average approximation poor precision
#my $bus_cable_width_nominal    = 0.0254 + 0.001;
#my $bus_cable_width = $bus_cable_width_nominal;

my $rail_width  = 0.003;
my $rail_height = 0.125; # 5 mils


# pads radii
# the pads material include the glue
our $pad_radius       = 3/2.0;
our $pad_displacement = 6 + 0.5;   # pad displacement from center
my $pad_thickness    = $epoxy_width/2.0 - $rail_width/2 - 4*$microgap_width;  # half thickness. With the rail, same total width as the glue + polyimide coverlay.



# G4 materials
my $silicon_material      = 'G4_Si';
my $rohacell_material     = 'rohacell';
my $carbon_fiber_material = 'carbonFiber';
my $epoxy_material        = 'tdr1100';

my $bus_cable_material = 'BusCable';
my $rail_material      = 'G4_Cu';
my $pad_material       = 'BusCableCopperAndNickelAndGold';

my $pcboard_material      = 'pcBoardMaterial';
my $paboard_material      = 'G4_SILICON_DIOXIDE';
my $chip_material         = 'pcBoardMaterial';
my $wirebond_material     = 'svtwirebond';
my $bst_support_material  = 'G4_Cu';


# G4 colors
my @silicon_color      = ('353540', '404045', '353540');
my $bus_cable_color    = '1205a1';
my $epoxy_color        = 'e200e1';
my $rohacell_color     = 'e10000';
my $carbon_fiber_color = '252020';
my $pcboard_color      = '0000ff';
my $paboard_color      = 'ff0000';
my $chip_color         = 'fff600';
my $pad_color          = 'eef6ff';
my $wirebond_color     = 'a5af9a';
my $bst_support_color  = '339933';


require "./utils.pl";


my $svt_shell_thickness = 0.25; # 250 microns thick aluminized Mylar (~5 micron aluminum and 250 micron mylar)

my @shell_ir  = (56.9,  132.5, 144.0, 178.6) ;
my @shell_len = (540.0, 553.7, 466.0, 628.7) ;
my @shell_z   = (307.7, 331.0, 171.5, 345.3) ;



# BST is a Tube. SLs are Tubes inside BST
sub makeBST
{
	
	for(my $l = 0; $l < $nregions; $l++)
	{
		make_sl($l+1);
		
		# sensitive sandwich
		place_wirebond($l, 1);      # -- wirebond
		place_silicon($l, 1);       # ---- silicon
		place_epoxy($l, 1, 1);      # ------ epoxy
		place_epoxy($l, 1, 2);      # ------ epoxy
		place_rail($l, 1);          # -------- rail
		place_bus_cable($l, 1);     # ---------- bus cable
		place_carbon_fiber($l, 1);  # ------------ carbon fiber
		place_rohacell($l);         # -------------- rohacell
		place_carbon_fiber($l, 2);  # ------------ carbon fiber
		place_bus_cable($l, 2);     # ---------- bus cable
		place_rail($l, 2);          # -------- rail
		place_epoxy($l, 2, 1);      # ------ epoxy
		place_epoxy($l, 2, 2);      # ------ epoxy
		place_silicon($l, 2);       # ---- silicon
		place_wirebond($l, 2);      # -- wirebond
		
		
		# electronics
		place_chip($l, 1, 1);       # ---- readout chip
		place_chip($l, 1, 2);       # ---- readout chip
		place_pcboard($l, 1);       # ------ pc board
		place_pitch_adapter($l, 1); # -------- pitch adapther from module to pc board
		place_pitch_adapter($l, 2); # -------- pitch adapther from module to pc board
		place_pcboard($l, 2);       # ------ pc board
		place_chip($l, 2, 1);       # ---- readout chip
		place_chip($l, 2, 2);       # ---- readout chip
		
		# support
		place_copper_support($l);
		place_downstream_support($l);
		
		# Aluminized Mylar shells
		# To act as faraday cage
		make_shells($l+1);
	}
}


sub make_sl
{
	my $slnumber = shift;
	my $slindex  = $slnumber - 1;
	
	my %detector = init_det();
	$detector{"name"}        = "bst_sl_$slnumber";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Super Layer $slnumber";
	$detector{"pos"}         = "0*cm 0*cm -$zshift*mm";
	$detector{"color"}       = "aaaaff";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$SL_ir[$slindex]*mm $SL_or[$slindex]*mm $SL_dz*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_AIR";
	$detector{"visible"}     = 0;
	print_det(\%configuration, \%detector);
}




sub place_silicon
{
	my $l          = shift;
	my $type       = shift;
	my $layer_no   = $l + 1;
	my $r          = 0;
	my $vname      = 0;
	my $descriptio = 0;
	my $p_index    = 1;  # Position index
	my $position_i = $p_index;
	
	if($type == 1)
	{
		$vname      = "si_V_Layer";
		$descriptio = "Barrel Silicon Tracker, Silicon V, Layer $layer_no, ";
	}
	
	if($type == 2)
	{
		
		$position_i = tot_nlayers() - $p_index + 1;
		$vname      = "si_W_Layer";
		$descriptio = "Barrel Silicon Tracker, Silicon W, Layer $layer_no, ";
	}
	$r = r_placement($l, $position_i);
	
	for(my $m = 0; $m < $number_of_modules[$l]; $m++)
	{
		my $module_n = $m + 1;
		
		for(my $s = 0; $s < $nsegments[$l] ; $s++)
		{
			my $snumber   = cnumber($s, 10);
			my $tpos      = pos_t($r, $l, $s);
			my $z         = $starting_point[$l] + $module_length / 2 + $m*$module_length + $m*$microgap_width + $m*$silicon_gap_width;
			my $Dx        = $silicon_height / 2;
			my $Dy        = $silicon_width  / 2;
			my $Dz        = $module_length  / 2;
			my $segment_n = $s + 1;
			
			my %detector = init_det();
			$detector{"name"}        = "$vname$layer_no\_Module$module_n\_Segment$snumber";
			$detector{"mother"}      = "bst_sl_$layer_no";
			$detector{"description"} = "$descriptio Module $module_n, Segment $segment_n";
			$detector{"pos"}         = "$tpos $z*mm";
			$detector{"rotation"}    = rot($r, $l, $s);
			$detector{"color"}       = $silicon_color[$m];
			$detector{"type"}        = "Box";
			$detector{"dimensions"}  = "$Dx*mm $Dy*mm $Dz*mm";
			$detector{"material"}    = $silicon_material;
			$detector{"style"}       = 1;
			$detector{"ncopy"}       = $s + 1;
			$detector{"sensitivity"} = "bst";
			$detector{"hit_type"}    = "bst";
			$detector{"identifiers"} = "superlayer manual $layer_no type manual $type segment manual $detector{'ncopy'} module manual $module_n strip manual 1";
			print_det(\%configuration, \%detector);
		}
	}
}

sub place_wirebond
{
	my $l          = shift;
	my $type       = shift;
	my $layer_no   = $l + 1;
	my $r          = 0;
	my $vname      = 0;
	my $descriptio = 0;
	my $p_index    = 1;  # Position index
	my $position_i = $p_index;
	
	if($type == 1)
	{
		$r          = r_placement($l, $position_i)            - $wirebond_width / 2.0 - $microgap_width - $silicon_width;
		$vname      = "wirebond_V_Layer";
		$descriptio = "Barrel Silicon Tracker, Wirebond V, Layer $layer_no, ";
	}
	
	if($type == 2)
	{
		$r = r_placement($l, tot_nlayers() - $position_i + 1) + $wirebond_width / 2.0 + $microgap_width + $silicon_width;
		$vname      = "wirebond_W_Layer";
		$descriptio = "Barrel Silicon Tracker, Wirebond W, Layer $layer_no, ";
	}
	
	for(my $m = 0; $m < $number_of_modules[$l]; $m++)
	{
		my $module_n = $m + 1;
		for(my $s = 0; $s < $nsegments[$l] ; $s++)
		{
			my $snumber   = cnumber($s, 10);
			my $Dx        = $pcboard_height  / 2.0;
			my $Dy        = $wirebond_width  / 2.0;
			my $Dz        = $wirebond_length / 2.0;
			my $tpos      = pos_t($r, $l, $s);
			my $z         = $starting_point[$l] + $m*$module_length - $Dz + $wirebond_length / 2.0 ;
			my $segment_n = $s + 1;
			
			my %detector = init_det();
			$detector{"name"}        = "$vname$layer_no\_Module$module_n\_Segment$snumber";
			$detector{"mother"}      = "bst_sl_$layer_no";
			$detector{"description"} = "$descriptio Module $module_n, Segment $segment_n";
			$detector{"type"}        = "Box";
			$detector{"pos"}         = "$tpos $z*mm";
			$detector{"rotation"}    = rot($r, $l, $s);
			$detector{"color"}       = $wirebond_color;
			$detector{"dimensions"}  = "$Dx*mm $Dy*mm $Dz*mm";
			$detector{"material"}    = $silicon_material;
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);
		}
	}
}

# Epoxy goes from the hip to the end of the silicon
# This is actually Epoxy + Plolyimide that covers the bus cable
# and is the same height as the pad + silver epoxy
sub place_epoxy
{
	my $l          = shift;
	my $type       = shift;
	my $updown     = shift;
	my $layer_no   = $l + 1;
	my $r1         = 0;
	my $vname      = 0;
	my $descriptio = 0;
	my $p_index    = 2;  # Position index
	my $position_i = $p_index;
	
	
	for(my $m = 0; $m<$number_of_modules[$l]; $m++)
	{
		if($type == 1)
		{
			$vname      = "epoxy_V_m$m"."_updown$updown"."_layer";
			$descriptio = "Epoxy V, Layer $layer_no, Module $m,  UpDown $updown, ";
		}
		
		if($type == 2)
		{
			$position_i = tot_nlayers() - $p_index + 1;
			$vname      = "epoxy_W_m$m"."_updown$updown"."_layer";
			$descriptio = "Epoxy W, Layer $layer_no,  Module $m, UpDown $updown, ";
		}
		$r1 = r_placement($l, $position_i);
		
		# actually the glue doesn't cover the rail
		# $pad_displacement is from center
		# so one side is module_height/2 - pad_displacement - 2*$pad_radius
		# the other side is  module_height/2 + pad_displacement - 2*$pad_radius
		my $displacement = 0;
		if($type == 1)
		{
			if($updown == 1)
			{
				$displacement =  ($module_height / 2 + $pad_displacement + $pad_radius)/2;
			}
			if($updown == 2)
			{
				$displacement = -($module_height / 2 - $pad_displacement + $pad_radius)/2;
			}
		}
		if($type == 2)
		{
			if($updown == 1)
			{
				$displacement = -($module_height / 2 - $pad_displacement + $pad_radius)/2;
			}
			if($updown == 2)
			{
				$displacement =  ($module_height / 2 + $pad_displacement + $pad_radius)/2;
			}
		}
		
		my $r = sqrt($r1 * $r1 + $displacement * $displacement);
		
		for(my $s = 0; $s < $nsegments[$l] ; $s++)
		{
			my $snumber   = cnumber($s, 10);
			
			my $Dx = 0;
			if($type == 1)
			{
				if($updown == 1)
				{
					$Dx           = $module_height / 4 - $pad_radius/2 - $pad_displacement/2 - 0.1; # subtracting 0.1mm
				}
				if($updown == 2)
				{
					$Dx           = $module_height / 4 - $pad_radius/2 + $pad_displacement/2 - 0.1; # subtracting 0.1mm
				}
			}
			if($type == 2)
			{
				if($updown == 1)
				{
					$Dx           = $module_height / 4 - $pad_radius/2 + $pad_displacement/2 - 0.1; # subtracting 0.1mm
				}
				if($updown == 2)
				{
					$Dx           = $module_height / 4 - $pad_radius/2 - $pad_displacement/2 - 0.1; # subtracting 0.1mm
				}
			}
			
			my $Dy        = $epoxy_width / 2;
			my $Dz        = $module_length/2.0 - 0.1;
			my $tpos      = pos_t_epoxy($r, $l, $s, $updown, $type);
			my $z         = $m*$module_length + $starting_point[$l] + $module_length/2;
			my $segment_n = $s + 1;
			
			my %detector = init_det();
			$detector{"name"}        = "$vname$layer_no\_segment$snumber";
			$detector{"mother"}      = "bst_sl_$layer_no";
			$detector{"description"} = "$descriptio Segment $segment_n";
			$detector{"pos"}         = "$tpos $z*mm";
			$detector{"rotation"}    = rot($r, $l, $s, 1);
			$detector{"color"}       = $epoxy_color;
			$detector{"type"}        = "Box";
			$detector{"dimensions"}  = "$Dx*mm $Dy*mm $Dz*mm";
			$detector{"material"}    = $epoxy_material;
			$detector{"style"}       = 1;
			
			print_det(\%configuration, \%detector);
			
		}
	}
}




# rail and pins
sub place_rail
{
	my $l              = shift;
	my $type           = shift;  # type bottom or up (also, left/right)
	my $layer_no       = $l + 1;
	my $r1             = 0;
	my $r              = 0;
	my $vname          = 0;
	my $descriptio     = 0;
	my $DX             = 0;
	my $DZ             = 0;
	my $position_index = 2; # same as epoxy, need to add the pad thickness for the rail
	
	# the rail are 2 / segment (one top one bottom)
	# RAIL
	
	# since the epoxy doesn't cover the rail, make them thick enough and
	# with composite material so they're thick enough?
	
	my $rail_length    = $rohacell_length/2.0;
	my $rail_thickness = $rail_width/2;
	
	if($type == 1)
	{
		$vname       = "rail_V_L$layer_no";
		$descriptio  = "Rail Tube V, Layer $layer_no, ";
		# rails is at the bottom of the pads
		$r1          = r_placement($l, $position_index) + $pad_thickness + $rail_thickness + $microgap_width;
	}
	
	if($type == 2)
	{
		$vname       = "rail_W_L$layer_no";
		$descriptio  = "Rail Tube W, Layer $layer_no, ";
		$r1          = r_placement($l, tot_nlayers() - $position_index + 1)  - $pad_thickness - $rail_thickness - $microgap_width;
	}
	
	# rails are at the bottom of the pads
	$r  = sqrt($r1 * $r1 + $pad_displacement * $pad_displacement)  ;
	
	for(my $s = 0; $s < $nsegments[$l] ; $s++)
	{
		my $tpos      = pos_t_pad($r, $l, $type, $s);
		my $z         = $starting_point[$l] + $rail_length;
		my $segment_n = $s + 1;
		my $snumber   = cnumber($s, 10);
		
		my %detector = init_det();
		$detector{"name"}        = $vname."_Segment$snumber";
		$detector{"mother"}      = "bst_sl_$layer_no";
		$detector{"description"} = "$descriptio Segment $segment_n";
		$detector{"pos"}         = "$tpos $z*mm";
		$detector{"rotation"}    = rot($r, $l, $s);
		$detector{"color"}       = "881122";
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$rail_height*mm $rail_thickness*mm $rail_length*mm";
		$detector{"material"}    = $rail_material;
		$detector{"mfield"}      = "no";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
	
	
	for(my $m = 0; $m<$number_of_modules[$l]; $m++)
	{
		
		# BUTTONS
		my $distance_from_edge = 15;  # as for McMullen drawings
		
		# adding the one at the front of the module
		$DZ          = $m*$module_length + 2*$pad_radius + $distance_from_edge;
		if($type == 1)
		{
			$vname       = "button_rail_V_u$m"."_L";
			$descriptio  = "Button Rail Tube V, Layer $layer_no, ";
			$r1          = r_placement($l, $position_index) ;
		}
		
		if($type == 2)
		{
			$vname       = "button_rail_W_u$m"."_L";
			$descriptio  = "Button Rail Tube W, Layer $layer_no, ";
			$r1          = r_placement($l, tot_nlayers() - $position_index + 1) ;
		}
		$r  = sqrt($r1 * $r1 + $pad_displacement * $pad_displacement)  ;
		
		
		for(my $s = 0; $s < $nsegments[$l] ; $s++)
		{
			my $snumber   = cnumber($s, 10);
			my $tpos      = pos_t_pad($r, $l, $type, $s);
			my $z         = $starting_point[$l] + $DZ;
			my $segment_n = $s + 1;
			
			my %detector = init_det();
			$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
			$detector{"mother"}      = "bst_sl_$layer_no";
			$detector{"description"} = "$descriptio Segment $segment_n";
			$detector{"pos"}         = "$tpos $z*mm";
			$detector{"rotation"}    = rot_pad($r, $l, $s);
			$detector{"color"}       = $pad_color;
			$detector{"type"}        = "Tube";
			$detector{"dimensions"}  = "0*mm $pad_radius*mm $pad_thickness*mm 0 360*deg";
			$detector{"material"}    = $pad_material;
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);
		}
		
		# adding the one middle the module
		$DZ          = $m*$module_length +  $module_length - 2*$pad_radius - $distance_from_edge;
		if($type == 1)
		{
			$vname       = "button_rail_V_d$m"."_L";
		}
		
		if($type == 2)
		{
			$vname       = "button_rail_W_d$m"."_L";
		}
		
		for(my $s = 0; $s < $nsegments[$l] ; $s++)
		{
			my $snumber   = cnumber($s, 10);
			my $tpos      = pos_t_pad($r, $l, $type, $s);
			my $z         = $starting_point[$l] + $DZ;
			my $segment_n = $s + 1;
			
			my %detector = init_det();
			$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
			$detector{"mother"}      = "bst_sl_$layer_no";
			$detector{"description"} = "$descriptio Segment $segment_n";
			$detector{"pos"}         = "$tpos $z*mm";
			$detector{"rotation"}    = rot_pad($r, $l, $s);
			$detector{"color"}       = $pad_color;
			$detector{"type"}        = "Tube";
			$detector{"dimensions"}  = "0*mm $pad_radius*mm $pad_thickness*mm 0 360*deg";
			$detector{"material"}    = $pad_material;
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);
		}
		
		
		
		# adding the one at the end of the module
		$DZ          = $m*$module_length +  $module_length/2 ;
		if($type == 1)
		{
			$vname       = "button_rail_V_m$m"."_L";
		}
		
		if($type == 2)
		{
			$vname       = "button_rail_W_m$m"."_L";
		}
		
		for(my $s = 0; $s < $nsegments[$l] ; $s++)
		{
			my $snumber   = cnumber($s, 10);
			my $tpos      = pos_t_pad($r, $l, $type, $s);
			my $z         = $starting_point[$l] + $DZ;
			my $segment_n = $s + 1;
			
			my %detector = init_det();
			$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
			$detector{"mother"}      = "bst_sl_$layer_no";
			$detector{"description"} = "$descriptio Segment $segment_n";
			$detector{"pos"}         = "$tpos $z*mm";
			$detector{"rotation"}    = rot_pad($r, $l, $s);
			$detector{"color"}       = $pad_color;
			$detector{"type"}        = "Tube";
			$detector{"dimensions"}  = "0*mm $pad_radius*mm $pad_thickness*mm 0 360*deg";
			$detector{"material"}    = $pad_material;
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);
		}
	}
}



# Bus Cable goes from the hip to the end of the silicon
sub place_bus_cable
{
	my $l          = shift;
	my $type       = shift;
	my $layer_no   = $l + 1;
	my $r          = 0;
	my $vname      = 0;
	my $descriptio = 0;
	my $p_index    = 3;  # Position index
	my $position_i = $p_index;
	
	if($type == 1)
	{
		$vname      = "busCable_V_Layer";
		$descriptio = "BusCable V, Layer $layer_no, ";
	}
	
	if($type == 2)
	{
		$position_i = tot_nlayers() - $p_index + 1;
		$vname      = "busCable_W_Layer";
		$descriptio = "BusCable W, Layer $layer_no, ";
	}
	$r = r_placement($l, $position_i);
	
	for(my $s = 0; $s < $nsegments[$l] ; $s++)
	{
		my $snumber   = cnumber($s, 10);
		my $Dx        = $module_height / 2;
		my $Dy        = $bus_cable_width / 2;
		my $Dz        = ( $number_of_modules[$l]*$module_length + $number_of_modules[$l]*$microgap_width + $pcboard_length + $microgap_width) / 2.0 + 2;
		my $tpos      = pos_t($r, $l, $s);
		my $z         = $starting_point[$l] + $roh_carbon_gap + $Dz - 46.58 - 4 - 0.11;
		my $segment_n = $s + 1;
		
		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      = "bst_sl_$layer_no";
		$detector{"description"} = "$descriptio Segment $segment_n";
		$detector{"pos"}         = "$tpos $z*mm";
		$detector{"rotation"}    = rot($r, $l, $s);
		$detector{"color"}       = $bus_cable_color;
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$Dx*mm $Dy*mm $Dz*mm";
		$detector{"material"}    = $bus_cable_material;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
}



# includes glue in the material
sub place_carbon_fiber
{
	my $l          = shift;
	my $type       = shift;
	my $layer_no   = $l + 1;
	my $r          = 0;
	my $vname      = 0;
	my $descriptio = 0;
	my $p_index    = 4;  # Position index
	my $position_i = $p_index;
	
	if($type == 1)
	{
		$vname       = "carbonFiber_V_L";
		$descriptio  = "Epoxy V, Layer $layer_no, ";
	}
	
	if($type == 2)
	{
		$position_i = tot_nlayers() - $p_index + 1;
		$vname       = "carbonFiber_W_L";
		$descriptio  = "Epoxy W, Layer $layer_no, ";
	}
	$r = r_placement($l, $position_i);
	
	for(my $s = 0; $s < $nsegments[$l] ; $s++)
	{
		my $snumber   = cnumber($s, 10);
		my $Dx        = $module_height / 2;
		my $Dy        = $carbon_fiber_width / 2;
		my $Dz        = $carbon_fiber_length / 2.0 ;
		my $tpos      = pos_t($r, $l, $s);
		my $z         = $starting_point[$l] + $roh_carbon_gap + $Dz - 46.58 - 4 - 0.11;   # copper extension + pitch adapter + silicon gap
		my $segment_n = $s + 1;
		
		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      = "bst_sl_$layer_no";
		$detector{"description"} = "$descriptio Segment $segment_n";
		$detector{"pos"}         = "$tpos $z*mm";
		$detector{"rotation"}    = rot($r, $l, $s);
		$detector{"color"}       = $carbon_fiber_color;
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$Dx*mm $Dy*mm $Dz*mm";
		$detector{"material"}    = $carbon_fiber_material;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
}


# rohacell + plastic insert at the end
sub place_rohacell
{
	my $l         = shift;
	my $layer_no  = $l + 1;
	my $r = r_placement($l, 5);
	
	for(my $s = 0; $s < $nsegments[$l] ; $s++)
	{
		my $snumber   = cnumber($s, 10);
		my $Dx        = $rohacell_height / 2;
		my $Dy        = $rohacell_width / 2;
		my $Dz        = $rohacell_length / 2.0 ;
		my $tpos      = pos_t($r, $l, $s);
		my $z         = $starting_point[$l] + $Dz + 2.0;   # 2mm is now copper
		my $segment_n = $s + 1;
		
		my %detector = init_det();
		$detector{"name"}        = "rohacell_L$layer_no\_Segment$snumber";
		$detector{"mother"}      = "bst_sl_$layer_no";
		$detector{"description"} = "Rohacell support, Layer $layer_no, Segment $segment_n";
		$detector{"pos"}         = "$tpos $z*mm";
		$detector{"rotation"}    = rot($r, $l, $s);
		$detector{"color"}       = $rohacell_color;
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$Dx*mm $Dy*mm $Dz*mm";
		$detector{"material"}    = $rohacell_material;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
		
		
		
		$Dx  = $plastic_height / 2.0;
		$Dy  = $plastic_width / 2.0 ;
		$Dz  = $plastic_length / 2.0 ;
		$z = $rohacell_length / 2.0 - $plastic_length/2.0 - 0.1;
		%detector = init_det();
		$detector{"name"}        = "plastic_L$layer_no\_Segment$snumber";
		$detector{"mother"}      = "rohacell_L$layer_no\_Segment$snumber";
		$detector{"description"} = "Plastic Tab inside Rohahell, Layer $layer_no, Segment $segment_n";
		$detector{"pos"}         = "0*mm 0*mm $z*mm";
		$detector{"rotation"}    = "0";
		$detector{"color"}       = $epoxy_color;
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$Dx*mm $Dy*mm $Dz*mm";
		$detector{"material"}    = $rohacell_material;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
		
	}
}





sub place_chip
{
	my $l          = shift;
	my $type       = shift;
	my $left_rigth = shift;
	my $layer_no   = $l + 1;
	my $r1         = 0;
	my $vname      = 0;
	my $descriptio = 0;
	my $p_index    = 1;  # Position index
	my $position_i = $p_index;
	
	if($type == 1)
	{
		$r1          = r_placement($l, $position_i)             - $pcboard_width - $chip_width / 2.0 - 2.0*$microgap_width ;
		$vname       = "chip_$left_rigth\_V_L";
		$descriptio  = "chip V, Layer $layer_no, ";
	}
	
	if($type == 2)
	{
		$r1 = r_placement($l, tot_nlayers() - $position_i + 1)  + $pcboard_width + $chip_width / 2.0 + 2.0*$microgap_width ;
		$vname       = "chip_$left_rigth\_W_L";
		$descriptio  = "chip W, Layer $layer_no, ";
	}
	my $r  = sqrt($r1 * $r1 + $chip_displacement * $chip_displacement);
	
	for(my $s = 0; $s < $nsegments[$l] ; $s++)
	{
		my $snumber   = cnumber($s, 10);
		my $Dx        = $chip_height / 2.0;
		my $Dy        = $chip_width  / 2.0;
		my $Dz        = $chip_length / 2.0 ;
		my $tpos      = pos_t_chip($r, $l, $left_rigth, $s);
		my $z         = $starting_point[$l] - $microgap_width - $Dz - $wirebond_length - - $microgap_width - $pitch_adapter_length;
		my $segment_n = $s + 1;
		
		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      = "bst_sl_$layer_no";
		$detector{"description"} = "$descriptio Segment $segment_n";
		$detector{"pos"}         = "$tpos $z*mm";
		$detector{"rotation"}    = rot($r, $l, $s);
		$detector{"color"}       = $chip_color;
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$Dx*mm $Dy*mm $Dz*mm";
		$detector{"material"}    = $pcboard_material;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
}



sub place_pcboard
{
	my $l          = shift;
	my $type       = shift;
	my $layer_no   = $l + 1;
	my $r          = 0;
	my $vname      = 0;
	my $descriptio = 0;
	my $p_index    = 1;  # Position index
	my $position_i = $p_index;
	
	if($type == 1)
	{
		$r          = r_placement($l, $position_i)             - $pcboard_width / 2.0 - $microgap_width ;
		$vname       = "pcBoard_V_L";
		$descriptio  = "PC Board V, Layer $layer_no, ";
	}
	
	if($type == 2)
	{
		$r = r_placement($l, tot_nlayers() - $position_i + 1)  + $pcboard_width / 2.0 + $microgap_width ;
		$vname       = "pcBoard_W_L";
		$descriptio  = "PC Board W, Layer $layer_no, ";
	}
	
	
	for(my $s = 0; $s < $nsegments[$l] ; $s++)
	{
		my $snumber   = cnumber($s, 10);
		my $Dx        = $pcboard_height / 2.0;
		my $Dy        = $pcboard_width  / 2.0;
		my $Dz        = $pcboard_length / 2.0 ;
		my $tpos      = pos_t($r, $l, $s);
		my $z         = $starting_point[$l] - $microgap_width - $Dz - $pitch_adapter_length - 0.34;
		my $segment_n = $s + 1;
		
		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      = "bst_sl_$layer_no";
		$detector{"description"} = "$descriptio Segment $segment_n";
		$detector{"pos"}         = "$tpos $z*mm";
		$detector{"rotation"}    = rot($r, $l, $s);
		$detector{"color"}       = $pcboard_color;
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$Dx*mm $Dy*mm $Dz*mm";
		$detector{"material"}    = $pcboard_material;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
}



sub place_pitch_adapter
{
	my $l          = shift;
	my $type       = shift;
	my $layer_no   = $l + 1;
	my $r          = 0;
	my $vname      = 0;
	my $descriptio = 0;
	my $p_index    = 1;  # Position index
	my $position_i = $p_index;
	
	if($type == 1)
	{
		$vname       = "pitchAdapter_V_L";
		$descriptio  = "PC Board V, Layer $layer_no, ";
	}
	
	if($type == 2)
	{
		$position_i  = tot_nlayers() - $p_index + 1;
		$vname       = "pitchAdapter_W_L";
		$descriptio  = "PC Board W, Layer $layer_no, ";
	}
	$r = r_placement($l, $position_i);
	
	for(my $s = 0; $s < $nsegments[$l] ; $s++)
	{
		my $snumber   = cnumber($s, 10);
		my $Dx        = $module_height / 2.0;
		my $Dy        = $silicon_width  / 2.0;
		my $Dz        = $pitch_adapter_length / 2.0 ;
		my $tpos      = pos_t($r, $l, $s);
		my $z         = $starting_point[$l] - $microgap_width - $Dz - $silicon_gap_width;
		my $segment_n = $s + 1;
		
		my %detector = init_det();
		$detector{"name"}        = "$vname$layer_no\_Segment$snumber";
		$detector{"mother"}      = "bst_sl_$layer_no";
		$detector{"description"} = "$descriptio Segment $segment_n";
		$detector{"pos"}         = "$tpos $z*mm";
		$detector{"rotation"}    = rot($r, $l, $s);
		$detector{"color"}       = $paboard_color;
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$Dx*mm $Dy*mm $Dz*mm";
		$detector{"material"}    = $paboard_material;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
}





sub place_copper_support
{
	my $l    = shift;
	my $layer_no       = $l + 1;
	my $r = r_placement($l, 6);
	
	for(my $s = 0; $s < $nsegments[$l] ; $s++)
	{
		my $snumber   = cnumber($s, 10);
		my $Dx        = $bst_support_height / 2.0;
		my $Dy        = $bst_support_width  / 2.0;
		my $Dz        = $bst_copper_length[$l] / 2.0 ;
		my $tpos      = pos_t($r, $l, $s);
		my $z         = $starting_point[$l] + $Dz - $microgap_width - $bst_copper_length[$l] - $pcboard_length - 10.0 ; # manually to avoid overlaps with carbon fiber
		my $segment_n = $s + 1;
		
		my %detector = init_det();
		$detector{"name"}        = "copperSupport_L$layer_no\_Segment$snumber";
		$detector{"mother"}      = "bst_sl_$layer_no";
		$detector{"description"} = "Copper support, Layer $layer_no, Segment $segment_n";
		$detector{"pos"}         = "$tpos $z*mm";
		$detector{"rotation"}    = rot($r, $l, $s);
		$detector{"color"}       = "881122";
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$Dx*mm $Dy*mm $Dz*mm";
		$detector{"material"}    = $bst_support_material;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
}



sub place_downstream_support
{
	my $l          = shift;
	
	my @iradius  = (   0.0  ,     0.0   ,   0.0  ,   0.0);  # Inner radii
	my @oradius  = (  65.39 ,    93.07  , 120.0 , 160.98);  # Outer radii - ATTENTION: LAYER3 is 0.49mm less because of overlaps
	my $ring_dz = 14;
	my $nzplanes = 2;
	
	
	my @IR     = ($iradius[$l], $iradius[$l] );
	my @OR     = ($oradius[$l], $oradius[$l] );
	my @zplane = (0     , $ring_dz    );
	my $SL = $l + 1;
	my $z         = $starting_point[$l] + $rohacell_length  - $ring_dz  + 2.0;   # same as rohacell position
	
	
	my $dimensions = "0.0*deg 360.0*deg $nsegments[$l]*counts $nzplanes*counts";
	for(my $i = 0; $i <$nzplanes ; $i++)
	{
		$dimensions = $dimensions ." $IR[$i]*mm";
	}
	for(my $i = 0; $i <$nzplanes ; $i++)
	{
		$dimensions = $dimensions ." $OR[$i]*mm";
	}
	for(my $i = 0; $i <$nzplanes ; $i++)
	{
		$dimensions = $dimensions ." $zplane[$i]*mm";
	}
	
	my %detector = init_det();
	$detector{"name"}        = "aBST_Downstream_SupportFrame_L$SL";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Downstream support Frame, Layer $SL";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"rotation"}    = "0";
	$detector{"color"}       = $bst_support_color;
	$detector{"type"}        = "Pgon";
	$detector{"dimensions"}  = "$dimensions";
	$detector{"material"}    = "Component";
	print_det(\%configuration, \%detector);
	
	
	my @toradius  = (  62.39 ,    89.47  , 116.35 , 156.37);  # Outer radii of solenoid
	%detector = init_det();
	$detector{"name"}        = "bBST_Downstream_SupportHole_L$SL";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Downstream support hole, Layer $SL";
	$detector{"pos"}         = "0*mm 0*mm 7*mm";
	$detector{"rotation"}    = "0";
	$detector{"color"}       = $bst_support_color;
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0 $toradius[$l]*mm $ring_dz*mm 0*deg 360*deg";
	$detector{"material"}    = "Component";
	print_det(\%configuration, \%detector);
	
	%detector = init_det();
	$detector{"name"}        = "downstreamSupport_L$SL";
	$detector{"mother"}      = "bst_sl_$SL";
	$detector{"description"} = "Downstream support, Layer $SL";
	$detector{"pos"}         = "0*mm 0*mm $z*mm";
	$detector{"rotation"}    = rot(0, $l, 0);
	if($l == 3)	{$detector{"rotation"}    = rot(0, $l, 199);}
	$detector{"color"}       = $bst_support_color;
	$detector{"type"}        = "Operation: aBST_Downstream_SupportFrame_L$SL - bBST_Downstream_SupportHole_L$SL";
	$detector{"dimensions"}  = "0";
	$detector{"material"}    = "peek";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}





# Aluminized Mylar shells
# To act as faraday cage
sub make_shells
{
	my $slnumber = shift;
	my $slindex  = $slnumber - 1;
	my $shell_i = $shell_ir[$slindex];
	my $shell_o = $shell_i + $svt_shell_thickness;
	my $slength = $shell_len[$slindex] / 2.0;
	my $zpos    = -$shell_z[$slindex] + $slength;   # Z = upstream edge to target center
	
	my %detector = init_det();
	$detector{"name"}        = "fcShell_$slnumber";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Faraday cage Shell for Super Layer $slnumber";
	$detector{"pos"}         = "0*cm 0*cm $zpos*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "223344";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$shell_i*mm $shell_o*mm $slength*mm 0*deg 360*deg";
	$detector{"material"}    = "bstalmylar";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}







