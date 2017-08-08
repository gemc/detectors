	our %configuration;
	our %parameters;

	our $startS;
	our $endS;
	our $startN;
	our $endN;
	
	# number of mirrors
	my $nmirrors = $parameters{"nmirrors"} ;

	# All dimensions in cm

	# PMTS parameters
	# PMTs are tubes

	#position of pmts in segment
	my @x0   = (); 
	my @y0   = ();
	# position of pmts in sector
	my @x0_sec = ();
	my @y0_sec = ();
	my @z0_sec = ();
	my @rad  = (); # pmt radius
	my @tilt = (); # Tilt angle of the PMT in the segment ref. system
	my @len  = (); # length of PMT tube
        my @shield_x0 = (); # shield dimensions
	my @shield_y0 = ();
	my @shield_z0 = ();
	my @sub_shield_x0 = (); # dimensions of the shield which will be subtracted
	my @sub_shield_y0 = ();
	my @sub_shield_z0 = ();
	my @shield_tilt = (); #Tilt angle of the shield
	my @segphi = (); # required rotation about x axis for pmts, pmts stoppers and shields
	my @segphi_cyl = (); # required rotation about x axis for cylindrical mirrors
	my @cyl_tilt_l = (); # rotation about z axis for cylindrical mirrors (left)
	my @cyl_tilt_r = (); # rotation about z axis for cylindrical mirrors (right)
	my @cyl_ang = (); # angle of the cylindrical mirror segment
	my @cyl_outer = (); # outer radius of the cylindrical mirror
	my @shield_pos_xR = (); # positions of the shields in sectors (R=right L=left)
	my @shield_pos_yR = ();
	my @shield_pos_zR = ();
	my @shield_pos_xL = ();
	my @shield_pos_yL = ();
	my @shield_pos_zL = ();
	my @mirror_pos_xR = (); # positions of the cylindrical mirrors in sectors (R=right L=left)
	my @mirror_pos_yR = ();
	my @mirror_pos_zR = ();
	my @mirror_pos_xL = ();
	my @mirror_pos_yL = ();
	my @mirror_pos_zL = ();
	my @fangle = ();

	sub buildPmts
	{	
		calculatePMTPars();
		build_pmts();
        
	} 

	sub calculatePMTPars
	{
		for(my $n=0; $n<$nmirrors ; $n++)
		{
			my $s = $n + 1;

			# All variables defined below take their values from ltcc__parameters_original.txt file which can be rewritten by running mirrors.C after adding new variables or editting current variables (one should define them in ltcc.h and io.C and also give the values in ccngeom.dat )

			$x0[$n]   = $parameters{"ltcc.pmt.s$s"."_pmt0x"};
			$y0[$n]   = $parameters{"ltcc.pmt.s$s"."_pmt0y"};
			$rad[$n]  = $parameters{"ltcc.pmt.s$s"."_radius"};
			$x0_sec[$n] = $parameters{"ltcc.pmt.s$s"."_x"};
			$y0_sec[$n] = $parameters{"ltcc.pmt.s$s"."_y"};
			$z0_sec[$n] = $parameters{"ltcc.pmt.s$s"."_z"};
			$tilt[$n] = $parameters{"ltcc.wc.s$s"."_angle"}; 
			$shield_x0[$n] = $parameters{"ltcc.shield.s$s"."_dx"};
			$shield_y0[$n] = $parameters{"ltcc.shield.s$s"."_dy"};
			$shield_z0[$n] = $parameters{"ltcc.shield.s$s"."_dz"};
			$shield_pos_xR[$n] = $parameters{"ltcc.shield.s$s"."_xR"};
			$shield_pos_yR[$n] = $parameters{"ltcc.shield.s$s"."_yR"};
			$shield_pos_zR[$n] = $parameters{"ltcc.shield.s$s"."_zR"};
			$shield_pos_xL[$n] = $parameters{"ltcc.shield.s$s"."_xL"};
			$shield_pos_yL[$n] = $parameters{"ltcc.shield.s$s"."_yL"};
			$shield_pos_zL[$n] = $parameters{"ltcc.shield.s$s"."_zL"};
			$mirror_pos_xR[$n] = $parameters{"ltcc.mirror.s$s"."_xR"};
			$mirror_pos_yR[$n] = $parameters{"ltcc.mirror.s$s"."_yR"};
			$mirror_pos_zR[$n] = $parameters{"ltcc.mirror.s$s"."_zR"};
			$mirror_pos_xL[$n] = $parameters{"ltcc.mirror.s$s"."_xL"};
			$mirror_pos_yL[$n] = $parameters{"ltcc.mirror.s$s"."_yL"};
			$mirror_pos_zL[$n] = $parameters{"ltcc.mirror.s$s"."_zL"};
			$shield_tilt[$n] =$parameters{"ltcc.shield.s$s"."_zangle"}; 
			$cyl_outer[$n] = $parameters{"ltcc.cyl.s$s"."_router"};
			$cyl_ang[$n] = 90 +  $parameters{"ltcc.shield.s$s"."_zangle"};
			$cyl_tilt_l[$n] = $parameters{"ltcc.cyl.s$s"."_leftAngle"};
			$cyl_tilt_r[$n] = $parameters{"ltcc.cyl.s$s"."_rightAngle"};


			#cylindrical mirror thickness is 1 mm (G4 Tube is used)
			$cyl_inner[$n] = $cyl_outer[$n] - 0.1;
			
	

			#To make shields with 1 mm thickness, the boxes with 1 mm smaller are subtracted from the original ones (G4 Box is used)

			$sub_shield_x0[$n] = $shield_x0[$n] - 0.1;
			$sub_shield_y0[$n] = $shield_y0[$n] - 0.1 ;
			$sub_shield_z0[$n] = $shield_z0[$n] + 0.1;
			
			# 90 - theta of center of ltcc. segment
			$segtheta[$n] = 90 - $parameters{"ltcc.s$s"."_theta"};

			#phi rotation angle for pmts, pmt stoppers and shield in sectors ! (calculated using their phi rotation angles in segments)
			$segphi[$n] = 90 - $segtheta[$n]; #rotation of pmts in sector


			#phi rotation angle cylindrical mirrors in sectors ! (calculated using phi rotation angle in segments)
			$segphi_cyl[$n] = -90 - $segtheta[$n];

			$len[$n] = 1;  # Hardcoding pmt length here

			$fangle[$s] = ($s - 2) * 60; # rotation angle of the ltcc frame for each sectors
			
			}
			
	}


	sub build_pmts
	{


	
		for(my $n=$startN; $n<=$endN; $n++)
			{
				for(my $s=$startS; $s<=$endS; $s++)
				{     

				# All following geometries are in the LTCC sectors ! Right and Left in names correspond to the specific geometries at right side or left side of the sector's center line 

				my %detector = init_det();
				$detector{"name"}        = "pmt_s$s"."right_$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "PMT right $n";
				$detector{"pos"}         = "$x0_sec[$n-1]*cm $y0_sec[$n-1]*cm $z0_sec[$n-1]*cm";
				$detector{"rotation"}    = "$segphi[$n-1]*deg -$tilt[$n-1]*deg 0*deg";
				$detector{"color"}       = "800000";
				$detector{"type"}        = "Tube";
				$detector{"dimensions"}  = "0*cm $rad[$n-1]*cm $len[$n-1]*cm 0*deg 360*deg";
				$detector{"material"}    = "LTCCPMTGlass";
				$detector{"style"}       = 1;
				$detector{"sensitivity"} = "ltcc";
				$detector{"hit_type"}    = "ltcc";
				$detector{"identifiers"} = "sector manual $s side manual 1 segment manual $n";
				print_det(\%configuration, \%detector);

				%detector = init_det();
				$detector{"name"}        = "pmt_s$s"."left_$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "PMT left $n";
				$detector{"pos"}         = "-$x0_sec[$n-1]*cm $y0_sec[$n-1]*cm $z0_sec[$n-1]*cm";
				$detector{"rotation"}    = "$segphi[$n-1]*deg $tilt[$n-1]*deg 0*deg";
				$detector{"color"}       = "800000";
				$detector{"type"}        = "Tube";
				$detector{"dimensions"}  = "0*cm $rad[$n-1]*cm $len[$n-1]*cm 0*deg 360*deg";
				$detector{"material"}    = "LTCCPMTGlass";
				$detector{"style"}       = 1;
				$detector{"sensitivity"} = "ltcc";
				$detector{"hit_type"}    = "ltcc";
				$detector{"identifiers"} = "sector manual $s side manual 2 segment manual $n";
				print_det(\%configuration, \%detector);

				# To prevent photons getting trapped inside the pmts smaller cylinders (light stoppers) are placed inside the pmts. 
				# These light stoppers do not have optical properties unlike pmts.
				my $stopLength = $rad[$n-1] - 0.01;

				%detector = init_det();
				$detector{"name"}        = "pmt_light_stopper_s$s"."right_$n";
				$detector{"mother"}      = "pmt_s$s"."right_$n";
				$detector{"description"} = "PMT light stopper right $n";
				$detector{"color"}       = "558844";
				$detector{"type"}        = "Tube";
				$detector{"dimensions"}  = "0*cm $stopLength*cm 0.5*cm 0*deg 360*deg";
				$detector{"material"}    = "G4_Galactic";
				$detector{"style"}       = 1;
				print_det(\%configuration, \%detector);

				%detector = init_det();
				$detector{"name"}        = "pmt_light_stopper_s$s"."left_$n";
				$detector{"mother"}      = "pmt_s$s"."left_$n";
				$detector{"description"} = "PMT light stopper left $n";
				$detector{"color"}       = "558844";
				$detector{"type"}        = "Tube";
				$detector{"dimensions"}  = "0*cm $stopLength*cm 0.5*cm 0*deg 360*deg";
				$detector{"material"}    = "G4_Galactic";
				$detector{"style"}       = 1;
				print_det(\%configuration, \%detector);

				
				
				# In this simulation there are 18 pmts and cylindrical mirrors in left and right segments of each sector
				# However the # of shields and  WCs are 17 in each segment. The following if statement is for 17 shields in each segment 

				

				# Shield dimensions were determined in a way that shields cover the outer face of the WC

				# Shield dimensions are not real dimension. Their sizes are decreased to avoid overlaps with other geometries and neighbor shields

				if($n < $endN){

				%detector = init_det();
				$detector{"name"}        = "shield_s$s"."right_$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "shield right $n";
				$detector{"pos"}         = "0*cm 0*cm 0*cm";
				$detector{"rotation"}    = "0*deg 0*deg 0*deg";;
				$detector{"color"}       = "000000";
				$detector{"type"}        = "Box";
				$detector{"dimensions"}  = "$shield_x0[$n-1]*cm $shield_y0[$n-1]*cm $shield_z0[$n-1]*cm";
				$detector{"material"}    = "Component";
				print_det(\%configuration, \%detector);

				%detector = init_det();
				$detector{"name"}        = "subtraction_shield_s$s"."right_$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "Subtraction shield right $n";
				$detector{"pos"}         = "0*cm 0*cm 0*cm";
				$detector{"rotation"}    = "0*deg 0*deg 0*deg";;
				$detector{"color"}       = "000000";
				$detector{"type"}        = "Box";
				$detector{"dimensions"}  = "$sub_shield_x0[$n-1]*cm $sub_shield_y0[$n-1]*cm $sub_shield_z0[$n-1]*cm";
				$detector{"material"} = "Component";
				print_det(\%configuration, \%detector);

				%detector = init_det();
				$detector{"name"}        = "final_shield_s$s"."right$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "combined shield right $n";
				$detector{"pos"}         = "$shield_pos_xR[$n-1]*cm $shield_pos_yR[$n-1]*cm $shield_pos_zR[$n-1]*cm";
				$detector{"rotation"}    = "$segphi[$n-1]*deg -$tilt[$n-1]*deg $shield_tilt[$n-1]*deg";
				$detector{"color"}       = "202020";
				$detector{"type"}        = "Operation:  shield_s$s"."right_$n - subtraction_shield_s$s"."right_$n";
				$detector{"material"}    = "G4_Fe";
				$detector{"style"}       = 1;
   				print_det(\%configuration, \%detector);	


				%detector = init_det();
				$detector{"name"}        = "shield_s$s"."left_$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "shield left $n";
				$detector{"pos"}         = "0*cm 0*cm 0*cm";
				$detector{"rotation"}    = "0*deg 0*deg 0*deg";
				$detector{"color"}       = "000000";
				$detector{"type"}        = "Box";
				$detector{"dimensions"}  = "$shield_x0[$n-1]*cm $shield_y0[$n-1]*cm $shield_z0[$n-1]*cm";
				$detector{"material"}    = "Component";
				print_det(\%configuration, \%detector);

				%detector = init_det();
				$detector{"name"}        = "subtraction_shield_s$s"."left_$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "Subtraction shield left $n";
				$detector{"pos"}         = "0*cm 0*cm 0*cm";
				$detector{"rotation"}    = "0*deg 0*deg 0*deg";
				$detector{"color"}       = "000000";
				$detector{"type"}        = "Box";
				$detector{"dimensions"}  = "$sub_shield_x0[$n-1]*cm $sub_shield_y0[$n-1]*cm $sub_shield_z0[$n-1]*cm";
				$detector{"material"}    = "Component";
				print_det(\%configuration, \%detector);
			
				

				%detector = init_det();
				$detector{"name"}        = "final_shield_s$s"."left_$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "combined shield left $n";
				$detector{"pos"}         = "$shield_pos_xL[$n-1]*cm $shield_pos_yL[$n-1]*cm $shield_pos_zL[$n-1]*cm";
				$detector{"rotation"}    = "$segphi[$n-1]*deg $tilt[$n-1]*deg -$shield_tilt[$n-1]*deg";
				$detector{"color"}       = "202020";
				$detector{"type"}        = "Operation:  shield_s$s"."left_$n - subtraction_shield_s$s"."left_$n";
				$detector{"material"}    = "G4_Fe";
				$detector{"style"}       = 1;
				print_det(\%configuration, \%detector);

				
				}


				
				# Cylindrical mirrors are placed in front of WCs, their half lengths are hardcoded as 3 cm

				# Cylindrical mirrors inner and outer radii are the same as WC's, both have 1 mm thickness			

				$detector{"name"}        = "cyl_mirrors_s$s"."right_$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "cyl mirrors right $n";
				$detector{"pos"}         = "$mirror_pos_xR[$n-1]*cm  $mirror_pos_yR[$n-1]*cm  $mirror_pos_zR[$n-1]*cm";
				$detector{"rotation"}    = "$segphi_cyl[$n-1]*deg $tilt[$n-1]*deg $cyl_tilt_r[$n-1]*deg";
				$detector{"color"}       = "aaffff";
				$detector{"type"}        = "Tube";
				$detector{"dimensions"}  = "$cyl_inner[$n-1]*cm $cyl_outer[$n-1]*cm 3*cm 0*deg $cyl_ang[$n-1]*deg";
				$detector{"material"}    = "G4_AIR";
				$detector{"style"}       = 1;
				$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
				$detector{"hit_type"}    = "mirror";
				print_det(\%configuration, \%detector);

				%detector = init_det();
				$detector{"name"}        = "cyl_mirrors_s$s"."left_$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "cyl mirrors left $n";
				$detector{"pos"}         = "$mirror_pos_xL[$n-1]*cm $mirror_pos_yL[$n-1]*cm $mirror_pos_zL[$n-1]*cm";
				$detector{"rotation"}    = "$segphi_cyl[$n-1]*deg -$tilt[$n-1]*deg $cyl_tilt_l[$n-1]*deg";
				$detector{"color"}       = "aaffff";
				$detector{"type"}        = "Tube";
				$detector{"dimensions"}  = "$cyl_inner[$n-1]*cm $cyl_outer[$n-1]*cm 3*cm 0*deg $cyl_ang[$n-1]*deg";
				$detector{"material"}    = "G4_AIR";
				$detector{"style"}       = 1;
				$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
				$detector{"hit_type"}    = "mirror";
				print_det(\%configuration, \%detector);

			}

		}


					for(my $s=$startS; $s<=$endS; $s++) {   

					my %detector = init_det();
					$detector{"name"}        = "frame1_s$s";
					$detector{"mother"}      = "root";
					$detector{"description"} = "ltcc frame $s";
					$detector{"pos"}         = "0*cm 0*cm 100*cm";
					$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
					$detector{"color"}       = "ccccdd";
					$detector{"type"}        = "CopyOf S1-BW ";
					#$detector{"material"}    = "G4_Galactic";
					$detector{"style"}       = 1;
					print_det(\%configuration, \%detector);

					%detector = init_det();
					$detector{"name"}        = "frame2_s$s";
					$detector{"mother"}      = "root";
					$detector{"description"} = "ltcc frame $s";
					$detector{"pos"}         = "0*cm 0*cm 100*cm";
					$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
					$detector{"color"}       = "ccccdd";
					$detector{"type"}        = "CopyOf S1-BB ";
					#$detector{"material"}    = "G4_Galactic";
					$detector{"style"}       = 1;
					print_det(\%configuration, \%detector);

					%detector = init_det();
					$detector{"name"}        = "frame3_s$s";
					$detector{"mother"}      = "root";
					$detector{"description"} = "ltcc frame $s";
					$detector{"pos"}         = "0*cm 0*cm 100*cm";
					$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
					$detector{"color"}       = "ccccdd";
					$detector{"type"}        = "CopyOf S1-BRB ";
					#$detector{"material"}    = "G4_Galactic";
					$detector{"style"}       = 1;
					print_det(\%configuration, \%detector);
			
					%detector = init_det();
					$detector{"name"}        = "frame4_s$s";
					$detector{"mother"}      = "root";
					$detector{"description"} = "ltcc frame $s";
					$detector{"pos"}         = "0*cm 0*cm 100*cm";
					$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
					$detector{"color"}       = "ccccdd";
					$detector{"type"}        = "CopyOf S1-LW ";
					#$detector{"material"}    = "G4_Galactic";
					$detector{"style"}       = 1;
					print_det(\%configuration, \%detector);
			
					%detector = init_det();
					$detector{"name"}        = "frame5_s$s";
					$detector{"mother"}      = "root";
					$detector{"description"} = "ltcc frame $s";
					$detector{"pos"}         = "0*cm 0*cm 100*cm";
					$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
					$detector{"color"}       = "ccccdd";
					$detector{"type"}        = "CopyOf S1-RW ";
					#$detector{"material"}    = "G4_Galactic";
					$detector{"style"}       = 1;
					print_det(\%configuration, \%detector);
				
					%detector = init_det();
					$detector{"name"}        = "frame6_s$s";
					$detector{"mother"}      = "root";
					$detector{"description"} = "ltcc frame $s";
					$detector{"pos"}         = "0*cm 0*cm 100*cm";
					$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
					$detector{"color"}       = "ccccdd";
					$detector{"type"}        = "CopyOf S1-TB ";
					#$detector{"material"}    = "G4_Galactic";
					$detector{"style"}       = 1;
					print_det(\%configuration, \%detector);

					%detector = init_det();
					$detector{"name"}        = "frame7_s$s";
					$detector{"mother"}      = "root";
					$detector{"description"} = "ltcc frame $s";
					$detector{"pos"}         = "0*cm 0*cm 100*cm";
					$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
					$detector{"color"}       = "ccccdd";
					$detector{"type"}        = "CopyOf S1-TRB ";
					#$detector{"material"}    = "G4_Galactic";
					$detector{"style"}       = 1;
					print_det(\%configuration, \%detector);

					%detector = init_det();
					$detector{"name"}        = "frame8_s$s";
					$detector{"mother"}      = "root";
					$detector{"description"} = "ltcc frame $s";
					$detector{"pos"}         = "0*cm 0*cm 100*cm";
					$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
					$detector{"color"}       = "ccccdd";
					$detector{"type"}        = "CopyOf S1-TLB ";
					#$detector{"material"}    = "G4_Galactic";
					$detector{"style"}       = 1;
					print_det(\%configuration, \%detector);

			
					%detector = init_det();
					$detector{"name"}        = "frame9_s$s";
					$detector{"mother"}      = "root";
					$detector{"description"} = "ltcc frame $s";
					$detector{"pos"}         = "0*cm 0*cm 100*cm";
					$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
					$detector{"color"}       = "ccccdd";
					$detector{"type"}        = "CopyOf S1-BLB ";
					$detector{"material"}    = "G4_Galactic";
					$detector{"style"}       = 1;
					print_det(\%configuration, \%detector);

				
				        }


 }



1;











