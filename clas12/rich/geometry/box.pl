use strict;
use warnings;

our %configuration;
our %parameters;

my $rmin      = 1;
my $rmax      = 1000000;

my %detector = ();    # hash (map) that defines the gemc detector
$detector{"rmin"} = $rmin;
$detector{"rmax"} = $rmax;

my $RAD=180/3.1415927;


my $RichBox_dz    = $parameters{"par_RichBox_dz"};
my $RichBox_dz_new = $parameters{"par_RichBox_dz"}*sin( 65/$RAD );
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

my $SteelPlate_y    = $parameters{"par_SteelPlate_y"};

my $RichBox_dy1_tot = $RichBox_dy1 + $SteelPlate_y ;
my $RichBox_dy2_tot = $RichBox_dy2 + $SteelPlate_y ;

my $RichOuterBox_dz    = $RichBox_dz      + 1.0 ;
my $RichOuterBox_th    = $RichBox_th            ;
my $RichOuterBox_ph    = $RichBox_ph            ;
my $RichOuterBox_dx1   = $RichBox_dx1     + 1.0 ;
my $RichOuterBox_dx2   = $RichBox_dx2     + 1.0 ;
my $RichOuterBox_dx3   = $RichBox_dx3     + 1.0 ;
my $RichOuterBox_dx4   = $RichBox_dx4     + 1.0 ;
my $RichOuterBox_dy1   = $RichBox_dy1_tot + 1.0 ;
my $RichOuterBox_dy2   = $RichBox_dy2_tot + 1.0 ;
my $RichOuterBox_alp1  = $RichBox_alp1    + 0.0 ;
my $RichOuterBox_alp2  = $RichBox_alp2    + 0.0 ;
my $RichOuterBox_x     = $RichBox_x       + 0.0 ;
my $RichOuterBox_y     = $RichBox_y       + 0.0 ;
my $RichOuterBox_z     = $RichBox_z       + 0.0 ;

require "./utils.pl";

sub build_rich_box
{
	my $sector = shift;

=begin GHOSTCODE

	# outer box
	my %detector = init_det();
	$detector{"name"}        = "rich_outer_box.$sector";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "RICH Outer container $sector";
#	$detector{"pos"}         = rich_box_pos($sector);
#	$detector{"rotation"}    = rich_box_rot($sector);
	$detector{"color"}       = "0077b3";
	$detector{"type"}        = "G4Trap";
	$detector{"dimensions"}  = "$RichOuterBox_dz*mm $RichOuterBox_th*deg $RichOuterBox_ph*deg $RichOuterBox_dy1*mm $RichOuterBox_dx1*mm $RichOuterBox_dx2*mm $RichOuterBox_alp1*deg $RichOuterBox_dy2*mm $RichOuterBox_dx3*mm $RichOuterBox_dx4*mm $RichOuterBox_alp2*deg";
	$detector{"material"}    = "Component";

	print_det(\%configuration, \%detector);

	%detector = init_det();
	$detector{"name"}        = "rich_inner_box.$sector";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "RICH sector $sector";
#	$detector{"pos"}         = rich_box_pos($sector);
#	$detector{"rotation"}    = rich_box_rot($sector);
	$detector{"color"}       = "0077b3";
	$detector{"type"}        = "G4Trap";
	$detector{"dimensions"}  = "$RichBox_dz*mm $RichBox_th*deg $RichBox_ph*deg $RichBox_dy1_tot*mm $RichBox_dx1*mm $RichBox_dx2*mm $RichBox_alp1*deg $RichBox_dy2_tot*mm $RichBox_dx3*mm $RichBox_dx4*mm $RichBox_alp2*deg";
	$detector{"material"}    = "Component";

	print_det(\%configuration, \%detector);

	%detector = init_det();
	$detector{"name"}        = "rich_box.$sector";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "RICH sector $sector";
	$detector{"pos"}         = rich_box_pos($sector);
#	$detector{"rotation"}    = "0*mm 0*mm 0*mm";
	$detector{"rotation"}    = rich_box_rot($sector);
	$detector{"color"}       = "0077b3";
	$detector{"type"}        = "Operation: rich_outer_box.$sector * rich_inner_box.$sector";
	$detector{"dimensions"}  = "0";
#	$detector{"type"}        = "G4Trap";
#	$detector{"dimensions"}  = "$RichBox_dz*mm $RichBox_th*deg $RichBox_ph*deg $RichBox_dy1_tot*mm $RichBox_dx1*mm $RichBox_dx2*mm $RichBox_alp1*deg $RichBox_dy2_tot*mm $RichBox_dx3*mm $RichBox_dx4*mm $RichBox_alp2*deg";
	$detector{"material"}    = "G4_AIR";

	print_det(\%configuration, \%detector);
=end GHOSTCODE

=cut

	%detector = init_det();
	$detector{"name"}        = "rich_box.$sector";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "RICH sector $sector";
	$detector{"pos"}         = rich_box_pos($sector);
	$detector{"rotation"}    = rich_box_rot($sector);
	$detector{"color"}       = "0077b3";
	$detector{"type"}        = "G4Trap";
#	$detector{"dimensions"}  = "$RichBox_dz_new*mm $RichBox_th*deg $RichBox_ph*deg $RichBox_dy1_tot*mm $RichBox_dx1*mm $RichBox_dx2*mm $RichBox_alp1*deg $RichBox_dy2_tot*mm $RichBox_dx3*mm $RichBox_dx4*mm $RichBox_alp2*deg";
	$detector{"dimensions"}  = "$RichBox_dz*mm $RichBox_th*deg $RichBox_ph*deg $RichBox_dy1_tot*mm $RichBox_dx1*mm $RichBox_dx2*mm $RichBox_alp1*deg $RichBox_dy2_tot*mm $RichBox_dx3*mm $RichBox_dx4*mm $RichBox_alp2*deg";
#	$detector{"dimensions"}  = "$RichBox_dz*mm $RichBox_th*deg $RichBox_ph*deg $RichBox_dy1_tot*mm $RichBox_dx1*mm $RichBox_dx2*mm $RichBox_alp1*deg $RichBox_dy2_tot*mm $RichBox_dx3*mm $RichBox_dx4*mm $RichBox_alp2*deg";
	$detector{"material"}    = "Gas_inGap";

	print_det(\%configuration, \%detector);


}


1;

