use strict;
use warnings;

our %configuration;
our %parameters;

my $thetaEC_deg = $parameters{"thetaEC_deg"};

#
# parameters first. These are described in CLAS-Note 2010-?? by Gilfoyle et al.
#
# Face of the EC is tilted 25 degrees, the large angle side is rotated towards detector,
# and the small angle vertex is rotated away from detector.
#
#  large angle side(top) -->  /\
#                             \ \
#      Side view               \ \
#                               \ \
#                                \ \
#                                 \_\   <-- small angle vertex(bottom)
#  target  |
#
# We are using the Hall B coordinate system with the origin at the target center.


my $extrathickness=0.1; #variable to make the mother slightly bigger so that there is no overlap

my $thetaEC = $thetaEC_deg*$pi/180;      # angle of EC face to a line perpendicular to the beamline in radians.
my $thetaO = 62.889041*$pi/180;          # angle between sides of EC at large scattering angle (angles opposite the beamside vertex) in radians.
my $a1 = 0.08555;                        # see CLAS-Note 2010-
my $a2 = 1864.65;
#$a3 = 4.627;   # corrected 10/3/10
my $a3 = 4.45635;
#$a4 = 4.3708;                        # Used to get the position of the u strips.
#$a5 = 103.66;                        # Used to get the width of the u strips.
#$a6 = 0.2476;                        # Used to get the width of the u strips.
#$a7 = 94.701;                        # Used to get the width of the v strips.
#$a8 = 0.2256;                        # Used to get the width of the v and w strip;
#$a9 = 94.926;                        # Used to get the width of the w strips.

my $dlead = 2.381;                       # thickness of lead layers in mm.
my $dscint= 10.0;                        # thickness of scintillator layers in mm.
my $nlayers = 39;                        # number of scintillator layers, there are 38 lead layers (no lead layer 1).
my $L1 = 7217.23;                        # length of line perpendicular to EC face that passes through the CLAS12 target.
my $ypo = 950.88;                        # distance from perpendicular point to the geometric center of the front face of the first scintillator.
my $MUoffset = 5265.0;                  # the CLAS12 target is at +5m (or -2 m??) in the gemc coordinates.

# Lid of EC box

my $d_steel1 = 1.75;
my $d_steel2 = 1.75;
my $d_foam   = 76.2;
my $d_lid    = $d_steel1 + $d_foam + $d_steel2;

#derived quantities.

my $tantheta = tan($thetaO);             # tangent of angle between sides of EC at large scattering angle (angles opposite the beamside vertex).
my $gamma1 = $pi - 2*$thetaO;                             # angle between sides of EC at small scattering angle.
my $totaldepth = ($nlayers-1)*($dscint+$dlead) + $dscint; # total thickness of lead and scintillator. There are 39 scintillator layers and 38 lead layers.
my $totalvol = $totaldepth+2*$d_lid;


# Mother Volume - description of parameters for Geant4 G4Trap volume.
#
# pDx1 	  Half x length of the side at y=-pDy1 of the face at -pDz
# pDx2 	  Half x length of the side at y=+pDy1 of the face at -pDz
# pDz 	  Half z length
# pTheta  Polar angle of the line joining the centres of the faces at -/+pDz
# pPhimom Azimuthal angle of the line joining the centre of the face at -pDz to the centre of the face at +pDz
# pDy1 	  Half y length at -pDz
# pDy2 	  Half y length at +pDz
# pDx3 	  Half x length of the side at y=-pDy2 of the face at +pDz
# pDx4 	  Half x length of the side at y=+pDy2 of the face at +pDz
# pAlp1   Angle with respect to the y axis from the centre of the side (lower endcap)
# pAlp2   Angle with respect to the y axis from the centre of the side (upper endcap)
#
# Note on pAlph1/2: the two angles have to be the same due to the planarity condition.
#
# all numbers are in mm or deg as specified in the $detector{"dimensions"} statement.

my $pDzmom    = $totalvol/2.0 + $extrathickness;          # half z length
my $pDy1mom   = &sycenter($nlayers) + &spDy($nlayers) + $extrathickness;  # maximum half y length at -pDz.
my $pDy2mom   = $pDy1mom;                               # half y length at +pDz.
my $pDx1mom   = 0.001;            # should be zero, but that makes gemc crash.
my $pDx2mom   = &spDx2($nlayers) + $extrathickness; # Half x length of the side at y=+pDy1 of the face at -pDz.
my $pThetamom = 0;                # Polar angle of the line joining the centres of the faces at +/-pDz
my $pPhimom   = $pThetamom;       # Azimuthal angle from the centre of the face at -pDz to the centre of the face at +pDz.
my $pDx3mom   = $pDx1mom;         # half x length of the side at y=-pDy2 of the face at +pDz
my $pDx4mom   = $pDx2mom;         # Half x length of the side at y=+pDy2 of the face at +pDz/
my $pAlp1mom  = $pThetamom;       # angle with respect to y axis from centre of side(lower endcap)
my $pAlp2mom  = $pThetamom;       # angle with respect to y axis from centre of side(uppder endcap)

# Geant4 builds mother volume in one sector, than rotates the contents in the
# 1st sector to form 6 total sectors. Sector orientations shown below looking
# in the direction of the beam.
#
#             TOP                     ^  y
#              .                      |
#           .  .  .                   |
#        .     .     .          x <----
#     .        .        .
# .       2    .    3       .
# .   .        .        .   .
# .      .     .     .      .
# .         .  .  .         .
# .   1        .       4    .  z/beam - into page
# .         .  .  .         .
# .      .     .     .      .
# .   .        .        .   .
# .       6    .    5       .
#     .        .        .
#        .     .     .
#           .  .  .
#              .

# We place the origin at the geometric center of each layer. The z axis runs along the beam line,
# the y axis points vertically straight up from beam line and the x axis points left looking out along
# the beam line. Calculate the position of the center of first scintillator face as the origin.
#
#     1. Get the vector from the target center to the front face of the first scintillator and perpendicular to the face.
my@L1vec = ( 0, $L1*sin($thetaEC), $L1*cos($thetaEC));
#     2. Vector that takes you from perpendicular point at L1vec to geometric center of Clas12 EC layer 1.
my@Svec = ( 0,-$ypo*cos($thetaEC), $ypo*sin($thetaEC));
#     3. Now add L1vec+Svec.
my@CLAS12front = ($L1vec[0]+ $Svec[0], $L1vec[1]+ $Svec[1], $L1vec[2]+ $Svec[2]);
#     4. Get vector from center of front face to the midpoint in the z direction
my@toCenter = (0, $pDzmom*sin($thetaEC),$pDzmom*cos($thetaEC));
#     5. Get final vector from target to center of the mother volume with origin at the center of the front face.
# Adding 1cm space since apparently this is not enough to avoid overlaps with PCAL
my@CLAS12center = ($CLAS12front[0]+$toCenter[0],$CLAS12front[1]+$toCenter[1],$CLAS12front[2]+$toCenter[2] + 10);

# array used to calculate pdX values for Geant4. Some lead layers are truncated at the small angle vertex.
my @beamVertexCut=(0.00001, 0.0000001, 1.440, 0.0000001, 0.000001, 1.448, 0.000001, 0.000001, 1.455, 0.001,
0.000001, 1.462, 0.000001, 0.000001, 1.0, 0.000001, 0.00001, 1.0, 0.000001, 0.000001, 1.0, 0.000001, 0.000001,
1.0, 0.000001, 0.000001, 1.0, 0.001, 0.000001, 1.0, 0.000001, 0.000001, 1.0, 0.000001, 0.000001, 1.0, 0.000001, 0.000001);



my $i = 1;
my $view   = &ECview($i);
my $stack  = &ECstack($i);

# define ec sector. The definition is independendt so that misalignment between sectors can be implemented if needed
sub define_mothers
{
	for(my $s=1; $s<=6; $s++)
	{
		build_mother($s);
	}
}


sub build_mother
{
	# generate red mother volume wireframe box, and write to a file.
	my $sector= shift;
	
	my %detector = init_det();
	$detector{"name"}        = "ec_s".$sector;
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Forward Calorimeter - Sector ".$sector;
	$detector{"pos"}         = ec_sec_pos($sector);
	$detector{"rotation"}    = ec_sec_rot($sector);
	$detector{"color"}       = "ff1111";
	$detector{"type"}        = "G4Trap";
	$detector{"dimensions"}  = "${pDzmom}*mm ${pThetamom}*deg ${pPhimom}*deg ${pDy1mom}*mm ${pDx1mom}*mm ${pDx2mom}*mm ${pAlp1mom}*deg ${pDy2mom}*mm ${pDx3mom}*mm ${pDx4mom}*mm ${pAlp2mom}*deg";
	$detector{"material"}    = "G4_AIR";
	$detector{"visible"}     = 0;
	print_det(\%configuration, \%detector);
}



# now start to do the alternating layers of scintillator and lead. Set up inputs first.

# All volumes produced are now placed in mother volume's coordinate sytem.
#  The Mother volume coordinate system has it's y axis running from the mother
#  volumes small angle vertex straight up to form a perpendicular angle at the
#  midpoint of the large angle side.
#
#
#                large angle side(top).
#         ...........................
#         \            |            /
#          .           |           .
#          \           |           /
#           .          |          .
#           \          |y_axis    /
#            .         |         .
#            \         |         /
#             .        |        .
#             \        |        /
#        _____________ o________x_axis____
#              \       |       /
#               .      |      .
#               \      |      /
#                .     |     .
#                \     |     /
#                 .    |    .
#                 \    |    /
#                  .   |    .
#                  \   |   /
#                    .  |   .
#                   \  |  /
#                    . |  .
#                    \ | /
#                    . | .
#                     \|/
#                      .
#             small angle vertex(bottom)
#
my $subname;
my $submother = "ec";
my $description;
my $pos;
my $rotation = "0*deg 0*deg 0*deg";
my $color = "0147FA";
my $type = "G4Trap";
my $dimensions;
my $material ="G4_AIR";
my $mfield = "no";
my $ncopy = 1;
my $pMany = 1;
my $exist = 1;
my $visible = 1;
my $style = 1;
my $sensitivity = "no";
my $hit_type = "";
my $identifiers = "";

# a scintillator layer first. set the G4Trap parameters.
#
my $pDx1   = 0.001;  # should be zero, but that makes gemc crash.
my $pDx2   = &spDx2(1);
my $pDz    = $dscint/2.0;  #<-------------------------------------
my $pTheta = 0;
my $pPhi   = $pTheta;
my $pDy1   = &spDy(1);
my $pDy2   = $pDy1;
my $pDx3   = $pDx1;
my $pDx4   = $pDx2;
my $pAlp1  = $pTheta;
my $pAlp2  = $pTheta;


# fill the Geant4 description of the volume and write the results into the file.



sub define_lids
{
	for(my $s=1; $s<=6; $s++)
	{
		build_lids($s);
	}
}

sub build_lids
{
	
	# Generate first stainless cover using first scintillator dimensions
	my $sector=shift;
	
	my $xscint = &sxcenter($i);
	my $yscint = &sycenter($i);
	my $zscint = &szcenter($i);
	my $pDzlid = $d_steel1/2;
	my $x_lid = $xscint;
	my $y_lid = $yscint;
	my $z_lid = $zscint-$pDz-$d_steel2-$d_foam-$d_steel1/2;
	
	my %detector = init_det();
	$detector{"name"}        = "eclid1_s".$sector;
	$detector{"mother"}      = "ec_s".$sector;
	$detector{"description"} = "Stainless Steel Skin 1";
	$detector{"pos"}         = "${x_lid}*mm ${y_lid}*mm ${z_lid}*mm";
	$detector{"rotation"}    = $rotation;
	$detector{"color"}       = "FCFFF0";
	$detector{"type"}        = "G4Trap";
	$detector{"dimensions"}  = "${pDzlid}*mm ${pTheta}*deg ${pPhi}*deg ${pDy1}*mm ${pDx1}*mm ${pDx2}*mm ${pAlp1}*deg ${pDy2}*mm ${pDx3}*mm  ${pDx4}*mm  ${pAlp2}*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	# Generate Last-a-Foam layer using first scintillator dimensions
	
	$pDzlid = $d_foam/2;
	$z_lid = $zscint-$pDz-$d_steel2-$d_foam/2;
	
	%detector = init_det();
	$detector{"name"}        = "eclid2_s".$sector;
	$detector{"mother"}      = "ec_s".$sector;
	$detector{"description"} = "Last-a-Foam";
	$detector{"pos"}         = "${x_lid}*mm ${y_lid}*mm ${z_lid}*mm";
	$detector{"rotation"}    = $rotation;
	$detector{"color"}       = "EED18C";
	$detector{"type"}        = "G4Trap";
	$detector{"dimensions"}  = "${pDzlid}*mm ${pTheta}*deg ${pPhi}*deg ${pDy1}*mm ${pDx1}*mm ${pDx2}*mm ${pAlp1}*deg ${pDy2}*mm ${pDx3}*mm  ${pDx4}*mm  ${pAlp2}*deg";
	$detector{"material"}    = "LastaFoam";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
	
	# Second stainless steel cover using first scintillator dimensions
	
	$pDzlid = $d_steel2/2;
	$z_lid =  $zscint-$pDz-$d_steel2/2;
	
	%detector = init_det();
	$detector{"name"}        = "eclid3_s".$sector;
	$detector{"mother"}      = "ec_s".$sector;
	$detector{"description"} = "Stainless Steel Skin 2";
	$detector{"pos"}         = "${x_lid}*mm ${y_lid}*mm ${z_lid}*mm";
	$detector{"rotation"}    = $rotation;
	$detector{"color"}       = "FCFFF0";
	$detector{"type"}        = "G4Trap";
	$detector{"dimensions"}  = "${pDzlid}*mm ${pTheta}*deg ${pPhi}*deg ${pDy1}*mm ${pDx1}*mm ${pDx2}*mm ${pAlp1}*deg ${pDy2}*mm ${pDx3}*mm  ${pDx4}*mm  ${pAlp2}*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
}

sub define_scintlayers
{
	for(my $s=1; $s<=6; $s++)
	{
		build_scintlayers($s);
	}
}


sub build_scintlayers
{
	my $sector = shift;
	my $i      = 1;
	my $xscint = &sxcenter($i);
	my $yscint = &sycenter($i);
	my $zscint = &szcenter($i);
	
	my $bindex = cnumber($i-1, 10);
	
	$view = &ECview($i);
	$stack= &ECstack($i);
	
	$subname = "scint_$bindex"."_s".$sector."_view_$view"."_stack_$stack";
	
	
	
	$description ="Forward Calorimeter scintillator layer ${i}";
	$pos = "$xscint*mm $yscint*mm $zscint*mm";
	# a scintillator layer first. set the G4Trap parameters.
	
	my $pDx1   = 0.001;  # should be zero, but that makes gemc crash.
	my $pDx2   = &spDx2(1);
	my $pDz    = $dscint/2.0;  #<-------------------------------------
	my $pTheta = 0;
	my $pPhi   = $pTheta;
	my $pDy1   = &spDy(1);
	my $pDy2   = $pDy1;
	my $pDx3   = $pDx1;
	my $pDx4   = $pDx2;
	my $pAlp1  = $pTheta;
	my $pAlp2  = $pTheta;
	
	my %detector = init_det();
	$detector{"name"}        = $subname;
	$detector{"mother"}      = "ec_s".$sector;
	$detector{"description"} = $description;
	$detector{"pos"}         = $pos;
	$detector{"rotation"}    = $rotation;
	$detector{"color"}       = "0147FA";
	$detector{"type"}        = "G4Trap";
	$detector{"dimensions"}  = "${pDz}*mm ${pTheta}*deg ${pPhi}*deg ${pDy1}*mm ${pDx1}*mm ${pDx2}*mm ${pAlp1}*deg ${pDy2}*mm ${pDx3}*mm  ${pDx4}*mm  ${pAlp2}*deg";
	$detector{"material"}    = "scintillator";
	$detector{"style"}       = 1;
	$detector{"sensitivity"} = "ec";
	$detector{"hit_type"}    = "ec";
	$detector{"identifiers"} = "sector manual $sector stack manual $stack view manual $view strip manual 36";
	print_det(\%configuration, \%detector);
	
	# loop over layers and generates Geant4 parameters for each scint and lead layer.
	
	
	for ($i = 2; $i <= $nlayers; $i++)
	{
		
		$view = &ECview($i);
		$stack= &ECstack($i);
		$bindex = cnumber($i-1, 10);
		
		# lead layer
		
		my $xlead = &sxcenterPb(${i});
		my $ylead = &sycenterPb(${i});
		my $zlead = &szcenterPb(${i});
		
		
		$subname = "lead_$bindex"."_s".$sector."_view_$view"."_stack_$stack";
		$description = "Forward Calorimeter lead layer ${i}";
		$pos  = "${xlead}*mm ${ylead}*mm ${zlead}*mm";         #position of center of trapezoid.
		$pDz  = $dlead/2.0;
		$pDy1 = &spDy($i) - $beamVertexCut[$i-2];
		$pDy2 = $pDy1;
		$pDx1 = $beamVertexCut[$i-2]*tan($gamma1/2);
		$pDx3 = $pDx1;
		$pDx2 = &spDx2($i);
		$pDx4 = $pDx2;
		$pTheta = 0;
		$pPhi   = $pTheta;
		$pAlp1  = $pTheta;
		$pAlp2  = $pTheta;
		
		%detector = init_det();
		$detector{"name"}        = $subname;
		$detector{"mother"}      = "ec_s".$sector;
		$detector{"description"} = $description;
		$detector{"pos"}         = $pos;
		$detector{"rotation"}    = $rotation;
		$detector{"color"}       = "7CFC00";
		$detector{"type"}        = "G4Trap";
		$detector{"dimensions"}  = "${pDz}*mm ${pTheta}*deg ${pPhi}*deg  ${pDy1}*mm ${pDx1}*mm  ${pDx2}*mm  ${pAlp1}*deg  ${pDy2}*mm ${pDx3}*mm  ${pDx4}*mm  ${pAlp2}*deg";
		$detector{"material"}    = "G4_Pb";
		$detector{"style"}       = 1;
		print_det(\%configuration, \%detector);
		
		
		
		# scintillator layer
		
		$xscint = &sxcenter($i);
		$yscint = &sycenter($i);
		$zscint = &szcenter($i);
		
		$subname = "scint_$bindex"."_s".$sector."_view_$view"."_stack_$stack";
		$description ="Forward Calorimeter scintillator layer ${i}";
		$pos = "${xscint}*mm ${yscint}*mm ${zscint}*mm";
		$pDz = $dscint/2.0;
		$pDy1 = &spDy($i);
		$pDy2 = $pDy1;
		$pDx1 = 0.001;
		$pDx3 = $pDx1;
		$pDx2 = &spDx2($i);
		$pDx4 = $pDx2;
		$pTheta = 0;
		$pPhi   = $pTheta;
		$pAlp1  = $pTheta;
		$pAlp2  = $pTheta;
		
		
		%detector = init_det();
		$detector{"name"}        = $subname;
		$detector{"mother"}      = "ec_s".$sector;
		$detector{"description"} = $description;
		$detector{"pos"}         = $pos;
		$detector{"rotation"}    = $rotation;
		$detector{"color"}       = "0147FA";
		$detector{"type"}        = "G4Trap";
		$detector{"dimensions"}  = "${pDz}*mm ${pTheta}*deg ${pPhi}*deg  ${pDy1}*mm ${pDx1}*mm  ${pDx2}*mm  ${pAlp1}*deg  ${pDy2}*mm ${pDx3}*mm  ${pDx4}*mm  ${pAlp2}*deg";
		$detector{"material"}    = "scintillator";
		$detector{"style"}       = 1;
		$detector{"sensitivity"} = "ec";
		$detector{"hit_type"}    = "ec";
		$detector{"identifiers"} = "sector manual $sector stack manual $stack view manual $view strip manual 36";
		print_det(\%configuration, \%detector);
		
	}
}


# subroutines
#
# scintillator positions:
# gives the x position of each scintillator layers geometric center inside the mother volume.
sub sxcenter($)
{
	my $xcent = 0;
	return $xcent;
}

# gives the y position of each scintillator layers geometric center inside the mother volume.
sub sycenter($)
{
	my $ycent = $a1*($_[0] - 1);
	return $ycent;
}

# gives the z position of each scintillator layers geometric center inside the mother volume.
sub szcenter($)
{
	my $layer = $_[0];
	my $zcent = -$totaldepth/2 + ($layer - 1)*($dscint + $dlead) + $dscint/2;
	return $zcent;
}

# lead positions.
# gives the x position of each lead layers geometric center inside the mother volume.
sub sxcenterPb($)
{
	my $xcentPb = 0;
	return $xcentPb;
}
# gives the y position of each lead layers geometric center inside the mother volume.
sub sycenterPb($)
{
	my $ycentPb = &sycenter($_[0]) + $beamVertexCut[$_[0]-2]/2;
	return $ycentPb;
}
#gives the z position of each lead layers geometric center inside the mother volume.
sub szcenterPb($){
	my $zcentPb = -$totaldepth/2 + ($_[0] - 2)*($dscint + $dlead) + $dscint/2 + ($dscint+$dlead)/2;
	return $zcentPb;
}

# half-widths of lead and scintillator layers.
#
# gives half y distance of trapezoidal EC layer $i,
sub spDy($)
{
	my $ywidth = $a2 + $a3*($_[0] - 1);
	return $ywidth;
}

# gives half x distance of trapezoidal EC layer $i;
sub spDx2($)
{
	my $xwidth = (2*&spDy($_[0]))/($tantheta);
	return $xwidth;
}




# using the layer to generate a number (1,2,3) for the different views (U, V,W).
sub ECview($)
{
	
	my $layer = $_[0];
	my $mod = $layer%3;
	
	my $view = 4;
	if ($mod == 1) {$view = 1;}
	if ($mod == 2) {$view = 2;}
	if ($mod == 0) {$view = 3;}
	
	if ($view == 4) {print "**** WARNING: No View assignment made. ****\n";}
	
	return $view;
}

# using the layer to generate a number (1,2,3) for the inner and outer stacks in the EC.
sub ECstack($)
{
	
	my $layer = $_[0];
	
	my $stack = 3;
	if ($layer <= 15) {$stack = 1;}
	if ($layer >  15) {$stack = 2;}
	if ($stack == 3) {print "**** WARNING: No Stack assignment made. ****\n";
	}
	
	return $stack;
}


sub ec_sec_pos
{
	my $sector = shift;
	# the ec sector is created on the xy plane with the tip toward the z axis, however it is placed  with the center at x=0
	# in a position that does not correspond to any actual sector. Sector one is with y = 0. In order to calculate the
	# position we need to rotate the center around the z axis, the rotation is negative (counterclockwise) by 60 degree for each sector, but
	# there is an initial positive rotation of 90 to bring the first sector from x=0 to y=0
	# my $phi = ($sector - 1)*60;
	my $phi =  -($sector-1)*60 + 90;
	my $x = fstr($CLAS12center[0]*cos(rad($phi))+$CLAS12center[1]*sin(rad($phi)));
	my $y = fstr(-$CLAS12center[0]*sin(rad($phi))+$CLAS12center[1]*cos(rad($phi)));
	my $z = fstr($CLAS12center[2]);
	
	return "$x*mm $y*mm $z*mm";
}

sub ec_sec_rot
{
	#the ec_sec_pos position the six sectors in the right place but they are all oriented vertically (tip pointing in the -y direction)
	#and they are not tilted
	#this sub routine will rotate them on themselves by 60 counterclockwise, plus there is an additional rotation of 90 clockwise to have sector 1
	#correct (pointing in the -x direction). After the rotation around their own z axes is done, each sector is tilted around x.
	my $sector = shift;
	
	my $tilt  = fstr($thetaEC_deg);
	my $zrot  = -($sector-1)*60 + 90;
	return "ordered: zxy $zrot*deg $tilt*deg 0*deg ";
}

sub makeEC
{
	define_mothers();
	define_lids();
	define_scintlayers();
}


1;



