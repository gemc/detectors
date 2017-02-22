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
	my @x0   = ();
	my @y0   = ();
	my @x0_sec = ();
	my @y0_sec = ();
	my @z0_sec = ();
	my @rad  = (); # radius
	my @tilt = (); # Tilt angle of the PMT in the segment ref. system
	my @len  = (); # length of PMT tube
	my @WCr2inner = ();
	my @WCr2outer = ();
	my @WCrzouter = ();
	my @WCrzinner = ();
        my @shield_x0 = ();
	my @shield_y0 = ();
	my @shield_z0 = ();
	my @sub_shield_x0 = ();
	my @sub_shield_y0 = ();
	my @sub_shield_z0 = ();
	my @shield_tilt = ();
	my @segphi = ();
	my @segphi_wc = ();
	my @cyl_tilt_l = ();
	my @cyl_tilt_r = ();
	my @shield_pos_xR = ();
	my @shield_pos_yR = ();
	my @shield_pos_zR = ();
	my @shield_pos_xL = ();
	my @shield_pos_yL = ();
	my @shield_pos_zL = ();
	my @mirror_pos_xR = ();
	my @mirror_pos_yR = ();
	my @mirror_pos_zR = ();
	my @mirror_pos_xL = ();
	my @mirror_pos_yL = ();
	my @mirror_pos_zL = ();

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
			$WCr1inner[$n] = $parameters{"ltcc.wc.s$s"."_r1inner"}; 
			$WCr2inner[$n] = $parameters{"ltcc.wc.s$s"."_r2inner"};
			$WCzouter[$n] = $parameters{"ltcc.wc.s$s"."_zouter"}; 
			$dz_d[$n] = $parameters{"ltcc.shield.s$s"."_shift"}; # half lengths of shields were decreased to prevent overlaps with the ltcc sectors

			
			$cyl_ang[$n] = 90 +  $parameters{"ltcc.shield.s$s"."_zangle"};
			$cyl_tilt_l[$n] = $parameters{"ltcc.cyl.s$s"."_leftAngle"};
			$cyl_tilt_r[$n] = $parameters{"ltcc.cyl.s$s"."_rightAngle"};

			#To obtain Winston Cone geometry a paraboloid is subtracted from the other one whose top/bottom radii are 0.1 cm bigger 				and half length z is 0.1 cm smaller

			$WCr1outer[$n] = $WCr1inner[$n] - 0.1;
			$WCr2outer[$n] = $WCr2inner[$n] - 0.1;
			

			
			

			#To obtain Winston Cone geometry a paraboloid is subtracted from the other one whose x and y dimensions are 0.1 cm 				bigger and z dimension is 0.1 cm smaller

			$sub_shield_x0[$n] = $shield_x0[$n] - 0.1;
			$sub_shield_y0[$n] = $shield_y0[$n] - 0.1 ;
			$sub_shield_z0[$n] = $shield_z0[$n] + 0.1;
			
			# 90 - theta of center of ltcc. segment
			$segtheta[$n] = 90 - $parameters{"ltcc.s$s"."_theta"};

			#phi rotation angle for pmts, pmt stoppers and shield in sectors ! (calculated using their phi rotation angles in segments)
			$segphi[$n] = 90 - $segtheta[$n]; #rotation of pmts in sector


			#phi rotation angle for Winston Cones and cylindrical mirrors in sectors ! (calculated using phi rotation angle in segments)
			$segphi_wc[$n] = -90 - $segtheta[$n];
			$len[$n] = 1;  # Harcoding length here

			
			
			}
			
			
			
	}


	sub build_pmts
	{

	
	

		for(my $n=$startN; $n<=$endN; $n++)
			{
				for(my $s=$startS; $s<=$endS; $s++)
				{       

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

				%detector = init_det();
				$detector{"name"}        = "pmt_light_stopper_s$s"."right_$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "PMT light stopper right $n";
				$detector{"pos"}         = "$x0_sec[$n-1]*cm $y0_sec[$n-1]*cm $z0_sec[$n-1]*cm";
				$detector{"rotation"}    = "$segphi[$n-1]*deg -$tilt[$n-1]*deg 0*deg";
				$detector{"color"}       = "558844";
				$detector{"type"}        = "Tube";
				$detector{"dimensions"}  = "0*cm $rad[$n-1]*cm 0.5*cm 0*deg 360*deg";
				$detector{"material"}    = "G4_Galactic";
				$detector{"style"}       = 1;
				print_det(\%configuration, \%detector);

				%detector = init_det();
				$detector{"name"}        = "pmt_light_stopper_s$s"."left_$n";
				$detector{"mother"}      = "ltccS$s";			
				$detector{"description"} = "PMT light stopper left $n";
				$detector{"pos"}         = "-$x0_sec[$n-1]*cm $y0_sec[$n-1]*cm $z0_sec[$n-1]*cm";
				$detector{"rotation"}    = "$segphi[$n-1]*deg  $tilt[$n-1]*deg  0*deg";
				$detector{"color"}       = "558844";
				$detector{"type"}        = "Tube";
				$detector{"dimensions"}  = "0*cm $rad[$n-1]*cm 0.5*cm 0*deg 360*deg";
				$detector{"material"}    = "G4_Galactic";
				$detector{"style"}       = 1;
				print_det(\%configuration, \%detector);

				
				
				# rotation angles in degrees
				my $phi = 90;
				my $psi = 0;

				#degree to radian
				my $d2r = pi/180;
	
				
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
				
			
				$detector{"name"}        = "cyl_mirrors_s$s"."right_$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "cyl mirrors right $n";
				$detector{"pos"}         = "$mirror_pos_xR[$n-1]*cm  $mirror_pos_yR[$n-1]*cm  $mirror_pos_zR[$n-1]*cm";
				$detector{"rotation"}    = "$segphi_wc[$n-1]*deg $tilt[$n-1]*deg $cyl_tilt_r[$n-1]*deg";
				$detector{"color"}       = "aaffff";
				$detector{"type"}        = "Tube";
				$detector{"dimensions"}  = "$WCr2outer[$n-1]*cm $WCr2inner[$n-1]*cm 3*cm 0*deg $cyl_ang[$n-1]*deg";
				$detector{"material"}    = "G4_AIR";
				$detector{"style"}       = 1;
				$detector{"sensitivity"} = "ltcc";
				$detector{"hit_type"}    = "ltcc";
				$detector{"identifiers"} = "sector manual $s side manual 1 segment manual $n";
				print_det(\%configuration, \%detector);

				%detector = init_det();
				$detector{"name"}        = "cyl_mirrors_s$s"."left_$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "cyl mirrors left $n";
				$detector{"pos"}         = "$mirror_pos_xL[$n-1]*cm $mirror_pos_yL[$n-1]*cm $mirror_pos_zL[$n-1]*cm";
				$detector{"rotation"}    = "$segphi_wc[$n-1]*deg -$tilt[$n-1]*deg $cyl_tilt_l[$n-1]*deg";
				$detector{"color"}       = "aaffff";
				$detector{"type"}        = "Tube";
				$detector{"dimensions"}  = "$WCr2outer[$n-1]*cm $WCr2inner[$n-1]*cm 3*cm 0*deg $cyl_ang[$n-1]*deg";
				$detector{"material"}    = "G4_AIR";
				$detector{"style"}       = 1;
				$detector{"sensitivity"} = "ltcc";
				$detector{"hit_type"}    = "ltcc";
				$detector{"identifiers"} = "sector manual $s side manual 2 segment manual $n";
				print_det(\%configuration, \%detector);


	

                		
		

		}



	}	


 }



1;











