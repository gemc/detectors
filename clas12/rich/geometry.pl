# Written by Giovanni Angelini (gangel@gwu.edu), Andrey Kim (kenjo@jlab.org) and Connor Pecar (cmp115@duke.edu)
package coatjava;

use strict;
use warnings;

use geometry;
use GXML;

my ($mothers, $positions, $rotations, $types, $dimensions, $ids);


sub makeRICH
{
	($mothers, $positions, $rotations, $types, $dimensions, $ids) = @main::volumes;
	my $dirName = shift;
	build_gxml($dirName);
}
sub makeRICHcad
{
    
    ($mothers, $positions, $rotations, $types, $dimensions, $ids) = @main::volumes;
    my $variation = shift;
    #my $sector = shift;
    build_gxml($variation);
}
sub makeRICHtext
{

    ($mothers, $positions, $rotations, $types, $dimensions, $ids) = @main::volumes;
    my $sector = shift;
    build_text($sector);
}

sub build_gxml
{       
        my $variation = shift;
	my @sectors = ();
	if ($variation eq "rga_fall2018"){	    
	    push(@sectors,"4");
	}
	if ($variation eq "default"){
	    push(@sectors,"4");
	    push(@sectors,"1");
        }
        if ($variation eq "rgc_summer2022"){
	    push(@sectors,"4");
	    push(@sectors,"1");
        }
	print join(", ", @sectors);
	print("\n");
	my $dirName = "cad_" . $variation;
	my $gxmlFile = new GXML($dirName);

	#remove the Spherical Mirror STL
	foreach my $sector (@sectors){
	    print("on sector: ");
	    print($sector);
	    print("\n");
	    build_MESH($gxmlFile,$sector,$variation);
	    build_Elements($gxmlFile,$sector,$variation);	
	    my $sectorsuffix = "_s" . $sector;
	    my @files = ($dirName.'/Layer_302_component_1'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_2'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_3'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_4'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_5'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_6'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_7'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_8'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_9'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_10'.$sectorsuffix.'.stl');
	    my $removed = unlink(@files);
	    print "Removed  $removed files from $dirName. (Spherical Mirrors STLs)\n";		
	}	 
	if (scalar @sectors > 0){
	    $gxmlFile->print();
	}
}
sub build_text
{
    my $sector = shift;
    build_SphericalMirrors($sector);
    build_PMTs($sector);    
}

sub build_MESH
{
	my $gxmlFile = shift;
	my $sector = shift;
	my $variation = shift;
	my $sectorsuffix = "_s" . $sector;
	
	my @allMeshes =("RICH_s4","Aluminum","CFRP","TedlarWrapping","MirrorSupport");
	foreach my $mesh (@allMeshes)
	{
		my %detector = init_det();
		my $vname                = $mesh;
	
		$detector{"name"}        = $vname . $sectorsuffix;
		if($mesh eq "RICH_s4"){
		    $detector{"name"} = "RICH" . $sectorsuffix;
		}		
		$detector{"pos"}         = $positions->{$vname};
		if($mesh eq "RICH_s4" and ($variation eq "rga_fall2018" or $variation eq "rgc_summer2022")){
		    $detector{"pos"} = "0*cm 0*cm 5*cm";
		}
		#rotate mesh for sector 1 180 deg. around z
		$detector{"rotation"}    = $rotations->{$vname};

		if($sector eq '1' and $mesh eq "RICH_s4"){
		    $detector{"rotation"}  = "0 0 180*deg";
		}
		$detector{"mother"}      = $mothers->{$vname};

		if($mesh eq "RICH_s4"){
		    $detector{"color"}       = "444444";
		    $detector{"style"}       = "wireframe";
		    $detector{"material"}    = "Air_Opt";
		}
        
		elsif($mesh eq "Aluminum"){
			$detector{"color"}       = "4444ff";
			$detector{"material"}    = "G4_Al";
			$detector{"identifiers"} ="aluminum";
			$detector{"mother"}      = "RICH" . $sectorsuffix;        
		}
		
		elsif($mesh eq "CFRP"){
			$detector{"color"}       = "44ff44";
			$detector{"material"}    = "CarbonFiber";
			$detector{"identifiers"}  = "CarbonFiber";
			$detector{"mother"}      = "RICH" . $sectorsuffix;
		}
		
		elsif($mesh eq "TedlarWrapping"){
		    $detector{"color"}       = "444444";
		    $detector{"material"}    = "G4_AIR";
		    $detector{"identifiers"}    = "CarbonFiber";
		    $detector{"mother"}      = "RICH" . $sectorsuffix;
		}

		elsif($mesh eq "MirrorSupport"){
		    $detector{"color"}       = "E9C45D";
		    $detector{"material"}    = "CarbonFiber";
		    $detector{"identifiers"}    = "CarbonFiber";
		    $detector{"mother"}      = "RICH" . $sectorsuffix;
		}

		$gxmlFile->add(\%detector);
	}
}


sub build_Elements
{
    my $gxmlFile = shift;
    my $sector = shift;
    my $variation = shift;
    my $sectorsuffix = "_s" . $sector;
    my $Max_Layer201=16;
    my $Max_Layer202=22;
    my $Max_Layer203=32;
    my $Max_Layer204 = 32;
    my $Max_Layer301=7;
    my $Max_Layer302=10;
    
    my $Layer=201;
    for (my $Component=1; $Component <= $Max_Layer201; $Component++) {
        my $MaterialName='aerogel_sector'.$sector.'_layer'.$Layer.'_component'.$Component;
        my $Sensitivity = 'mirror: aerogel_surface_roughness';
	my $mesh = 'Layer_'.$Layer.'_component_'.$Component;
        my %detector = init_det();
        my $vname                = $mesh;
        $detector{"name"}        = $vname.$sectorsuffix;
        $detector{"pos"}         = $positions->{$vname};
	$detector{"rotation"}    = $rotations->{$vname};
        $detector{"mother"}      = $mothers->{$vname};
        $detector{"color"}       = "4444ff";
        $detector{"material"}    = $MaterialName;
	$detector{"sensitivity"} = $Sensitivity;
	$detector{"hitType"}    =  "mirror";
        $detector{"identifiers"}    = "aerogel";
        $detector{"mother"}      = "RICH" . $sectorsuffix;
        $gxmlFile->add(\%detector);
    }



 $Layer=202;
for (my $Component=1; $Component <= $Max_Layer202; $Component++) {
    my $MaterialName='aerogel_sector'.$sector.'_layer'.$Layer.'_component'.$Component;
    my $Sensitivity = 'mirror: aerogel_surface_roughness';
    my $mesh = 'Layer_'.$Layer.'_component_'.$Component;
    my %detector = init_det();
    my $vname                = $mesh;
    $detector{"name"}        = $vname.$sectorsuffix;
    $detector{"pos"}         = $positions->{$vname};
    $detector{"rotation"}    = $rotations->{$vname};
    $detector{"mother"}      = $mothers->{$vname};
    $detector{"color"}       = "4444ff";
    $detector{"material"}    = $MaterialName;
    $detector{"sensitivity"} = $Sensitivity;
    $detector{"hitType"}    =  "mirror";
    $detector{"identifiers"}    = "aerogel";
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $gxmlFile->add(\%detector);
}


$Layer=203;
for (my $Component=1; $Component <= $Max_Layer203; $Component++) {
    my $MaterialName='aerogel_sector'.$sector.'_layer'.$Layer.'_component'.$Component;
    my $Sensitivity = 'mirror: aerogel_surface_roughness';
    my $mesh = 'Layer_'.$Layer.'_component_'.$Component;
    my %detector = init_det();
    my $vname                = $mesh;
    $detector{"name"}        = $vname.$sectorsuffix;
    $detector{"pos"}         = $positions->{$vname};
    $detector{"rotation"}    = $rotations->{$vname};
    $detector{"mother"}      = $mothers->{$vname};
    $detector{"color"}       = "4444ff";
    $detector{"material"}    = $MaterialName;
    $detector{"sensitivity"} = $Sensitivity;
    $detector{"hitType"}    =  "mirror";
    $detector{"identifiers"}    = "aerogel";
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $gxmlFile->add(\%detector);
}


$Layer=204;
for (my $Component=1; $Component <= $Max_Layer204; $Component++) {
    my $MaterialName='aerogel_sector'.$sector.'_layer'.$Layer.'_component'.$Component;
    my $Sensitivity = 'mirror: aerogel_surface_roughness';
    my $mesh = 'Layer_'.$Layer.'_component_'.$Component;
    my %detector = init_det();
    my $vname                = $mesh;
    $detector{"name"}        = $vname.$sectorsuffix;
    $detector{"pos"}         = $positions->{$vname};
    $detector{"rotation"}    = $rotations->{$vname};
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"color"}       = "4444ff";
    $detector{"material"}    = $MaterialName;
    $detector{"sensitivity"} = $Sensitivity;
    $detector{"hitType"}    =  "mirror";
    $detector{"identifiers"}    = "aluminum";
    $gxmlFile->add(\%detector);
}
    
$Layer=301;
for (my $Component=1; $Component <= $Max_Layer301 ; $Component++) {
    my $MaterialName='mirror_sector'.$sector.'_layer'.$Layer.'_component'.$Component;
    my $mesh = 'Layer_'.$Layer.'_component_'.$Component;
    my %detector = init_det();
    my $vname                = $mesh;
    $detector{"name"}        = $vname.$sectorsuffix;
    $detector{"pos"}         = $positions->{$vname};
    $detector{"rotation"}    = $rotations->{$vname};    
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"color"}       = "cc99ff";
    $detector{"material"}    = "G4_Pyrex_Glass";
    $detector{"hitType"}    = 'mirror';
    $detector{"sensitivity"} = "mirror: rich_s".$sector."_mirror_planar_comp_".$Component;
    $detector{"identifiers"} = 'sector manual '.$Component;
    $gxmlFile->add(\%detector);
  }
}





sub build_PMTs{
    my $nPMTS  = 0 ;

    my $sector = shift;
    my $sectorsuffix = "_s" . $sector;
    
    my $PMT_rows = 23;
    for(my $irow=0; $irow<$PMT_rows; $irow++){
	my $nPMTInARow = 6 + $irow;
	
	for(my $ipmt=$nPMTInARow-1; $ipmt>=0; $ipmt--){
	    my $vname = sprintf("MAPMT_${irow}_${ipmt}");
	    my %detector = init_det();
	    
	    $nPMTS++;
	    
	    
            %detector = init_det();
	    $detector{"name"}        = "$vname" . $sectorsuffix;
	    $detector{"mother"}      = "RICH".$sectorsuffix;
	    $detector{"description"} = "PMT mother volume";
	    $detector{"pos"}         = $positions->{$vname};
	    $detector{"rotation"}    = $rotations->{$vname};
	    $detector{"color"}       = "444444";
	    $detector{"type"}        = $types->{$vname};
	    $detector{"dimensions"}  = $dimensions->{$vname};
	    $detector{"material"}    = "Air_Opt";
	    
	    print_det(\%main::configuration, \%detector);
	    
	    my @Case = ("Top","Bottom","Left","Right");
	    foreach my $section (@Case){
		my $AlCase = sprintf("Al${section}_${vname}");
		my %detector = init_det();
		
		$detector{"name"}        = "$AlCase" . $sectorsuffix;
		$detector{"mother"}      = $mothers->{$AlCase}.$sectorsuffix;
		$detector{"description"} = "PMT mother volume";
		$detector{"pos"}         = $positions->{$AlCase};
		$detector{"rotation"}    = $rotations->{$AlCase};
		$detector{"type"}        = $types->{$AlCase};
		$detector{"dimensions"}  = $dimensions->{$AlCase};
		$detector{"material"}    = "G4_Al";
		$detector{"style"}    = "0";
		print_det(\%main::configuration, \%detector);
	    }
	    
	    my $Socket = sprintf("Socket_${vname}");
	    
	    %detector = init_det();
	    $detector{"name"}        = "$Socket" . $sectorsuffix;
	    $detector{"mother"}      = $mothers->{$Socket}.$sectorsuffix;
	    $detector{"description"} = "PMT mother volume";
	    $detector{"pos"}         = $positions->{$Socket};
	    $detector{"rotation"}    = $rotations->{$Socket};
	    $detector{"color"}       = "ff9900";
	    $detector{"type"}        = $types->{$Socket};
	    $detector{"dimensions"}  = $dimensions->{$Socket};
	    $detector{"material"}    = "G4_Cu";
	    
	    
	    print_det(\%main::configuration, \%detector);
	    
	    my $Window = sprintf("Window_${vname}");
	    
	    %detector = init_det();
	    $detector{"name"}        = "$Window" . $sectorsuffix;
	    $detector{"mother"}      = $mothers->{$Window}.$sectorsuffix;
	    $detector{"description"} = "PMT mother volume";
	    $detector{"pos"}         = $positions->{$Window};
	    $detector{"rotation"}    = $rotations->{$Window};
	    $detector{"color"}       = "99bbff";
	    $detector{"type"}        = $types->{$Window};
	    $detector{"dimensions"}  = $dimensions->{$Window};
	    $detector{"material"}    = "Glass_H8500";
	    print_det(\%main::configuration, \%detector);
	    
	    my $Photocathode = sprintf("Photocathode_${vname}");
	    
	    %detector = init_det();
	    $detector{"name"}        = "$Photocathode" . $sectorsuffix;
	    $detector{"mother"}      = $mothers->{$Photocathode}.$sectorsuffix;
	    $detector{"description"} = "PMT mother volume";
	    $detector{"pos"}         = $positions->{$Photocathode};
	    $detector{"rotation"}    = $rotations->{$Photocathode};
	    $detector{"color"}       = "999966";
	    $detector{"type"}        = $types->{$Photocathode};
	    $detector{"dimensions"}  = $dimensions->{$Photocathode};
	    $detector{"material"}    = "Air_Opt";#"Photocathode_H8500";
	    $detector{"sensitivity"} = "rich";
	    $detector{"hit_type"}    = "rich";
	    $detector{"identifiers"} = "sector manual $sector pad manual $nPMTS pixel manual 1";
	    print_det(\%main::configuration, \%detector);
	    
	}
    }
    print "Produced $nPMTS pmt  " ;
}

sub build_SphericalMirrors
{
    my $sector = shift;
    my $sectorsuffix = "_s" . $sector;

    my $RadiusSphere= 2700.00;
    my $RadiusSphereFinal= 2701.00;

    my %detector = init_det();
    # Spherical Mirror 1 Component
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror3PreShift" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"description"} = "Spherical Mirror 1 component";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 122*deg 12.25*deg 60.0*deg 15.0*deg";
    $detector{"material"}    = "Component";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 6
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror6" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm ";
    $detector{"rotation"}    = "90*deg 0*deg -90*deg";
    $detector{"description"} = "SphericalMirror6 ";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 122*deg 12.25*deg 75.0*deg 15.0*deg";
    $detector{"material"}    = "CarbonFiber";
    $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_s".$sector."_mirror_spherical_6";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 10";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 7
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror7" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm ";
    $detector{"rotation"}    = "90*deg 0*deg -90*deg";
    $detector{"description"} = "SphericalMirror7 ";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 122*deg 12.25*deg 90.0*deg 15.0*deg";
    $detector{"material"}    = "CarbonFiber";
    $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_s".$sector."_mirror_spherical_7";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 11";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 4 pre shift
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror4PreShift" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"pos"}         = "0*mm 0*mm  0*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"description"} = "SphericalMirror4PreShift";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 122*deg 12.25*deg 105.0*deg 15.0*deg";
    $detector{"material"}    = "Component";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 8 pre shift
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror8PreShift" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"pos"}         = "0*mm 0*mm  0*mm ";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"description"} = "SphericalMirror8PreShift";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 134.25*deg 11.5*deg 60.0*deg 21.0*deg";
    $detector{"material"}    = "Component";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 9
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror9" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm";
    $detector{"rotation"}    = "90*deg 0*deg -90*deg";
    $detector{"description"} = "SphericalMirror9";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 134.25*deg 11.5*deg 81.0*deg 18.0*deg";
    $detector{"material"}    = "CarbonFiber";
     $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_s".$sector."_mirror_spherical_9";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 12";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 10 (3C) pre shift
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror10PreShift" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"pos"}         = "0*mm 0*mm  0*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";    
    $detector{"description"} = "SphericalMirror10PreShift";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 134.25*deg 11.5*deg 99.0*deg 21.0*deg";
    $detector{"material"}    = "Component";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 1 before shift
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror1PreShift" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"pos"}         = "0*mm 0*mm  0*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"description"} = "SphericalMirror1PreShift";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 145.75*deg 11.25*deg 60.0*deg 21.0*deg";
    $detector{"material"}    = "Component";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 5
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror5" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm";
    $detector{"rotation"}    = "90*deg 0*deg -90*deg";
    $detector{"description"} = "SphericalMirror5";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 145.75*deg 11.25*deg 81.0*deg 18.0*deg";
    $detector{"material"}    = "CarbonFiber";
    $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_s".$sector."_mirror_spherical_5";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 13";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 2 pre shift
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror2PreShift" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"pos"}         = "0*mm 0*mm  0*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"description"} = "SphericalMirror2PreShift";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 145.75*deg 11.25*deg 99.0*deg 21.0*deg";
    $detector{"material"}    = "Component";
    print_det(\%main::configuration, \%detector);
    
    # Tilted Plane1
    %detector = init_det();
    $detector{"name"}        = "TiltedPlane1" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"pos"}         = "0*mm 0*mm -525.0*mm";
    $detector{"rotation"}    = "30*deg 0*deg 40*deg";
    $detector{"description"} = "TiltedPlane1";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Box";
    $detector{"dimensions"}  = "3000.0*mm 3000.0*mm 280*mm";
    $detector{"material"}    = "Component";
    print_det(\%main::configuration, \%detector);
    
    # Tilted Plane2
    %detector = init_det();
    $detector{"name"}        = "TiltedPlane2" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"pos"}         = "0*mm 0*mm 525.0*mm";
    $detector{"rotation"}    = "-30*deg 0*deg 40*deg";
    $detector{"description"} = "TiltedPlane2";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Box";
    $detector{"dimensions"}  = "3000.0*mm 3000.0*mm 280*mm";
    $detector{"material"}    = "Component";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 4
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror4" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm";    
    $detector{"rotation"}    = "90*deg 0*deg -90*deg";
    $detector{"description"} = "subtraction mirror4-plane";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Operation:@ SphericalMirror4PreShift".$sectorsuffix." - TiltedPlane1".$sectorsuffix;
    $detector{"dimensions"}  = "0";
    $detector{"material"}    = "CarbonFiber";
    $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_s".$sector."_mirror_spherical_4";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 15";
    print_det(\%main::configuration, \%detector);
    
    # SphericalMirror 10
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror10" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm ";
    $detector{"rotation"}    = "90*deg 0*deg -90*deg";    
    $detector{"description"} = "subtraction mirror4-plane";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Operation:@ SphericalMirror10PreShift".$sectorsuffix." - TiltedPlane1".$sectorsuffix;
    $detector{"dimensions"}  = "0";
    $detector{"material"}    = "CarbonFiber";
     $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_s".$sector."_mirror_spherical_10";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 16";
    print_det(\%main::configuration, \%detector);
    
    # Spherical mirror 2
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror2" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm ";
    $detector{"rotation"}    = "90*deg 0*deg -90*deg";    
    $detector{"description"} = "subtraction mirror";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Operation:@ SphericalMirror2PreShift".$sectorsuffix." - TiltedPlane1".$sectorsuffix;
    $detector{"dimensions"}  = "0";
    $detector{"material"}    = "CarbonFiber";
     $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_s".$sector."_mirror_spherical_2";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 17";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 3
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror3" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm ";
    $detector{"rotation"}    = "90*deg 0*deg -90*deg";
    $detector{"description"} = "subtraction mirror 3";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Operation:@ SphericalMirror3PreShift".$sectorsuffix." - TiltedPlane2".$sectorsuffix;
    $detector{"dimensions"}  = "0";
    $detector{"material"}    = "CarbonFiber";
     $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_s".$sector."_mirror_spherical_3";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 18";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 8
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror8" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm";
    $detector{"rotation"}    = "90*deg 0*deg -90*deg";
    $detector{"description"} = "subtraction mirror 5";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Operation:@ SphericalMirror8PreShift".$sectorsuffix." - TiltedPlane2".$sectorsuffix;
    $detector{"dimensions"}  = "0";
    $detector{"material"}    = "CarbonFiber";
     $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_s".$sector."_mirror_spherical_8";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 19";
    print_det(\%main::configuration, \%detector);
    
    # SphericalMirror1
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror1" . $sectorsuffix;
    $detector{"mother"}      = "RICH" . $sectorsuffix;
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm";
    $detector{"rotation"}    = "90*deg 0*deg -90*deg";    
    $detector{"description"} = "subtraction mirror 1";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Operation:@ SphericalMirror1PreShift".$sectorsuffix." - TiltedPlane2".$sectorsuffix;
    $detector{"dimensions"}  = "0";
    $detector{"material"}    = "CarbonFiber";
    $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_s".$sector."_mirror_spherical_1";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 20";
    print_det(\%main::configuration, \%detector);
    
}

1;
