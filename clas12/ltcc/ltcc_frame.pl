
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
		
	}
	
}

1;
