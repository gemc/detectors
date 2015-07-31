use strict;
use warnings;

our %configuration;
our %parameters;

my $rmin      = 1;
my $rmax      = 1000000;

my %detector = ();    # hash (map) that defines the gemc detector
$detector{"rmin"} = $rmin;
$detector{"rmax"} = $rmax;

#################################################################
# All dimensions are in mm
# check component colors
#################################################################

my $RAD=180/3.1415927;

######################################################
#  RICH BOX:  detector mother volume
#  (G4Trap Volume)
######################################################
#                 x2 
#  __________|___________  
# \          |          /  
#  \      dy1|         /   
#   \        |B = barycenter        
#    --------|-------/      
#  yb \      |      /
#      \     |     /  alfa = opening angle
#       \___ |____/_)____            
#     y0 \   | x1/      
#         \  |  /
#          \ | /
#           \|/
#            C = center
#####################################################


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

require "./utils.pl";

sub build_rich_box
{
	my $sector = shift;

	my %detector = init_det();
	$detector{"name"}        = "rich_box.$sector";
	$detector{"mother"}      = "root";
	$detector{"description"} = "RICH sector $sector";
	$detector{"pos"}         = rich_box_pos($sector);
#	$detector{"pos"}         = "${RichBox_x}*mm ${RichBox_y}*mm ${RichBox_z}*mm";
#	$detector{"rotation"}    = "$RichBox_the*deg $RichBox_phi*deg $RichBox_psi*deg";
	$detector{"rotation"}    = rich_box_rot($sector);
	$detector{"color"}       = "af4035";
	$detector{"type"}        = "G4Trap";
	$detector{"dimensions"}  = "$RichBox_dz*mm $RichBox_th*deg $RichBox_ph*deg $RichBox_dy1*mm $RichBox_dx1*mm $RichBox_dx2*mm $RichBox_alp1*deg $RichBox_dy2*mm $RichBox_dx3*mm $RichBox_dx4*mm $RichBox_alp2*deg";
	$detector{"material"}    = "G4_AIR";

	print_det(\%configuration, \%detector);
}


1;

