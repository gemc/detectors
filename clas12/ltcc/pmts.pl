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
	my @shield_rot = ();
	my @sub_shield_x0 = ();
	my @sub_shield_y0 = ();
	my @sub_shield_z0 = ();
	my @shield_tilt = ();
	my @segphi = ();
	my @segphi2 = ();
	my @y0_seg = ();
	my @z0_seg = ();
	my @y0_nseg = ();
	my @z0_nseg = ();
	my @dz_d = ();

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
			$tilt[$n] = $parameters{"ltcc.wc.s$s"."_angle"}; 
			$shield_x0[$n] = $parameters{"ltcc.shield.s$s"."_dx"};
			$shield_y0[$n] = $parameters{"ltcc.shield.s$s"."_dy"};
			$shield_z0[$n] = $parameters{"ltcc.shield.s$s"."_dz"};
			$shield_tilt[$n] = $parameters{"ltcc.shield.s$s"."_zangle"};
			$WCr1inner[$n] = $parameters{"ltcc.wc.s$s"."_r1inner"}; 
			$WCr2inner[$n] = $parameters{"ltcc.wc.s$s"."_r2inner"};
			$WCzouter[$n] = $parameters{"ltcc.wc.s$s"."_zouter"}; 
			# half lengths of WCs were decreased to prevent overlaps with the ltcc sectors
			$dz_d[$n] = $parameters{"ltcc.shield.s$s"."_shift"};; 

			#To obtain Winston Cone geometry a paraboloid is subtracted from the other one whose top/bottom radii are 1 cm bigger 				and half length z is 0.1 cm smaller

			$WCr1outer[$n] = $WCr1inner[$n] - 1;
			$WCr2outer[$n] = $WCr2inner[$n] - 1;
			$WCzinner[$n] = $WCzouter[$n] - 0.1;

			#To obtain Winston Cone geometry a paraboloid is subtracted from the other one whose x and y dimensions are 0.1 cm 				bigger and z dimension is 0.1 cm smaller

			$sub_shield_x0[$n] = $shield_x0[$n] - 0.1;
			$sub_shield_y0[$n] = $shield_y0[$n] - 0.1 ;
			$sub_shield_z0[$n] = $shield_z0[$n] + 0.1;
			
			# 90 - theta of center of ltcc. segment
			$segtheta[$n] = 90 - $parameters{"ltcc.s$s"."_theta"};

			#phi rotation angle for pmts, pmt stoppers and shield in sectors ! (calculated using their phi rotation angles in segments)
			$segphi[$n] = 90 - $segtheta[$n];

			#phi rotation angle for Winston Cones and cylindrical mirrors in sectors ! (calculated using phi rotation angle in segments)
			$segphi2[$n] = -90 - $segtheta[$n];
			$len[$n] = 1;  # Harcoding length here

			#degree to radian
			$d2r = pi/180;

			
			# pmt positions in ltcc sectors. Calculated by using rotation(by segtheta angle) and translation(no 		translation in x direction) from their positions in segments
			$y0_seg[$n] = $y0[$n]*cos($segtheta[$n]*$d2r);
			$z0_seg[$n] = $y0[$n]*sin($segtheta[$n]*$d2r);
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
				$detector{"pos"}         = "$x0[$n-1]*cm $y0_seg[$n-1]*cm $z0_seg[$n-1]*cm";
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
				$detector{"pos"}         = "-$x0[$n-1]*cm $y0_seg[$n-1]*cm $z0_seg[$n-1]*cm";
				$detector{"rotation"}    = "$segphi[$n-1]*deg  $tilt[$n-1]*deg 0*deg";
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
				$detector{"pos"}         = "$x0[$n-1]*cm $y0_seg[$n-1]*cm $z0_seg[$n-1]*cm";
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
				$detector{"pos"}         = "-$x0[$n-1]*cm $y0_seg[$n-1]*cm $z0_seg[$n-1]*cm";
				$detector{"rotation"}    = "$segphi[$n-1]*deg  $tilt[$n-1]*deg  0*deg";
				$detector{"color"}       = "558844";
				$detector{"type"}        = "Tube";
				$detector{"dimensions"}  = "0*cm $rad[$n-1]*cm 0.5*cm 0*deg 360*deg";
				$detector{"material"}    = "G4_Galactic";
				$detector{"style"}       = 1;
				print_det(\%configuration, \%detector);

				
				my $swcouterdim = $WCzouter[$n-1] . "*cm " . $WCr1outer[$n-1] . "*cm " . $WCr2outer[$n-1] . "*cm";
				my $swcinnerdim = $WCzinner[$n-1] . "*cm " . $WCr1inner[$n-1] . "*cm " . $WCr2inner[$n-1] . "*cm";

				# the distance between pmt and WC center of masses
				my $l = $WCzouter[$n-1] + $len[$n-1]  ; 

				# rotation angles in degrees
				my $phi = 90;
				my $psi = 0;

				#degree to radian
				my $d2r = pi/180;
	
				

				#Calculation of the position of Winston Cones in ltcc sectors

				my $pos_xp_r = $l*sin($tilt[$n-1] * $d2r); # x coordinate of the distance between CMs after rotation (for right pmts)
				my $pos_yp_r = $l*sin($phi * $d2r)*cos($tilt[$n-1] * $d2r);# y coordinate of the distance between CMs after rotation (for right pmts)
				my $pos_zp_r = $l*cos($tilt[$n-1] * $d2r)*cos($phi * $d2r);# z coordinate of the distance between CMs after rotation (for right pmts)

				my $pos_xp_l = -$l*sin($tilt[$n-1] * $d2r); # x coordinate of the distance between CMs after rotation (for left pmts)
				my $pos_yp_l = $l*sin($phi * $d2r)*cos($tilt[$n-1] * $d2r); # y coordinate of the distance between CMs after rotation (for left pmts)
				my $pos_zp_l = $l*cos($phi * $d2r)*cos($tilt[$n-1] * $d2r); # z coordinate of the distance between CMs after rotation (for left pmts)
				
				# positions for WCs which will be in front of right pmts

				my $geo_pos_x_r = $x0[$n-1] - $pos_xp_r; 
				my $geo_pos_y_r = ($y0[$n-1] - $pos_yp_r)*cos($segtheta[$n-1]* $d2r)+($pos_zp_r)*sin($segtheta[$n-1]*$d2r);
				my $geo_pos_z_r = ($y0[$n-1] - $pos_yp_r)*sin($segtheta[$n-1]*$d2r)-($pos_zp_r)*cos($segtheta[$n-1]*$d2r);

				my $geo_pos_x_l = -$x0[$n-1] - $pos_xp_l; #positions for WCs which will be in front of left pmts	
				my $geo_pos_y_l = ($y0[$n-1] - $pos_yp_l)*cos($segtheta[$n-1]*$d2r)+($pos_zp_l)*sin($segtheta[$n-1]*$d2r);
				my $geo_pos_z_l = ($y0[$n-1] - $pos_yp_l)*sin($segtheta[$n-1]*$d2r)-($pos_zp_l)*cos($segtheta[$n-1]*$d2r);


				
	
				#Calculation of the position of shields in ltcc sectors

				my $shield_xp_r = $dz_d[$n-1]*sin($tilt[$n-1] * $d2r); # x coordinate of the distance between CMs after rotation (for right pmts)
				my $shield_yp_r = $dz_d[$n-1]*sin($phi * $d2r)*cos($tilt[$n-1] * $d2r);# y coordinate of the distance between CMs after rotation (for right pmts)
				my $shield_zp_r = $dz_d[$n-1]*cos($tilt[$n-1] * $d2r)*cos($phi * $d2r);# z coordinate of the distance between CMs after rotation (for right pmts)

				my $shield_xp_l = -$dz_d[$n-1]*sin($tilt[$n-1] * $d2r); # x coordinate of the distance between CMs after rotation (for left pmts)
				my $shield_yp_l = $dz_d[$n-1]*sin($phi * $d2r)*cos($tilt[$n-1] * $d2r); # y coordinate of the distance between CMs after rotation (for left pmts)
				my $shield_zp_l = $dz_d[$n-1]*cos($phi * $d2r)*cos($tilt[$n-1] * $d2r); # z coordinate of the distance between CMs after rotation (for left pmts)
				
				# positions for WCs which will be in front of right pmts

				my $shield_pos_x_r = $x0[$n-1] - $shield_xp_r; 
				my $shield_pos_y_r = ($y0[$n-1] - $shield_yp_r)*cos($segtheta[$n-1]* $d2r)+($shield_zp_r)*sin($segtheta[$n-1]*$d2r);
				my $shield_pos_z_r = ($y0[$n-1] - $shield_yp_r)*sin($segtheta[$n-1]*$d2r)-($shield_zp_r)*cos($segtheta[$n-1]*$d2r);

				my $shield_pos_x_l = -$x0[$n-1] - $shield_xp_l; #positions for WCs which will be in front of left pmts	
				my $shield_pos_y_l = ($y0[$n-1] - $shield_yp_l)*cos($segtheta[$n-1]*$d2r)+($shield_zp_l)*sin($segtheta[$n-1]*$d2r);
				my $shield_pos_z_l = ($y0[$n-1] - $shield_yp_l)*sin($segtheta[$n-1]*$d2r)-($shield_zp_l)*cos($segtheta[$n-1]*$d2r);

				if($n < $endN) 
				{

				%detector = init_det();
				$detector{"name"}        = "cone_s$s"."right_inner$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "cone right inner $n";
				$detector{"pos"}         = "0*cm 0*cm 0*cm";
				$detector{"rotation"}    = "0*deg 0*deg 0*deg";
				$detector{"col"}         = "558844";
				$detector{"type"}        = "Paraboloid";
				$detector{"dimensions"}  = $swcinnerdim;
				$detector{"material"}    = "Component";
				print_det(\%configuration, \%detector);
	
	
				%detector = init_det();
				$detector{"name"}        = "cone_s$s"."right_outer$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "cone right outer $n";
				$detector{"pos"}         = "0*cm 0*cm 0*cm";
				$detector{"rotation"}    = "0*deg 0*deg 0*deg";
				$detector{"col"}         = "558844";
				$detector{"type"}        = "Paraboloid";
				$detector{"dimensions"}  = $swcouterdim;
				$detector{"material"}    = "Component";
				print_det(\%configuration, \%detector);
	
			
				%detector = init_det();
				$detector{"name"}        = "cone_s$s"."right_$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "combined cone right $n";
				$detector{"pos"}         = "$geo_pos_x_r*cm $geo_pos_y_r*cm $geo_pos_z_r*cm";
				$detector{"rotation"}    = "$segphi2[$n-1]*deg $tilt[$n-1]*deg 0*deg";
				$detector{"color"}       = "b87333";
				$detector{"type"}        = "Operation:  cone_s$s"."right_inner$n - cone_s$s"."right_outer$n ";
				$detector{"material"}    = "Air_Opt";
				$detector{"style"}       = "1";
				$detector{"sensitivity"}    = "mirror: ltcc_AlMgF2";
				$detector{"hit_type"}       = "mirror";
				$detector{"identifiers"} = "sector manual $s side manual 1 segment manual $n";
				print_det(\%configuration, \%detector);
			
	
				%detector = init_det();
				$detector{"name"}        = "cone_s$s"."left_inner$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "cone left inner $n";
				$detector{"pos"}         = "0*cm 0*cm 0*cm";
				$detector{"rotation"}    = "0*deg 0*deg 0*deg";
				$detector{"col"}         = "66bbff";
				$detector{"type"}        = "Paraboloid";
				$detector{"dimensions"}  = $swcinnerdim;
				$detector{"material"}    = "Component";
				print_det(\%configuration, \%detector);
	
			
	
				%detector = init_det();
				$detector{"name"}        = "cone_s$s"."left_outer$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "cone left outer $n";
				$detector{"pos"}         = "0*cm 0*cm 0*cm";
				$detector{"rotation"}    = "0*deg 0*deg 0*deg";
				$detector{"col"}         = "558844";
				$detector{"type"}        = "Paraboloid";
				$detector{"dimensions"}  = $swcouterdim;
				$detector{"material"}    = "Component";
				print_det(\%configuration, \%detector);
	
			
				%detector = init_det();
				$detector{"name"}        = "cone_s$s"."left_$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "combined cone left $n";
				$detector{"pos"}         = "$geo_pos_x_l*cm $geo_pos_y_l*cm $geo_pos_z_l*cm";
				$detector{"rotation"}    = "$segphi2[$n-1]*deg -$tilt[$n-1]*deg 0*deg";
				$detector{"color"}       = "b87333";
				$detector{"type"}        = "Operation:  cone_s$s"."left_inner$n - cone_s$s"."left_outer$n";
				$detector{"material"}    = "Air_Opt";
				$detector{"style"}       = "1";
   				$detector{"sensitivity"}    = "mirror: ltcc_AlMgF2";
				$detector{"hit_type"}       = "mirror";
				$detector{"identifiers"} = "sector manual $s side manual 2 segment manual $n";
				print_det(\%configuration, \%detector);


				
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
				$detector{"pos"}         = "$shield_pos_x_r*cm $shield_pos_y_r*cm $shield_pos_z_r*cm";;
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
				$detector{"pos"}         = "$shield_pos_x_l*cm $shield_pos_y_l*cm $shield_pos_z_l*cm";
				$detector{"rotation"}    = "$segphi[$n-1]*deg $tilt[$n-1]*deg -$shield_tilt[$n-1]*deg";
				$detector{"color"}       = "202020";
				$detector{"type"}        = "Operation:  shield_s$s"."left_$n - subtraction_shield_s$s"."left_$n";
				$detector{"material"}    = "G4_Fe";
				$detector{"style"}       = 1;
				print_det(\%configuration, \%detector);

				}

				# the distance between WC and cylindrical mirror center of masses
				my $l_wm = $WCzouter[$n-1] + 3 ;

				my $mir_pos_x_r = $geo_pos_x_r - $l_wm * sin($tilt[$n-1] * $d2r);
				my $mir_pos_y_r = (($y0[$n-1] - $pos_yp_r) - $l_wm * sin($phi * $d2r) * cos($tilt[$n-1] * $d2r))*cos($segtheta[$n-1]*pi/180)-(-$pos_zp_r - $l_wm * cos($tilt[$n-1] * $d2r) * cos($phi * $d2r))*sin($segtheta[$n-1]*pi/180);
				my $mir_pos_z_r = (($y0[$n-1] - $pos_yp_r) - $l_wm * sin($phi * $d2r) * cos($tilt[$n-1] * $d2r))*sin($segtheta[$n-1]*pi/180)+(-$pos_zp_r - $l_wm * cos($tilt[$n-1] * $d2r) * cos($phi * $d2r))*cos($segtheta[$n-1]*pi/180);
				
				my $mir_pos_x_l = $geo_pos_x_l + $l_wm * sin($tilt[$n-1] * $d2r);
				my $mir_pos_y_l = (($y0[$n-1] - $pos_yp_l) - $l_wm * sin($phi * $d2r) * cos($tilt[$n-1] * $d2r))*cos($segtheta[$n-1]*pi/180)-(-$pos_zp_l - $l_wm * cos($tilt[$n-1] * $d2r) * cos($phi * $d2r))*sin($segtheta[$n-1]*pi/180);
				my $mir_pos_z_l = (($y0[$n-1] - $pos_yp_l) - $l_wm * sin($phi * $d2r) * cos($tilt[$n-1] * $d2r))*sin($segtheta[$n-1]*pi/180)+(-$pos_zp_l - $l_wm * cos($tilt[$n-1] * $d2r) * cos($phi * $d2r))*cos($segtheta[$n-1]*pi/180);
				
				$detector{"name"}        = "cyl_mirrors_s$s"."right_$n";
				$detector{"mother"}      = "ltccS$s";
				$detector{"description"} = "cyl mirrors right $n";
				$detector{"pos"}         = "$mir_pos_x_r*cm $mir_pos_y_r*cm $mir_pos_z_r*cm";
				$detector{"rotation"}    = "$segphi2[$n-1]*deg $tilt[$n-1]*deg 90*deg";
				$detector{"color"}       = "aaffff";
				$detector{"type"}        = "Tube";
				$detector{"dimensions"}  = "$WCr2outer[$n-1]*cm $WCr2inner[$n-1]*cm 3*cm 0*deg 180*deg";
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
				$detector{"pos"}         = "$mir_pos_x_l*cm $mir_pos_y_l*cm $mir_pos_z_l*cm";
				$detector{"rotation"}    = "$segphi2[$n-1]*deg -$tilt[$n-1]*deg -90*deg";
				$detector{"color"}       = "aaffff";
				$detector{"type"}        = "Tube";
				$detector{"dimensions"}  = "$WCr2outer[$n-1]*cm $WCr2inner[$n-1]*cm 3*cm 0*deg 180*deg";
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











