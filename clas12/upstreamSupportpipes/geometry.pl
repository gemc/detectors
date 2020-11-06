use strict;
use warnings;

our %configuration;

my $shift = 130;
my $STARTcart = -462.3;

sub geometry()
{
	build_mom();
	build_MVTpipe();
	build_SVTpipe();
	#build_SVTcart();
}

sub build_mom()
{
	my $START = 1764;   # 1764*mm
	my $END   = 4460.9; # 4460.9*mm
	my %detector = init_det();
	$detector{"name"}        = "mom";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Support pipes' mother volume";
	$detector{"pos"}         = "0*cm 0*cm $shift*cm";
	$detector{"rotation"}    = "0*deg 180*deg 0*deg";
	$detector{"color"}       = "eeeeee";
	$detector{"type"}        = "Polycone";
	# $detector{"dimensions"}  = "0*deg 360*deg 12*counts 103*mm 103*mm 152.6*mm 152.6*mm 152.6*mm 152.6*mm 152.6*mm 152.6*mm 152.6*mm 152.6*mm 152.6*mm 152.6*mm 248.4*mm 248.4*mm 248.4*mm 248.4*mm 500*mm 500*mm 800*mm 800*mm 1800*mm 1800*mm 800*mm 800*mm $START*mm 2589*mm 2589*mm 2816*mm 2816*mm 3170*mm 3170*mm 3540*mm 3540*mm 3693*mm 3693*mm $END*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 6*counts 103*mm 103*mm 152.6*mm 152.6*mm 152.6*mm 152.6*mm 248.4*mm 248.4*mm 248.4*mm 248.4*mm 500*mm 500*mm $START*mm 2589*mm 2589*mm 2816*mm 2816*mm 3146.41*mm";
	$detector{"material"}    = "G4_AIR";
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);

}

sub build_MVTpipe()
{
	my %detector = init_det();
	$detector{"name"}        = "JL0046104";
	$detector{"mother"}      = "mom";
	$detector{"description"} = "MVT support pipe";
	$detector{"color"}       = "777777";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 20*counts 237*mm 236*mm 236*mm 238*mm 238*mm 238*mm 238*mm 238*mm 238*mm 238*mm 238*mm 238*mm 238*mm 244.77*mm 254*mm 254*mm 257*mm 257*mm 257*mm 257*mm 244*mm 244*mm 244*mm 244*mm 244*mm 241*mm 241*mm 245.5*mm 245.5*mm 245.78*mm 247.5*mm 250.627*mm 253.124*mm 260*mm 260*mm 260*mm 260*mm 260*mm 314*mm 314*mm 1979.76*mm 1980.76*mm 1991.76*mm 1991.76*mm 2001.76*mm 2001.76*mm 2836.76*mm 2836.76*mm 2840.76*mm 2841.76*mm 2842.76*mm 2842.76*mm 2846.76*mm 2857.76*mm 2872.76*mm 2878.76*mm 2878.76*mm 2949.76*mm 2949.76*mm 2979.76*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "JL0045868";
	$detector{"mother"}      = "mom";
	$detector{"description"} = "MVT support pipe";
	$detector{"color"}       = "777777"; #cccccc
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 13*counts 205*mm 204*mm 204*mm 204*mm 204*mm 204*mm 204*mm 209.501*mm 209.501*mm 209.501*mm 209.501*mm 209.501*mm 209.501*mm 208*mm 208*mm 208*mm 208.279*mm 210*mm 212.5*mm 212.5*mm 212.5*mm 212.5*mm 244*mm 244*mm 235.999*mm 235.999*mm 1764.76*mm 1765.76*mm 1800.76*mm 1801.76*mm 1802.76*mm 1802.76*mm 1815.76*mm 1815.76*mm 1967.76*mm 1967.76*mm 1979.76*mm 1979.76*mm 1985.76*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

}

sub build_SVTpipe()
{
	my %detector = init_det();

	$detector{"name"}        = "14_Inch_Tube";
	$detector{"mother"}      = "mom";
	$detector{"description"} = "14 Inch Tube, flange cart side and forward mounting flange";
	$detector{"color"}       = "ff7f00";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 8*counts 171.45*mm 171.45*mm 136.525*mm 136.525*mm 171.45*mm 171.45*mm 171.45*mm 171.45*mm 177.8*mm 177.8*mm 177.8*mm 177.8*mm 177.8*mm 177.8*mm 228.6*mm 228.6*mm 2397.11*mm 2409.81*mm 2409.81*mm 2422.51*mm 2422.51*mm 3127.36*mm 3127.36*mm 3146.41*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "MVTflangeI";
	$detector{"mother"}      = "mom";
	$detector{"description"} = "Reg 4 and MVT Mounting Flange (Inner Ring)";
	$detector{"color"}       = "771111";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 196.85*mm 196.85*mm 228.6*mm 228.6*mm 2979.76*mm 3005.16*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "MVTflangeO";
	$detector{"mother"}      = "mom";
	$detector{"description"} = "Reg 4 and MVT Mounting Flange (Outer Ring)";
	$detector{"color"}       = "771111";
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 260.35*mm 260.35*mm 304.8*mm 304.8*mm 2979.76*mm 3005.16*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "10.75_Inch_Tube";
	$detector{"mother"}      = "mom";
	$detector{"description"} = "SVT 10.75 Inch Tube, center step flange, and SVT interface flange";
	$detector{"color"}       = "ff7f00"; #444444
	$detector{"type"}        = "Polycone";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"dimensions"}  = "0*deg 360*deg 10*counts 132.334*mm 132.334*mm 107.95*mm 107.95*mm 132.334*mm 132.334*mm 132.334*mm 132.334*mm 136.525*mm 136.525*mm 136.525*mm 136.525*mm 136.525*mm 136.525*mm 136.525*mm 136.525*mm 165.735*mm 165.735*mm 165.735*mm 165.735*mm 2039.96*mm 2053.34*mm 2053.34*mm 2066.04*mm 2066.04*mm 2397.11*mm 2397.11*mm 2409.53*mm 2409.53*mm 2409.81*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

}

sub build_SVTcart()
{
	my $zcart = $STARTcart + 381;
	my %detector = init_det();

	$detector{"name"}        = "mounting_tube_plate"; #############MOUNTING_TUBE#############################
	$detector{"mother"}      = "band";
	$detector{"description"} = "Mounting Tube Plate";
	$detector{"color"}       = "777777";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "0*mm -272.494*mm $zcart*mm";
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
	$detector{"pos"}         = "0*mm -221.694*mm $zcart*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"dimensions"}  = "177.8*mm 44.45*mm 12.7*mm";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);

	$detector{"name"}        = "mounting_tube_plate001alex";
	$detector{"mother"}      = "band";
	$detector{"description"} = "Mounting Tube Plate001";
	$detector{"color"}       = "777777";
	$detector{"type"}        = "Box";
	$detector{"pos"}         = "247.65*mm -12.144*mm $zcart*mm";
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
	$detector{"pos"}         = "-247.65*mm -12.144*mm $zcart*mm";
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
	$detector{"pos"}         = "0*mm -514.35*mm $zcart*mm";
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
	$detector{"pos"}         = "0*mm 0*mm -254*mm";
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
	$detector{"pos"}         = "304.35*mm -12.144*mm $zcart*mm";
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
	$detector{"pos"}         = "304.35*mm -228.044*mm $zcart*mm";
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
	$detector{"pos"}         = "-304.35*mm -12.144*mm $zcart*mm";
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
	$detector{"pos"}         = "-304.35*mm -228.044*mm $zcart*mm";
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
	$detector{"pos"}         = "254*mm -596.9*mm $zcart*mm";
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
	$detector{"pos"}         = "-254*mm -596.9*mm $zcart*mm";
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
	$detector{"pos"}         = "0*mm -596.9*mm $zcart*mm";
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
	$detector{"pos"}         = "0*mm -596.9*mm $zcart*mm";
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
	$detector{"pos"}         = "908.05*mm -647.7*mm $zcart*mm";
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
	$detector{"pos"}         = "-908.05*mm -647.7*mm $zcart*mm";
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
