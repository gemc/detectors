# Written by Giovanni Angelini (gangel@gwu.edu) and Andrey Kim (kenjo@jlab.org)
package coatjava;

use strict;
use warnings;

use geometry;
use GXML;

my ($mothers, $positions, $rotations, $types, $dimensions, $ids);

my $npaddles = 48;

sub makeRICH
{
	($mothers, $positions, $rotations, $types, $dimensions, $ids) = @main::volumes;
	my $dirName = shift;
	build_gxml($dirName);
}

sub build_gxml
{
	my $dirName = shift;
	my $gxmlFile = new GXML($dirName);

	build_MESH($gxmlFile);
    build_Elements($gxmlFile);
    build_SphericalMirrors();
	build_PMTs();
	#build_upLightGuides($gxmlFile);
	#build_downLightGuides($gxmlFile);
	$gxmlFile->print();
    #remove the Spherical Mirror STL
    my @files = ($dirName.'/Layer_302_component_1.stl', $dirName.'/Layer_302_component_2.stl',$dirName.'/Layer_302_component_3.stl',$dirName.'/Layer_302_component_4.stl',$dirName.'/Layer_302_component_5.stl',$dirName.'/Layer_302_component_6.stl',$dirName.'/Layer_302_component_7.stl',$dirName.'/Layer_302_component_8.stl',$dirName.'/Layer_302_component_9.stl',$dirName.'/Layer_302_component_10.stl');
    my $removed = unlink(@files);
    print "Removed  $removed files from $dirName. (Spherical Mirrors STLs)\n";

}

sub build_MESH
{
	my $gxmlFile = shift;
#	my @allMeshes =("OpticalGasVolume", "Aluminum","AerogelTiles","CFRP","Glass","TedlarWrapping","SphericalMirrors");
	my @allMeshes =("RICH_s4","Aluminum","CFRP","TedlarWrapping","MirrorSupport");
	foreach my $mesh (@allMeshes)
	{
		my %detector = init_det();

		my $vname                = $mesh;

		$detector{"name"}        = $vname;
		$detector{"pos"}         = $positions->{$vname};
		$detector{"rotation"}    = $rotations->{$vname};
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
            $detector{"mother"}      = "RICH_s4";

        
		}
		
		elsif($mesh eq "CFRP"){
			$detector{"color"}       = "44ff44";
			$detector{"material"}    = "CarbonFiber";
			$detector{"identifiers"}  = "CarbonFiber";
            $detector{"mother"}      = "RICH_s4";
		}
		
		elsif($mesh eq "TedlarWrapping"){
			$detector{"color"}       = "444444";
			$detector{"material"}    = "G4_AIR";
			$detector{"identifiers"}    = "CarbonFiber";
            $detector{"mother"}      = "RICH_s4";
		}

        elsif($mesh eq "MirrorSupport"){
            $detector{"color"}       = "E9C45D";
            $detector{"material"}    = "CarbonFiber";
            $detector{"identifiers"}    = "CarbonFiber";
            $detector{"mother"}      = "RICH_s4";
        }

		$gxmlFile->add(\%detector);
	}
}


sub build_Elements
{
    my $gxmlFile = shift;
    my $Max_Layer201=16;
    my $Max_Layer202=22;
    my $Max_Layer203=32;
    my $Max_Layer204=31;
    my $Max_Layer301=7;
    my $Max_Layer302=10;
    
    my $Layer=201;
    for (my $Component=1; $Component <= $Max_Layer201; $Component++) {
        my $MaterialName='aerogel_sector4_layer'.$Layer.'_component'.$Component;
        my $mesh = 'Layer_'.$Layer.'_component_'.$Component;
        my %detector = init_det();
        my $vname                = $mesh;
        $detector{"name"}        = $vname;
        $detector{"pos"}         = $positions->{$vname};
        $detector{"rotation"}    = $rotations->{$vname};
        $detector{"mother"}      = $mothers->{$vname};
        $detector{"color"}       = "4444ff";
        $detector{"material"}    = $MaterialName;
        $detector{"identifiers"}    = "aerogel";
        $detector{"mother"}      = "RICH_s4";
        $gxmlFile->add(\%detector);
    }



 $Layer=202;
for (my $Component=1; $Component <= $Max_Layer202; $Component++) {
    my $MaterialName='aerogel_sector4_layer'.$Layer.'_component'.$Component;
    my $mesh = 'Layer_'.$Layer.'_component_'.$Component;
    my %detector = init_det();
    my $vname                = $mesh;
    $detector{"name"}        = $vname;
    $detector{"pos"}         = $positions->{$vname};
    $detector{"rotation"}    = $rotations->{$vname};
    $detector{"mother"}      = $mothers->{$vname};
    $detector{"color"}       = "4444ff";
    $detector{"material"}    = $MaterialName;
    $detector{"identifiers"}    = "aerogel";
    $detector{"mother"}      = "RICH_s4";
    $gxmlFile->add(\%detector);
}


$Layer=203;
for (my $Component=1; $Component <= $Max_Layer203; $Component++) {
    my $MaterialName='aerogel_sector4_layer'.$Layer.'_component'.$Component;
    my $mesh = 'Layer_'.$Layer.'_component_'.$Component;
    my %detector = init_det();
    my $vname                = $mesh;
    $detector{"name"}        = $vname;
    $detector{"pos"}         = $positions->{$vname};
    $detector{"rotation"}    = $rotations->{$vname};
    $detector{"mother"}      = $mothers->{$vname};
    $detector{"color"}       = "4444ff";
    $detector{"material"}    = $MaterialName;
    $detector{"identifiers"}    = "aerogel";
    $detector{"mother"}      = "RICH_s4";
    $gxmlFile->add(\%detector);
}


$Layer=204;
for (my $Component=1; $Component <= $Max_Layer204; $Component++) {
    my $MaterialName='aerogel_sector4_layer'.$Layer.'_component'.$Component;
    my $mesh = 'Layer_'.$Layer.'_component_'.$Component;
    my %detector = init_det();
    my $vname                = $mesh;
    $detector{"name"}        = $vname;
    $detector{"pos"}         = $positions->{$vname};
    $detector{"rotation"}    = $rotations->{$vname};
    $detector{"mother"}      = $mothers->{$vname};
    $detector{"color"}       = "4444ff";
    $detector{"material"}    = $MaterialName;
    $detector{"identifiers"}    = "aluminum";
    $gxmlFile->add(\%detector);
}
    
$Layer=301;
for (my $Component=1; $Component <= $Max_Layer301 ; $Component++) {
    my $MaterialName='mirror_sector4_layer'.$Layer.'_component'.$Component;
    my $mesh = 'Layer_'.$Layer.'_component_'.$Component;
    my %detector = init_det();
    my $vname                = $mesh;
    $detector{"name"}        = $vname;
    $detector{"pos"}         = $positions->{$vname};
    $detector{"rotation"}    = $rotations->{$vname};
    $detector{"mother"}      = $mothers->{$vname};
    $detector{"color"}       = "cc99ff";
    $detector{"material"}    = "G4_Pyrex_Glass";
    $detector{"hitType"}    = 'mirror';
    $detector{"sensitivity"} = "mirror: rich_AlMgF2";
    $detector{"identifiers"} = 'sector manual '.$Component;
    $gxmlFile->add(\%detector);
  }
}



my $nPMTS  = 0 ;

sub build_PMTs{
	my $PMT_rows = 23;
	for(my $irow=0; $irow<$PMT_rows; $irow++){
		my $nPMTInARow = 6 + $irow;

		for(my $ipmt=0; $ipmt<$nPMTInARow; $ipmt++){
			my $vname = sprintf("MAPMT_${irow}_${ipmt}");
			my %detector = init_det();
      
      $nPMTS++;
			
      
            %detector = init_det();
			$detector{"name"}        = "$vname";
			$detector{"mother"}      = $mothers->{$vname};
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
	
				$detector{"name"}        = "$AlCase";
				$detector{"mother"}      = $mothers->{$AlCase};
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
			$detector{"name"}        = "$Socket";
			$detector{"mother"}      = $mothers->{$Socket};
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
			$detector{"name"}        = "$Window";
			$detector{"mother"}      = $mothers->{$Window};
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
			$detector{"name"}        = "$Photocathode";
			$detector{"mother"}      = $mothers->{$Photocathode};
			$detector{"description"} = "PMT mother volume";
			$detector{"pos"}         = $positions->{$Photocathode};
			$detector{"rotation"}    = $rotations->{$Photocathode};
			$detector{"color"}       = "999966";
			$detector{"type"}        = $types->{$Photocathode};
			$detector{"dimensions"}  = $dimensions->{$Photocathode};
			$detector{"material"}    = "Air_Opt";
           $detector{"sensitivity"} = "rich";
           $detector{"hit_type"}    = "rich";
           $detector{"identifiers"} = "sector manual 4 pad manual $nPMTS pixel manual 1";
			print_det(\%main::configuration, \%detector);
			
		}
	}
   print "Produced $nPMTS pmt  " ;
}

sub build_SphericalMirrors
{
    my $RadiusSphere= 2700.00;
    my $RadiusSphereFinal= 2701.00;

    my %detector = init_det();
    # Spherical Mirror 1 Component
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror1";
    $detector{"mother"}      = "RICH_s4";
    $detector{"description"} = "Spherical Mirror 1 component";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 122*deg 12.25*deg 60.0*deg 15.0*deg";
    $detector{"material"}    = "Component";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 1B
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror1B";
    $detector{"mother"}      = "RICH_s4";
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm ";
    $detector{"rotation"}    = "90*deg 0*deg -90*deg";
    $detector{"description"} = "SphericalMirror1B ";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 122*deg 12.25*deg 75.0*deg 15.0*deg";
    $detector{"material"}    = "CarbonFiber";
    $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_AlMgF2 ";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 10";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 1C
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror1C";
    $detector{"mother"}      = "RICH_s4";
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm ";
    $detector{"rotation"}    = "90*deg 0*deg -90*deg";
    $detector{"description"} = "SphericalMirror1C ";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 122*deg 12.25*deg 90.0*deg 15.0*deg";
    $detector{"material"}    = "CarbonFiber";
     $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_AlMgF2 ";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 11";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 1D
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror1D";
    $detector{"mother"}      = "RICH_s4";
    $detector{"pos"}         = "0*mm 0*mm  0*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"description"} = "SphericalMirror1D";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 122*deg 12.25*deg 105.0*deg 15.0*deg";
    $detector{"material"}    = "Component";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 2
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror2";
    $detector{"mother"}      = "RICH_s4";
    $detector{"pos"}         = "0*mm 0*mm  0*mm ";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"description"} = "SphericalMirror2";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 134.25*deg 11.5*deg 60.0*deg 21.0*deg";
    $detector{"material"}    = "Component";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 2B
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror2B";
    $detector{"mother"}      = "RICH_s4";
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm";
    $detector{"rotation"}    = "90*deg 0 -90*deg";
    $detector{"description"} = "SphericalMirror2B";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 134.25*deg 11.5*deg 81.0*deg 18.0*deg";
    $detector{"material"}    = "CarbonFiber";
     $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_AlMgF2 ";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 12";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 2C
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror2C";
    $detector{"mother"}      = "RICH_s4";
    $detector{"pos"}         = "0*mm 0*mm  0*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"description"} = "SphericalMirror2C";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 134.25*deg 11.5*deg 99.0*deg 21.0*deg";
    $detector{"material"}    = "Component";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 3
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror3";
    $detector{"mother"}      = "RICH_s4";
    $detector{"pos"}         = "0*mm 0*mm  0*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"description"} = "SphericalMirror3";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 145.75*deg 11.25*deg 60.0*deg 21.0*deg";
    $detector{"material"}    = "Component";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 3B
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror3B";
    $detector{"mother"}      = "RICH_s4";
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm";
    $detector{"rotation"}    = "90*deg 0 -90*deg";
    $detector{"description"} = "SphericalMirror3B";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 145.75*deg 11.25*deg 81.0*deg 18.0*deg";
    $detector{"material"}    = "CarbonFiber";
    $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_AlMgF2 ";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 13";
    print_det(\%main::configuration, \%detector);
    
    # Spherical Mirror 3C
    %detector = init_det();
    $detector{"name"}        = "SphericalMirror3C";
    $detector{"mother"}      = "RICH_s4";
    $detector{"pos"}         = "0*mm 0*mm  0*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"description"} = "SphericalMirror3C";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Sphere";
    $detector{"dimensions"}  = "$RadiusSphere*mm $RadiusSphereFinal*mm 145.75*deg 11.25*deg 99.0*deg 21.0*deg";
    $detector{"material"}    = "Component";
    print_det(\%main::configuration, \%detector);
    
    # Tilted Plane1
    %detector = init_det();
    $detector{"name"}        = "TiltedPlane1";
    $detector{"mother"}      = "RICH_s4";
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
    $detector{"name"}        = "TiltedPlane2";
    $detector{"mother"}      = "RICH_s4";
    $detector{"pos"}         = "0*mm 0*mm 525.0*mm";
    $detector{"rotation"}    = "-30*deg 0*deg 40*deg";
    $detector{"description"} = "TiltedPlane2";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Box";
    $detector{"dimensions"}  = "3000.0*mm 3000.0*mm 280*mm";
    $detector{"material"}    = "Component";
    print_det(\%main::configuration, \%detector);
    
    # New Mirror 4
    %detector = init_det();
    $detector{"name"}        = "NewMirror4";
    $detector{"mother"}      = "RICH_s4";
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm";
    $detector{"rotation"}    = "90*deg 0 -90*deg";
    $detector{"description"} = "subtraction mirror1-plane";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Operation:@ SphericalMirror1D - TiltedPlane1";
    $detector{"dimensions"}  = "0";
    $detector{"material"}    = "CarbonFiber";
     $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_AlMgF2 ";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 15";
    print_det(\%main::configuration, \%detector);
    
    # New Mirror 6
    %detector = init_det();
    $detector{"name"}        = "NewMirror6";
    $detector{"mother"}      = "RICH_s4";
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm ";
    $detector{"rotation"}    = "90*deg 0 -90*deg";
    $detector{"description"} = "subtraction mirror4-plane";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Operation:@ SphericalMirror2C - TiltedPlane1";
    $detector{"dimensions"}  = "0";
    $detector{"material"}    = "CarbonFiber";
     $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_AlMgF2 ";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 16";
    print_det(\%main::configuration, \%detector);
    
    # New Mirror 2
    %detector = init_det();
    $detector{"name"}        = "NewMirror2";
    $detector{"mother"}      = "RICH_s4";
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm ";
    $detector{"rotation"}    = "90*deg 0 -90*deg";
    $detector{"description"} = "subtraction mirror";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Operation:@ SphericalMirror3C - TiltedPlane1";
    $detector{"dimensions"}  = "0";
    $detector{"material"}    = "CarbonFiber";
     $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_AlMgF2 ";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 17";
    print_det(\%main::configuration, \%detector);
    
    # New Mirror 3
    %detector = init_det();
    $detector{"name"}        = "NewMirror3";
    $detector{"mother"}      = "RICH_s4";
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm ";
    $detector{"rotation"}    = "90*deg 0 -90*deg";
    $detector{"description"} = "subtraction mirror 3";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Operation:@ SphericalMirror1 - TiltedPlane2";
    $detector{"dimensions"}  = "0";
    $detector{"material"}    = "CarbonFiber";
     $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_AlMgF2 ";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 18";
    print_det(\%main::configuration, \%detector);
    
    # New Mirror 5
    %detector = init_det();
    $detector{"name"}        = "NewMirror5";
    $detector{"mother"}      = "RICH_s4";
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm";
    $detector{"rotation"}    = "90*deg 0 -90*deg";
    $detector{"description"} = "subtraction mirror 5";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Operation:@ SphericalMirror2 - TiltedPlane2";
    $detector{"dimensions"}  = "0";
    $detector{"material"}    = "CarbonFiber";
     $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_AlMgF2 ";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 19";
    print_det(\%main::configuration, \%detector);
    
    # New Mirror 1
    %detector = init_det();
    $detector{"name"}        = "NewMirror1";
    $detector{"mother"}      = "RICH_s4";
    $detector{"pos"}         = "-458.68*mm 0*mm  3919.77*mm";
    $detector{"rotation"}    = "90*deg 0 -90*deg";
    $detector{"description"} = "subtraction mirror 1";
    $detector{"color"}       = "696277";
    $detector{"type"}        = "Operation:@ SphericalMirror3 - TiltedPlane2";
    $detector{"dimensions"}  = "0";
    $detector{"material"}    = "CarbonFiber";
     $detector{"style"}    = "1";
    $detector{"sensitivity"} = "mirror: rich_AlMgF2 ";
    $detector{"hit_type"}    = "mirror";
    $detector{"identifiers"} = "id manual 20";
    print_det(\%main::configuration, \%detector);
    
}

sub build_fake_mother
{
	my $microgap = 0.1;

	my $TorusLength = 2158.4/2.0;  # 1/2 length of torus
	my $TorusZpos   = 3833;        # center of the torus position (include its semilengt). Value from M. Zarecky, R. Miller PDF file on 1/13/16

	my $torusZstart = $TorusZpos - $TorusLength - $microgap;
	my $torusZEnd   = $TorusZpos + $TorusLength + $microgap;

	my $nplanes_Cone = 8;

	my @z_plane_Cone = ( 1206.0,  1556.0, 2406.0, $torusZstart,  $torusZstart, $torusZEnd, $torusZEnd, 8500.0 );
	my @iradius_Cone = ( 2575.0,  2000.0,  132.0,        132.0,          61.5,       61.5,      197.0,  197.0 );
	my @oradius_Cone = ( 2575.0,  3500.0, 4800.0,       5000.0,        5000.0,     5000.0,     5000.0, 5000.0 );

		my %detector = init_det();
	
		$detector{"name"}        = "fc";
		$detector{"mother"}      = "root";
		$detector{"description"} = "Forward Carriage (FC) detector envelope to hold the torus magnet and the FC detectors";
		$detector{"pos"}         = "0*mm 0.0*mm 0*mm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = "88aa88";
		$detector{"type"}        = "Polycone";
	
		my $dimen = "0.0*deg 360*deg $nplanes_Cone*counts";
		for(my $i = 0; $i <$nplanes_Cone; $i++) {$dimen = $dimen ." $iradius_Cone[$i]*mm";}
		for(my $i = 0; $i <$nplanes_Cone; $i++) {$dimen = $dimen ." $oradius_Cone[$i]*mm";}
		for(my $i = 0; $i <$nplanes_Cone; $i++) {$dimen = $dimen ." $z_plane_Cone[$i]*mm";}
		$detector{"dimensions"}  = $dimen;

		$detector{"material"}    = "Air_Opt";
		#$detector{"mfield"}      = "clas12-torus-big";
		$detector{"visible"}     = 0;
		$detector{"style"}       = 0;
		print_det(\%main::configuration, \%detector);
}

1;
