
our %configuration;
our %parameters;

our $startS;
our $endS;
our $startN;
our $endN;

# number of mirrors
my $nmirrors = $parameters{"nmirrors"};


my @wc_sec_x_r = ();
my @wc_sec_y_r = ();
my @wc_sec_z_r = ();
my @wc_sec_x_l = ();
my @wc_sec_y_l = ();
my @wc_sec_z_l = ();
my @tilt = (); # Tilt angle of the PMT in the segment ref. system
my @shield_tilt = (); #Tilt angle of the shield
my @segphi = (); # required rotation about x axis for pmts, pmts stoppers and shields
my @segtheta = ();

sub buildCones
{
	calculateconePars();
	build_cones();

}

sub calculateconePars
{
	for(my $n=0; $n<$nmirrors ; $n++)
	{
		my $s = $n + 1;


		$tilt[$n] = $parameters{"ltcc.wc.s$s"."_angle"};
		$wc_sec_x_r[$n] = $parameters{"ltcc.wc.s$s"."_xR"};
		$wc_sec_y_r[$n] = $parameters{"ltcc.wc.s$s"."_yR"};
		$wc_sec_z_r[$n] = $parameters{"ltcc.wc.s$s"."_zR"};
		$wc_sec_x_l[$n] = $parameters{"ltcc.wc.s$s"."_xL"};
		$wc_sec_y_l[$n] = $parameters{"ltcc.wc.s$s"."_yL"};
		$wc_sec_z_l[$n] = $parameters{"ltcc.wc.s$s"."_zL"};
		$shield_tilt[$n] =$parameters{"ltcc.shield.s$s"."_zangle"};
		$segtheta[$n] = 90 - $parameters{"ltcc.s$s"."_theta"};
		$segphi[$n] = 90 - $segtheta[$n]; #rotation of pmts in sector

	}

}



sub build_cones {

	for(my $n=$startN; $n<=$endN; $n++)
	{
		for(my $s=$startS; $s<=$endS; $s++)
		{

			if($s != 4 && $s != 1) {


				if($n < 11){
						
					if($s == 3){

					    if($n != 1){
						my %detector = init_det();
						$detector{"name"}        = "cone_s$s"."right_$n";
						$detector{"mother"}      = "ltccS$s";
						$detector{"description"} = "cone right $n";
						$detector{"pos"}         = "$wc_sec_x_r[$n-1]*cm $wc_sec_y_r[$n-1]*cm $wc_sec_z_r[$n-1]*cm";
						$detector{"rotation"}    = "$segphi[$n-1]*deg -$tilt[$n-1]*deg $shield_tilt[$n-1]*deg";
						$detector{"color"}       = "aa9999";
						$detector{"type"}        = "CopyOf WC_S";
						$detector{"material"}    = "G4_Cu";
						$detector{"style"}       = "1";
						$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
						$detector{"hit_type"}    = "mirror";
						print_det(\%configuration, \%detector);
						       }
					my %detector = init_det();
					$detector{"name"}        = "cone_s$s"."left_$n";
					$detector{"mother"}      = "ltccS$s";
					$detector{"description"} = "cone left $n";
					$detector{"pos"}         = "$wc_sec_x_l[$n-1]*cm $wc_sec_y_l[$n-1]*cm $wc_sec_z_l[$n-1]*cm";
					$detector{"rotation"}    = "$segphi[$n-1]*deg $tilt[$n-1]*deg -$shield_tilt[$n-1]*deg";
					$detector{"color"}       = "aa9999";
					$detector{"type"}        = "CopyOf WC_S";
					$detector{"material"}    = "G4_Cu";
					$detector{"style"}       = "1";
					$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
					$detector{"hit_type"}    = "mirror";
					print_det(\%configuration, \%detector);
						    }
							
					    else{
						my %detector = init_det();
						$detector{"name"}        = "cone_s$s"."right_$n";
						$detector{"mother"}      = "ltccS$s";
						$detector{"description"} = "cone right $n";
						$detector{"pos"}         = "$wc_sec_x_r[$n-1]*cm $wc_sec_y_r[$n-1]*cm $wc_sec_z_r[$n-1]*cm";
						$detector{"rotation"}    = "$segphi[$n-1]*deg -$tilt[$n-1]*deg $shield_tilt[$n-1]*deg";
						$detector{"color"}       = "aa9999";
						$detector{"type"}        = "CopyOf WC_S";
						$detector{"material"}    = "G4_Cu";
						$detector{"style"}       = "1";
						$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
						$detector{"hit_type"}    = "mirror";
						print_det(\%configuration, \%detector);
					%detector = init_det();
					$detector{"name"}        = "cone_s$s"."left_$n";
					$detector{"mother"}      = "ltccS$s";
					$detector{"description"} = "cone left $n";
					$detector{"pos"}         = "$wc_sec_x_l[$n-1]*cm $wc_sec_y_l[$n-1]*cm $wc_sec_z_l[$n-1]*cm";
					$detector{"rotation"}    = "$segphi[$n-1]*deg $tilt[$n-1]*deg -$shield_tilt[$n-1]*deg";
					$detector{"color"}       = "aa9999";
					$detector{"type"}        = "CopyOf WC_S";
					$detector{"material"}    = "G4_Cu";
					$detector{"style"}       = "1";
					$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
					$detector{"hit_type"}    = "mirror";
					print_det(\%configuration, \%detector);
					     }
						}

						

				elsif($n > 10 && $n < 13){

					if($s == 3){

					   if($n != 11){

						my %detector = init_det();
						$detector{"name"}        = "cone_s$s"."right_$n";
						$detector{"mother"}      = "ltccS$s";
						$detector{"description"} = "cone right $n";
						$detector{"pos"}         = "$wc_sec_x_r[$n-1]*cm $wc_sec_y_r[$n-1]*cm $wc_sec_z_r[$n-1]*cm";
						$detector{"rotation"}    = "$segphi[$n-1]*deg -$tilt[$n-1]*deg $shield_tilt[$n-1]*deg";
						$detector{"color"}       = "aa9999";
						$detector{"type"}        = "CopyOf WC_M";
						$detector{"material"}    = "G4_Cu";
						$detector{"style"}       = "1";
						$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
						$detector{"hit_type"}    = "mirror";
						print_det(\%configuration, \%detector);
						        }
					
					my %detector = init_det();
					$detector{"name"}        = "cone_s$s"."left_$n";
					$detector{"mother"}      = "ltccS$s";
					$detector{"description"} = "cone left $n";
					$detector{"pos"}         = "$wc_sec_x_l[$n-1]*cm $wc_sec_y_l[$n-1]*cm $wc_sec_z_l[$n-1]*cm";
					$detector{"rotation"}    = "$segphi[$n-1]*deg $tilt[$n-1]*deg -$shield_tilt[$n-1]*deg";
					$detector{"color"}       = "aa9999";
					$detector{"type"}        = "CopyOf WC_M";
					$detector{"material"}    = "G4_Cu";
					$detector{"style"}       = "1";
					$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
					$detector{"hit_type"}    = "mirror";
					print_det(\%configuration, \%detector);
						}

					   else{
						my %detector = init_det();
						$detector{"name"}        = "cone_s$s"."right_$n";
						$detector{"mother"}      = "ltccS$s";
						$detector{"description"} = "cone right $n";
						$detector{"pos"}         = "$wc_sec_x_r[$n-1]*cm $wc_sec_y_r[$n-1]*cm $wc_sec_z_r[$n-1]*cm";
						$detector{"rotation"}    = "$segphi[$n-1]*deg -$tilt[$n-1]*deg $shield_tilt[$n-1]*deg";
						$detector{"color"}       = "aa9999";
						$detector{"type"}        = "CopyOf WC_M";
						$detector{"material"}    = "G4_Cu";
						$detector{"style"}       = "1";
						$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
						$detector{"hit_type"}    = "mirror";
						print_det(\%configuration, \%detector);
						
					
					%detector = init_det();
					$detector{"name"}        = "cone_s$s"."left_$n";
					$detector{"mother"}      = "ltccS$s";
					$detector{"description"} = "cone left $n";
					$detector{"pos"}         = "$wc_sec_x_l[$n-1]*cm $wc_sec_y_l[$n-1]*cm $wc_sec_z_l[$n-1]*cm";
					$detector{"rotation"}    = "$segphi[$n-1]*deg $tilt[$n-1]*deg -$shield_tilt[$n-1]*deg";
					$detector{"color"}       = "aa9999";
					$detector{"type"}        = "CopyOf WC_M";
					$detector{"material"}    = "G4_Cu";
					$detector{"style"}       = "1";
					$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
					$detector{"hit_type"}    = "mirror";
					print_det(\%configuration, \%detector);
					       }

						}

						
				       elsif($n > 12 && $n < $endN) {

					
					  if($s == 3){

					      if($n != 13){

						my %detector = init_det();
						$detector{"name"}        = "cone_s$s"."right_$n";
						$detector{"mother"}      = "ltccS$s";
						$detector{"description"} = "cone right $n";
						$detector{"pos"}         = "$wc_sec_x_r[$n-1]*cm $wc_sec_y_r[$n-1]*cm $wc_sec_z_r[$n-1]*cm";
						$detector{"rotation"}    = "$segphi[$n-1]*deg -$tilt[$n-1]*deg $shield_tilt[$n-1]*deg";
						$detector{"color"}       = "aa9999";
						$detector{"type"}        = "CopyOf WC_L";
						$detector{"material"}    = "G4_Cu";
						$detector{"style"}       = "1";
						$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
						$detector{"hit_type"}    = "mirror";
						print_det(\%configuration, \%detector);
							}
						   
					my %detector = init_det();
					$detector{"name"}        = "cone_s$s"."left_$n";
					$detector{"mother"}      = "ltccS$s";
					$detector{"description"} = "cone left $n";
					$detector{"pos"}         = "$wc_sec_x_l[$n-1]*cm $wc_sec_y_l[$n-1]*cm $wc_sec_z_l[$n-1]*cm";
					$detector{"rotation"}    = "$segphi[$n-1]*deg $tilt[$n-1]*deg -$shield_tilt[$n-1]*deg";
					$detector{"color"}       = "aa9999";
					$detector{"type"}        = "CopyOf WC_L";
					$detector{"material"}    = "G4_Cu";
					$detector{"style"}       = "1";
					$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
					$detector{"hit_type"}    = "mirror";
					print_det(\%configuration, \%detector);

						}

					else{
						my %detector = init_det();
						$detector{"name"}        = "cone_s$s"."right_$n";
						$detector{"mother"}      = "ltccS$s";
						$detector{"description"} = "cone right $n";
						$detector{"pos"}         = "$wc_sec_x_r[$n-1]*cm $wc_sec_y_r[$n-1]*cm $wc_sec_z_r[$n-1]*cm";
						$detector{"rotation"}    = "$segphi[$n-1]*deg -$tilt[$n-1]*deg $shield_tilt[$n-1]*deg";
						$detector{"color"}       = "aa9999";
						$detector{"type"}        = "CopyOf WC_L";
						$detector{"material"}    = "G4_Cu";
						$detector{"style"}       = "1";
						$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
						$detector{"hit_type"}    = "mirror";
						print_det(\%configuration, \%detector);
						
						   
					%detector = init_det();
					$detector{"name"}        = "cone_s$s"."left_$n";
					$detector{"mother"}      = "ltccS$s";
					$detector{"description"} = "cone left $n";
					$detector{"pos"}         = "$wc_sec_x_l[$n-1]*cm $wc_sec_y_l[$n-1]*cm $wc_sec_z_l[$n-1]*cm";
					$detector{"rotation"}    = "$segphi[$n-1]*deg $tilt[$n-1]*deg -$shield_tilt[$n-1]*deg";
					$detector{"color"}       = "aa9999";
					$detector{"type"}        = "CopyOf WC_L";
					$detector{"material"}    = "G4_Cu";
					$detector{"style"}       = "1";
					$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
					$detector{"hit_type"}    = "mirror";
					print_det(\%configuration, \%detector);

						}

							}

				}

		}

		

	}

}
1;
