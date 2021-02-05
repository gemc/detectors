use strict;
use warnings;

our %configuration;

# Assign paramters to local variables
my $NUM_LAYERS = 6;
my $NUM_BARS   = 18;
my $NUM_SHDS   = 3;

my $band_xpos  = 0;
my $band_ypos  = 900; #
my $band_zpos  = 655; #

my $bcolor = 'aaaaaa';
my $mbar_length = 1637;  # mm
my $lbar_length = 2019;  # mm
my $sbar_length = 512;   # mm
my $vframe_x  = 3;       # inches
my $vframe_y  = 1541.33; # mm
my $vframe_z  = 6;       # inches
my @vframe    = ($vframe_x/2, $vframe_y/2, $vframe_z/2);
my @vinframe  = ($vframe_x/2-0.25, $vframe_y/2, $vframe_z/2-0.25);
my @vframepos = ($band_xpos - 1078.9, $band_xpos - 448.3, $band_xpos + 448.3, $band_xpos + 1078.9);
my $align_x = 0; # mm 565.66 - 560.57  -5.09
my $align_y = 0; # mm 227.70 - 210.48   21.50077
my $align_z = 3608.71;            # mm 3378.60 3500

my $STARTcart = -462.3; #3146.41

sub band()
{
	my %detector = init_det();
	$detector{"name"}        = "band";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Mother volume of BAND";
	$detector{"pos"}         = "$align_x*mm $align_y*mm $align_z*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "339999";
	$detector{"type"}        = "Pgon";
	$detector{"dimensions"}  = "-45*deg 360*deg 4*counts 3*counts 160*mm 160*mm 160*mm 1500*mm 1500*mm 1500*mm -462.3*mm 0*mm 900*mm";
	$detector{"material"}    = "G4_AIR";
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);

	#build_measurements();
	build_scintillators();
	build_frame();
	build_shielding();
	build_cart();
}

sub build_measurements
{
	my %detector = init_det();
	$detector{"name"}        = "point7";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Point 7";
	$detector{"pos"}         = "-140.07*mm 227.71*mm 4041.71*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "ff0000";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "100*mm 10*mm 100*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "point6";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Point 6";
	$detector{"pos"}         = "-132.27*mm -210.48*mm 4027.95*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "ff0000";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "100*mm 10*mm 100*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "point2";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Point 2";
	$detector{"pos"}         = "-854.3*mm 850.23*mm 4139.72*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "ff0000";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "5*mm 20*mm 5*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "point8";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Point 8";
	$detector{"pos"}         = "846.05*mm 839.47*mm 4139.52*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "ff9900";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "5*mm 20*mm 5*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "point1";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Point 1";
	$detector{"pos"}         = "-1042.56*mm -349.15*mm 4157.40*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "ff0000";
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "5*mm 20*mm 20*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

}
sub build_scintillators
{
	for(my $j=1; $j<=$NUM_LAYERS; $j++)
	{
		for(my $i=1; $i<=$NUM_BARS; $i++)
		{
			my $barnum      = 100*$j + $i;

			my %detector = init_det();
			# positioning
			my $x      = $band_xpos;
			my $y      = $band_ypos;
			my $z      = $band_zpos;
			my $xpos = $x;
			my $ypos = $y - 73.03*($i-1); # 73.69
			my $zpos = $z - 76.75*($j-1);
			my $xdim = $lbar_length/2;
			my $ydim = 36;
			my $zdim = 36;
			$bcolor  = '007fff';

			if($i<=10 || $i>=17) # long bars
			{
				if($j==$NUM_LAYERS)
				{
					$zdim = 10;
					$zpos = $zpos - 2;
					$bcolor = '800080';
				}
				if($i<=3) # medium bars
				{
					$xdim = $mbar_length/2;
					$bcolor = 'ff00ff';
					if($j==$NUM_LAYERS)
						{$bcolor = '008000';}
				}

				if($j==5 && $i>=16) {next;}
				if($j==$NUM_LAYERS && $i>=16) {$zpos = $zpos + 72;}
				$detector{"name"}        = "scintillator_$barnum";
				$detector{"mother"}      = "band";
				$detector{"description"} = "Scintillator";
				$detector{"pos"}         = "$x*mm $ypos*mm $zpos*mm";
				$detector{"rotation"}    = "0*deg 0*deg 0*deg";
				$detector{"color"}       = $bcolor;
				$detector{"type"}        = "Box";
				$detector{"dimensions"}  = "$xdim*mm $ydim*mm $zdim*mm";
				$detector{"material"}    = "ej200";
				$detector{"style"}       = 0;
				print_det(\%configuration, \%detector);

				for(my $k=1; $k<=2; $k++) # pmt shields
				{
					my $dx = 1138.74;
					if($i<=3)
						{$dx = 947.4;}
					my $xp = $x - $dx;

					$detector{"name"}        = "pmtshield_$barnum L";
					my $colour               = "111111";
					if($k==2)
					{
						if($j==$NUM_LAYERS) {last;}
						$xp = $x + $dx;
						$detector{"name"}        = "pmtshield_$barnum R";
						$colour                  = "771111";
					}
					$detector{"mother"}      = "band";
					$detector{"description"} = "Mu metal shield for pmt";
					$detector{"pos"}         = "$xp*mm $ypos*mm $zpos*mm";
					$detector{"rotation"}    = "0*deg 90*deg 0*deg";
					$detector{"color"}       = $colour;
					$detector{"type"}        = "Tube";
					$detector{"dimensions"}  = "30.035*mm 32.725*mm 88.9*mm 0*deg 360*deg";
					$detector{"material"}    = "conetic";
					$detector{"style"}       = 0;
					print_det(\%configuration, \%detector);
				} # pmt shields

			} # long bars
			if($i>10 && $i<=16) # short bars
			{
				$bcolor = '4cbb17';
				if($j==$NUM_LAYERS)
				{
					$zdim = 10;
					$zpos = $zpos - 2;
					$bcolor = '007fff';
				}
				if($j==5 && $i>=16) {next;}
				if($j==$NUM_LAYERS && $i>=16) {$zpos = $zpos + 72;}
				# Short Bars
				my $xpo = "753.5";
				my $ypo = 200 - 72*$i;
				my $zpo = $z + 72*($j-1);
				$detector{"name"}        = "scintillator_$barnum B";
				$detector{"mother"}      = "band";
				$detector{"description"} = "Short Bars";
				$detector{"pos"}         = "$xpo*mm $ypos*mm $zpos*mm";
				$detector{"rotation"}    = "0*deg 0*deg 0*deg";
				$detector{"color"}       = "$bcolor";
				$detector{"type"}        = "Box";
				$detector{"dimensions"}  = "255*mm 36*mm $zdim*mm";
				$detector{"material"}    = "ej200";
				$detector{"style"}       = 0;
				print_det(\%configuration, \%detector);
			
				$bcolor = '32cd32';
				if($j==$NUM_LAYERS)
					{$bcolor = '007fff';}
				# Short Bars
				$xpo = "-753.5";
				$detector{"name"}        = "scintillator_$barnum A";
				$detector{"mother"}      = "band";
				$detector{"description"} = "Short Bars";
				$detector{"pos"}         = "$xpo*mm $ypos*mm $zpos*mm";
				$detector{"rotation"}    = "0*deg 0*deg 0*deg";
				$detector{"color"}       = "$bcolor";
				$detector{"type"}        = "Box";
				$detector{"dimensions"}  = "255*mm 36*mm $zdim*mm";
				$detector{"material"}    = "ej200";
				$detector{"style"}       = 0;
				print_det(\%configuration, \%detector);

				for(my $k=1; $k<=4; $k++) # pmt shields
				{
					if($k>=3 && $j==$NUM_LAYERS){last;}
					my $xp = $x - 1138.74;
					$detector{"name"}        = "pmtshield_$barnum Lout";
					my $colour               = "111111";
					if($k==2)
					{
						$xp = $x + 1138.74;
						$detector{"name"}        = "pmtshield_$barnum Rout";
						$colour                  = "771111";
					}
					if($k==3)
					{
						$xp = $x - 368.263;
						$detector{"name"}        = "pmtshield_$barnum Rin";
						$colour                  = "771111";
					}
					if($k==4)
					{
						$xp = $x + 368.263;
						$detector{"name"}        = "pmtshield_$barnum Lin";
						$colour                  = "111111";
					}
					$detector{"mother"}      = "band";
					$detector{"description"} = "Mu metal shield for pmt";
					$detector{"pos"}         = "$xp*mm $ypos*mm $zpos*mm";
					$detector{"rotation"}    = "0*deg 90*deg 0*deg";
					$detector{"color"}       = $colour;
					$detector{"type"}        = "Tube";
					$detector{"dimensions"}  = "30.035*mm 32.725*mm 88.9*mm 0*deg 360*deg";
					$detector{"material"}    = "conetic";
					$detector{"style"}       = 0;
					print_det(\%configuration, \%detector);
				} # pmt shields

			} # short bars

		} # NUM_BARS
	} # NUM_LAYERS
}
sub build_frame
{
	for(my $i=1; $i<=4; $i++)
	{
		my $qnumber     = cnumber($i-1, 10);
		
		# positioning
		my $yp     = $band_ypos - 575.715;
		my $zp     = $band_zpos - 533;

		my %detector = init_det();
		$detector{"name"}        = "support_$qnumber";
		$detector{"mother"}      = "band";
		$detector{"description"} = "Vertical support beam of BAND frame";
		$detector{"pos"}         = "$vframepos[$i-1]*mm $yp*mm $zp*mm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = "777777";
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$vframe[0]*inches $vframe[1]*mm $vframe[2]*inches";
		$detector{"material"}    = "G4_STAINLESS-STEEL";
		$detector{"style"}       = 0;
		print_det(\%configuration, \%detector);

		# Inside of support beam
		$detector{"name"}        = "support_inside_$qnumber";
		$detector{"mother"}      = "support_$qnumber";
		$detector{"description"} = "Inside of support beam";
		$detector{"pos"}         = "0*mm 0*mm 0*mm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = "eeeeee";
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$vinframe[0]*inches $vinframe[1]*mm $vinframe[2]*inches";
		$detector{"material"}    = "G4_AIR";
		$detector{"style"}       = 0;
		print_det(\%configuration, \%detector);
	}
}

sub build_shielding
{
	my $q=0;
	for(my $n=1; $n<=$NUM_SHDS; $n++)
	{
		$q = $q + $n;
		my @lxpo = ($band_xpos - 763.065, $band_xpos - 0, $band_xpos + 763.065);
		my @lypo = ($band_ypos - 652.850, $band_ypos - 367.6000, $band_ypos - 652.850);
		my @lzpo = ($band_zpos - 556.097, $band_zpos - 629.3285, $band_zpos - 556.097);
		my @lnum = (19, 10, 19);
		my @sx   = (21.60/2, 39.30/2, 21.60/2);
		my @sz   = (1.102/2, 1.11/2, 1.102/2);
		my $sy   = 2.83*$lnum[$n-1]/2;
		my $sd   = $sx[$n-1] - 1/2;
		my $sb   = 0.79/2;

		my %detector = init_det();
		$detector{"name"}        = "leadshield_$q";
		$detector{"mother"}      = "band";
		$detector{"description"} = "Aluminum plates for lead shield $q";
		$detector{"pos"}         = "$lxpo[$n-1]*mm $lypo[$n-1]*mm $lzpo[$n-1]*mm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = "aaaaaa";
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$sx[$n-1]*inches $sy*inches $sz[$n-1]*inches";
		$detector{"material"}    = "G4_Al";
		$detector{"style"}       = 0;
		print_det(\%configuration, \%detector);

		$detector{"name"}        = "leadblock_$q";
		$detector{"mother"}      = "leadshield_$q";
		$detector{"description"} = "Lead block inside shield $q";
		$detector{"pos"}         = "0*mm 0*mm 0*mm";
		$detector{"rotation"}    = "0*deg 0*deg 0*deg";
		$detector{"color"}       = "555555";
		$detector{"type"}        = "Box";
		$detector{"dimensions"}  = "$sd*inches $sy*inches $sb*inches";
		$detector{"material"}    = "G4_Pb";
		$detector{"style"}       = 0;
		print_det(\%configuration, \%detector);

	}
}

sub build_cart()
{
	my $zcart = $STARTcart + 381;
	my %detector = init_det();

	$detector{"name"}        = "mounting_tube_plate"; #############MOUNTING_TUBE#############################
	$detector{"mother"}      = "band";
	$detector{"description"} = "Mounting Tube Plate";
	$detector{"color"}       = "777777";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "0*mm -272.494*mm $zcart*mm"; #3527.41
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "317.5*mm 6.35*mm 381*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zcart = $STARTcart + 12.7;
	$detector{"name"}        = "mounting_tube_plate001";
	$detector{"mother"}      = "band";
	$detector{"description"} = "Mounting Tube Plate001";
	$detector{"color"}       = "777777";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "0*mm -221.694*mm $zcart*mm"; #y=-12.144 z=3159.11
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "177.8*mm 44.45*mm 12.7*mm"; #x=317.5 y=254
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "mounting_tube_plate001alex";
	$detector{"mother"}      = "band";
	$detector{"description"} = "Mounting Tube Plate001";
	$detector{"color"}       = "777777";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "247.65*mm -12.144*mm $zcart*mm"; #3159.11
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "69.85*mm 254*mm 12.7*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "mounting_tube_plate001james";
	$detector{"mother"}      = "band";
	$detector{"description"} = "Mounting Tube Plate001";
	$detector{"color"}       = "777777";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "-247.65*mm -12.144*mm $zcart*mm"; #3159.11
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "69.85*mm 254*mm 12.7*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);


	$zcart = $STARTcart + 393.7; #
	$detector{"name"}        = "adjustment_plate";
	$detector{"mother"}      = "band";
	$detector{"description"} = "Adjustment Plate";
	$detector{"color"}       = "777777";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "0*mm -514.35*mm $zcart*mm"; #3540.11
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "317.5*mm 6.35*mm 368.3*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "adjustment_hole";
	$detector{"mother"}      = "adjustment_plate";
	$detector{"description"} = "Adjustment Plate hole";
	$detector{"color"}       = "eeeeee";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "0*mm 0*mm -254*mm"; # z=3286.11
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "165.1*mm 6.35*mm 114.3*mm";
	$detector{"material"}    = "G4_AIR";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zcart = $STARTcart + 63.5; 
	$detector{"name"}        = "gusset006vert"; #################GUSSET
	$detector{"mother"}      = "band";
	$detector{"description"} = "Gusset006";
	$detector{"color"}       = "555555";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "304.35*mm -12.144*mm $zcart*mm"; #3209.91
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "13.15*mm 254*mm 38.1*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zcart = $STARTcart + 431.8; 
	$detector{"name"}        = "gusset006hori";
	$detector{"mother"}      = "band";
	$detector{"description"} = "Gusset006";
	$detector{"color"}       = "555555";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "304.35*mm -228.044*mm $zcart*mm"; #3578.21
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "13.15*mm 38.1*mm 330.2*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zcart = $STARTcart + 63.5; 
	$detector{"name"}        = "gusset007vert";
	$detector{"mother"}      = "band";
	$detector{"description"} = "Gusset007";
	$detector{"color"}       = "555555";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "-304.35*mm -12.144*mm $zcart*mm"; #3209.91
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "13.15*mm 254*mm 38.1*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zcart = $STARTcart + 431.8; 
	$detector{"name"}        = "gusset007hori";
	$detector{"mother"}      = "band";
	$detector{"description"} = "Gusset007";
	$detector{"color"}       = "555555";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "-304.35*mm -228.044*mm $zcart*mm"; #3578.21
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "13.15*mm 38.1*mm 330.2*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$zcart = $STARTcart + 669.925; 
	$detector{"name"}        = "shortstrut"; ###########################################SQUARETUBES======================================
	$detector{"mother"}      = "band";
	$detector{"description"} = "Short Strut";
	$detector{"color"}       = "ff00ff";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "254*mm -596.9*mm $zcart*mm"; #3816.335
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "76.2*mm 76.2*mm 644.525*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "shortstrutair";
	$detector{"mother"}      = "shortstrut";
	$detector{"description"} = "Short Strut air";
	$detector{"color"}       = "ffc0cb";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "69.85*mm 69.85*mm 644.525*mm";
	$detector{"material"}    = "G4_AIR";
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "shortstrut001";
	$detector{"mother"}      = "band";
	$detector{"description"} = "Short Strut001";
	$detector{"color"}       = "ff00ff";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "-254*mm -596.9*mm $zcart*mm"; #3816.335
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "76.2*mm 76.2*mm 644.525*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "shortstrut001air";
	$detector{"mother"}      = "shortstrut001";
	$detector{"description"} = "Short Strut001 air";
	$detector{"color"}       = "ffc0cb";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "69.85*mm 69.85*mm 644.525*mm";
	$detector{"material"}    = "G4_AIR";
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);

	$zcart = $STARTcart + 736.6; 
	$detector{"name"}        = "6x6x.25squaretubebrace";
	$detector{"mother"}      = "band";
	$detector{"description"} = "6x6x.25 Square Tube Brace";
	$detector{"color"}       = "ff00ff";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "0*mm -596.9*mm $zcart*mm"; #3883.01
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "177.8*mm 76.2*mm 76.2*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "6x6x.25squaretubebraceair";
	$detector{"mother"}      = "6x6x.25squaretubebrace";
	$detector{"description"} = "6x6x.25 Square Tube Brace air";
	$detector{"color"}       = "ffc0cb";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "177.8*mm 69.85*mm 69.85*mm";
	$detector{"material"}    = "G4_AIR";
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "6x6x.25squaretubebracehole";
	$detector{"mother"}      = "6x6x.25squaretubebrace";
	$detector{"description"} = "6x6x.25 Square Tube Brace hole";
	$detector{"color"}       = "eeeeee";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "0*mm 0*mm 73.025*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "127*mm 44.45*mm 3.175*mm";
	$detector{"material"}    = "G4_AIR";
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);

	$zcart = $STARTcart + 469.9; 
	$detector{"name"}        = "6x6x.25squaretubeshort001";
	$detector{"mother"}      = "band";
	$detector{"description"} = "6x6x.25 Square Tube Short001";
	$detector{"color"}       = "ff00ff";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "0*mm -596.9*mm $zcart*mm"; #3616.31
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "177.8*mm 76.2*mm 76.2*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "6x6x.25squaretubeshort001air";
	$detector{"mother"}      = "6x6x.25squaretubeshort001";
	$detector{"description"} = "6x6x.25 Square Tube Short001 air";
	$detector{"color"}       = "ffc0cb";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "177.8*mm 69.85*mm 69.85*mm";
	$detector{"material"}    = "G4_AIR";
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "secondbeamds";
	$detector{"mother"}      = "band";
	$detector{"description"} = "second beam ds";
	$detector{"color"}       = "ff00ff";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "908.05*mm -647.7*mm $zcart*mm"; #3616.31
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "577.85*mm 76.2*mm 76.2*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "secondbeamdsair";
	$detector{"mother"}      = "secondbeamds";
	$detector{"description"} = "second beam ds air";
	$detector{"color"}       = "ffc0cb";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "577.85*mm 69.85*mm 69.85*mm";
	$detector{"material"}    = "G4_AIR";
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "secondbeamds001";
	$detector{"mother"}      = "band";
	$detector{"description"} = "second beam ds001";
	$detector{"color"}       = "ff00ff";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "-908.05*mm -647.7*mm $zcart*mm"; #3616.31
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "577.85*mm 76.2*mm 76.2*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "secondbeamds001air";
	$detector{"mother"}      = "secondbeamds001";
	$detector{"description"} = "second beam ds001 air";
	$detector{"color"}       = "ffc0cb";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "577.85*mm 69.85*mm 69.85*mm";
	$detector{"material"}    = "G4_AIR";
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);

}
