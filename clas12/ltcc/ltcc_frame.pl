
our %configuration;
our %parameters;

our $startS;
our $endS;
our $startN;
our $endN;

# number of mirrors
my $nmirrors = $parameters{"nmirrors"} ;

my @fangle = ();

sub buildLtccFrame
{
	calculateFramePars();
	build_LtccFrame();

}

sub calculateFramePars
{
	for(my $n=0; $n<$nmirrors ; $n++)
	{
		my $s = $n + 1;

		$fangle[$s] = ($s - 2) * 60; # rotation angle of the ltcc frame for each sectors

	}

}

sub build_LtccFrame
{


	for(my $s=$startS; $s<=$endS; $s++) {

		if($s != 3 && $s != 4 && $s != 1) {
			my %detector = init_det();
			$detector{"name"}        = "frame1_s$s";
			$detector{"mother"}      = "fc";
			$detector{"description"} = "ltcc frame $s";
			$detector{"pos"}         = "0*cm 0*cm 1273.7*mm";
			$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
			$detector{"color"}       = "ccccdd";
			$detector{"type"}        = "CopyOf S1-BW";
			$detector{"material"}    = "G4_STAINLESS-STEEL";
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);

			%detector = init_det();
			$detector{"name"}        = "frame2_s$s";
			$detector{"mother"}      = "fc";
			$detector{"description"} = "ltcc frame $s";
			$detector{"pos"}         = "0*cm 0*cm 1273.7*mm";
			$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
			$detector{"color"}       = "ccccdd";
			$detector{"type"}        = "CopyOf S1-BB";
			$detector{"material"}    = "G4_STAINLESS-STEEL";
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);

			%detector = init_det();
			$detector{"name"}        = "frame3_s$s";
			$detector{"mother"}      = "fc";
			$detector{"description"} = "ltcc frame $s";
			$detector{"pos"}         = "0*cm 0*cm 1273.7*mm";
			$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
			$detector{"color"}       = "ccccdd";
			$detector{"type"}        = "CopyOf S1-BRB";
			$detector{"material"}    = "G4_STAINLESS-STEEL";
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);

			%detector = init_det();
			$detector{"name"}        = "frame4_s$s";
			$detector{"mother"}      = "fc";
			$detector{"description"} = "ltcc frame $s";
			$detector{"pos"}         = "0*cm 0*cm 1273.7*mm";
			$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
			$detector{"color"}       = "ccccdd";
			$detector{"type"}        = "CopyOf S1-LW ";
			$detector{"material"}    = "G4_STAINLESS-STEEL";
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);

			%detector = init_det();
			$detector{"name"}        = "frame5_s$s";
			$detector{"mother"}      = "fc";
			$detector{"description"} = "ltcc frame $s";
			$detector{"pos"}         = "0*cm 0*cm 1273.7*mm";
			$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
			$detector{"color"}       = "ccccdd";
			$detector{"type"}        = "CopyOf S1-RW";
			$detector{"material"}    = "G4_STAINLESS-STEEL";
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);

			%detector = init_det();
			$detector{"name"}        = "frame6_s$s";
			$detector{"mother"}      = "fc";
			$detector{"description"} = "ltcc frame $s";
			$detector{"pos"}         = "0*cm 0*cm 1273.7*mm";
			$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
			$detector{"color"}       = "ccccdd";
			$detector{"type"}        = "CopyOf S1-TB";
			$detector{"material"}    = "G4_STAINLESS-STEEL";
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);

			%detector = init_det();
			$detector{"name"}        = "frame7_s$s";
			$detector{"mother"}      = "fc";
			$detector{"description"} = "ltcc frame $s";
			$detector{"pos"}         = "0*cm 0*cm 1273.7*mm";
			$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
			$detector{"color"}       = "ccccdd";
			$detector{"type"}        = "CopyOf S1-TRB";
			$detector{"material"}    = "G4_STAINLESS-STEEL";
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);

			%detector = init_det();
			$detector{"name"}        = "frame8_s$s";
			$detector{"mother"}      = "fc";
			$detector{"description"} = "ltcc frame $s";
			$detector{"pos"}         = "0*cm 0*cm 1273.7*mm";
			$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
			$detector{"color"}       = "ccccdd";
			$detector{"type"}        = "CopyOf S1-TLB";
			$detector{"material"}    = "G4_STAINLESS-STEEL";
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);


			%detector = init_det();
			$detector{"name"}        = "frame9_s$s";
			$detector{"mother"}      = "fc";
			$detector{"description"} = "ltcc frame $s";
			$detector{"pos"}         = "0*cm 0*cm 1273.7*mm";
			$detector{"rotation"}    = "180*deg 0*deg $fangle[$s]*deg";
			$detector{"color"}       = "ccccdd";
			$detector{"type"}        = "CopyOf S1-BLB";
			$detector{"material"}    = "G4_STAINLESS-STEEL";
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);

		}
		
		if($s == 3 || $s == 5 || $s == 6) {
			
			my $nangle = ($s - 1) * 60; # rotation angle of the ltcc frame for each sectors

			my %detector = init_det();
			$detector{"name"}        = "nose1_s$s";
			$detector{"mother"}      = "fc";
			$detector{"description"} = "ltcc nose piece 1 $s";
			$detector{"pos"}         = "0*cm 0*cm 1273.7*mm";
			$detector{"rotation"}    = "180*deg 0*deg $nangle*deg";
			$detector{"color"}       = "8888aa";
			$detector{"type"}        = "CopyOf NFrame";
			$detector{"material"}    = "G4_Al";
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);
			
			%detector = init_det();
			$detector{"name"}        = "nose2_s$s";
			$detector{"mother"}      = "fc";
			$detector{"description"} = "ltcc nose piece 1 $s";
			$detector{"pos"}         = "0*cm 0*cm 1273.7*mm";
			$detector{"rotation"}    = "180*deg 0*deg $nangle*deg";
			$detector{"color"}       = "8888aa";
			$detector{"type"}        = "CopyOf FrontPlate";
			$detector{"material"}    = "G4_Al";
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);

			%detector = init_det();
			$detector{"name"}        = "nose3_s$s";
			$detector{"mother"}      = "fc";
			$detector{"description"} = "ltcc nose piece 1 $s";
			$detector{"pos"}         = "0*cm 0*cm 1273.7*mm";
			$detector{"rotation"}    = "180*deg 0*deg $nangle*deg";
			$detector{"color"}       = "8888aa";
			$detector{"type"}        = "CopyOf Mount";
			$detector{"material"}    = "G4_Al";
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);


			%detector = init_det();
			$detector{"name"}        = "nose4_s$s";
			$detector{"mother"}      = "fc";
			$detector{"description"} = "ltcc nose piece 1 $s";
			$detector{"pos"}         = "0*cm 0*cm 1273.7*mm";
			$detector{"rotation"}    = "180*deg 0*deg $nangle*deg";
			$detector{"color"}       = "8888aa";
			$detector{"type"}        = "CopyOf Nose";
			$detector{"material"}    = "G4_Al";
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);


			%detector = init_det();
			$detector{"name"}        = "nose5_s$s";
			$detector{"mother"}      = "fc";
			$detector{"description"} = "ltcc nose piece 1 $s";
			$detector{"pos"}         = "0*cm 0*cm 1273.7*mm";
			$detector{"rotation"}    = "180*deg 0*deg $nangle*deg";
			$detector{"color"}       = "8888aa";
			$detector{"type"}        = "CopyOf BottomPlate";
			$detector{"material"}    = "G4_Al";
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);


			%detector = init_det();
			$detector{"name"}        = "nose6_s$s";
			$detector{"mother"}      = "fc";
			$detector{"description"} = "ltcc nose piece 1 $s";
			$detector{"pos"}         = "0*cm 0*cm 1273.7*mm";
			$detector{"rotation"}    = "180*deg 0*deg $nangle*deg";
			$detector{"color"}       = "8888aa";
			$detector{"type"}        = "CopyOf Epoxy";
			$detector{"material"}    = "G4_CR39";
			$detector{"style"}       = 1;
			print_det(\%configuration, \%detector);



			
			
			
			
		}
	}
	
}

1;
