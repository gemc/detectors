use strict;
use warnings;

our %configuration;
our %parameters;


# RICH parameters
# all dimensions are in inches

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

# calculate paddles position, dimensions, titles based on parameters

sub rich_box_pos
{
	my $sector = shift;

	# projection into the xy plane
	my $phi = ($sector -1)*60;
	my $r = sqrt( $RichBox_x* $RichBox_x + $RichBox_y*$RichBox_y) ;
	my $x = $r*cos(rad($phi));
	my $y = $r*sin(rad($phi));
	my $z = $RichBox_z;

	print "phi, x, y, z are $phi $x $y $z \n";

	return "$x*mm $y*mm $z*mm";
}

sub rich_box_rot
{
	my $sector = shift;

	# projection into the xy plane
	my $phi = $RichBox_phi ;
	my $the = $RichBox_the*( -1 )**($sector + 1) ;
	my $psi = $RichBox_psi + ($sector -1)*60;

	my $tilt  = fstr($RichBox_the);
	my $zrot  = -($sector-1)*60 + 90;

#	print "phi, the, psi are $phi $the $psi \n";

	return "ordered: zxy $zrot*deg $tilt*deg 0*deg ";

#	return "$phi*deg $the*deg $psi*deg";
}

#sub panel_1b_pos
#{
#	my $sector = shift;

	# projection into the xy plane
#	my $panel1b_pos_xy = $panel1b_xpos[0] + $panel1b_dz*cos(rad($tilt_p1b));
#	my $phi = ($sector - 1)*60;
#	my $x = fstr($panel1b_pos_xy*cos(rad($phi)));
#	my $y = fstr($panel1b_pos_xy*sin(rad($phi)));
	
#	my $panel1b_pos_z = fstr($panel1b_zpos[0] - $panel1b_dz*sin(rad($tilt_p1b)));
	
#	return "$x*inches $y*inches $panel1b_pos_z*inches";

#}


1;
