use strict;
use warnings;

our %configuration;
our %parameters;

######################################################
#  RADIATORs:  radiator wall separated into slices of
#              different thickness or refractive index
#  (G4Trap Volume)
######################################################
#  __________|____________ _ RichGap_y0 + 2*RichGap_dy1 
# \          | rad.5    /  
#  \---------|---------/ - - h4  
#   \--------|--------/ - -- h3
#    \-------|-------/ - - - h2 
#     \------|------/ - - -- h1
#      \     |rad.1/  
#       \___ |____/ _ _ _ _  RichGap_y0        
#
#####################################################
my $RAD=180/3.1415927;

my $RichBox_dz    = $parameters{"par_RichBox_dz"};
my $RichBox_th    = $parameters{"par_RichBox_th"};
my $RichBox_ph    = $parameters{"par_RichBox_ph"};
my $RichBox_dx1   = $parameters{"par_RichBox_dx1"};
my $RichBox_dx2   = $parameters{"par_RichBox_dx2"};
my $RichBox_dx3   = $parameters{"par_RichBox_dx3"};
my $RichBox_dx4   = $parameters{"par_RichBox_dx4"};
my $RichBox_dy1   = $parameters{"par_RichBox_dy1"};
my $RichBox_dy2   = $parameters{"par_RichBox_dy2"};
my $RichBox_alp1  = $parameters{"par_RichBox_alp1"};
my $RichBox_alp2  = $parameters{"par_RichBox_alp2"};
my $RichBox_x     = $parameters{"par_RichBox_x"};
my $RichBox_y     = $parameters{"par_RichBox_y"};
my $RichBox_z     = $parameters{"par_RichBox_z"};
my $RichBox_the   = $parameters{"par_RichBox_the"};
my $RichBox_phi   = $parameters{"par_RichBox_phi"};
my $RichBox_psi   = $parameters{"par_RichBox_psi"};


my $RichGap_dz   = $parameters{"par_RichGap_dz"};
my $RichGap_dx1  = $parameters{"par_RichGap_dx1"};
my $RichGap_dx2  = $parameters{"par_RichGap_dx2"};
my $RichGap_dx3  = $parameters{"par_RichGap_dx3"};
my $RichGap_dx4  = $parameters{"par_RichGap_dx4"};
my $RichGap_dy1  = $parameters{"par_RichGap_dy1"};
my $RichGap_dy2  = $parameters{"par_RichGap_dy2"};

# reference points of entrance window 
my $RichGap_opa1  =  2*$RichGap_dy1/($RichGap_dx2-$RichGap_dx1);     # opening angle
my $RichGap_yc1   =  $RichGap_opa1*($RichGap_dx1+$RichGap_dx2)/2.;   # barycenter height with respect the beam axis
my $RichGap_yb1   =  $RichGap_yc1 - $RichGap_dy1;                    # bottom level with respect the beam axis
# rear window 
my $RichGap_opa2  =  2*$RichGap_dy2/($RichGap_dx4-$RichGap_dx3);     # rear window tg(alfa)
#my $RichGap_yc2   =  $RichGap_opa2*($RichGap_dx3+$RichGap_dx4)/2.+$RichGap_dz*tan($RichBox_th/$RAD);    barycenter height with respect the beam axis
my $RichGap_yc2   =  $RichGap_opa2*($RichGap_dx3+$RichGap_dx4)/2.;  # barycenter height with respect the beam axis
my $RichGap_yb2   =  $RichGap_yc2 - $RichGap_dy2;                    # bottom level with respect the beam axis

# limits for aerogel volume, defined at the center of the RICH gap for simplicity
my $PreMirror_carbon_dz   = $parameters{"par_PreMirror_carbon_dz"};
my $PreMirror_glass_dz    = $parameters{"par_PreMirror_glass_dz"};
my $PreMirror_aero_dz     = $parameters{"par_PreMirror_aero_dz"};
my $PreMirror_alp1        = $parameters{"par_PreMirror_alp1"};
my $PreMirror_alp2        = $parameters{"par_PreMirror_alp2"};
my $PreMirror_x           = $parameters{"par_PreMirror_x"};
my $PreMirror_ph          = $parameters{"par_PreMirror_ph"};

my $PreMirror_aerovol_dz  = $PreMirror_aero_dz+4.;

my $PreMirror_th   = $RichBox_th;

my $PreMirror_dy1   = $RichGap_dy1;
my $PreMirror_dy2   = $RichGap_dy1;

my $PreMirror_dx1   = ($RichGap_yc1 - $PreMirror_dy1)/$RichGap_opa1-1.;
my $PreMirror_dx2   = ($RichGap_yc1 + $PreMirror_dy1)/$RichGap_opa1-1.;
my $PreMirror_dx3   = $PreMirror_dx1;
my $PreMirror_dx4   = $PreMirror_dx2;

my $PreMirror_carbon_z = $PreMirror_carbon_dz - $RichGap_dz + 0.;
my $PreMirror_glass_z  = $PreMirror_carbon_z + $PreMirror_carbon_dz + $PreMirror_glass_dz + 1.;
my $PreMirror_aero_z   = $PreMirror_glass_z + $PreMirror_glass_dz + $PreMirror_aero_dz + 1.;
my $PreMirror_dz       = $PreMirror_carbon_dz + $PreMirror_glass_dz + 0.5;
my $PreMirror_z        = $PreMirror_dz - $RichGap_dz;
my $PreMirror_carbon_y = $PreMirror_carbon_z *  tan($RichBox_th/$RAD);
my $PreMirror_glass_y  = $PreMirror_glass_z *  tan($RichBox_th/$RAD);
my $PreMirror_aero_y   = $PreMirror_aero_z *  tan($RichBox_th/$RAD);

my $AERO_dy1   = $PreMirror_dy1-2.;
my $AERO_dy2   = $PreMirror_dy1-2.;

my $AERO_dx1   = $PreMirror_dx1-2.; 
my $AERO_dx2   = $PreMirror_dx2-2.;
my $AERO_dx3   = $PreMirror_dx1-2.;
my $AERO_dx4   = $PreMirror_dx2-2.;

my $AERO_opa1  =  2*$AERO_dy1/($AERO_dx2-$AERO_dx1);     # opening angle
my $AERO_yc1   =  $AERO_opa1*($AERO_dx1+$AERO_dx2)/2.;   # barycenter height with respect the beam axis
my $AERO_yb1   =  $AERO_yc1 - $AERO_dy1;                    # bottom level with respect the beam axis
# rear window
my $AERO_opa2  =  2*$AERO_dy2/($AERO_dx4-$AERO_dx3);     # rear window tg(alfa)
my $AERO_yc2   =  $AERO_opa2*($AERO_dx3+$AERO_dx4)/2.;   # barycenter height with respect the beam axis
my $AERO_yb2   =  $AERO_yc2 - $AERO_dy2;                    # bottom level with respect the beam axis

my $AERO_types    = 3;
my @AERO_dz       = ( 10., 10., 30.);
my @AERO_dd       = ( 100., 100., 100.);
my @AERO_ddspace  = ( .1, .1, .1);
my @AERO_zoff     = ( 1., 1., 1.);
#my @AERO_mate     = ('NOV105_2cm_cern6_tile1', 'NOV105_2cm_cern6_tile1', 'NOV105_2cm_cern6_tile1'); FIX MATERIAL HERE!
my @AERO_mate     = ('Air', 'Air', 'Air');

my $AERO_rows  = 11;
my $AERO_h     = $AERO_rows * $AERO_dd[0]*2.;
my @AERO_rowtype  = (0, 0, 0, 0, 1, 1, 1, 2, 2, 2, 2);
my @AERO_wrap     = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

my $trapp_dz      =$parameters{"par_trapp_dz"};
my $trapp_dx1     =$parameters{"par_trapp_dx1"};
my $trapp_dx2     =$parameters{"par_trapp_dx2"};
my $trapp_dx3     =$parameters{"par_trapp_dx3"};
my $trapp_dx4     =$parameters{"par_trapp_dx4"};
my $trapp_dy1     =$parameters{"par_trapp_dy1"};
my $trapp_dy2     =$parameters{"par_trapp_dy2"};
my $PostPlane_dz  =$parameters{"par_PostPlane_dz"};


# limits for detecors
my $trapp_opa1  =  2*$trapp_dy1/($trapp_dx2-$trapp_dx1);     # opening angle
my $trapp_yc1   =  $trapp_opa1*($trapp_dx1+$trapp_dx2)/2.;   # barycenter height with respect the beam axis
my $trapp_yb1   =  $trapp_yc1 - $trapp_dy1;                    # bottom level with respect the beam axis
# rear window 
my $trapp_opa2  =  2*$trapp_dy2/($trapp_dx4-$trapp_dx3);     # rear window tg(alfa)
my $trapp_yc2   =  $trapp_opa2*($trapp_dx3+$trapp_dx4)/2.-$trapp_dz*tan($RichBox_th/$RAD);   # barycenter height with respect the beam axis
my $trapp_yb2   =  $trapp_yc2 - $trapp_dy2;                    # bottom level with respect the beam axis

# H8500 
my $type=0;  

my $MAPMT_TYPEs = 4 ;
my @MAPMT_name      = ('H8500', 'H8500_03', 'R8900', 'R8900_C');
my @MAPMT_descr     = ('H8500', 'H8500_03', 'R8900', 'R8900_C');
my @MAPMT_color     = ('0000ee', '0000ee', 'ff44ff', 'ee99ff');

my @MAPMT_DX        = (52./2., 52./2., 25./2., 25./2.);
my @MAPMT_DY        = (52./2., 52./2., 25./2., 25./2.);
my @MAPMT_DZ        = (28./2., 28./2., 25./2., 25./2.);
my @MAPMT_DXSPACE    = (1.0/2., 0.0/2., 0.0/2., 0.0/2.);
my @MAPMT_DYSPACE    = (1.0/2., 0.0/2., 0.0/2., 0.0/2.);

my @PhCath_DX       = ((7*6.08+5.8)/2., 5.8/2., 5.5/2., 5.5/2.);
my @PhCath_DY       = ((7*6.08+5.8)/2., 5.8/2., 5.5/2., 5.5/2.);
my $PhCath_DZ       = 1.0;

my $PhWindow_DZ     = 1.5/2.;

my $MAPMT_Z = $RichGap_dz - $MAPMT_DZ[$type] - 4 * $PostPlane_dz ;

my $X_START  =  -$RichGap_dx4;
my $X_END    =   $RichGap_dx4;
my $Y_START  =  -$RichGap_dy2 + $MAPMT_Z * tan($RichBox_th/$RAD);
my $Y_END    =   $Y_START + 1200.;
print "MAPMTS limits $X_START $X_END $Y_START $Y_END $MAPMT_Z \n";


my $MAX_NUM = 200;
my $iy=0;


sub build_mapmt
{

    my $sector = shift;

 
    # be sure MAPMT is contained at the bottom ot the RICH Gap
    my $Bottom_opa = ($RichGap_dy2-$RichGap_dz*tan($RichBox_th/$RAD)-$RichGap_dy1)/2/$RichGap_dz;
    my $MAPMT_Y = $Y_START+$MAPMT_DY[$type]+2*$MAPMT_DZ[$type]*$Bottom_opa;
  
    for(my $n1=1; $n1<=$MAX_NUM; $n1++)
    {
	if($MAPMT_Y <  $Y_START+$MAPMT_DY[$type] || $MAPMT_Y >  $Y_END-$MAPMT_DY[$type]){next;}

	my $MAPMT_Xmi     = -($trapp_yc2 + $MAPMT_Y - $MAPMT_DY[$type])/$trapp_opa2;  #left line
	my $MAPMT_Xma     = ($trapp_yc2 + $MAPMT_Y - $MAPMT_DY[$type])/$trapp_opa2;  #right line
	my $MAPMT_Xnum    = ($MAPMT_Xma-$MAPMT_Xmi)/2/($MAPMT_DX[$type] + $MAPMT_DXSPACE[$type]);
	my $MAPMT_num     = int($MAPMT_Xnum);
	my $MAPMT_Xmargin = ($MAPMT_Xma-$MAPMT_Xmi)/2.-$MAPMT_num*($MAPMT_DX[$type] + $MAPMT_DXSPACE[$type]) + $MAPMT_DXSPACE[$type];
	my $MAPMT_X    = $MAPMT_Xmi + $MAPMT_Xmargin + $MAPMT_DX[$type];

	for(my $n2=1; $n2<=$MAX_NUM; $n2++)
	{

	    if($MAPMT_X < $X_START + $MAPMT_DX[$type] || $MAPMT_X > $X_END - $MAPMT_DX[$type]
	       || $MAPMT_X < $MAPMT_Xmi + $MAPMT_DX[$type] || $MAPMT_X > $MAPMT_Xma - $MAPMT_DX[$type]){next;}

	    my $padnumber            = $iy+1;

	    my %detector = init_det();
	    $detector{"name"}        = "$MAPMT_name[$type]_$padnumber.$sector";
	    $detector{"mother"}      = "rich_gap.$sector";
	    $detector{"pos"}         = "${MAPMT_X}*mm ${MAPMT_Y}*mm ${MAPMT_Z}*mm";
	    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
	    $detector{"color"}       = "$MAPMT_color[$type]";
#     if($padnumber==1){
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$MAPMT_DX[$type]*mm $MAPMT_DY[$type]*mm $MAPMT_DZ[$type]*mm";
		
		
		if($configuration{"verbosity"} eq "2")
		{
		    print "Base MAPMT $iy $MAPMT_X $MAPMT_Y $iy $padnumber\n";
		}
#     }
#     if($padnumber>1){
#          $detector{"type"}        = "CopyOf $MAPMT_name[0]_1";
#          $detector{"dimensions"}  = "0*mm";
#          print "Copy MAPMT $iy $MAPMT_X $MAPMT_Y $iy $padnumber\n"; 
#     }

#	    %detector = init_det();
	    $detector{"description"} = "MAPMT $padnumber";
	    $detector{"ncopy"}       = $padnumber;
#     $detector{"material"}    = "Glass";
	    $detector{"material"}    = "Gas_inGap";
#	    $detector{"material"}    = "Air";
	    $detector{"mfield"}      = "no";
	    $detector{"pMany"}       = 1;
	    $detector{"exist"}       = 1;
	    $detector{"visible"}     = 1;
	    $detector{"style"}       = 0;
	    $detector{"sensitivity"} = "no";

	    print_det(\%configuration, \%detector);

#     if($padnumber==1){
		if($configuration{"verbosity"} eq "2")
		{
		    print "---> Generate PhWindow for $MAPMT_name[$type]_$padnumber \n";
		}
		
	    %detector = init_det();
	    $detector{"name"}        = "AAs_PMT_case_$padnumber.$sector";
	    $detector{"mother"}      = "$MAPMT_name[$type]_$padnumber.$sector";
	    $detector{"description"} = "Case for PMT";
	    $detector{"pos"}         = "0*mm 0*mm 0*mm";
	    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
	    $detector{"color"}       = "99eeff";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$MAPMT_DX[$type]*mm $MAPMT_DY[$type]*mm $MAPMT_DZ[$type]*mm";
	    $detector{"material"}    = "Component";

	    print_det(\%configuration, \%detector);

	    my $PMTcase_DX = $MAPMT_DX[$type] - 0.2;
	    my $PMTcase_DY = $MAPMT_DY[$type] - 0.2;
	    my $PMTcase_DZ = $MAPMT_DZ[$type] + 5;

	    %detector = init_det();
#	    $detector{"name"}        = "AAt_PMT_case";
	    $detector{"name"}        = "AAt_PMT_case_$padnumber.$sector";
	    $detector{"mother"}      = "$MAPMT_name[$type]_$padnumber.$sector";
	    $detector{"description"} = "Case for PMT";
	    $detector{"pos"}         = "0*mm 0*mm 0*mm";
	    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
	    $detector{"color"}       = "99eeff";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$PMTcase_DX*mm $PMTcase_DY*mm $PMTcase_DZ*mm";
#             $detector{"material"}    = "Gas_inGap";
	    $detector{"material"}    = "Component";

	    print_det(\%configuration, \%detector);

	    %detector = init_det();
	    $detector{"name"}        = "AAu_PMT_case_$padnumber.$sector";
	    $detector{"mother"}      = "$MAPMT_name[$type]_$padnumber.$sector";
	    $detector{"description"} = "Case for PMT";
	    $detector{"pos"}         = "0*mm 0*mm 0*mm";
	    $detector{"rotation"}    = "0*deg 0*deg 0*deg";

	    $detector{"color"}       = "99eeff";
	    $detector{"type"}        = "Operation: AAs_PMT_case_$padnumber.$sector - AAt_PMT_case_$padnumber.$sector";
	    $detector{"dimensions"}  = "0";
	    $detector{"material"}    = "Aluminum";
	    $detector{"style"}       = 1;
	    print_det(\%configuration, \%detector);

	    my $PhWindow_X = 0.0;
	    my $PhWindow_Y = 0.0;
	    my $PhWindow_Z = -$MAPMT_DZ[$type] + $PhWindow_DZ;

	    %detector = init_det();
	    $detector{"name"}        = "PhWindow_$padnumber.$sector";
	    $detector{"mother"}      = "$MAPMT_name[$type]_$padnumber.$sector";
	    $detector{"description"} = "PMT Glass window";
	    $detector{"pos"}         = "$PhWindow_X*mm $PhWindow_Y*mm $PhWindow_Z*mm";
	    $detector{"rotation"}    = "0.*deg 0.*deg 0.*deg";
	    $detector{"color"}       = "004000";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$PMTcase_DX*mm $PMTcase_DY*mm $PhWindow_DZ*mm";
#	    $detector{"material"}    = "Glass_H8500";
	    $detector{"material"}    = "Glass";
	    $detector{"style"}       = 1;
	    print_det(\%configuration, \%detector);
  
		if($configuration{"verbosity"} eq "2")
		{
		    print "---> Generate PhCathode for $MAPMT_name[$type]_$padnumber \n";
		}
		my $PhCath_X   = 0;
	    my $PhCath_Y   = 0;
	    my $PhCath_Z   = $PhWindow_Z + $PhWindow_DZ + 1.05 * $PhCath_DZ;
  
	    %detector = init_det();
	    $detector{"name"}        = "PhCath_$padnumber.$sector";
	    $detector{"mother"}      = "$MAPMT_name[$type]_$padnumber.$sector";
	    $detector{"description"} = "Bialkali Photo Cathode";
	    $detector{"pos"}         = "${PhCath_X}*mm ${PhCath_Y}*mm ${PhCath_Z}*mm";
	    $detector{"rotation"}    = "0.*deg 0.*deg 0.*deg";
	    #$detector{"color"}       = "${MAPMT_color[$type]}";
	    $detector{"color"}       = "000200";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$PhCath_DX[$type]*mm $PhCath_DY[$type]*mm $PhCath_DZ*mm";
	    $detector{"material"}    = "Gas_inGap";
	    $detector{"style"}       = 1;
#	    $detector{"sensitivity"} = "RICH";
#	    $detector{"hit_type"}    = "RICH"; 
	    $detector{"identifiers"} = "sector manual $sector pad manual $padnumber pixel manual 1";
	    print_det(\%configuration, \%detector);
  
		if($configuration{"verbosity"} eq "2")
		{
	    	print "---> Generate PMT Socket for $MAPMT_name[$type]_$padnumber \n";
		}
		my $PMTSocket_DZ = 1.0;

	    my $PMTSocket_X = 0.0;
	    my $PMTSocket_Y = 0.0;
	    my $PMTSocket_Z = 0.0;

	    %detector = init_det();
	    $detector{"name"}        = "PMTSocket_$padnumber.$sector";
	    $detector{"mother"}      = "$MAPMT_name[$type]_$padnumber.$sector";
	    $detector{"description"} = "PMT Socket";
	    $detector{"pos"}         = "$PMTSocket_X*mm $PMTSocket_Y*mm $PMTSocket_Z*mm";
	    $detector{"rotation"}    = "0.*deg 0.*deg 0.*deg";
	    $detector{"color"}       = "005000";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$PMTcase_DX*mm $PMTcase_DY*mm $PMTSocket_DZ*mm";
	    $detector{"material"}    = "G4_Cu";
	    $detector{"style"}       = 1;
	    print_det(\%configuration, \%detector);
#        }

	    $iy++;

	    $MAPMT_X += 2*($MAPMT_DX[$type] + $MAPMT_DXSPACE[$type]);
	}
	$MAPMT_Y += 2*($MAPMT_DY[$type] + $MAPMT_DYSPACE[$type]);
    }

    print "$iy pads in total\n";

}


1;
