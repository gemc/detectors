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

my $RichGap_dz    = $parameters{"par_RichGap_dz"};
my $RichGap_dx1   = $parameters{"par_RichGap_dx1"};
my $RichGap_dx2   = $parameters{"par_RichGap_dx2"};
my $RichGap_dx3   = $parameters{"par_RichGap_dx3"};
my $RichGap_dx4   = $parameters{"par_RichGap_dx4"};
my $RichGap_dy1   = $parameters{"par_RichGap_dy1"};
my $RichGap_dy2   = $parameters{"par_RichGap_dy2"};
my $RichBox_th    = $parameters{"par_RichBox_th"};
my $RichBox_ph    = $parameters{"par_RichBox_ph"};
my $RichBox_alp1  = $parameters{"par_RichBox_alp1"};
my $RichBox_alp2  = $parameters{"par_RichBox_alp2"};
my $RichBox_dx1   = $parameters{"par_RichBox_dx1"};
my $RichBox_dx2   = $parameters{"par_RichBox_dx2"};
my $RichBox_dx3   = $parameters{"par_RichBox_dx3"};
my $RichBox_dx4   = $parameters{"par_RichBox_dx4"};
my $RichBox_dz    = $parameters{"par_RichBox_dz"};
my $RichBox_dy1   = $parameters{"par_RichBox_dy1"};
my $RichBox_dy2   = $parameters{"par_RichBox_dy2"};
my $RichBox_x     = $parameters{"par_RichBox_x"};
my $RichBox_y     = $parameters{"par_RichBox_y"};
my $RichBox_z     = $parameters{"par_RichBox_z"};
my $RichBox_the   = $parameters{"par_RichBox_the"};
my $RichBox_phi   = $parameters{"par_RichBox_phi"};
my $RichBox_psi   = $parameters{"par_RichBox_psi"};

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

my $iy=0;


sub build_rich_radiator
{

    my $sector = shift;

    my $RadiSlice_y       = -$RichGap_dy1 + $AERO_dd[0];

    for(my $n1 = 0; $n1<$AERO_rows; $n1++)
    {

	my $RadiSlice_type    = $AERO_rowtype[$n1];
	my $RadiSlice_wrap    = $AERO_wrap[$n1];

	my $RadiSlice_dd      = $AERO_dd[$RadiSlice_type];
	my $RadiSlice_dz      = $AERO_dz[$RadiSlice_type];
	my $RadiSlice_zoff    = $AERO_zoff[$RadiSlice_type];
	my $RadiSlice_ddspace = $AERO_ddspace[$RadiSlice_type];
	my $RadiSlice_mate    = $AERO_mate[$RadiSlice_type];

	my $RadiSlice_Xma     = ($AERO_yc2 + $RadiSlice_y + $RadiSlice_dd)/$AERO_opa2;  #right line
	my $RadiSlice_Xnum    = $RadiSlice_Xma/2.0/($RadiSlice_dd + $RadiSlice_ddspace);
	my $RadiSlice_num     = int($RadiSlice_Xnum)+1;
	my $RadiSlice_x       = -($RadiSlice_num - 0.5) * 2*($RadiSlice_dd + $RadiSlice_ddspace);

	my $RadiBox_dd        = $RadiSlice_dd+0.05;
	my $RadiBox_dz        = $RadiSlice_dz-0.01;
		
	if($configuration{"verbosity"} eq "2")
	{
		print "AERO offsets  $RadiSlice_type $RadiSlice_y $RadiSlice_Xma $RadiSlice_num  --> $RadiSlice_x \n";
	}
		
	for(my $n2=0; $n2<2*$RadiSlice_num; $n2++)
	{
		if($configuration{"verbosity"} eq "2")
		{
	    	print "       AERO pos  --> $RadiSlice_x $RadiSlice_wrap \n";
		}
		
	    my $m            = $iy+1;

	    my %detector = init_det();

 	    $detector{"name"}        = "ABj_RadiBox_$m.$sector";
	    $detector{"mother"}      = "rich_gap.$sector";
	    $detector{"description"} = "Aerogel Tile Box";
	    $detector{"pos"}         = "0*cm 0*cm 0*cm";
	    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
	    $detector{"color"}       = "af4035";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$RadiBox_dd*mm $RadiBox_dd*mm $RadiBox_dz*mm";
	    $detector{"material"}    = "Component";
	   print_det(\%configuration, \%detector);
 
	    %detector = init_det();
	    $detector{"name"}        = "ABk_RadiVol_$m.$sector";
	    $detector{"mother"}      = "rich_gap.$sector";
	    $detector{"description"} = "Aerogel Tile Volume";
	    $detector{"pos"}         = "0*cm 0*cm 0*cm";
	    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
	    $detector{"color"}       = "af4035";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$RadiSlice_dd*mm $RadiSlice_dd*mm $RadiSlice_dz*mm";
	    $detector{"material"}    = "Component";
	   print_det(\%configuration, \%detector);

#           aerogel tile in the xy-space (to be cutted inside the available space)
	    %detector = init_det();
	    $detector{"name"}        = "ABl_RadiTile_$m.$sector";
	    $detector{"mother"}      = "rich_gap.$sector";
	    $detector{"description"} = "Aerogel Tile";
	    $detector{"pos"}         = "$RadiSlice_x*mm $RadiSlice_y*mm 0*mm";
	    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
	    $detector{"color"}       = "af4035";
#           $detector{"type"}        = "Copyof ABk_RadiVol_$m";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$RadiSlice_dd*mm $RadiSlice_dd*mm $RadiSlice_dz*mm";
	    $detector{"material"}    = "Component";
	   print_det(\%configuration, \%detector);
 
#      aerogel wrap in the xy-space (to be cutted inside the available space)
	    %detector = init_det();
	    $detector{"name"}        = "ABm_RadiWrap_$m.$sector";
	    $detector{"mother"}      = "rich_gap.$sector";
	    $detector{"description"} = "Aerogel Wrap";
	    $detector{"pos"}         = "$RadiSlice_x*mm $RadiSlice_y*mm 0*mm";
	    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
	    $detector{"color"}       = "111000";
	    $detector{"type"}        = "Operation: ABj_RadiBox_$m.$sector - ABk_RadiVol_$m.$sector";
	    $detector{"material"}    = "Component";
#       if($n2==25){$detector{"material"}    = "Air";}
		print_det(\%configuration, \%detector);

	    my $RadiSlice_z    = $PreMirror_z + $PreMirror_dz + $RadiSlice_dz + $RadiSlice_zoff + 1.;
	    my $RadiSlice_y    = $RadiSlice_z * tan($RichBox_th/$RAD);

#      shaped aerogel tile in the 3D-space 
	    %detector = init_det();
	    $detector{"name"}        = "RADIATOR_$m.$sector";
	    $detector{"mother"}      = "rich_gap.$sector";
	    $detector{"description"} = "Aerogel Radiator";
	    $detector{"pos"}         = "0*mm $RadiSlice_y*mm $RadiSlice_z*mm";
	    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
	    $detector{"color"}       = "111000";
	    $detector{"type"}        = "Operation: ABh_AeroVol.$sector * ABl_RadiTile_$m.$sector";
	    $detector{"dimensions"}  = "0";
#           $detector{"material"}    = "RichAerogel5";
	    $detector{"material"}    = $RadiSlice_mate;
	   print_det(\%configuration, \%detector);

#      shaped aerogel wrap in the 3D-space 
	    %detector = init_det();
	    $detector{"name"}        = "RADWRAP_$m.$sector";
	    $detector{"mother"}      = "rich_gap.$sector";
	    $detector{"description"} = "Aerogel Wrap";
	    $detector{"pos"}         = "0*mm $RadiSlice_y*mm $RadiSlice_z*mm";
	    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
	    $detector{"color"}       = "111000";
	    $detector{"type"}        = "Operation: ABh_AeroVol.$sector * ABm_RadiWrap_$m.$sector";
	    $detector{"dimensions"}  = "0";
	    $detector{"material"}    = "G4_AIR";
	    $detector{"style"}       = 1;

#      do not consider a small corner which causes volume operation crash
	    if($RadiSlice_wrap > 0 )
		{
			print_det(\%configuration, \%detector);
	    }
    
	    $iy++;

	    $RadiSlice_x += 2*($RadiSlice_dd + $RadiSlice_ddspace);
	}

	$RadiSlice_y += 2*($RadiSlice_dd + $RadiSlice_ddspace);
    }

#    print_det(\%configuration, \%detector);

}



1;
