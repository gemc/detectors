
# Parallelepiped Coils 1
my $PC1_dx    = $ColdHubLength - 100.0;   # This part will end on the z-axis
my $PC1_dy    = 20.9;                     # Aluminum 1/2 Thickness = 41.8 mm
my $PC1_dz    = 1700.0;                   # length from beampipe
my $PC1_angle = -25.0;
my $PC1_zpos = -20.0;


# Part 1: main Parallelepiped
sub make_part1
{
	my %detector = init_det();
	$detector{"name"}        = "aaa_Torus_part1";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus Component #1: parallelepiped part";
	$detector{"pos"}         = "0*mm 0.0*cm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "ff88bb";
	$detector{"type"}        = "Parallelepiped";
	$detector{"dimensions"}  = "$PC1_dx*mm $PC1_dy*mm $PC1_dz*mm 0*deg $PC1_angle*deg 0*deg";
	$detector{"material"}    = "Air";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


# Part 2: Box to subtract to part1: Hole near the Outer Ring
my $B1_dx    = $PC1_dx + 500.0;   # This will end on the z-axis
my $B1_dy    = $PC1_dy + 100;
my $B1_dz    = 600.0;
my $B1_posx  = -1700.0;
my $B1_posz  = $B1_dz + $PC1_dz - 1100.0;
my $B1_angle = +22.0;

sub make_part2
{
	my %detector = init_det();
	$detector{"name"}        = "aaa_Torus_part2";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus Component #2: Box to subtract";
	$detector{"pos"}         = "$B1_posx*mm 0.0*cm $B1_posz*mm";
	$detector{"rotation"}    = "0*deg $B1_angle*deg 0*deg";
	$detector{"color"}       = "ff00ff";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "$B1_dx*mm $B1_dy*mm $B1_dz*mm";
	$detector{"material"}    = "Air";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

# Part 3 - Parallelepiped with top Hole: Part 2 - Part1
sub make_part3
{
	my %detector = init_det();
	$detector{"name"}        = "aaa_Torus_part3";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus Component #3: aaa_Torus_part1 - aaa_Torus_part2";
	$detector{"pos"}         = "0*mm 0.0*cm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "ffff66";
	$detector{"type"}        = "Operation: aaa_Torus_part1 - aaa_Torus_part2";
	$detector{"dimensions"}  = "0*mm";
	$detector{"material"}    = "Air";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}



# Part 4: Box to add to part3: it will make the hole look like the drawings
my $B2_dx    =  510.0;   # This will end on the z-axis
my $B2_dz    =  200.0;
my $B2_posx  =  -270.0;
my $B2_posz  = 1180.0;
my $B2_angle = +90.0;

sub make_part4
{
	my %detector = init_det();
	$detector{"name"}        = "aaa_Torus_part4";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus Coil: small Box to add";
	$detector{"pos"}         = "$B2_posx*mm 0.0*cm $B2_posz*mm";
	$detector{"rotation"}    = "0*deg $B2_angle*deg 0*deg";
	$detector{"color"}       = "ff66ff";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "$B2_dx*mm $PC1_dy*mm $B2_dz*mm";
	$detector{"material"}    = "Air";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


# Part 5 - Parallelepiped with final top: Part3 + part4
sub make_part5
{
	my %detector = init_det();
	$detector{"name"}        = "aaa_Torus_part5";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus Component #5: aaa_Torus_part3 + aaa_Torus_part4";
	$detector{"pos"}         = "0*mm 0.0*cm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = $acol;
	$detector{"type"}        = "Operation: aaa_Torus_part3 + aaa_Torus_part4";
	$detector{"dimensions"}  = "0*mm";
	$detector{"material"}    = "Air";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}



# Part6: Box to add to make front face perperndicolar to beam
my $B3_dx    =  120.0;   # This will end on the z-axis
my $B3_dy    =  $PC1_dy + .05;
my $B3_dz    =  200.0;
my $B3_x     =  -200.0;
my $B3_z     =  -1505.0;

sub make_part6
{
	my %detector = init_det();
	$detector{"name"}        = "aaa_Torus_part6";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus Coil: Box to add to make front face perperndicolar to beam";
	$detector{"pos"}         = "$B3_x*mm 0*mm $B3_z*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "ff0000";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "$B3_dx*mm $B3_dy*mm $B3_dz*mm";
	$detector{"material"}    = "Air";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}



# inal Parallelepiped: Part 5 + part6. Make copies of all Coils, call them aab_Torus_part$nindex
my $overlap = 30.00;
sub make_coils
{
	for(my $n=0; $n<6; $n++)
	{
		my $nindex      = $n+1;
		my $R           = $ColdHubOR + $PC1_dz - $overlap;
		
		my %detector = init_det();
		$detector{"name"}        = "aab_Torus_part$nindex";
		$detector{"mother"}      = "fc";
		$detector{"description"} = "Torus Component #$nindex: aaa_Torus_part5 + aaa_Torus_part6";
		$detector{"pos"}         = Pos($R, $n);
		$detector{"rotation"}    = Rot($R, $n);
		$detector{"color"}       = $acol;
		$detector{"type"}        = "Operation: aaa_Torus_part5 + aaa_Torus_part6";
		$detector{"dimensions"}  = "0*mm";
		$detector{"material"}    = "Air";
		if($n <6)
		{
			$detector{"material"}    = "Component";
		}
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
}

# Sum Cold Hub with first Coil
sub make_coil1
{
	my %detector = init_det();
	$detector{"name"}        = "aac_Torus_part1";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus Ring + aab_Torus_part1";
	$detector{"pos"}         = "0.0*cm 0.0*cm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = $acol;
	$detector{"type"}        = "Operation: Torus_ColdHub + aab_Torus_part1";
	$detector{"dimensions"}  = "0*mm";
	$detector{"material"}    = "Air";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

# Add remaining coils: Final Aluminum Cold Hub + Coils it's aac_Torus_part6
sub make_sumcoils
{
	for(my $n=1; $n<6; $n++)
	{
		my $iname       = $n+1;
		
		my %detector = init_det();
		$detector{"name"}        = "aac_Torus_part$iname";
		$detector{"mother"}      = "fc";
		$detector{"description"} = "aac_Torus_part$n + aab_Torus_part$iname";
		$detector{"pos"}         = "0.0*cm 0.0*cm $TorusZpos*mm";
		$detector{"rotation"}    = "0*deg 180*deg 0*deg";
		$detector{"color"}       = $acol;
		$detector{"type"}        = "Operation: aac_Torus_part$n + aab_Torus_part$iname";
		$detector{"dimensions"}  = "0*mm";
		$detector{"material"}    = "G4_Al";
		$detector{"material"}    = "Component";
		if($n == 5)
		{
			$detector{"name"}        = "torus_Aluminum_Coils";
			#			$detector{"mother"}      = "fc";
			$detector{"material"}    = "G4_Al";
		}
		$detector{"visible"}     = 1;
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
}

#sub make_aluminum_coils
#{
#    make_IRing();
#    make_part1();
#    make_part2();
#    make_part3();
#    make_part4();
#    make_part5();
#    make_part6();
#    make_coils();
#    make_coil1();
#    make_sumcoils();
#}




######################################             Air Coils             ######################################

# Parallelepiped Coils 2
my $PC2_dx    = $TorusAirLength - 36.0;   # This part will end on the z-axis. Steel plates are 6mm
my $PC2_dy    = 41.59;                    # Air 1/2 Thickness: Steel plates are 6mm thick so it's (95.18 - 12) (/2 =41.59)
my $PC2_dz    = 1800.0;                   # length from beampipe
my $PC2_angle = -25.0;
my $PC2_zpos = 65.0;

# Part 1: main Parallelepiped
sub make_air_part1
{
	my %detector = init_det();
	$detector{"name"}        = "aaa_TorusAir_part1";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus Air Component #1: parallelepiped part";
	$detector{"pos"}         = "0*mm 0.0*cm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "ff88bb";
	$detector{"type"}        = "Parallelepiped";
	$detector{"dimensions"}  = "$PC2_dx*mm $PC2_dy*mm $PC2_dz*mm 0*deg $PC2_angle*deg 0*deg";
	$detector{"material"}    = "Air";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


# Part 2: Box to subtract to part1: Hole near the Outer Ring
my $B4_dx    = $PC2_dx + 500.0;   # This will end on the z-axis
my $B4_dy    = $PC2_dy + 100;
my $B4_dz    = 600.0;
my $B4_posx  = -2300.0 + 6.0;
my $B4_posz  = $B4_dz + $PC2_dz - 1150.0;
my $B4_angle = +22.0;

sub make_air_part2
{
	my %detector = init_det();
	$detector{"name"}        = "aaa_TorusAir_part2";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus Air Component #2: Box to subtract";
	$detector{"pos"}         = "$B4_posx*mm 0.0*cm $B4_posz*mm";
	$detector{"rotation"}    = "0*deg $B4_angle*deg 0*deg";
	$detector{"color"}       = "ff00ff";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "$B4_dx*mm $B4_dy*mm $B4_dz*mm";
	$detector{"material"}    = "Air";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

# Part 3 - Parallelepiped with top Hole: Part 2 - Part1
sub make_air_part3
{
	my %detector = init_det();
	$detector{"name"}        = "aaa_TorusAir_part3";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus Air Component #3: aaa_TorusAir_part1 - aaa_TorusAir_part2";
	$detector{"pos"}         = "0*mm 0.0*cm -10*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "ffff66";
	$detector{"type"}        = "Operation: aaa_TorusAir_part1 - aaa_TorusAir_part2";
	$detector{"dimensions"}  = "0*mm";
	$detector{"material"}    = "Air";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


#sub make_air_coils
#{
#    make_air_part1();
#    make_air_part2();
#    make_air_part3();
#}



######################################   Steel Frame   ######################################

# set flag to decide whether to add the big outer torus rings or not (0=NO, 1=YES)
my $add_torus_ORing=0;

my $scol              = 'ffff9b';



# Parallelepiped Coils 1
my $PC3_dx    = $SteelFrameLength - 30.0;   # This part will end on the z-axis
my $PC3_dy    = 47.59;                      # SteelFrame 1/2 Thickness: Steel plates are 6mm thick
my $PC3_dz    = 1800.0;                     # length from beampipe
my $PC3_angle = -25.0;
my $PC3_zpos = 78.0;

# Inner Ring:
my $SteelPlateIR   =  7.64*$inches ;
my $SteelPlateOR   =  7.87*$inches ;
my $SpanAngleCoil  = atan($PC3_dy/($SteelPlateOR - 55.0))*180.0/$pi;
my $SpanAnglePlate = 35.00;


# Part 1: main Parallelepiped
sub make_steel_part1
{
	my %detector = init_det();
	$detector{"name"}        = "aaa_SteelFrame_part1";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus SST Frame Component #1: parallelepiped part";
	$detector{"pos"}         = "0*mm 0.0*cm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "ff88bb";
	$detector{"type"}        = "Parallelepiped";
	$detector{"dimensions"}  = "$PC3_dx*mm $PC3_dy*mm $PC3_dz*mm 0*deg $PC3_angle*deg 0*deg";
	$detector{"material"}    = "Air";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


# Part 2: Box to subtract to part1: Hole near the Outer Ring
my $B5_dx    = $PC3_dx + 500.0 - 30.0;   # This will end on the z-axis
my $B5_dy    = $PC3_dy + 100;
my $B5_dz    = 600.0;
my $B5_posx  = -2300.0;
my $B5_posz  = $B5_dz + $PC3_dz - 1150.0;
my $B5_angle = +22.0;

sub make_steel_part2
{
	my %detector = init_det();
	$detector{"name"}        = "aaa_SteelFrame_part2";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus SteelFrame Component #2: Box to subtract";
	$detector{"pos"}         = "$B5_posx*mm 0.0*cm $B5_posz*mm";
	$detector{"rotation"}    = "0*deg $B5_angle*deg 0*deg";
	$detector{"color"}       = "ff00ff";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "$B5_dx*mm $B5_dy*mm $B5_dz*mm";
	$detector{"material"}    = "Air";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

# Part 3 - Parallelepiped with top Hole: Part 2 - Part1
sub make_steel_part3
{
	my %detector = init_det();
	$detector{"name"}        = "aab_SteelFrame_part3";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus SteelFrame Component #3: aaa_SteelFrame_part1 - aaa_SteelFrame_part2";
	$detector{"pos"}         = "0*mm 0.0*cm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "ffff66";
	$detector{"type"}        = "Operation: aaa_SteelFrame_part1 - aaa_SteelFrame_part2";
	$detector{"dimensions"}  = "0*mm";
	$detector{"material"}    = "Air";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


# Make all empty Coils (subtract air part), call them aac_SteelFrame_part$nindex
my $overlap2 = 15.00;
sub make_empty_coils
{
	for(my $n=0; $n<6; $n++)
	{
		my $nindex      = $n+1;
		my $R           = $SteelPlateOR + $PC3_dz - $overlap2;
		my %detector = init_det();
		$detector{"name"}        = "aac_SteelFrame_part$nindex";
		$detector{"mother"}      = "fc";
		$detector{"description"} = "Torus Component #$nindex:  aab_SteelFrame_part3 - aaa_TorusAir_part3";
		$detector{"pos"}         = Pos2($R, $n);
		$detector{"rotation"}    = Rot($R, $n);
		$detector{"color"}       = $scol;
		$detector{"type"}        = "Operation: aab_SteelFrame_part3 - aaa_TorusAir_part3";
		$detector{"dimensions"}  = "0*mm";
		$detector{"material"}    = "Air";
		$detector{"material"}    = "Component";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
}

sub make_steel_plates
{
	for(my $n=0; $n<6; $n++)
	{
		my $nindex      = $n+1;
		my $R           = $SteelPlateOR ;
		my $start_phi   = -$SpanAnglePlate/2.0;
		my $length      =  $SteelFrameLength;
		my %detector = init_det();
		$detector{"name"}        = "aae_SteelPlate_part$nindex";
		$detector{"mother"}      = "fc";
		$detector{"description"} = "Steel Plate $nindex";
		$detector{"pos"}         = "0.0*cm 0.0*cm 0*cm";
		$detector{"rotation"}    = Rot2($R, $n);
		$detector{"color"}       = $scol;
		$detector{"type"}        = "Tube";
		$detector{"dimensions"}  = "$SteelPlateIR*mm $SteelPlateOR*mm $length*mm $start_phi*deg $SpanAnglePlate*deg";
		$detector{"material"}    = "Air";
		$detector{"material"}    = "Component";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
}




# Part4: mold first plate with first frame
sub make_steel_part4
{
	my %detector = init_det();
	$detector{"name"}        = "aaf_Steel_part01";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Steel Plate + Frame 1";
	$detector{"pos"}         = "0*mm 0.0*cm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = $scol;
	$detector{"type"}        = "Operation: aae_SteelPlate_part1 + aac_SteelFrame_part1";
	$detector{"material"}    = "Air";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


# Part5: add in order frames and plates
sub make_steel_part5
{
	my $index_frame = 6;
	my $index_plate = 2;
	for(my $n=1; $n<10+$add_torus_ORing; $n++)
	{
		my $zero        = "0";
		if($n > 8)
		{
			$zero     = "";
		}
		my $nindex      = $n+1;
		
		my %detector = init_det();
		$detector{"name"}        = "aaf_Steel_part$zero$nindex";
		$detector{"mother"}      = "fc";
		$detector{"description"} = "Steel Part $nindex";
		$detector{"pos"}         = "0*mm 0.0*cm 0*mm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = $scol;
		
		if($n%2 == 1)
		{
			if($n == 9)
			{
				$zero     = "0";
			}
			$detector{"type"}  = "Operation: aaf_Steel_part$zero$n + aac_SteelFrame_part$index_frame";
			$index_frame--;
		}
		if($n%2 == 0)
		{
			$detector{"type"}  = "Operation: aaf_Steel_part$zero$n + aae_SteelPlate_part$index_plate";
			$index_plate++;
		}
		$detector{"material"}    = "Air";
		$detector{"material"}    = "Component";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
	}
}


sub make_steel_part6
{
	my %detector = init_det();
	$detector{"name"}        = "torus_steel_frame";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Steel Part 11";
	$detector{"pos"}         = "0*mm 0.0*cm $TorusZpos*mm";
	$detector{"rotation"}    = "0*deg 180*deg 0*deg";
	$detector{"color"}       = $scol;
	$detector{"type"}        = "Operation: aaf_Steel_part10 + aae_SteelPlate_part6";
	$detector{"material"}    = "StainlessSteel";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


# Big Torus ring 1
my $O1CoilLength = 80.0;
my $O1CoilID     = 2600.0;
my $O1CoilOD     = 2770.0;
my $O1CoilZpos   = 2100.0;
sub make_ORing1
{
	my %detector = init_det();
	$detector{"name"}        = "Torus_Outer_Ring1";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus Outer Ring1";
	$detector{"pos"}         = "0.0*cm 0.0*cm $O1CoilZpos*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = $scol;
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$O1CoilID*mm $O1CoilOD*mm $O1CoilLength*mm  0.0*deg 360.0*deg";
	$detector{"material"}    = "Air";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


sub make_sumor1
{
	my %detector = init_det();
	$detector{"name"}        = "aag_Torus_part1";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "aaf_Steel_part11 + Torus_Outer_Ring1";
	$detector{"pos"}         = "0.0*cm 0.0*cm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = $scol;
	$detector{"type"}        = "Operation: aaf_Steel_part11 + Torus_Outer_Ring1";
	$detector{"dimensions"}  = "0*mm";
	$detector{"material"}    = "Air";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


# Big Torus ring 2
my $O2CoilLength = 130.0;
my $O2CoilID     = 3400.0;
my $O2CoilOD     = 3650.0;
my $O2CoilZpos   = 680.0;
sub make_ORing2
{
	my %detector = init_det();
	$detector{"name"}        = "Torus_Outer_Ring2";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus Outer Ring2";
	$detector{"pos"}         = "0.0*cm 0.0*cm $O2CoilZpos*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = $scol;
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$O2CoilID*mm $O2CoilOD*mm $O2CoilLength*mm  0.0*deg 360.0*deg";
	$detector{"material"}    = "Air";
	$detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


sub make_sumor2
{
	my %detector = init_det();
	$detector{"name"}        = "torus_steel_frame";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "aag_Torus_part1 + Torus_Outer_Ring2";
	$detector{"pos"}         = "0.0*cm 0.0*cm $TorusZpos*mm";
	$detector{"rotation"}    = "0*deg 180*deg 0*deg";
	$detector{"type"}        = "Operation: aag_Torus_part1 + Torus_Outer_Ring2";
	$detector{"color"}       = $scol;
	$detector{"dimensions"}  = "0*mm";
	$detector{"material"}    = "StainlessSteel";
	# $detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}



#sub make_steel_frame
#{
#
#        make_ipipe();
#	make_ishield();
#	make_steel_part1();
#	make_steel_part2();
#	make_steel_part3();
#	make_empty_coils();
#	make_steel_plates();
#	make_steel_part4();
#	make_steel_part5();
#
#	make_w_shields();
#
#
#	if($add_torus_ORing == 0 )
#	  {
#	    make_steel_part6();
#	  }
#	else
#	  {
#	    make_ORing1();
#	    make_sumor1();
#	    make_ORing2();
#	    make_sumor2();
#	  }
#	make_face_plate();
#	make_face_plate2();
#}



#make_aluminum_coils();
#make_air_coils();
#make_steel_frame();
#
#



sub Pos
{
	my $R = shift;
	my $i = shift;
	my $z         = $PC1_zpos + $PC1_dz*tan(abs(rad($PC1_angle))) - 80.0;
	
	my $theta     = 30.0 + $i*60.0;
	my $x         = sprintf("%.3f", $R*cos(rad($theta)));
	my $y         = sprintf("%.3f", $R*sin(rad($theta)));
	return "$x*mm $y*mm $z*mm";
}

sub Rot
{
	my $R = shift;
	my $i = shift;
	
	my $theta     = 30.0 + $i*60.0;
	
	return "ordered: yxz -90*deg $theta*deg 0*deg";
}



sub Pos2
{
	my $R = shift;
	my $i = shift;
	my $z         = $PC3_zpos + $PC3_dz*tan(abs(rad($PC3_angle))) - 80.0;
	
	my $theta     = 30.0 + $i*60.0;
	my $x         = sprintf("%.3f", $R*cos(rad($theta)));
	my $y         = sprintf("%.3f", $R*sin(rad($theta)));
	return "$x*mm $y*mm $z*mm";
}


sub Rot2
{
	my $R = shift;
	my $i = shift;
	
	my $theta     = $i*60.0;
	
	return "0*deg 0*deg $theta*deg";
}


