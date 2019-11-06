use strict;
use warnings;

our %configuration;

sub build_ebox
{
	my %detector = init_det();
	$detector{"name"}        = "ebox";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Electronics box";
	$detector{"pos"}         = "0*cm 0*cm 0*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "339999";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "119.39*mm 133*mm 114.62*mm"; # 114*cm 114*cm 104*cm
	$detector{"material"}    = "G4_AIR";
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);

	build_crate();
	build_panel();
}

sub build_crate
{
	
	my %detector = init_det();
	$detector{"name"}        = "Nearside";
	$detector{"mother"}      = "ebox";
	$detector{"description"} = "Crate side attached to MVT";
	$detector{"pos"}         = "-116.89*mm 0*cm 0*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "aaaaaa";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "2.5*mm 133*mm 114.62*mm"; # 114*cm 114*cm 104*cm
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "Back";
	$detector{"mother"}      = "ebox";
	$detector{"description"} = "Back of Crate";
	$detector{"pos"}         = "0*cm 0*cm -113.27*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "aaaaaa";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "119.39*mm 133*mm 1.25*mm"; # 114*cm 114*cm 104*cm
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "Farside";
	$detector{"mother"}      = "ebox";
	$detector{"description"} = "Crate side away from MVT";
	$detector{"pos"}         = "118.14*mm 0*cm 0*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "aaaaaa";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "1.25*mm 133*mm 114.62*mm"; # 114*cm 114*cm 104*cm
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "top";
	$detector{"mother"}      = "ebox";
	$detector{"description"} = "Topside of the crate";
	$detector{"pos"}         = "0*cm 132.25*mm 0*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "aaaaaa";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "119.39*mm 0.75*mm 114.62*mm"; # 114*cm 114*cm 104*cm
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "bottom";
	$detector{"mother"}      = "ebox";
	$detector{"description"} = "Bottom side of the Crate";
	$detector{"pos"}         = "0*cm -132.25*mm 0*cm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "aaaaaa";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "119.39*mm 0.75*mm 114.62*mm"; # 114*cm 114*cm 104*cm
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "patch_panel";
	$detector{"mother"}      = "ebox";
	$detector{"description"} = "Patch Panel for Crate";
	$detector{"pos"}         = "0*mm -174.9*mm 74.6*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "999999";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "90*mm 20*mm 15*mm"; # 114*cm 114*cm 104*cm
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}
sub build_panel
{
	for(my $n=1; $n<=8; $n++)
	{
		my $xpo = ($n-1)*25.42-99.18;
		my $zpo = 112.62;
		my %detector = init_det();
		$detector{"name"}        = "panel_$n";
		$detector{"mother"}      = "ebox";
		$detector{"description"} = "Panel $n";
		$detector{"pos"}         = "$xpo*mm 0*cm $zpo*mm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = "ee5500";
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "12.5*mm 131*mm 1.2*mm"; # 5*mm 133*mm 1*mm
		$detector{"material"}    = "G4_Al";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);

		$xpo = $xpo - 10.5;
		$zpo = $zpo - 113;
		$detector{"name"}        = "Lplate_$n";
		$detector{"mother"}      = "ebox";
		$detector{"description"} = "Left plate $n";
		$detector{"pos"}         = "$xpo*mm 0*cm $zpo*mm"; # 5*cm
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = "888888"; #dddddd
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "0.3*mm 116*mm 107.5*mm"; # 1*mm 133*mm 20*mm
		$detector{"material"}    = "G4_Al";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);

		$xpo = $xpo + 21;
		$detector{"name"}        = "Rplate_$n";
		$detector{"mother"}      = "ebox";
		$detector{"description"} = "Right plate $n";
		$detector{"pos"}         = "$xpo*mm 0*cm $zpo*mm"; # 5*cm
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = "888888"; #555555
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "0.3*mm 116*mm 107.5*mm"; # 1*mm 133*mm 20*mm
		$detector{"material"}    = "G4_Al";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);

		$xpo = $xpo - 6.5;
		$detector{"name"}        = "eboard_$n";
		$detector{"mother"}      = "ebox";
		$detector{"description"} = "Electronics board $n";
		$detector{"pos"}         = "$xpo*mm 0*cm $zpo*mm"; # 5*cm
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = "9AB973"; #771111
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "1*mm 116.75*mm 110*mm"; # 1*mm 133*mm 21*mm
		$detector{"material"}    = "G10"; # pcb fiberglass
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);

	}
}
