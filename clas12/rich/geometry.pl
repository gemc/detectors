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
	    build_SphericalMirrors($sector,$gxmlFile);
	    my $sectorsuffix = "_s" . $sector;
	    #my @files = ($dirName.'/Layer_302_component_1'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_2'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_3'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_4'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_5'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_6'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_7'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_8'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_9'.$sectorsuffix.'.stl',$dirName.'/Layer_302_component_10'.$sectorsuffix.'.stl');
	    #my $removed = unlink(@files);
	    #print "Removed  $removed files from $dirName. (Spherical Mirrors STLs)\n";		
	}	 
	if (scalar @sectors > 0){
	    $gxmlFile->print();
	}
}
sub build_text
{
    my $sector = shift;
    #build_SphericalMirrors($sector);
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
    my $Max_Layer204 = 31;
    if($sector eq '1'){
	$Max_Layer204=32;
    }
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

    my $gxmlFile = shift;

    my $RadiusSphere= 2700.00;
    my $RadiusSphereFinal= 2701.00;

    my %detector = init_det();

    # Naming convention: Layer_302_component_1'.$sectorsuffix.'.stl'
    for (my $Component=1; $Component <= 10; $Component++) {

	my $MaterialName='mirror_sector'.$sector.'_layer302_component'.$Component;
	my $mesh = 'Layer_302_component_'.$Component;
	my %detector = init_det();
	my $vname                = $mesh;
	$detector{"name"}        = $vname.$sectorsuffix;
	$detector{"pos"}         = $positions->{$vname};
	$detector{"rotation"}    = $rotations->{$vname};
	$detector{"mother"}      = "RICH" . $sectorsuffix;
	$detector{"color"}       = "cc99ff";
	$detector{"material"}    = "CarbonFiber";
	$detector{"hitType"}    = 'mirror';
	$detector{"sensitivity"} = "mirror: rich_s".$sector."_mirror_spherical_".$Component;
	$detector{"identifiers"} = 'sector manual '.$Component;
	$gxmlFile->add(\%detector);	
    }    
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
