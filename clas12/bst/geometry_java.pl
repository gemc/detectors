package coatjava;

use strict;
use warnings;
use geometry;

# volumes.pl returns the array of hashes (6 hashes)
# number of entries in each hash is equal to the number of volumes (all mothers+all daughters)
# keys of hashes consist of volume names (constructed in COATJAVA SVT factory)
# e.g. per each volume with 'volumeName':
# mothers['volumeName'] = 'name of mothervolume'
# positions['volumeName'] = 'x y z'
# rotations['volumeName'] = 'rotationOrder: angleX angleY angleZ' (e.g. 'xyz: 90*deg 90*deg 90*deg')
# types['volumeName'] = 'name of volumeType (Trd, Box etc.)'
# dimensions['volumeName'] = 'dimensions of volume (e.g. 3 values for Box, 5 values for Trd etc.'
# ids['volumeName'] = 'region# sector# module#'

my ($mothers, $positions, $rotations, $types, $dimensions, $ids);

# old                           -> new
# superlayer (1,2,3,4)          -> region (1,2,3,4)
# segment (1-10,1-14,1-18,1-24) -> sector (1-10,1-14,1-18,1-24)
# type (V=1,W=2)                -> module (U=1,V=2)
# module (1-3)                  -> sp (sensorPhysical) (1-3)
# strip (1)                     -> strip (1)

my $nregions;
my @nsectors;
my $nmodules;
my $nsensors;
my $bsensorzones;
my $bsensors;

# will move materials to CCDB later
my %materials = ("silicon", "G4_Si",
                 "rohacell", "rohacell",
                 "pitchAdaptor", "G4_SILICON_DIOXIDE");

my $btestone = 0;

sub makeBST
{
	($mothers, $positions, $rotations, $types, $dimensions, $ids) = @main::volumes;

    $nregions     = $main::parameters{"nregions"};
    $nmodules     = $main::parameters{"nmodules"};
    $nsensors     = $main::parameters{"nsensors"};
    $bsensorzones = $main::parameters{"bsensorzones"};
    $bsensors     = $main::parameters{"bsensors"};

    if($btestone)
    {
        $nregions = 1;
        $nmodules = 1;
        $nsensors = 1;
    }

    build_mother();
    
    for(my $r=1; $r<=$nregions; $r++ )
    {
        $nsectors[$r-1] = $main::parameters{"nsectors_r".$r};
        if($btestone){ $nsectors[0] = 1; }
        build_region($r);
    }
}

sub build_mother
{
    my $vname = "svt";
    my $vdesc = "SVT Mother";
    
    my %detector = init_det();
    %detector = setup_detector( $vname, \%detector );
    %detector = setup_detector_passive($vdesc, \%detector );
    $detector{"mother"} = "root"; # overwrite mother from file
    $detector{"visible"} = 0;
    print_det(\%main::configuration, \%detector);
}

sub build_region
{
    my $r = shift;
    my $vname = "region".$r;
    my $vdesc = "SVT Region ".$r;

    #print "Hello from ".$vdesc."\n";

    my %detector = init_det();
    %detector = setup_detector( $vname, \%detector );
    %detector = setup_detector_passive( $vdesc, \%detector );
    $detector{"visible"} = 0;
    print_det(\%main::configuration, \%detector);

    for(my $s=1; $s<=$nsectors[$r-1]; $s++ )
    {
        build_sector($r,$s);
    }
}

sub build_sector
{
    my $r = shift;
    my $s = shift;
    my $vname = "sector".$s."_r".$r;
    my $vdesc = "SVT Sector ".$s.", Region ".$r;

    #print "Hello from ".$vdesc."\n";

    my %detector = init_det();
    %detector = setup_detector( $vname, \%detector );
    %detector = setup_detector_passive( $vdesc, \%detector );
    $detector{"visible"} = 0;
    print_det(\%main::configuration, \%detector);

    for(my $m=1; $m<=$nmodules; $m++ )
    {
        build_module($r,$s,$m);
        build_pitch_adaptor($r,$s,$m);
    }

    #build_rohacell($r,$s);
}

sub build_module
{
    my $r = shift;
    my $s = shift;
    my $m = shift;
    my $vname = "module".$m."_s".$s."_r".$r;
    my $vdesc = "SVT Module ".$m.", Sector ".$s.", Region ".$r;

    #print "Hello from ".$vdesc."\n";

    #if( $bsensors )
    #{
        for(my $sp=1; $sp<=$nsensors; $sp++ )
        {
            build_sensor_physical($r,$s,$m,$sp);
        }
        
        my %detector = init_det();
        %detector = setup_detector( $vname, \%detector );
        %detector = setup_detector_passive( $vdesc, \%detector );
        $detector{"visible"} = 0;
        print_det(\%main::configuration, \%detector);
    #}
    #else
    #{
    #    my %detector = init_det();
    #    %detector = setup_detector( $vname, \%detector );
    #    #$detector{"mother"} = "root"; # overwrite mother from file
    #    %detector = setup_detector_active( $vdesc, \%detector );
    #    $detector{"ncopy"} = $sp;
    #    $detector{"identifiers"} = "superlayer manual $r type manual $m segment manual $s module manual $sp strip manual 1"; # cannot do! need 3 physical sensors!
    #    print_det(\%main::configuration, \%detector);
    #}
}

sub build_sensor_physical
{
    my $r  = shift;
    my $s  = shift;
    my $m  = shift;
    my $sp = shift;
    my $vname = "sensorPhysical".$sp."_m".$m."_s".$s."_r".$r;
    my $vdesc = "SVT Physical Sensor ".$sp.", Module ".$m.", Sector ".$s.", Region ".$r;

    #print "Hello from ".$vdesc."\n";

    if( $bsensorzones )
    {        
        build_sensor_active($r,$s,$m,$sp);
        build_sensor_dead_len($r,$s,$m,$sp,1);
        build_sensor_dead_len($r,$s,$m,$sp,2);
        build_sensor_dead_wid($r,$s,$m,$sp,3);
        build_sensor_dead_wid($r,$s,$m,$sp,4);

        my %detector = init_det();
        %detector = setup_detector( $vname, \%detector );
        %detector = setup_detector_passive( $vdesc, \%detector );
        $detector{"visible"} = 0;
        print_det(\%main::configuration, \%detector);
    }
    else
    {
        my %detector = init_det();
        %detector = setup_detector( $vname, \%detector );
        %detector = setup_detector_active( $vdesc, \%detector );
        $detector{"identifiers"} = "superlayer manual $r type manual $m segment manual $s module manual $sp strip manual 1";
        print_det(\%main::configuration, \%detector);
    }
}

sub build_sensor_active
{
    my $r  = shift;
    my $s  = shift;
    my $m  = shift;
    my $sp = shift;
    my $vname = "sensorActive"."_sp".$sp."_m".$m."_s".$s."_r".$r;
    my $vdesc = "SVT Sensor Active Zone ".$sp.", Module ".$m.", Sector ".$s.", Region ".$r;

    #print "Hello from ".$vdesc."\n";

    my %detector = init_det();
    %detector = setup_detector( $vname, \%detector );
    %detector = setup_detector_active( $vdesc, \%detector );
    $detector{"identifiers"} = "superlayer manual $r type manual $m segment manual $s module manual $sp strip manual 1";
    print_det(\%main::configuration, \%detector);
}

sub build_sensor_dead_len
{
    my $r  = shift;
    my $s  = shift;
    my $m  = shift;
    my $sp = shift;
    my $dz = shift;
    my $vname = "deadZoneLen".$dz."_sp".$sp."_m".$m."_s".$s."_r".$r;
    my $vdesc = "SVT Sensor Dead Zone ".$dz." Along Length of Physical Sensor ".$sp.", Module ".$m.", Sector ".$s.", Region ".$r;

    #print "Hello from ".$vdesc."\n";

    my %detector = init_det();
    %detector = setup_detector( $vname, \%detector );
    %detector = setup_detector_passive( $vdesc, \%detector );
    $detector{"material"} = $materials{"silicon"};
    print_det(\%main::configuration, \%detector);
}

sub build_sensor_dead_wid
{
    my $r  = shift;
    my $s  = shift;
    my $m  = shift;
    my $sp = shift;
    my $dz = shift;
    my $vname = "deadZoneWid".$dz."_sp".$sp."_m".$m."_s".$s."_r".$r;
    my $vdesc = "SVT Sensor Dead Zone ".$dz." Along Width of Physical Sensor ".$sp.", Module ".$m.", Sector ".$s.", Region ".$r;

    #print "Hello from ".$vdesc."\n";

    my %detector = init_det();
    %detector = setup_detector( $vname, \%detector );
    %detector = setup_detector_passive( $vdesc, \%detector );
    $detector{"material"} = $materials{"silicon"};
    print_det(\%main::configuration, \%detector);
}

sub build_pitch_adaptor
{
    my $r = shift;
    my $s = shift;
    my $m = shift;
    my $vname = "pitchAdaptor".$m."_s".$s."_r".$r;
    my $vdesc = "SVT Pitch Adaptor ".$m.", Sector ".$s.", Region ".$r;

    #print "Hello from ".$vdesc."\n";

    my %detector = init_det();
    %detector = setup_detector( $vname, \%detector );
    %detector = setup_detector_passive( $vdesc, \%detector );
    $detector{"material"} = $materials{"pitchAdaptor"};
    print_det(\%main::configuration, \%detector);
}

sub build_rohacell
{
    my $r = shift;
    my $s = shift;
    my $vname = "rohacell"."_s".$s."_r".$r;
    my $vdesc = "SVT Rohacell Support".", Sector ".$s.", Region ".$r;

    #print "Hello from ".$vdesc."\n";

    my %detector = init_det();
    %detector = setup_detector( $vname, \%detector );
    %detector = setup_detector_passive( $vdesc, \%detector );
    $detector{"material"} = $materials{"rohacell"};
    print_det(\%main::configuration, \%detector);
}

sub setup_detector_active
{
    my $description = shift;
    my %detector = %{shift()};

    $detector{"description"} = $description;
	$detector{"color"}       = "0000ff";
	$detector{"mfield"}      = "no";
    $detector{"ncopy"}       = "1";
	$detector{"visible"}     = 1;
    $detector{"style"}       = 1; # 0 = wireframe, 1 = solid
    
    $detector{"material"}    = "G4_Si";
	$detector{"sensitivity"} = "bst";
	$detector{"hit_type"}    = "bst";
	
    return %detector;
}

sub setup_detector_passive
{
    my $description = shift;
    my %detector = %{shift()};
    
    $detector{"description"} = $description;
	$detector{"color"}       = "cccccc";
	$detector{"material"}    = "G4_AIR";
	$detector{"mfield"}      = "no";
	$detector{"ncopy"}       = "1";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1; # 0 = wireframe, 1 = solid
    
    return %detector;
}

sub setup_detector
{
    my $vname = shift;
    my %detector = %{shift()};

    if( not defined $mothers->{$vname} ){ die "unknown volume: \"".$vname."\"\n"; }
    
    $detector{"name"}        = $vname;
	$detector{"mother"}      = $mothers->{$vname};    
	$detector{"pos"}         = $positions->{$vname};
	$detector{"rotation"}    = $rotations->{$vname};
	$detector{"type"}        = $types->{$vname};
	$detector{"dimensions"}  = $dimensions->{$vname};
    
    return %detector;
}

1;
