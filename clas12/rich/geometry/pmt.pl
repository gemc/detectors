use strict;
use warnings;

our %configuration;
our %parameters;

my $RAD=180/3.1415927;

my $RichBox_dz        = $parameters{"par_RichBox_dz"};
my $RichBox_dx1       = $parameters{"par_RichBox_dx1"};
my $RichBox_dx2       = $parameters{"par_RichBox_dx2"};
my $RichBox_dy1       = $parameters{"par_RichBox_dy1"};
my $RichBox_the       = $parameters{"par_RichBox_the"};

my $PMTPanel_dy1      = $parameters{"par_PMTPanel_dy1"};

my $PMTCase_dx        = $parameters{"par_PMTCase_dx"};
my $PMTCase_dy        = $parameters{"par_PMTCase_dy"};
my $PMTCase_dz        = $parameters{"par_PMTCase_dz"};
my $PMTCase_width     = $parameters{"par_PMTCase_width"};
my $PMTWindow_dz      = $parameters{"par_PMTWindow_dz"};
my $PMTPhotocatode_dx = $parameters{"par_PMTPhotocatode_dx"};
my $PMTPhotocatode_dy = $parameters{"par_PMTPhotocatode_dy"};
my $PMTPhotocatode_dz = $parameters{"par_PMTPhotocatode_dz"};
my $PMTSocket_dz      = $parameters{"par_PMTSocket_dz"};

my $PMTSeparation     = $parameters{"par_PMTSeparation"};
my $PMTOffsetFromPanel= $parameters{"par_PMTOffsetFromPanel"};
my $PMTDistanceFromAerogel_z= $parameters{"par_PMTDistanceFromAerogel_z"};

my $PMTOffsetFromBox_y = $parameters{"par_PMTOffsetFromBox_y"};
my $PMTOffsetFromBox_z = $parameters{"par_PMTOffsetFromBox_z"};

 # parameters for the containing volume
my $PMT_rows  = POSIX::floor( ( 2*$PMTPanel_dy1 - 2*$PMTOffsetFromPanel )/( 2*$PMTCase_dy + $PMTSeparation ) ) ;

# z position of PMTs defined with respect to the aerogel
my $EntrancePanel_dz   = $parameters{"par_EntrancePanel_dz"};
my $FrontalMirror_offset= $parameters{"par_FrontalMirror_offset"};
my $FrontalMirror_dz    = $parameters{"par_FrontalMirror_dz"};
my $AerogelTile_dz = $parameters{"par_AerogelTile_dz"};

# values of y and z for the center of mass of the PMTs in the first raw, as calculated from M. Mirazita function, based on D. Orecchini drawings
my $PMTFirstRaw_y = $parameters{"par_PMTFirstRaw_y"};
my $PMTFirstRaw_z = $parameters{"par_PMTFirstRaw_z"};

#my $PMTCase_z       =  $PMTOffsetFromBox_z/( cos( $RichBox_the ) ) + $PMTCase_dz ;
my $PMTCase_z       = $PMTFirstRaw_z ;# + $PMTCase_dz ;

my $PMTCase_dy_offset = $PMTOffsetFromBox_y/sin( ( 90 - $RichBox_the)/$RAD );

# to start from the Box bottom at a given z use: $PMTCase_y_offset  = -$RichBox_dy1 - ( $PMTCase_z - $PMTCase_dz )*tan( $RichBox_the/$RAD )
# final positioning starting from the box bottom and adding the y offset
#my $PMTCase_y_offset  = -$RichBox_dy1 - ( $PMTCase_z - $PMTCase_dz )*tan( $RichBox_the/$RAD ) + $PMTCase_dy_offset;

my $PMTCase_y_offset = $PMTFirstRaw_y ; # - ( $PMTCase_z - $PMTCase_dz )*tan( $RichBox_the/$RAD ) ;

my $TanBoxOpeningAngle = ( $RichBox_dx2 - $RichBox_dx1 )/( 2*$RichBox_dy1 ) ;


print " Producing $PMT_rows rows of PMTs \n" ;

sub build_pmts
{

    my $sector = shift ;

    my $nPMTS  = 0 ;

    # loop on the raws
#    for(my $_iraw = 0; $_iraw < 1; $_iraw++){
    for(my $_iraw = 0; $_iraw < $PMT_rows; $_iraw++){

	# for any raw, define the number of tiles to be stored there

	# set first the y position of the tile
#	my $PMTCase_y = $PMTCase_y_offset + $PMTCase_dy*( 1 + 2*$_iraw ) + $PMTSeparation*$_iraw ;
	my $PMTCase_y = $PMTCase_y_offset + $PMTCase_dy*( 2*$_iraw ) + $PMTSeparation*$_iraw ;

	# it has to be calculated at the base of the PMTs to be stored in that raw, not in the middle or in the top, where one would overestimate the number of PMTs entering there
	my $EffectiveXLength = 2*$RichBox_dx1 + 2*$PMTCase_dy_offset*abs( $TanBoxOpeningAngle ) + 2*( 2*$PMTCase_dy + $PMTSeparation )*$_iraw*abs( $TanBoxOpeningAngle ) + $PMTSeparation ;# - 2*$DistanceFromEdges;

	print "Raw $_iraw is wide $EffectiveXLength, the center of mass of the PMTs is $PMTCase_y" ;

#	my $nTileInARaw = POSIX::floor( $EffectiveXLength/( 2*$PMTCase_dx + $PMTSeparation ) );
	my $nPMTInARaw = 6 + $_iraw ;

	print " and there are $nPMTInARaw pmts \n" ;

	# shift due to the separation among the PMTs, that corresponds to nPMTs - 1 semi-separations 
	my $ShiftPMTs_x = ( $nPMTInARaw - 1 )*( $PMTSeparation/2.0 ) ;

	# the offset to the right is calculated as the number of PMTs times their dx, -1 since one has to position the center of mass
	my $PMTOffset_x = ( $nPMTInARaw - 1)*$PMTCase_dx + $ShiftPMTs_x;

	# loop on the number of tiles in a given raw
#	for(my $_ipmt = 3; $_ipmt < 4; $_ipmt++){
 	for(my $_ipmt = 0; $_ipmt < $nPMTInARaw; $_ipmt++){

	    $nPMTS++;

	    my $PMTCase_x = $PMTOffset_x - ( 2*$PMTCase_dx + $PMTSeparation)*$_ipmt ;

	    # pmt containing volume
	    my %detector = init_det();

	    print "Placing PMT PMTRaw_${_iraw}_n$nPMTS.inSec$sector at ${PMTCase_x}*mm ${PMTCase_y}*mm ${PMTCase_z}*mm \n" ;

	    $detector{"name"}        = "PMTRaw_${_iraw}_n$nPMTS.inSec$sector";
	    $detector{"mother"}      = "rich_box.$sector";
	    $detector{"description"} = "PMT in the central raw";
	    $detector{"pos"}         = "${PMTCase_x}*mm ${PMTCase_y}*mm ${PMTCase_z}*mm";
	    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
	    $detector{"color"}       = "3973ac";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$PMTCase_dx*mm $PMTCase_dy*mm $PMTCase_dz*mm";
	    $detector{"material"}    = "Gas_inGap";

	    print_det(\%configuration, \%detector);

	    # pmt aluminium case - build it through volume subtraction
	    %detector = init_det();
	    $detector{"name"}        = "PMTOuterVoumeRaw_${_iraw}_n$nPMTS.inSec$sector";
	    $detector{"mother"}      = "rich_box.$sector";
	    $detector{"description"} = "outer box";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$PMTCase_dx*mm $PMTCase_dy*mm $PMTCase_dz*mm";
	    $detector{"material"}    = "Component";

	    print_det(\%configuration, \%detector);

	    # inner volume
	    %detector = init_det();

	    my $PMTInner_dx = $PMTCase_dx - $PMTCase_width ;
	    my $PMTInner_dy = $PMTCase_dy - $PMTCase_width ;

	    # shift dz in order to open the case in front to let the light to pass - than shift its positioning in z accordingly
	    my $PMTInner_zShift = 2 ;
	    my $PMTInner_dz = $PMTCase_dz + $PMTInner_zShift ;

	    $detector{"name"}        = "PMTInnerVoumeRaw_${_iraw}_n$nPMTS.inSec$sector";
	    $detector{"mother"}      = "rich_box.$sector";
	    $detector{"description"} = "inner box";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$PMTInner_dx*mm $PMTInner_dy*mm $PMTInner_dz*mm";
	    $detector{"material"}    = "Component";

	    print_det(\%configuration, \%detector);

	    # pmt aluminium case - subtract the two volumes and place it inside the pmt volume
	    %detector = init_det();
	    $detector{"name"}        = "PMTCaseRaw_${_iraw}_n$nPMTS.inSec$sector";
	    $detector{"mother"}      = "PMTRaw_${_iraw}_n$nPMTS.inSec$sector";
	    $detector{"pos"}         = "0*mm  0*mm 0*mm";
	    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
	    $detector{"description"} = "PMT case";
	    $detector{"dimensions"}  = "0";
	    $detector{"type"}        = "Operation: PMTOuterVoumeRaw_${_iraw}_n$nPMTS.inSec$sector - PMTInnerVoumeRaw_${_iraw}_n$nPMTS.inSec$sector";
	    $detector{"material"}    = "Aluminum";
	    $detector{"style"}       = "0";

	    print_det(\%configuration, \%detector);

# after the case in aluminum, it creates the PMT glass window placed inside the PMT volume
	    my $PMTWindow_z = -$PMTCase_dz + $PMTWindow_dz ;

# place the window inside the case - not overlapping it
	    my $PMTWindow_dx = $PMTCase_dx -  $PMTCase_width ;
	    my $PMTWindow_dy = $PMTCase_dy -  $PMTCase_width ;

	    %detector = init_det();
	    $detector{"name"}        = "PMTWindowRaw_${_iraw}_n$nPMTS.inSec$sector";
	    $detector{"mother"}      = "PMTRaw_${_iraw}_n$nPMTS.inSec$sector";
	    $detector{"description"} = "PMT glass window in the central raw";
	    $detector{"pos"}         = "0*mm 0*mm ${PMTWindow_z}*mm";
	    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
	    $detector{"color"}       = "99bbff";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$PMTWindow_dx*mm $PMTWindow_dy*mm $PMTWindow_dz*mm";
	    $detector{"material"}    = "Glass_H8500";

	    print_det(\%configuration, \%detector);

# it creates now the photocatode, with the rich hit sensitivity
	    my $PMTPhotocatode_z = -$PMTCase_dz + 2*$PMTWindow_dz + $PMTPhotocatode_dz ;

	    %detector = init_det();
	    $detector{"name"}        = "PMTPhotocatodeRaw_${_iraw}_n$nPMTS.inSec$sector";
	    $detector{"mother"}      = "PMTRaw_${_iraw}_n$nPMTS.inSec$sector";
	    $detector{"description"} = "PMT bialkali photocatode in the central raw";
	    $detector{"pos"}         = "0*mm 0*mm ${PMTPhotocatode_z}*mm";
	    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
	    $detector{"color"}       = "999966";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$PMTPhotocatode_dx*mm $PMTPhotocatode_dy*mm $PMTPhotocatode_dz*mm";
	    $detector{"sensitivity"} = "rich";
	    $detector{"hit_type"}    = "rich"; 
	    $detector{"identifiers"} = "sector manual $sector pad manual $nPMTS pixel manual 1";
	    $detector{"material"}    = "Gas_inGap";

	    print_det(\%configuration, \%detector);

# and finally it creates a socket accounting for the electronic material budget
	    my $SocketZShift = 1.0 ; # to separate the socket from the photocatode
#	    my $PMTSocket_z = -$PMTCase_dz + 2*$PMTWindow_dz + 2*$PMTPhotocatode_dz + $PMTSocket_dz + $SocketZShift;
	    my $PMTSocket_z =  $PMTCase_dz - $PMTSocket_dz ;

# place the window inside the case - not overlapping it
	    my $PMTSocket_dx = $PMTCase_dx -  $PMTCase_width ;
	    my $PMTSocket_dy = $PMTCase_dy -  $PMTCase_width ;

	    %detector = init_det();
	    $detector{"name"}        = "PMTSocketRaw_${_iraw}_n$nPMTS.inSec$sector";
	    $detector{"mother"}      = "PMTRaw_${_iraw}_n$nPMTS.inSec$sector";
	    $detector{"description"} = "PMT socket in the central raw";
	    $detector{"pos"}         = "0*mm 0*mm ${PMTSocket_z}*mm";
	    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
	    $detector{"color"}       = "ff9900";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$PMTSocket_dx*mm $PMTSocket_dy*mm $PMTSocket_dz*mm";
	    $detector{"material"}    = "G4_Cu";

	    print_det(\%configuration, \%detector);

	} # it closes the loop on the PMTs in a given raw

    } # it closes the loop on the raws

    print "Produced $nPMTS pmt" ;

}


1;
