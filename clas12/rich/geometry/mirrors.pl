use strict;
use warnings;

our %configuration;
our %parameters;

######################################################
#  RICH GAP:  inner gap for components 
#  (G4Trap Volume)
######################################################

my $RAD=180/3.1415927;

my $PostPlane_dz  =$parameters{"par_PostPlane_dz"};

my $RichGap_dz   = $parameters{"par_RichGap_dz"};
my $RichGap_dx1  = $parameters{"par_RichGap_dx1"};
my $RichGap_dx2  = $parameters{"par_RichGap_dx2"};
my $RichGap_dx3  = $parameters{"par_RichGap_dx3"};
my $RichGap_dx4  = $parameters{"par_RichGap_dx4"};
my $RichGap_dy1  = $parameters{"par_RichGap_dy1"};
my $RichGap_dy2  = $parameters{"par_RichGap_dy2"};
my $RichBox_th    = $parameters{"par_RichBox_th"};
my $RichBox_ph    = $parameters{"par_RichBox_ph"};
my $RichBox_alp1  = $parameters{"par_RichBox_alp1"};
my $RichBox_alp2  = $parameters{"par_RichBox_alp2"};


######################################################
#  FOCUSING MIRROR:  elliptical mirror reflecting light back
#  (Composite Volume)
######################################################

# None of these components are sensitive.
#$detector{"mfield"}      = "no";
#$detector{"ncopy"}       = 1;
#$detector{"pMany"}       = 1;

#these lines where originally here
#$detector{"exist"}       = 1;
#$detector{"visible"}     = 1;
#$detector{"style"}       = 1;
#$detector{"color"}       = "af4035";

#$detector{"sensitivity"} = "no";
#$detector{"hit_type"}    = "";
#$detector{"identifiers"} = "";


my $number_of_mirrors = 2;
my $mthick  = 1.0;  # mirror is 1mm thick
my $rthick  = 1.0;  # radiator is 10 cm thick

# SEMI Axis
my @axisA   = ( 4000.000 + $mthick  , 4000.000  ,  1786.859   ,  1728.375  );  # Semiaxis A
my @axisB   = ( 4000.000 + $mthick  , 4000.000  ,  1786.859   ,  1728.375  );  # Semiaxis A
my @axisC   = ( 4000.000 + $mthick  , 4000.000  ,  1497.604   ,  1383.621  );  # Semiaxis C

my @axisAv  = ( $axisA[0] - $mthick ,  $axisA[1] - $rthick  ,   $axisA[2]  - $mthick ,  $axisA[3]- $mthick  );  # Semiaxis A thickness
my @axisBv  = ( $axisB[0] - $mthick ,  $axisB[1] - $rthick  ,   $axisB[2]  - $mthick ,  $axisB[3]- $mthick  );  # Semiaxis B thickness
my @axisCv  = ( $axisC[0] - $mthick ,  $axisC[1] - $rthick  ,   $axisC[2]  - $mthick ,  $axisC[3]- $mthick  );  # Semiaxis C thickness


# The first focal point is the target
# The second focal point position is given below (left mirror).
# For an ellipse, the distance between the two focal points is    d = 2 sqrt(a2-b2)
# http://en.wikipedia.org/wiki/Ellipse

# G4 colors
my @mirror_color      = ('99eeff', 'ee99ff', 'ff44ff', 'ffee55');
my @mirror_style      = (1, 0, 0, 0);

# ELLIPTICAL MIRROR
#my $mirror_y0         = -319.06 - 523.;
#my $mirror_z0        = -3765.5 - 2 * $PostPlane_dz + 514/2. + 28.;  #base
# SPHERICAL MIRROR r=4000
my $mirror_y0         = -919.816 - 0. * sin(25./$RAD);
my $mirror_z0         = -3478.748 - 2 * $PostPlane_dz - 0. * cos(25./$RAD) ;  #base
# SPHERICAL MIRROR r=3000
#my $mirror_y0         = -919.816 + 0. * sin(25./$RAD);
#my $mirror_z0         = -3478.748 - 2 * $PostPlane_dz + 1100. * cos(25./$RAD) ;  #base

#my $mirror_z0         = -3811.5;
#my $mirror_z0        = -3751.5;    #base

sub build_rich_mirror_a
{

    my $sector = shift;

    for(my $m = 0; $m < $number_of_mirrors; $m++)
    {

	my $mind                 = $m + 1;

	my %detector = init_det();

	$detector{"name"}        = "AAl_rich_mirror$mind.$sector";
	$detector{"mother"}      = "rich_gap.$sector";
	$detector{"description"} = "High Threshold Cerenkov Mirror $mind - Ellipsoid part 1";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = $mirror_color[$m];
	$detector{"type"}        = "Ellipsoid";
	$detector{"dimensions"}  = "$axisA[$m]*mm $axisB[$m]*mm $axisC[$m]*mm 0*mm 0*mm";
#    $detector{"material"}    = "Gas_inGap";
	$detector{"material"}    = "Component";
	print_det(\%configuration, \%detector);


    }
}


sub build_rich_mirror_b
{

    my $sector = shift;

    for(my $m = 0; $m < $number_of_mirrors; $m++)
    {

	my $mind                 = $m + 1;

	my %detector = init_det();

	$detector{"name"}        = "AAm_rich_mirror$mind.$sector";
	$detector{"mother"}      = "rich_gap.$sector";
	$detector{"description"} = "High Threshold Cerenkov Mirror $mind - Ellipsoid part 2";
	$detector{"pos"}         = "0*mm 0*mm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = $mirror_color[$m];
	$detector{"type"}        = "Ellipsoid";
	$detector{"dimensions"}  = "$axisAv[$m]*mm $axisBv[$m]*mm $axisCv[$m]*mm 0*mm 0*mm";
#    $detector{"material"}    = "Gas_inGap";
	$detector{"material"}    = "Component";
	print_det(\%configuration, \%detector);

    }
}

sub build_rich_mirror_c
{

    my $sector = shift;

    for(my $m = 0; $m < $number_of_mirrors; $m++)

    {

	my $mind                 = $m + 1;

	my %detector = init_det();

	$detector{"name"}        = "AAn_rich_mirror$mind.$sector";
	$detector{"mother"}      = "rich_gap.$sector";
	$detector{"description"} = "High Threshold Cerenkov Mirror $mind - Ellipsoid part1 - part2";
	$detector{"pos"}         = "0*mm $mirror_y0*mm $mirror_z0*mm"; 
	$detector{"rotation"}    = "-25*deg 0*deg 0*deg";
	$detector{"color"}       = $mirror_color[$m];
	$detector{"type"}        = "Operation: AAl_rich_mirror$mind.$sector - AAm_rich_mirror$mind.$sector";
	$detector{"dimensions"}  = "0";
	$detector{"style"}       = "0";
#    $detector{"material"}    = "Gas_inGap";
	$detector{"material"}    = "Component";
	print_det(\%configuration, \%detector);

   }
}


sub build_rich_mirror
{

    my $sector = shift;

    #for(my $m = 0; $m < $number_of_mirrors; $m++)
    for(my $m = 0; $m < 1; $m++)
    {

	my $mind                 = $m + 1;

	my %detector = init_det();

	$detector{"name"}        = "rich_mirror$mind.$sector";
	$detector{"mother"}      = "rich_gap.$sector";
	$detector{"description"} = "High Threshold Cerenkov Mirror $mind - Ellipsoid part1 - part2";
	$detector{"pos"}         = "0*mm $mirror_y0*mm $mirror_z0*mm";  # shift per zona morta
	$detector{"rotation"}    = "-25*deg 0*deg 0*deg";
	$detector{"color"}       = $mirror_color[$m];
	$detector{"type"}        = "Operation: AAn_rich_mirror$mind.$sector - AAq_rich_cut.$sector";
	$detector{"dimensions"}  = "0";
#	$detector{"material"}    = "Air";
	$detector{"material"}    = "Gas_inGap";
#    $detector{"material"}    = "Component";
	$detector{"style"}       = 1;
#	$detector{"sensitivity"} = "no";
		#	$detector{"sensitivity"} = "mirror: simpleMirror";
		#	$detector{"hit_type"}    = "mirror";


	print_det(\%configuration, \%detector);

    }
}

1;
