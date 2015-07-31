use strict;
use warnings;

our %configuration;
our %parameters;

######################################################
#  RICH GAP:  inner gap for components 
#  (G4Trap Volume)
######################################################

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

sub build_rich_gap
{

    my $sector = shift;

    my %detector = init_det();
    $detector{"name"}        = "rich_gap.$sector";
    $detector{"mother"}      = "rich_box.$sector";
    $detector{"description"} = "RICH Gap";
    $detector{"pos"}         = "0*mm 0*mm 0*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       = "af4035";
    $detector{"type"}        = "G4Trap";
    $detector{"dimensions"}  = "$RichGap_dz*mm $RichBox_th*deg $RichBox_ph*deg $RichGap_dy1*mm $RichGap_dx1*mm $RichGap_dx2*mm $RichBox_alp1*deg $RichGap_dy2*mm $RichGap_dx3*mm $RichGap_dx4*mm $RichBox_alp2*deg";
    $detector{"material"}    = "G4_AIR";
#    $detector{"material"}    = "Gas_inGap";

  print_det(\%configuration, \%detector);
}



1;
