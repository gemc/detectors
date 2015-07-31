use strict;
use warnings;

our %configuration;
our %parameters;


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

my $iy=0;


sub build_box_mirror
{

    my $sector = shift;

    my %detector = init_det();

    $detector{"name"}        = "ACi_rich_boxmirror.$sector";
    $detector{"mother"}      = "rich_box.$sector";
    $detector{"description"} = "Box of mirrors";
    $detector{"type"}        = "G4Trap";
    $detector{"dimensions"}  = "$RichBox_dz*mm $RichBox_th*deg $RichBox_ph*deg $RichBox_dy1*mm $RichBox_dx1*mm $RichBox_dx2*mm $RichBox_alp1*deg $RichBox_dy2*mm $RichBox_dx3*mm $RichBox_dx4*mm $RichBox_alp2*deg";
#  $detector{"material"}    = "Gas_inGap";
    $detector{"material"}    = "Component";
 
    print_det(\%configuration, \%detector);

    %detector = init_det();
    $detector{"name"}        = "ACj_rich_boxmirror.$sector";
    $detector{"mother"}      = "rich_box.$sector";
    $detector{"description"} = "Box of mirrors";
    $detector{"type"}        = "G4Trap";
    $detector{"dimensions"}  = "$RichGap_dz*mm $RichBox_th*deg $RichBox_ph*deg $RichGap_dy1*mm $RichGap_dx1*mm $RichGap_dx2*mm $RichBox_alp1*deg $RichGap_dy2*mm $RichGap_dx3*mm $RichGap_dx4*mm $RichBox_alp2*deg";
#  $detector{"material"}    = "Gas_inGap";
    $detector{"material"}    = "Component";
    print_det(\%configuration, \%detector);

    %detector = init_det();
    $detector{"name"}        = "rich_boxmirror.$sector";
    $detector{"mother"}      = "rich_box.$sector";
    $detector{"description"} = "Box of mirrors";
    $detector{"type"}        = "Operation: ACi_rich_boxmirror.$sector - ACj_rich_boxmirror.$sector";
    $detector{"dimensions"}  = "0";
    $detector{"material"}    = "G4_AIR";
#    $detector{"material"}    = "Gas_inGap"; It was gasingap!
    print_det(\%configuration, \%detector);

}




1;
