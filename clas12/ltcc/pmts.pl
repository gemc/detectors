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
        my @box_x0 = ();
	my @box_y0 = ();
	my @box_z0 = ();
	my @box_rot = ();
	my @sub_box_x0 = ();
	my @sub_box_y0 = ();
	my @sub_box_z0 = ();
	my @box_tilt = ();
	


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
			$box_x0[$n] = $parameters{"ltcc.shield.s$s"."_dx"};
			$box_y0[$n] = $parameters{"ltcc.shield.s$s"."_dy"};
			$box_z0[$n] = $parameters{"ltcc.shield.s$s"."_dz"};
			$box_tilt[$n] = $parameters{"ltcc.shield.s$s"."_zangle"};
			$sub_box_x0[$n] = $box_x0[$n] - 0.2;
			$sub_box_y0[$n] = $box_y0[$n] - 0.2 ;
			$sub_box_z0[$n] = $box_z0[$n] + 0.2;
			
			
			

			$WCr1inner[$n] = $parameters{"ltcc.wc.s$s"."_r1inner"}; 
			$WCr2inner[$n] = $parameters{"ltcc.wc.s$s"."_r2inner"};
			$WCzouter[$n] = $parameters{"ltcc.wc.s$s"."_zouter"};  
			$WCr1outer[$n] = $WCr1inner[$n] + 1;
			$WCr2outer[$n] = $WCr2inner[$n] + 1;
			$WCzinner[$n] = $WCzouter[$n] + 0.01;
			
			# 90 - theta of center of ltcc. segment
			$segtheta[$n] = 90 - $parameters{"ltcc.s$s"."_theta"};
			
			$len[$n] = 1;  # Harcoding length here
		}
	}


	sub build_pmts
	{
		for(my $n=$startN; $n<$endN; $n++)
		{
			for(my $s=$startS; $s<=$endS; $s++)
			{       

				my %detector = init_det();

				$detector{"name"}        = "pmt_s$s"."right_$n";
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
				#$detector{"mother"}      = "root";
				$detector{"description"} = "PMT right $n";
				$detector{"pos"}         = "$x0[$n-1]*cm $y0[$n-1]*cm 0*mm";
				$detector{"rotation"}    = "90*deg -$tilt[$n-1]*deg 0*deg";
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
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
				#$detector{"mother"}      = "root";
				$detector{"description"} = "PMT left $n";
				$detector{"pos"}         = "-$x0[$n-1]*cm $y0[$n-1]*cm 0*mm";
				$detector{"rotation"}    = "90*deg  $tilt[$n-1]*deg  0*deg";
				$detector{"color"}       = "8000000";
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
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
				#$detector{"mother"}      = "root";
				$detector{"description"} = "PMT light stopper right $n";
				$detector{"pos"}         = "$x0[$n-1]*cm $y0[$n-1]*cm 0*mm";
				$detector{"rotation"}    = "90*deg -$tilt[$n-1]*deg 0*deg";
				$detector{"color"}       = "558844";
				$detector{"type"}        = "Tube";
				$detector{"dimensions"}  = "0*cm $rad[$n-1]*cm 0.5*cm 0*deg 360*deg";
				$detector{"material"}    = "G4_Galactic";
				$detector{"style"}       = 1;
				print_det(\%configuration, \%detector);

				%detector = init_det();
				$detector{"name"}        = "pmt_light_stopper_s$s"."left_$n";
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
				#$detector{"mother"}      = "root";
				$detector{"description"} = "PMT light stopper left $n";
				$detector{"pos"}         = "-$x0[$n-1]*cm $y0[$n-1]*cm 0*mm";
				$detector{"rotation"}    = "90*deg  $tilt[$n-1]*deg  0*deg";
				$detector{"color"}       = "558844";
				$detector{"type"}        = "Tube";
				$detector{"dimensions"}  = "0*cm $rad[$n-1]*cm 0.5*cm 0*deg 360*deg";
				$detector{"material"}    = "G4_Galactic";
				$detector{"style"}       = 1;
				print_det(\%configuration, \%detector);

				%detector = init_det();
				$detector{"name"}        = "box_s$s"."right_$n";
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
				#$detector{"mother"}      = "root";
				$detector{"description"} = "Box right $n";
				$detector{"pos"}         = "0*cm 0*cm 0*cm";
				$detector{"rotation"}    = "0*deg 0*deg 0*deg";;
				$detector{"color"}       = "000000";
				$detector{"type"}        = "Box";
				$detector{"dimensions"}  = "$box_x0[$n-1]*cm $box_y0[$n-1]*cm $box_z0[$n-1]*cm";
				$detector{"material"}    = "Component";
				print_det(\%configuration, \%detector);

				%detector = init_det();
				$detector{"name"}        = "box_s$s"."left_$n";
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
				#$detector{"mother"}      = "root";
				$detector{"description"} = "Box left $n";
				$detector{"pos"}         = "0*cm 0*cm 0*cm";
				$detector{"rotation"}    = "0*deg 0*deg 0*deg";
				$detector{"color"}       = "000000";
				$detector{"type"}        = "Box";
				$detector{"dimensions"}  = "$box_x0[$n-1]*cm $box_y0[$n-1]*cm $box_z0[$n-1]*cm";
				$detector{"material"}    = "Component";
				print_det(\%configuration, \%detector);
		
				%detector = init_det();
				$detector{"name"}        = "subtraction_box_s$s"."right_$n";
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
				#$detector{"mother"}      = "root";
				$detector{"description"} = "Subtraction Box right $n";
				$detector{"pos"}         = "0*cm 0*cm 0*cm";;
				$detector{"rotation"}    = "0*deg 0*deg 0*deg";;
				$detector{"color"}       = "000000";
				$detector{"type"}        = "Box";
				$detector{"dimensions"}  = "$sub_box_x0[$n-1]*cm $sub_box_y0[$n-1]*cm $sub_box_z0[$n-1]*cm";
				$detector{"material"} = "Component";
				print_det(\%configuration, \%detector);

				%detector = init_det();
				$detector{"name"}        = "subtraction_box_s$s"."left_$n";
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
				#$detector{"mother"}      = "root";
				$detector{"description"} = "Subtraction Box left $n";
				$detector{"pos"}         = "0*cm 0*cm 0*cm";
				$detector{"rotation"}    = "0*deg 0*deg 0*deg";
				$detector{"color"}       = "000000";
				$detector{"type"}        = "Box";
				$detector{"dimensions"}  = "$sub_box_x0[$n-1]*cm $sub_box_y0[$n-1]*cm $sub_box_z0[$n-1]*cm";
				$detector{"material"}    = "Component";
				print_det(\%configuration, \%detector);
			
				%detector = init_det();
				$detector{"name"}        = "final_box_s$s"."right$n";
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
				$detector{"description"} = "combined box right $n";
				$detector{"pos"}         = "$x0[$n-1]*cm $y0[$n-1]*cm 0*cm";
				$detector{"rotation"}    = "90*deg -$tilt[$n-1]*deg $box_tilt[$n-1]*deg";
				$detector{"color"}       = "202020";
				$detector{"type"}        = "Operation:  box_s$s"."right_$n - subtraction_box_s$s"."right_$n";
				$detector{"material"}    = "G4_Fe";
				$detector{"style"}       = 1;
   				print_det(\%configuration, \%detector);

				%detector = init_det();
				$detector{"name"}        = "final_box_s$s"."left_$n";
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
				$detector{"description"} = "combined box left $n";
				$detector{"pos"}         = "-$x0[$n-1]*cm $y0[$n-1]*cm 0*cm";
				$detector{"rotation"}    = "90*deg $tilt[$n-1]*deg -$box_tilt[$n-1]*deg";
				$detector{"color"}       = "202020";
				$detector{"type"}        = "Operation:  box_s$s"."left_$n - subtraction_box_s$s"."left_$n";
				$detector{"material"}    = "G4_Fe";
				$detector{"style"}       = 1;
				print_det(\%configuration, \%detector);

				my $swcouterdim = $WCzouter[$n-1] . "*cm " . $WCr1outer[$n-1] . "*cm " . $WCr2outer[$n-1] . "*cm";
				my $swcinnerdim = $WCzinner[$n-1] . "*cm " . $WCr1inner[$n-1] . "*cm " . $WCr2inner[$n-1] . "*cm";
				my $l = $WCzouter[$n-1] + $len[$n-1]  ; # the distance between pmt and WC center of masses
				my $d2r = pi/180;
				my $theta = $tilt[$n-1]; # rotation angles in degrees
				my $phi = 90;
				my $psi = 0;
				my $pos_xp_l = -$l*sin($theta * $d2r); # x coordinate of the distance between CMs after rotation (for left pmts)
				my $pos_yp_l = $l*sin($phi * $d2r)*cos($theta * $d2r); # y coordinate of the distance between CMs after rotation (for left pmts)
				my $pos_zp_l = $l*cos($phi * $d2r)*cos($theta * $d2r); # z coordinate of the distance between CMs after rotation (for left pmts)
				my $pos_xp_r = $l*sin($theta * $d2r); # for right pmts
				my $pos_yp_r = $l*sin($phi * $d2r)*cos($theta * $d2r);
				my $pos_zp_r = $l*cos($theta * $d2r)*cos($phi * $d2r);
				my $geo_pos_x_r = $x0[$n-1] - $pos_xp_r; # positions for WCs which will be in front of right pmts
				my $geo_pos_y_r = $y0[$n-1] - $pos_yp_r;
				my $geo_pos_z_r = - $pos_zp_r;
				my $geo_pos_x_l = -$x0[$n-1] - $pos_xp_l; #positions for WCs which will be in front of left pmts	
				my $geo_pos_y_l = $y0[$n-1] - $pos_yp_l;
				my $geo_pos_z_l =  - $pos_zp_l;

				%detector = init_det();
				$detector{"name"}        = "cone_s$s"."right_inner$n";
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
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
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
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
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
				$detector{"description"} = "combined cone right $n";
				$detector{"pos"}         = "$geo_pos_x_r*cm $geo_pos_y_r*cm $geo_pos_z_r*cm";
				$detector{"rotation"}    = "-$phi*deg $theta*deg -$psi*deg";
				$detector{"color"}       = "b87333";
				$detector{"type"}        = "Operation:  cone_s$s"."right_outer$n - cone_s$s"."right_inner$n ";
				$detector{"material"}    = "Air_Opt";
				$detector{"style"}       = "1";
				$detector{"sensitivity"}    = "mirror: ltcc_AlMgF2";
				$detector{"hit_type"}       = "mirror";
				$detector{"identifiers"} = "sector manual $s side manual 1 segment manual $n";
				print_det(\%configuration, \%detector);
			
	
				%detector = init_det();
				$detector{"name"}        = "cone_s$s"."left_inner$n";
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
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
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
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
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
				$detector{"description"} = "combined cone left $n";
				$detector{"pos"}         = "$geo_pos_x_l*cm $geo_pos_y_l*cm $geo_pos_z_l*cm";
				$detector{"rotation"}    = "-$phi*deg -$theta*deg -$psi*deg";
				$detector{"color"}       = "b87333";
				$detector{"type"}        = "Operation:  cone_s$s"."left_outer$n - cone_s$s"."left_inner$n";
				$detector{"material"}    = "Air_Opt";
				$detector{"style"}       = "1";
   				$detector{"sensitivity"}    = "mirror: ltcc_AlMgF2";
				$detector{"hit_type"}       = "mirror";
				$detector{"identifiers"} = "sector manual $s side manual 2 segment manual $n";
				print_det(\%configuration, \%detector);

				my $l_wm = $WCzouter[$n-1] + 3 ;
				my $mir_pos_x_r = $geo_pos_x_r - $l_wm * sin($theta * $d2r);
				my $mir_pos_y_r = $geo_pos_y_r - $l_wm * sin($phi * $d2r) * cos($theta * $d2r);
				my $mir_pos_z_r = $geo_pos_z_r - $l_wm * cos($theta * $d2r) * cos($phi * $d2r);
				
				my $mir_pos_x_l = $geo_pos_x_l + $l_wm * sin($theta * $d2r);
				my $mir_pos_y_l = $geo_pos_y_l - $l_wm * sin($phi * $d2r) * cos($theta * $d2r);
				my $mir_pos_z_l = $geo_pos_z_l - $l_wm * cos($theta * $d2r) * cos($phi * $d2r);
				
				$detector{"name"}        = "cyl_mirrors_s$s"."right_$n";
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
				#$detector{"mother"}      = "root";
				$detector{"description"} = "cyl mirrors right $n";
				$detector{"pos"}         = "$mir_pos_x_r*cm $mir_pos_y_r*cm $mir_pos_z_r*cm";
				$detector{"rotation"}    = "-$phi*deg $theta*deg 90*deg";
				$detector{"color"}       = "aaffff";
				$detector{"type"}        = "Tube";
				$detector{"dimensions"}  = "7*cm 8*cm 3*cm 0*deg 180*deg";
				$detector{"material"}    = "G4_AIR";
				$detector{"style"}       = 1;
				$detector{"sensitivity"} = "ltcc";
				$detector{"hit_type"}    = "ltcc";
				$detector{"identifiers"} = "sector manual $s side manual 1 segment manual $n";
				print_det(\%configuration, \%detector);

				%detector = init_det();
				$detector{"name"}        = "cyl_mirrors_s$s"."left_$n";
				$detector{"mother"}      = "segment_pmt_s$s"."$n";
				#$detector{"mother"}      = "root";
				$detector{"description"} = "cyl mirrors left $n";
				$detector{"pos"}         = "$mir_pos_x_l*cm $mir_pos_y_l*cm $mir_pos_z_l*cm";
				$detector{"rotation"}    = "-$phi*deg -$theta*deg 90*deg";
				$detector{"color"}       = "aaffff";
				$detector{"type"}        = "Tube";
				$detector{"dimensions"}  = "7*cm 8*cm 3*cm 0*deg 180*deg";
				$detector{"material"}    = "G4_AIR";
				$detector{"style"}       = 1;
				$detector{"sensitivity"} = "ltcc";
				$detector{"hit_type"}    = "ltcc";
				$detector{"identifiers"} = "sector manual $s side manual 2 segment manual $n";
				print_det(\%configuration, \%detector);



	}

                		# Building the box that contains the pmts (left and right)
				# Starts 1mm above x11
				my $segment_box_length    = $x0[$n-1]  + $rad[$n-1] + 2;
				my $segment_box_thickness = 2*$rad[$n-1] + 2;
				my $segment_box_height    = $y0[$n-1]  + $rad[$n-1] + 2;
				%detector = init_det();
				$detector{"name"}        = "segment_pmt_box_$n";
				$detector{"mother"}      = "root";
				$detector{"description"} = "Light Threshold Cerenkov Counter Segment Box $n";
				$detector{"type"}        = "Box";
				$detector{"dimensions"}  = "$segment_box_length*cm $segment_box_height*cm $segment_box_thickness*cm";
				$detector{"material"}    = "Component";
				print_det(\%configuration, \%detector);
                		#  # Box to subract from  segment box
				#  # Starts 1mm below
				my $s_segment_box_length    = $segment_box_length    + 0.2;
				my $s_segment_box_thickness = $segment_box_thickness + 0.2;
				my $s_segment_box_height    = $segment_box_height   ;
				my $yshift = $segment_box_thickness;      # Should be enough to encompass all mirrrors
		
			        %detector = init_det();
				$detector{"name"}        = "segment_pmt_subtract_box_$n";
				$detector{"mother"}      = "root";
				$detector{"description"} = "Light Threshold Cerenkov Counter Segment Box to Subtract $n";
				$detector{"pos"}         = "0*cm -$yshift*cm 0*mm";
				$detector{"type"}        = "Box";
				$detector{"dimensions"}  = "$s_segment_box_length*cm $s_segment_box_height*cm $s_segment_box_thickness*cm";
				$detector{"material"}    = "Component";
				print_det(\%configuration, \%detector);

                
				for(my $s=$startS; $s<=$endS; $s++)
				{
					my %detector = init_det();
					$detector{"name"}        = "segment_pmt_s$s"."$n";
					$detector{"mother"}      = "ltccS$s";
					$detector{"description"} = "Light Threshold Cerenkov Counter PMT segment $n";
					#$detector{"mother"}      = "root";
					#$detector{"rotation"}    = "0*deg 0*deg 0*deg";
					$detector{"rotation"}    = "-$segtheta[$n-1]*deg 0*deg 0*deg";
					$detector{"color"}       = "00ff11";
					$detector{"type"}        = "Operation: segment_pmt_box_$n - segment_pmt_subtract_box_$n";
					$detector{"dimensions"}  = "0";
					$detector{"material"}    = "C4F10";
					$detector{"visible"}     = 0;
					print_det(\%configuration, \%detector);
				}
                
                
		
		

		}



	}	






1;











