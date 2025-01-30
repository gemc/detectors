
our %configuration;
our %parameters;

our $startS;
our $endS;
our $startN;
our $endN;

our @rga_spring2018_sectorsPresence;
our @rga_spring2018_materials;

our @rga_fall2018_sectorsPresence;
our @rga_fall2018_materials;

our @rgb_winter2020_sectorsPresence;
our @rgb_winter2020_materials;

our @rgb_spring2019_sectorsPresence;
our @rgb_spring2019_materials;

our @rgm_winter2021_sectorsPresence;
our @rgm_winter2021_materials;

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

			my $shouldPrintDetector = 0;
			my $gasMaterial = "C4F10";

			if($configuration{"variation"} eq "rga_spring2018") {
				if($rga_spring2018_sectorsPresence[$s - 1] == 1) {
					$shouldPrintDetector = 1;
					$gasMaterial = $rga_spring2018_materials[$s - 1];
				}
			} elsif($configuration{"variation"} eq "rga_fall2018") {
				if($rga_fall2018_sectorsPresence[$s - 1] == 1) {
					$shouldPrintDetector = 1;
					$gasMaterial = $rga_fall2018_materials[$s - 1];
				}
			} elsif($configuration{"variation"} eq "rgb_winter2020") {
				if($rgb_winter2020_sectorsPresence[$s - 1] == 1) {
					$shouldPrintDetector = 1;
					$gasMaterial = $rgb_winter2020_materials[$s - 1];
				}
			} elsif($configuration{"variation"} eq "rgb_spring2019" || $configuration{"variation"} eq "default") {
				if($rgb_spring2019_sectorsPresence[$s - 1] == 1) {
					$shouldPrintDetector = 1;
					$gasMaterial = $rgb_spring2019_materials[$s - 1];
				}
			} elsif($configuration{"variation"} eq "rgm_winter2021" ) {
				if($rgm_winter2021_sectorsPresence[$s - 1] == 1) {
					$shouldPrintDetector = 1;
					$gasMaterial = $rgm_materials[$s - 1];
				}
			}

			if($shouldPrintDetector == 1) {

				# SMALL CONES (Copper)
				# --------------------
				if($n < 11) {

					# STL Cone is in S3
					if($s == 3) {

						# Right one: Copy it if it's not the STL (#1)
						if($n != 1) {
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

					# Not S3, can copy all
					else {
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



				# Medium CONES (plastic)
				# ----------------------
				elsif($n > 10 && $n < 13) {

					# STL Cone is in S3
					if($s == 3){

						# Right one: Copy it if it's not the STL (#11)
						if($n != 11) {

							my %detector = init_det();
							$detector{"name"}        = "cone_s$s"."right_$n";
							$detector{"mother"}      = "ltccS$s";
							$detector{"description"} = "cone right $n";
							$detector{"pos"}         = "$wc_sec_x_r[$n-1]*cm $wc_sec_y_r[$n-1]*cm $wc_sec_z_r[$n-1]*cm";
							$detector{"rotation"}    = "$segphi[$n-1]*deg -$tilt[$n-1]*deg $shield_tilt[$n-1]*deg";
							$detector{"color"}       = "aa9999";
							$detector{"type"}        = "CopyOf WC_M";
							$detector{"material"}    = "G4_PLASTIC_SC_VINYLTOLUENE";
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
						$detector{"material"}    = "G4_PLASTIC_SC_VINYLTOLUENE";
						$detector{"style"}       = "1";
						$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
						$detector{"hit_type"}    = "mirror";
						print_det(\%configuration, \%detector);
					}

					# Not S3, can copy all
					else {
						my %detector = init_det();
						$detector{"name"}        = "cone_s$s"."right_$n";
						$detector{"mother"}      = "ltccS$s";
						$detector{"description"} = "cone right $n";
						$detector{"pos"}         = "$wc_sec_x_r[$n-1]*cm $wc_sec_y_r[$n-1]*cm $wc_sec_z_r[$n-1]*cm";
						$detector{"rotation"}    = "$segphi[$n-1]*deg -$tilt[$n-1]*deg $shield_tilt[$n-1]*deg";
						$detector{"color"}       = "aa9999";
						$detector{"type"}        = "CopyOf WC_M";
						$detector{"material"}    = "G4_PLASTIC_SC_VINYLTOLUENE";
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
						$detector{"material"}    = "G4_PLASTIC_SC_VINYLTOLUENE";
						$detector{"style"}       = "1";
						$detector{"sensitivity"} = "mirror: ltcc_AlMgF2";
						$detector{"hit_type"}    = "mirror";
						print_det(\%configuration, \%detector);
					}

				}


				# Big CONES (copper)
				# ------------------
				elsif($n > 12 && $n < $endN) {

					
					# STL Cone is in S3
					if($s == 3){

						# Right one: Copy it if it's not the STL (#13)
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

					# Not S3, can copy all
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
