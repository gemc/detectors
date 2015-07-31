use strict;
use warnings;

our %configuration;
our %parameters;

######################################################
#  RICH GAP:  inner gap for components 
#  (G4Trap Volume)
######################################################

my $RAD=180/3.1415927;

my $mirror_y0         = -919.816 - 0. * sin(25.0/$RAD);
my $PostPlane_dz    = 1.0;
my $mirror_z0         = -3478.748 - 2 * $PostPlane_dz - 0.0 * cos(25.0/$RAD) ;  #base

my @AERO_dz       = ( 10., 10., 30.);

my $RichGap_dz   = $parameters{"par_RichGap_dz"};
my $RichGap_dx1  = $parameters{"par_RichGap_dx1"};
my $RichGap_dx2  = $parameters{"par_RichGap_dx2"};
my $RichGap_dx3  = $parameters{"par_RichGap_dx3"};
my $RichGap_dx4  = $parameters{"par_RichGap_dx4"};
my $RichGap_dy1  = $parameters{"par_RichGap_dy1"};
my $RichGap_dy2  = $parameters{"par_RichGap_dy2"};
my $RichBox_th   = $parameters{"par_RichBox_th"};
my $RichBox_ph   = $parameters{"par_RichBox_ph"};
my $RichBox_alp1 = $parameters{"par_RichBox_alp1"};
my $RichBox_alp2 = $parameters{"par_RichBox_alp2"};


my $RichGap_opa1  =  2*$RichGap_dy1/($RichGap_dx2-$RichGap_dx1);     # opening angle
my $RichGap_yc1   =  $RichGap_opa1*($RichGap_dx1+$RichGap_dx2)/2.;   # barycenter height with respect the beam axis
# rear window 
my $RichGap_opa2  =  2*$RichGap_dy2/($RichGap_dx4-$RichGap_dx3);     # rear window tg(alfa)
#my $RichGap_yc2   =  $RichGap_opa2*($RichGap_dx3+$RichGap_dx4)/2.+$RichGap_dz*tan($RichBox_th/$RAD);    barycenter height with respect the beam axis
my $RichGap_yc2   =  $RichGap_opa2*($RichGap_dx3+$RichGap_dx4)/2.;  # barycenter height with respect the beam axis
my $RichGap_yb1   =  $RichGap_yc1 - $RichGap_dy1;                    # bottom level with respect the beam axis
my $RichGap_yb2   =  $RichGap_yc2 - $RichGap_dy2;                    # bottom level with respect the beam axis

my $CutGap_roof =   1.0;
my $CutGap_fr   =   ($CutGap_roof-1.+2*0.672)/2.;

my $CutGap_th   =  $RichBox_th;
my $CutGap_ph   =  $RichBox_ph;

my $CutGap_dy1  =  $RichGap_dy1*($CutGap_fr);
my $CutGap_dy2  =  $RichGap_dy2*($CutGap_fr);

my $CutGap_yc1  =  $RichGap_yb1+$RichGap_dy1*(1+$CutGap_roof)-$CutGap_dy1;
my $CutGap_yc2  =  $RichGap_yb2+$RichGap_dy2*(1+$CutGap_roof)-$CutGap_dy2;
my $CutGap_dx1  =  ($CutGap_yc1 - $CutGap_dy1)/$RichGap_opa1*0.98; 
my $CutGap_dx2  =  ($CutGap_yc1 + $CutGap_dy1)/$RichGap_opa1*0.98; 
my $CutGap_dx3  =  ($CutGap_yc2 - $CutGap_dy2)/$RichGap_opa2*0.98; 
my $CutGap_dx4  =  ($CutGap_yc2 + $CutGap_dy2)/$RichGap_opa2*0.98; 

# it was as below, but there is not component 3 initialized
#my $CutGap_dz   =  $RichGap_dz-$AERO_dz[3];
my $CutGap_dz   =  $RichGap_dz-$AERO_dz[2];

#my $CutGap_y   =  +($RichGap_dy1+$RichGap_dy2)/2.*$CutGap_roof-($CutGap_dy1+$CutGap_dy2)/2.;
#my $CutGap_z   =  $AERO_dz[3];
my $CutGap_y0   =  +($RichGap_dy1+$RichGap_dy2)/2.*$CutGap_roof-($CutGap_dy1+$CutGap_dy2)/2.-$mirror_y0;
# it was as below, but there is not component 3 initialized
#my $CutGap_z0   =  $AERO_dz[3]-$mirror_z0;
my $CutGap_z0   =  $AERO_dz[2]-$mirror_z0;
my $CutGap_y    = cos(25./$RAD)*$CutGap_y0+sin(25./$RAD)*$CutGap_z0;
my $CutGap_z    = -sin(25./$RAD)*$CutGap_y0+cos(25./$RAD)*$CutGap_z0;



sub build_rich_cutbox
{

    my $sector = shift;

    my %detector = init_det();
    $detector{"name"}        = "AAo_rich_cutbox.$sector";
    $detector{"mother"}      = "rich_gap.$sector";
    $detector{"description"} = "Box used to cut the mirrors";
    $detector{"pos"}         = "0*mm 0*mm 0*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       = "ffffff";
    $detector{"type"}        = "Box";
    $detector{"dimensions"}  = "10000*mm 10000*mm 10000*mm";
# $detector{"material"}    = "Gas_inGap";
    $detector{"material"}    = "Component";

    print_det(\%configuration, \%detector);
}

sub build_rich_cutgap
{

    my $sector = shift;

    my %detector = init_det();
    $detector{"name"}        = "AAp_rich_cutgap.$sector";
    $detector{"mother"}      = "rich_gap.$sector";
    $detector{"description"} = "Box for cut";
    $detector{"pos"}         = "0*mm $CutGap_y*mm $CutGap_z*mm";
    $detector{"rotation"}    = "25*deg 0*deg 0*deg";
    $detector{"color"}       = "008000";
    $detector{"type"}        = "G4Trap";
    $detector{"dimensions"}  = "$CutGap_dz*mm $CutGap_th*deg $CutGap_ph*deg $CutGap_dy1*mm $CutGap_dx1*mm $CutGap_dx2*mm $RichBox_alp1*deg $CutGap_dy2*mm $CutGap_dx3*mm $CutGap_dx4*mm $RichBox_alp2*deg";
#  $detector{"material"}    = "Gas_inGap";
    $detector{"material"}    = "Component";

    print_det(\%configuration, \%detector);

}

sub build_rich_cut
{

    my $sector = shift;

    my %detector = init_det();

    $detector{"name"}        = "AAq_rich_cut.$sector";
    $detector{"mother"}      = "rich_box.$sector";
    $detector{"description"} = "Open space for mirrors";
    $detector{"pos"}         = "0*mm 0*mm 0*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       = "008000";
    $detector{"type"}        = "Operation: AAo_rich_cutbox.$sector - AAp_rich_cutgap.$sector";
    $detector{"dimensions"}  = "0";
#  $detector{"material"}    = "Gas_inGap";
    $detector{"material"}    = "Component";

    print_det(\%configuration, \%detector);

}



1;
