# Cylindrical mirrors are placed in front of WCs, their half lengths are hardcoded as 3 cm

# Cylindrical mirrors' inner and outer radii are the same as WCs', both have 1 mm thickness


our %configuration;
our %parameters;

our $startS;
our $endS;
our $startN;
our $endN;

# number of mirrors
my $nmirrors = $parameters{"nmirrors"};

my @segphi = (); # required rotation about x axis for pmts, pmts stoppers and shields
my @segphi_cyl = (); # required rotation about x axis for cylindrical mirrors
my @cyl_tilt_l = (); # rotation about z axis for cylindrical mirrors (left)
my @cyl_tilt_r = (); # rotation about z axis for cylindrical mirrors (right)
my @cyl_ang = (); # angle of the cylindrical mirror segment
my @cyl_outer = (); # outer radius of the cylindrical mirror
my @mirror_pos_xR = (); # positions of the cylindrical mirrors in sectors (R=right L=left)
my @mirror_pos_yR = ();
my @mirror_pos_zR = ();
my @mirror_pos_xL = ();
my @mirror_pos_yL = ();
my @mirror_pos_zL = ();


sub buildCylMirrors
{
	calculateMirPars();
	build_cylMir();

}

sub calculateMirPars
{
	for(my $n=0; $n<$nmirrors ; $n++)
	{
		my $s = $n + 1;
		$mirror_pos_xR[$n] = $parameters{"ltcc.mirror.s$s"."_xR"};
		$mirror_pos_yR[$n] = $parameters{"ltcc.mirror.s$s"."_yR"};
		$mirror_pos_zR[$n] = $parameters{"ltcc.mirror.s$s"."_zR"};
		$mirror_pos_xL[$n] = $parameters{"ltcc.mirror.s$s"."_xL"};
		$mirror_pos_yL[$n] = $parameters{"ltcc.mirror.s$s"."_yL"};
		$mirror_pos_zL[$n] = $parameters{"ltcc.mirror.s$s"."_zL"};
		$cyl_outer[$n] = $parameters{"ltcc.cyl.s$s"."_router"};
		$cyl_ang[$n] = 90 +  $parameters{"ltcc.shield.s$s"."_zangle"};
		$cyl_tilt_l[$n] = $parameters{"ltcc.cyl.s$s"."_leftAngle"};
		$cyl_tilt_r[$n] = $parameters{"ltcc.cyl.s$s"."_rightAngle"};
		# 90 - theta of center of ltcc. segment
		$segtheta[$n] = 90 - $parameters{"ltcc.s$s"."_theta"};
		#phi rotation angle cylindrical mirrors in sectors ! (calculated using phi rotation angle in segments)
		$segphi_cyl[$n] = -90 - $segtheta[$n];
		#cylindrical mirror thickness is 1 mm (G4 Tube is used)
		$cyl_inner[$n] = $cyl_outer[$n] - 0.1;
		$tilt[$n] = $parameters{"ltcc.wc.s$s"."_angle"};
	}
}




sub build_cylMir
{

	for(my $n=$startN; $n<=$endN; $n++)
	{
		for(my $s=$startS; $s<=$endS; $s++)
		{

			if($s != 4 && $s != 1){

				if($n < $endN){
			
					my %detector = init_det();
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
		}
	}
}

1;
