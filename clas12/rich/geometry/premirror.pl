use strict;
use warnings;

our %configuration;
our %parameters;


my $RAD=180/3.1415927;

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
my $RichBox_y    = $parameters{"par_RichBox_y"};

# reference points of entrance window 
my $RichGap_opa1  =  2*$RichGap_dy1/($RichGap_dx2-$RichGap_dx1);     # opening angle
my $RichGap_yc1   =  $RichGap_opa1*($RichGap_dx1+$RichGap_dx2)/2.;   # barycenter height with respect the beam axis
my $RichGap_yb1   =  $RichGap_yc1 - $RichGap_dy1;                    # bottom level with respect the beam axis
# rear window 
my $RichGap_opa2  =  2*$RichGap_dy2/($RichGap_dx4-$RichGap_dx3);     # rear window tg(alfa)
#my $RichGap_yc2   =  $RichGap_opa2*($RichGap_dx3+$RichGap_dx4)/2.+$RichGap_dz*tan($RichBox_th/$RAD);    barycenter height with respect the beam axis
my $RichGap_yc2   =  $RichGap_opa2*($RichGap_dx3+$RichGap_dx4)/2.;  # barycenter height with respect the beam axis
my $RichGap_yb2   =  $RichGap_yc2 - $RichGap_dy2;                    # bottom level with respect the beam axis

print "Rich offsets  $RichGap_opa1 $RichGap_yc1 $RichGap_yb1 $RichBox_y \n";
print "Rich offsets  $RichGap_opa2 $RichGap_yc2 $RichGap_yb2 $RichBox_y\n";

######################################################
#  PREMIRROR:  plane mirror at the RICH entrance window
#  (G4Trap Volume)
######################################################

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

sub build_rich_premirror
{

    my $sector = shift;

    my %detector = init_det();
    $detector{"name"}        = "EntranceW.$sector";
    $detector{"mother"}      = "rich_gap.$sector";
    $detector{"description"} = "Entrance Window";
    $detector{"pos"}         = "${PreMirror_x}*mm ${PreMirror_carbon_y}*mm ${PreMirror_carbon_z}*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       =  "772200";
    $detector{"type"}        = "G4Trap";
    $detector{"dimensions"}  = "$PreMirror_carbon_dz*mm $PreMirror_th*deg $PreMirror_ph*deg $PreMirror_dy1*mm $PreMirror_dx1*mm $PreMirror_dx2*mm $PreMirror_alp1*deg $PreMirror_dy2*mm $PreMirror_dx3*mm $PreMirror_dx4*mm $PreMirror_alp2*deg";
    $detector{"material"}    = "CarbonFiber";
    $detector{"style"}       = 1;
    print_det(\%configuration, \%detector);

    %detector = init_det();
    $detector{"name"}        = "PREMIRROR.$sector";
    $detector{"mother"}      = "rich_gap.$sector";
    $detector{"description"} = "Secondary mirror";
    $detector{"pos"}         = "${PreMirror_x}*mm ${PreMirror_glass_y}*mm ${PreMirror_glass_z}*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       = "99eeff";
    $detector{"type"}        = "G4Trap";
    $detector{"dimensions"}  = "$PreMirror_glass_dz*mm $PreMirror_th*deg $PreMirror_ph*deg $PreMirror_dy1*mm $PreMirror_dx1*mm $PreMirror_dx2*mm $PreMirror_alp1*deg $PreMirror_dy2*mm $PreMirror_dx3*mm $PreMirror_dx4*mm $PreMirror_alp2*deg";
    $detector{"material"}    = "G4_AIR";
    $detector{"style"}       = 1;
    print_det(\%configuration, \%detector);

    %detector = init_det();
    $detector{"name"}        = "ABg_AeroBox.$sector";
    $detector{"mother"}      = "rich_gap.$sector";
    $detector{"description"} = "Aerogel box";
    $detector{"pos"}         = "${PreMirror_x}*mm ${PreMirror_aero_y}*mm ${PreMirror_aero_z}*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       = "af4035";
    $detector{"type"}        = "G4Trap";
    $detector{"dimensions"}  = "$PreMirror_aero_dz*mm $PreMirror_th*deg $PreMirror_ph*deg $PreMirror_dy1*mm $PreMirror_dx1*mm $PreMirror_dx2*mm $PreMirror_alp1*deg $PreMirror_dy2*mm $PreMirror_dx3*mm $PreMirror_dx4*mm $PreMirror_alp2*deg";
#  $detector{"material"}    = "Air";
    $detector{"material"}    = "Component";
    print_det(\%configuration, \%detector);

    %detector = init_det();
    $detector{"name"}        = "ABh_AeroVol.$sector";
    $detector{"mother"}      = "rich_gap.$sector";
    $detector{"description"} = "Aerogel volume";
#  $detector{"pos"}         = "${PreMirror_x}*mm ${PreMirror_aero_y}*mm ${PreMirror_aero_z}*mm";
    $detector{"pos"}         = "0*cm 0*cm 0*cm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       = "af4035";
    $detector{"type"}        = "G4Trap";
    $detector{"dimensions"}  = "$PreMirror_aerovol_dz*mm $PreMirror_th*deg $PreMirror_ph*deg $AERO_dy1*mm $AERO_dx1*mm $AERO_dx2*mm $PreMirror_alp1*deg $AERO_dy2*mm $AERO_dx3*mm $AERO_dx4*mm $PreMirror_alp2*deg";
#  $detector{"material"}    = "Air";
    $detector{"material"}    = "Component";
    print_det(\%configuration, \%detector);


    %detector = init_det();
    $detector{"name"}        = "ABi_AeroWrap.$sector";
    $detector{"mother"}      = "rich_gap.$sector";
    $detector{"description"} = "Aerogel wrap";
#  $detector{"pos"}         = "${PreMirror_x}*mm ${PreMirror_aero_y}*mm ${PreMirror_aero_z}*mm";
    $detector{"pos"}         = "0*cm 0*cm 0*cm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       =  "772200";
 #   $detector{"type"}        = "G4Trap";
    $detector{"type"}        = "Operation: ABg_AeroBox.$sector - ABh_AeroVol.$sector";
#  $detector{"material"}    = "Air";
    $detector{"material"}    = "Component";
 #   $detector{"mfield"}      = "no";
    $detector{"visible"}     = 1;
    $detector{"style"}       = 1;

    print_det(\%configuration, \%detector);

}




1;

