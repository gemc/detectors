# use strict;
use warnings;

our %configuration;
our %parameters;

# FMT is a Tube containing all SLs
my $envelope = 'FMT';

# All dimensions in mm

my @starting_point =();

my $fmt_ir 			= $parameters{"FMT_mothervol_InnerRadius"};
my $fmt_or 			= $parameters{"FMT_mothervol_OutRadius"};
my $nlayer			= $parameters{"FMT_nlayer"};
$starting_point[0] 	= $parameters{"FMT_zpos_layer1"};
$starting_point[1] 	= $parameters{"FMT_zpos_layer2"};
$starting_point[2] 	= $parameters{"FMT_zpos_layer3"};
$starting_point[3] 	= $parameters{"FMT_zpos_layer4"};
$starting_point[4] 	= $parameters{"FMT_zpos_layer5"};
$starting_point[5] 	= $parameters{"FMT_zpos_layer6"};
my $innerPeek_RMin 	= $parameters{"FMT_innerPEEKInnerRadius"};
my $innerPeek_RMax 	= $parameters{"FMT_innerPEEKOuterRadius"};
my $Det_RMin 	    = $parameters{"FMT_DetInnerRadius"};
my $Det_RMax 	    = $parameters{"FMT_DetOuterRadius"};
my $Act_RMin 	    = $parameters{"FMT_ActInnerRadius"};
my $Act_RMax 	    = $parameters{"FMT_ActOuterRadius"};
my $outerPeek_RMin 	= $parameters{"FMT_outerPEEKInnerRadius"};
my $outerPeek_RMax 	= $parameters{"FMT_outerPEEKOuterRadius"};
my $Peek_Dz 		= 0.5*$parameters{"FMT_PEEK_Dz"}; # half width
#my $Epoxy_Dz 		= 0.5*$parameters{"FMT_Epoxy_Dz"}; # half width
my $CuGround_Dz 	= 0.5*$parameters{"FMT_CuGround_Dz"}; # half width
my $PCBGround_Dz 	= 0.5*$parameters{"FMT_PCBGround_Dz"}; # half width
my $Rohacell_Dz 	= 0.5*$parameters{"FMT_Rohacell_Dz"}; # half width
my $PCBDetector_Dz 	= 0.5*$parameters{"FMT_PCBDetector_Dz"}; # half width
my $Strips_Dz 		= 0.5*$parameters{"FMT_Strips_Dz"}; # half width
my $Kapton_Dz 		= 0.5*$parameters{"FMT_Kapton_Dz"}; # half width
my $ResistStrips_Dz = 0.5*$parameters{"FMT_ResistStrips_Dz"}; # half width
my $Gas1_Dz 		= 0.5*$parameters{"FMT_Gas1_Dz"}; # half width
my $Mesh_Dz 		= 0.5*$parameters{"FMT_Mesh_Dz"}; # half width
my $Gas2_Dz 		= 0.5*$parameters{"FMT_Gas2_Dz"}; # half width
my $DriftCuElectrode_Dz 	= 0.5*$parameters{"FMT_DriftCuElectrode_Dz"}; # half width
my $DriftPCB_Dz 			= 0.5*$parameters{"FMT_DriftPCB_Dz"}; # half width
my $DriftCuGround_Dz 		= 0.5*$parameters{"FMT_DriftCuGround_Dz"}; # half width


# G4 materials
my $peek_material   	= 'myPeek';
my $alu_material		= 'myAlu';
#my $epoxy_material  	= 'myEpoxy';
my $pcb_material 		= 'myFR4';
my $copper_material		= 'myCopper';
my $strips_material  	= 'myfmtMMStrips'; #copper
my $gas_material     	= 'myfmtMMGas'; # neon ethan CF4
my $mesh_material    	= 'myfmtMMMesh'; # inox
#my $drift_material   	= 'myMMMylar';
my $air_material	 	= 'myAir';
my $kapton_material	 	= 'myKapton';
my $rohacell_material 	= 'myRohacell';
my $resist_material		= 'myfmtResistPaste'; # for resistiv strips
#define myGlue...
# we neglect the pillars holding the mesh... we are neglectint all the pyralux here, actualy...


# G4 colors
# I put random colors...
my $peek_color       = '666666';
my $alu_color        = '666666';
#my $epoxy_color     = 'e200e1';
my $pcb_color    	 = '0000ff';
my $copper_color	 = '666600';
my $strips_color     = '353540';
my $gas_color        = 'e10000';
my $mesh_color       = '252020';
#my $drift_color     = 'fff600';
my $air_color	 	 = 'e200e1';
my $kapton_color	 = 'fff600';
my $rohacell_color 	 = '00ff00';
my $resist_color	 = '000000';
#myGlue


$pi = 3.141592653589793238;

my $fmt_dz = ($starting_point[5] - $starting_point[0])/2.0 + 8.0;

my $fmt_starting = ($starting_point[2] + $starting_point[3])/2.0;

sub define_fmt
{
  make_fmt();

  for(my $l = 0; $l < $nlayer; $l++) 
    {
	place_cuground($l);
	place_pcbground($l);
	place_rohacell($l);
	place_pcbdetector($l);
	place_strips($l);
	place_kapton($l);
	place_resist($l);
	place_gas1($l);
	place_mesh($l);
	place_gas2($l);
    place_innerpeek($l);
	place_outerpeek($l);
	place_driftcuelectrode($l);
	place_driftpcb($l);
    place_driftcuground($l);
	
    #place_epoxy($l); #no more use for epoxy I think
    
  }
}

sub make_fmt
{
    my $zpos      = $fmt_starting;

    my %detector = init_det();    
    $detector{"name"}        = $envelope;
    $detector{"mother"}      = "root";
    $detector{"description"} = "Forward Micromegas Vertex Tracker";
    $detector{"pos"}         = "0*mm 0*mm $zpos*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       = "aaaaff";
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "$fmt_ir*mm $fmt_or*mm $fmt_dz*mm 0*deg 360*deg";
    $detector{"material"}    = "Air";
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 0;
    $detector{"style"}       = 0;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
    
    print_det(\%configuration, \%detector);
}

sub place_cuground
{
    my $l    = shift; 
    my $layer_no       = $l + 1;
    
    my $z          = $starting_point[$l] -  $fmt_starting + $CuGround_Dz;
    my $vname      = "FMT_CuGround";
    my $descriptio = "Cu Ground, Layer $layer_no, ";
    
    # names
    my $tpos      = "0*mm 0*mm";
    my $PRMin     = $Det_RMin;
    my $PRMax     = $Det_RMax;
    my $PDz       = $CuGround_Dz;

    my %detector = init_det();    	
    $detector{"name"}        = "$vname$layer_no";
    $detector{"mother"}      = $envelope;
    $detector{"description"} = "$descriptio";
    $detector{"pos"}         = "$tpos $z*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       = $copper_color;
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm 0*deg 360*deg";
    $detector{"material"}    = $copper_material;
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
    
    print_det(\%configuration, \%detector);
    
}

sub place_pcbground
{
    my $l    = shift; 
    my $layer_no       = $l + 1;
	
	my $z           =  $starting_point[$l] - $fmt_starting + 2*$CuGround_Dz + $PCBGround_Dz;
	my $vname       = "FMT_PCB_Ground";
	my $descriptio  = "PCB Ground, Layer $layer_no, ";
 
    
    # names
    my $tpos      = "0*mm 0*mm";
    my $PRMin     = $Det_RMin;
    my $PRMax     = $Det_RMax;
    my $PDz       = $PCBGround_Dz;

    my %detector = init_det();    	
	$detector{"name"}        = "$vname$layer_no";
	$detector{"mother"}      =  $envelope;
	$detector{"description"} = "$descriptio";
	$detector{"pos"}         = "$tpos $z*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = $pcb_color;
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm 0*deg 360*deg";
	$detector{"material"}    = $pcb_material;
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
	print_det(\%configuration, \%detector);
}

sub place_rohacell
{
    my $l    = shift; 
    my $layer_no       = $l + 1;
	
	my $z           =  $starting_point[$l] - $fmt_starting + 2*$CuGround_Dz + 2*$PCBGround_Dz + $Rohacell_Dz;
	my $vname       = "FMT_Rohacell";
	my $descriptio  = "Rohacell, Layer $layer_no, ";
 
    
    # names
    my $tpos      = "0*mm 0*mm";
    my $PRMin     = $Det_RMin;
    my $PRMax     = $Det_RMax;
    my $PDz       = $Rohacell_Dz;

    my %detector = init_det();    	
	$detector{"name"}        = "$vname$layer_no";
	$detector{"mother"}      =  $envelope;
	$detector{"description"} = "$descriptio";
	$detector{"pos"}         = "$tpos $z*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = $rohacell_color;
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm 0*deg 360*deg";
	$detector{"material"}    = $rohacell_material;
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
	print_det(\%configuration, \%detector);
}

sub place_pcbdetector
{
    my $l    = shift; 
    my $layer_no       = $l + 1;
	
	my $z           =  $starting_point[$l] - $fmt_starting + 2*$CuGround_Dz + 2*$PCBGround_Dz + 2*$Rohacell_Dz + $PCBDetector_Dz;
	my $vname       = "FMT_PCB_Detector";
	my $descriptio  = "PCB Detector, Layer $layer_no, ";
 
    
    # names
    my $tpos      = "0*mm 0*mm";
    my $PRMin     = $Det_RMin;
    my $PRMax     = $Det_RMax;
    my $PDz       = $PCBDetector_Dz;

    my %detector = init_det();    	
	$detector{"name"}        = "$vname$layer_no";
	$detector{"mother"}      =  $envelope;
	$detector{"description"} = "$descriptio";
	$detector{"pos"}         = "$tpos $z*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = $pcb_color;
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm 0*deg 360*deg";
	$detector{"material"}    = $pcb_material;
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
	print_det(\%configuration, \%detector);
}

sub place_strips
{
    my $l    = shift; 
    my $layer_no       = $l + 1;

	my $z           = $starting_point[$l] - $fmt_starting + 2*$CuGround_Dz + 2*$PCBGround_Dz + 2*$Rohacell_Dz + 2*$PCBDetector_Dz + $Strips_Dz;
	my $vname       = "FMT_Strips";
	my $descriptio  = "Strips, Layer $layer_no, ";
    
	
	# names
	my $tpos       = "0*mm 0*mm";
	my $PRMin     = $Act_RMin;
	my $PRMax     = $Act_RMax;
	my $PDz       = $Strips_Dz;

    my %detector = init_det();    	
	$detector{"name"}        = "$vname$layer_no";
	$detector{"mother"}      =  $envelope;
	$detector{"description"} = "$descriptio";
	$detector{"pos"}         = "$tpos $z*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = $strips_color;
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm 0*deg 360*deg";
	$detector{"material"}    = $strips_material;
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
	print_det(\%configuration, \%detector);
}

sub place_kapton
{
    my $l    = shift; 
    my $layer_no       = $l + 1;

	my $z           = $starting_point[$l] - $fmt_starting + 2*$CuGround_Dz + 2*$PCBGround_Dz + 2*$Rohacell_Dz + 2*$PCBDetector_Dz + 2*$Strips_Dz + $Kapton_Dz;
	my $vname       = "FMT_Kapton";
	my $descriptio  = "Kapton, Layer $layer_no, ";
    
	
	# names
	my $tpos       = "0*mm 0*mm";
	my $PRMin     = $Det_RMin;
	my $PRMax     = $Det_RMax;
	my $PDz       = $Kapton_Dz;

    my %detector = init_det();    	
	$detector{"name"}        = "$vname$layer_no";
	$detector{"mother"}      =  $envelope;
	$detector{"description"} = "$descriptio";
	$detector{"pos"}         = "$tpos $z*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = $kapton_color;
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm 0*deg 360*deg";
	$detector{"material"}    = $kapton_material;
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
	print_det(\%configuration, \%detector);
}

sub place_resist
{
    my $l    = shift; 
    my $layer_no       = $l + 1;

	my $z           = $starting_point[$l] - $fmt_starting + 2*$CuGround_Dz + 2*$PCBGround_Dz + 2*$Rohacell_Dz + 2*$PCBDetector_Dz + 2*$Strips_Dz + 2*$Kapton_Dz + $ResistStrips_Dz;
	my $vname       = "FMT_Resistiv_Strips";
	my $descriptio  = "Resistiv Strips, Layer $layer_no, ";
    
	
	# names
	my $tpos       = "0*mm 0*mm";
	my $PRMin     = $Act_RMin;
	my $PRMax     = $Act_RMax;
	my $PDz       = $ResistStrips_Dz;

    my %detector = init_det();    	
	$detector{"name"}        = "$vname$layer_no";
	$detector{"mother"}      =  $envelope;
	$detector{"description"} = "$descriptio";
	$detector{"pos"}         = "$tpos $z*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = $resist_color;
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm 0*deg 360*deg";
	$detector{"material"}    = $resist_material;
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
	print_det(\%configuration, \%detector);
}

sub place_gas1
{
    my $l    = shift; 
    my $layer_no       = $l + 1;

	my $z           = $starting_point[$l] - $fmt_starting + 2*$CuGround_Dz + 2*$PCBGround_Dz + 2*$Rohacell_Dz + 2*$PCBDetector_Dz + 2*$Strips_Dz + 2*$Kapton_Dz + 2*$ResistStrips_Dz + $Gas1_Dz;
	my $vname       = "FMT_Gas1";
	my $descriptio  = "Gas1, Layer $layer_no, ";

    
    # names
	my $tpos       = "0*mm 0*mm";
	my $PRMin     = $innerPeek_RMax;
	my $PRMax     = $outerPeek_RMin;
	my $PDz       = $Gas1_Dz;

    my %detector = init_det();    	
	$detector{"name"}        = "$vname$layer_no";
	$detector{"mother"}      =  $envelope;
	$detector{"description"} = "$descriptio";
	$detector{"pos"}         = "$tpos $z*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = $gas_color;
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm 0*deg 360*deg";
	$detector{"material"}    = $gas_material;
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
	print_det(\%configuration, \%detector);
}

sub place_mesh
{
    my $l    = shift; 
    my $layer_no       = $l + 1;
 
	my $z           = $starting_point[$l] - $fmt_starting + 2*$CuGround_Dz + 2*$PCBGround_Dz + 2*$Rohacell_Dz + 2*$PCBDetector_Dz + 2*$Strips_Dz + 2*$Kapton_Dz + 2*$ResistStrips_Dz + 2*$Gas1_Dz + $Mesh_Dz;
	my $vname       = "FMT_Mesh";
	my $descriptio  = "Mesh, Layer $layer_no, ";

    
    # names
    my $tpos       = "0*mm 0*mm";
    my $PRMin     = $Det_RMin;
    my $PRMax     = $Det_RMax;
    my $PDz       = $Mesh_Dz;
 
    my %detector = init_det();       
    $detector{"name"}        = "$vname$layer_no";
    $detector{"mother"}      =  $envelope;
    $detector{"description"} = "$descriptio";
    $detector{"pos"}         = "$tpos $z*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       = $mesh_color;
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm 0*deg 360*deg";
    $detector{"material"}    = $mesh_material;
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
	print_det(\%configuration, \%detector);
}

sub place_gas2
{
    my $l    = shift;
	my $type = 1;
    my $layer_no       = $l + 1;

	my $z           = $starting_point[$l] - $fmt_starting + 2*$CuGround_Dz + 2*$PCBGround_Dz + 2*$Rohacell_Dz + 2*$PCBDetector_Dz + 2*$Strips_Dz + 2*$Kapton_Dz + 2*$ResistStrips_Dz + 2*$Gas1_Dz + 2*$Mesh_Dz + $Gas2_Dz;;
	my $vname       = "FMT_Gas2";
	my $descriptio  = "Gas2, Layer $layer_no, ";

    
    # names
    my $tpos       = "0*mm 0*mm";
    my $PRMin     = $innerPeek_RMax;
    my $PRMax     = $outerPeek_RMin;
    my $PDz       = $Gas2_Dz;
 
    my %detector = init_det();       
    $detector{"name"}        = "$vname$layer_no";
    $detector{"mother"}      = $envelope;
    $detector{"description"} = "$descriptio";
    $detector{"pos"}         = "$tpos $z*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       = $gas_color;
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm 0*deg 360*deg";
    $detector{"material"}    =  $gas_material;
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "fmt";
    $detector{"hit_type"}    = "fmt";
    $detector{"identifiers"} ="superlayer manual $layer_no type manual $type segment manual $detector{'ncopy'} strip manual 1";
    print_det(\%configuration, \%detector);
}

sub place_innerpeek
{
    my $l    = shift; 
    my $layer_no       = $l + 1;
    
    my $z          = $starting_point[$l] - $fmt_starting + 2*$CuGround_Dz + 2*$PCBGround_Dz + 2*$Rohacell_Dz + 2*$PCBDetector_Dz + 2*$Strips_Dz + 2*$Kapton_Dz + 2*$ResistStrips_Dz + 2*$Gas1_Dz + 2*$Mesh_Dz + $Peek_Dz;
    my $vname      = "FMT_innerPeek";
    my $descriptio = "inner PEEK, Layer $layer_no, ";
    
    # names
    my $tpos      = "0*mm 0*mm";
    my $PRMin     = $innerPeek_RMin;
    my $PRMax     = $innerPeek_RMax;
    my $PDz       = $Peek_Dz;
	
    $detector{"name"}        = "$vname$layer_no";
    $detector{"mother"}      = $envelope;
    $detector{"description"} = "$descriptio";
    $detector{"pos"}         = "$tpos $z*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       = $peek_color;
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm 0*deg 360*deg";
    $detector{"material"}    = $peek_material;
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
    
    print_det(\%configuration, \%detector);
    
}

sub place_outerpeek
{
    my $l    = shift; 
    my $layer_no       = $l + 1;
    
    my $z          = $starting_point[$l] - $fmt_starting + 2*$CuGround_Dz + 2*$PCBGround_Dz + 2*$Rohacell_Dz + 2*$PCBDetector_Dz + 2*$Strips_Dz + 2*$Kapton_Dz + 2*$ResistStrips_Dz + 2*$Gas1_Dz + 2*$Mesh_Dz + $Peek_Dz;
    my $vname      = "FMT_outerPeek";
    my $descriptio = "outer PEEK, Layer $layer_no, ";
    
    # names
    my $tpos      = "0*mm 0*mm";
    my $PRMin     = $outerPeek_RMin;
    my $PRMax     = $outerPeek_RMax;
    my $PDz       = $Peek_Dz;
	
    $detector{"name"}        = "$vname$layer_no";
    $detector{"mother"}      = $envelope;
    $detector{"description"} = "$descriptio";
    $detector{"pos"}         = "$tpos $z*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       = $alu_color;
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm 0*deg 360*deg";
    $detector{"material"}    = $alu_material;
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
    
    print_det(\%configuration, \%detector);
    
}

sub place_driftcuelectrode
{
    my $l    = shift; 
    my $layer_no       = $l + 1;

	$z           = $starting_point[$l] - $fmt_starting + 2*$CuGround_Dz + 2*$PCBGround_Dz + 2*$Rohacell_Dz + 2*$PCBDetector_Dz + 2*$Strips_Dz + 2*$Kapton_Dz + 2*$ResistStrips_Dz + 2*$Gas1_Dz + 2*$Mesh_Dz + 2*$Peek_Dz + $DriftCuElectrode_Dz;
	$vname       = "FMT_Drift_Cu_Electrode";
	$descriptio  = "Drift Cu Electrode, Layer $layer_no, ";

    
    # names
    my $tpos       = "0*mm 0*mm";
    my $PRMin     = $Act_RMin;
    my $PRMax     = $Act_RMax;
    my $PDz       = $DriftCuElectrode_Dz;

    my %detector = init_det();        
    $detector{"name"}        = "$vname$layer_no";
    $detector{"mother"}      =  $envelope;
    $detector{"description"} = "$descriptio";
    $detector{"pos"}         = "$tpos $z*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       = $copper_color;
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm 0*deg 360*deg";
    $detector{"material"}    = $copper_material;
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
    print_det(\%configuration, \%detector);
}

sub place_driftpcb
{
    my $l    = shift; 
    my $layer_no       = $l + 1;

	$z           = $starting_point[$l] - $fmt_starting + 2*$CuGround_Dz + 2*$PCBGround_Dz + 2*$Rohacell_Dz + 2*$PCBDetector_Dz + 2*$Strips_Dz + 2*$Kapton_Dz + 2*$ResistStrips_Dz + 2*$Gas1_Dz + 2*$Mesh_Dz + 2*$Peek_Dz + 2*$DriftCuElectrode_Dz + $DriftPCB_Dz;
	$vname       = "FMT_Drift_PCB";
	$descriptio  = "Drift PCB, Layer $layer_no, ";

    
    # names
    my $tpos       = "0*mm 0*mm";
    my $PRMin     = $Det_RMin;
    my $PRMax     = $Det_RMax;
    my $PDz       = $DriftPCB_Dz;

    my %detector = init_det();        
    $detector{"name"}        = "$vname$layer_no";
    $detector{"mother"}      =  $envelope;
    $detector{"description"} = "$descriptio";
    $detector{"pos"}         = "$tpos $z*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       = $pcb_color;
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm 0*deg 360*deg";
    $detector{"material"}    = $pcb_material;
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
    print_det(\%configuration, \%detector);
}

sub place_driftcuground
{
    my $l    = shift; 
    my $layer_no       = $l + 1;

	$z           = $starting_point[$l] - $fmt_starting + 2*$CuGround_Dz + 2*$PCBGround_Dz + 2*$Rohacell_Dz + 2*$PCBDetector_Dz + 2*$Strips_Dz + 2*$Kapton_Dz + 2*$ResistStrips_Dz + 2*$Gas1_Dz + 2*$Mesh_Dz + 2*$Peek_Dz + 2*$DriftCuElectrode_Dz + 2*$DriftPCB_Dz + $DriftCuGround_Dz;
	$vname       = "FMT_Drift_Cu_Ground";
	$descriptio  = "Drift Cu Ground, Layer $layer_no, ";

    
    # names
    my $tpos       = "0*mm 0*mm";
    my $PRMin     = $Det_RMin;
    my $PRMax     = $Det_RMax;
    my $PDz       = $DriftCuGround_Dz;

    my %detector = init_det();        
    $detector{"name"}        = "$vname$layer_no";
    $detector{"mother"}      =  $envelope;
    $detector{"description"} = "$descriptio";
    $detector{"pos"}         = "$tpos $z*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       = $copper_color;
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm 0*deg 360*deg";
    $detector{"material"}    = $copper_material;
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
    print_det(\%configuration, \%detector);
}


# not useful for fmt
sub place_epoxy
{
    my $l    = shift; 
    my $layer_no       = $l + 1;
    
    my $z          = - $fmt_starting + $starting_point[$l];
    my $vname      = "FMT_Epoxy";
    my $descriptio = "Epoxy, Layer $layer_no, ";
    
    # names
    my $tpos      = "0*mm 0*mm";
    my $PRMin     = $Det_RMin;
    my $PRMax     = $Det_RMax;
    my $PDz       = $Epoxy_Dz;

    my %detector = init_det();    	
    $detector{"name"}        = "$vname$layer_no";
    $detector{"mother"}      = $envelope;
    $detector{"description"} = "$descriptio";
    $detector{"pos"}         = "$tpos $z*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       = $epoxy_color;
    $detector{"type"}        = "Tube";
    $detector{"dimensions"}  = "$PRMin*mm $PRMax*mm $PDz*mm 0*deg 360*deg";
    $detector{"material"}    = $epoxy_material;
    $detector{"mfield"}      = "no";
    $detector{"ncopy"}       = 1;
    $detector{"pMany"}       = 1;
    $detector{"exist"}       = 1;
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;
    $detector{"sensitivity"} = "no";
    $detector{"hit_type"}    = "no";
    $detector{"identifiers"} = "no";
    
    print_det(\%configuration, \%detector);
    
}


1;
