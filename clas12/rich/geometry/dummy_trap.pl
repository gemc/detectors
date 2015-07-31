use strict;
use warnings;

our %configuration;
our %parameters;

my $RichBox_th    = $parameters{"par_RichBox_th"};
my $RichBox_ph    = $parameters{"par_RichBox_ph"};
my $RichBox_alp1  = $parameters{"par_RichBox_alp1"};
my $RichBox_alp2  = $parameters{"par_RichBox_alp2"};

my $trapp_dz      =$parameters{"par_trapp_dz"};
my $trapp_dx1     =$parameters{"par_trapp_dx1"};
my $trapp_dx2     =$parameters{"par_trapp_dx2"};
my $trapp_dx3     =$parameters{"par_trapp_dx3"};
my $trapp_dx4     =$parameters{"par_trapp_dx4"};
my $trapp_dy1     =$parameters{"par_trapp_dy1"};
my $trapp_dy2     =$parameters{"par_trapp_dy2"};


sub build_dummy_trap
{

    my $sector = shift;

    my %detector = init_det();
    $detector{"name"}        = "dummy_trap.$sector";
    $detector{"mother"}      = "rich_gap.$sector";
    $detector{"description"} = "G4Trap to check specific volumes";
    $detector{"pos"}         = "0*mm 0*mm 0*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       = "af4035";
    $detector{"type"}        = "G4Trap";
    $detector{"dimensions"}  = "$trapp_dz*mm $RichBox_th*deg $RichBox_ph*deg $trapp_dy1*mm $trapp_dx1*mm $trapp_dx2*mm $RichBox_alp1*deg $trapp_dy2*mm $trapp_dx3*mm $trapp_dx4*mm $RichBox_alp2*deg";
    $detector{"material"}    = "G4_AIR";
    $detector{"visible"}     = 0;
    $detector{"style"}       = 1;
    print_det(\%configuration, \%detector);
}



1;
