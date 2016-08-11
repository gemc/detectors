use strict;
use warnings;

our %configuration;
our %parameters;


my $RAD=180/3.1415927;

my $FrontalSystemBottom_dz    = $parameters{"par_FrontalSystemBottom_dz"};
my $FrontalSystemBottom_th    = $parameters{"par_FrontalSystemBottom_th"};
my $FrontalSystemBottom_ph    = $parameters{"par_FrontalSystemBottom_ph"};
my $FrontalSystemBottom_dx1   = $parameters{"par_FrontalSystemBottom_dx1"};
my $FrontalSystemBottom_dx2   = $parameters{"par_FrontalSystemBottom_dx2"};
my $FrontalSystemBottom_dx3   = $parameters{"par_FrontalSystemBottom_dx3"};
my $FrontalSystemBottom_dx4   = $parameters{"par_FrontalSystemBottom_dx4"};
my $FrontalSystemBottom_dy1   = $parameters{"par_FrontalSystemBottom_dy1"};
my $FrontalSystemBottom_dy2   = $parameters{"par_FrontalSystemBottom_dy2"};
my $FrontalSystemBottom_alp1  = $parameters{"par_FrontalSystemBottom_alp1"};
my $FrontalSystemBottom_alp2  = $parameters{"par_FrontalSystemBottom_alp2"};
my $FrontalSystemBottom_offset= $parameters{"par_FrontalSystemBottom_offset"};

my $FrontalSystemBottom_x     = $parameters{"par_FrontalSystemBottom_x"};
my $FrontalSystemBottom_y     = $parameters{"par_FrontalSystemBottom_y"};
my $FrontalSystemBottom_z     = $parameters{"par_FrontalSystemBottom_z"};

my $FrontalSystemTop_dz    = $parameters{"par_FrontalSystemTop_dz"};
my $FrontalSystemTop_th    = $parameters{"par_FrontalSystemTop_th"};
my $FrontalSystemTop_ph    = $parameters{"par_FrontalSystemTop_ph"};
my $FrontalSystemTop_dx1   = $parameters{"par_FrontalSystemTop_dx1"};
my $FrontalSystemTop_dx2   = $parameters{"par_FrontalSystemTop_dx2"};
my $FrontalSystemTop_dx3   = $parameters{"par_FrontalSystemTop_dx3"};
my $FrontalSystemTop_dx4   = $parameters{"par_FrontalSystemTop_dx4"};
my $FrontalSystemTop_dy1   = $parameters{"par_FrontalSystemTop_dy1"};
my $FrontalSystemTop_dy2   = $parameters{"par_FrontalSystemTop_dy2"};
my $FrontalSystemTop_alp1  = $parameters{"par_FrontalSystemTop_alp1"};
my $FrontalSystemTop_alp2  = $parameters{"par_FrontalSystemTop_alp2"};
my $FrontalSystemTop_offset= $parameters{"par_FrontalSystemTop_offset"};

my $FrontalSystemTop_x     = $parameters{"par_FrontalSystemTop_x"};
my $FrontalSystemTop_y     = $parameters{"par_FrontalSystemTop_y"};
my $FrontalSystemTop_z     = $parameters{"par_FrontalSystemTop_z"};

my $FrontalMirrorFrameWidth   = $parameters{"par_FrontalMirrorFrameWidth"};

my $FrontalMirror_dz    = $parameters{"par_FrontalMirror_dz"};

my $AerogelTile_dx            = $parameters{"par_AerogelTile_dx"};
my $AerogelTile_dy            = $parameters{"par_AerogelTile_dy"};
my $AerogelTile_dz            = $parameters{"par_AerogelTile_dz"};

my $AerogelTileSeparation     = $parameters{"par_AerogelTileSeparation"};

# opening angle to set the number of tiles per raw
my $OpeningAngle              = atan2( ( $FrontalSystemBottom_dx2 - $FrontalSystemBottom_dx1 ),  2*$FrontalSystemBottom_dy1 ) ; #*$RAD;
my $TanOpeningAngle           =        ( $FrontalSystemBottom_dx2 - $FrontalSystemBottom_dx1 )/( 2*$FrontalSystemBottom_dy1 ) ; #*$RAD;

# mirror and aerogel tile z is the same for all the tiles - it is defined with respect to the containing volume
my $FrontalMirror_z     = -${FrontalSystemBottom_dz} + $FrontalMirrorFrameWidth + $FrontalMirror_dz ;

my $AerogelTile_z             = $FrontalMirror_z     + $AerogelTile_dz ;

my $AerogelTileNumber    = 0 ;

sub build_frontal_system_bottom
{

# start creating the volume representing the frame occupancy
    my $sector = shift;

    my %detector = init_det();
    $detector{"name"}        = "FrontalSystemBottom.$sector";
    $detector{"mother"}      = "rich_box.$sector";
    $detector{"description"} = "System containing the frontal, bottom mirror and the corresponding aerogel tiles";
    $detector{"pos"}         = " ${FrontalSystemBottom_x}*mm ${FrontalSystemBottom_y}*mm ${FrontalSystemBottom_z}*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       =  "adad85";
    $detector{"type"}        = "G4Trap";
    $detector{"dimensions"}  = "$FrontalSystemBottom_dz*mm $FrontalSystemBottom_th*deg $FrontalSystemBottom_ph*deg $FrontalSystemBottom_dy1*mm $FrontalSystemBottom_dx1*mm $FrontalSystemBottom_dx2*mm $FrontalSystemBottom_alp1*deg $FrontalSystemBottom_dy2*mm $FrontalSystemBottom_dx3*mm $FrontalSystemBottom_dx4*mm $FrontalSystemBottom_alp2*deg";
    $detector{"material"}    = "Gas_inGap";
    $detector{"style"}       = 0;

    print_det(\%configuration, \%detector);

# now define the mirror, that is the frame minus its width = 2mm - it is contained inside the frame volume

    my $FrontalMirrorBottom_dx1   = $FrontalSystemBottom_dx1 - $FrontalMirrorFrameWidth*cos( $OpeningAngle/$RAD ) ; 
    my $FrontalMirrorBottom_dx2   = $FrontalSystemBottom_dx2 - $FrontalMirrorFrameWidth*cos( $OpeningAngle/$RAD ) ; 
    my $FrontalMirrorBottom_dx3   = $FrontalSystemBottom_dx3 - $FrontalMirrorFrameWidth*cos( $OpeningAngle/$RAD ) ;  
    my $FrontalMirrorBottom_dx4   = $FrontalSystemBottom_dx4 - $FrontalMirrorFrameWidth*cos( $OpeningAngle/$RAD ) ;  
    my $FrontalMirrorBottom_dy1   = $FrontalSystemBottom_dy1 - $FrontalMirrorFrameWidth ; 
    my $FrontalMirrorBottom_dy2   = $FrontalSystemBottom_dy2 - $FrontalMirrorFrameWidth ;   

    %detector = init_det();
    $detector{"name"}        = "FrontalMirrorBottom.$sector";
    $detector{"mother"}      = "FrontalSystemBottom.$sector";
    $detector{"description"} = "System containing the frontal, bottom mirror and the corresponding aerogel tiles";
    $detector{"pos"}         = "0*mm 0*mm $FrontalMirror_z*mm";
    $detector{"color"}       =  "99ffff";
    $detector{"type"}        = "G4Trap";
    $detector{"dimensions"}  = "$FrontalMirror_dz*mm $FrontalSystemBottom_th*deg $FrontalSystemBottom_ph*deg $FrontalMirrorBottom_dy1*mm $FrontalMirrorBottom_dx1*mm $FrontalMirrorBottom_dx2*mm $FrontalSystemBottom_alp1*deg $FrontalMirrorBottom_dy2*mm $FrontalMirrorBottom_dx3*mm $FrontalMirrorBottom_dx4*mm $FrontalSystemBottom_alp2*deg";
    $detector{"material"}    = "CarbonFiber";
    $detector{"style"}       = 1;

    print_det(\%configuration, \%detector);


# now the define the frame that contains the mirror and the aerogel
# volume to cut

    %detector = init_det();
    $detector{"name"}        = "FrontalFrameVolumeBottom.$sector";
    $detector{"mother"}      = "FrontalSystemBottom.$sector";
    $detector{"description"} = "System containing the frontal, bottom mirror and the corresponding aerogel tiles";
    $detector{"color"}       =  "99ffff";
    $detector{"type"}        = "G4Trap";
    $detector{"dimensions"}  = "$FrontalSystemBottom_dz*mm $FrontalSystemBottom_th*deg $FrontalSystemBottom_ph*deg $FrontalMirrorBottom_dy1*mm $FrontalMirrorBottom_dx1*mm $FrontalMirrorBottom_dx2*mm $FrontalSystemBottom_alp1*deg $FrontalMirrorBottom_dy2*mm $FrontalMirrorBottom_dx3*mm $FrontalMirrorBottom_dx4*mm $FrontalSystemBottom_alp2*deg";
    $detector{"material"}    = "Component";
    $detector{"style"}       = 0;

    print_det(\%configuration, \%detector);

    %detector = init_det();

    $detector{"name"}        = "FrontalFrameBottom.$sector";
    $detector{"mother"}      = "FrontalSystemBottom.$sector";
    $detector{"description"} = "Frame containing the frontal, bottom mirror and the corresponding aerogel tiles";
    $detector{"dimensions"}  = "0*mm";
    $detector{"type"}        = "Operation: FrontalSystemBottom.$sector - FrontalFrameVolumeBottom.$sector";
    $detector{"material"}    = "Aluminum";
    $detector{"style"}       = 1;

    print_det(\%configuration, \%detector);


# now define the volume used to cut the aerogel tiles so that they have the proper shape in the edges of the box

    %detector = init_det();

    $detector{"name"}        = "AerogelContainingVolumeBottom.$sector";
    $detector{"mother"}      = "FrontalSystemBottom.$sector";
    $detector{"description"} = "System containing the frontal, bottom mirror and the corresponding aerogel tiles";
    $detector{"pos"}         = "0*mm 0*mm $FrontalMirror_z*mm";
    $detector{"color"}       =  "99ffff";
    $detector{"type"}        = "G4Trap";
    $detector{"dimensions"}  = "$FrontalSystemBottom_dz*mm $FrontalSystemBottom_th*deg $FrontalSystemBottom_ph*deg $FrontalMirrorBottom_dy1*mm $FrontalMirrorBottom_dx1*mm $FrontalMirrorBottom_dx2*mm $FrontalSystemBottom_alp1*deg $FrontalMirrorBottom_dy2*mm $FrontalMirrorBottom_dx3*mm $FrontalMirrorBottom_dx4*mm $FrontalSystemBottom_alp2*deg";
    $detector{"material"}    = "Component";
    $detector{"style"}       = 0;

    print_det(\%configuration, \%detector);




# define the tiles through a loop
# first group, in correspondence of the bottom mirror, is composed of 4 raws
    # loop on the raws
    for(my $_iraw = 0; $_iraw < 4; $_iraw++){

	# to calculate the effective number of tiles per raw, calculate its length at the top level - such a calculation has to be done separately for left and rigth, since aerogel tiles are symmetric around the center of the box
	my $EffectiveSemiXLength = $FrontalSystemBottom_dx1 + ( 2*$AerogelTile_dy + $AerogelTileSeparation)*$_iraw*abs($TanOpeningAngle); # - 2*$AerogelOffset_dx ;

	# factor 2 comes from the fact that we considered only the semi length
	my $nTileInARaw = 2*POSIX::ceil( $EffectiveSemiXLength/( 2*$AerogelTile_dx + $AerogelTileSeparation ) );

	print " n tile in the raw $_iraw is $nTileInARaw\n" ;

	# calculate tile y position, that is common to the whole raw
	my $AerogelTile_y        = -$FrontalMirrorBottom_dy1 + $AerogelTile_dy*( 1 + 2*$_iraw) + $AerogelTileSeparation*$_iraw ;

	# loop now on the number of tiles per raw
	for(my $_itile = 0; $_itile < $nTileInARaw; $_itile++){

	    $AerogelTileNumber++ ;

	    my $AerogelTile_x        = -( $nTileInARaw - 1 )*( $AerogelTile_dx + $AerogelTileSeparation*0.5 ) + $_itile*( 2*$AerogelTile_dx + $AerogelTileSeparation );

#	    print " $AerogelTile_x - $AerogelTile_y for tile $_itile " ;

	    print " Tile n $AerogelTileNumber " ;

# shape the wrap

# aerogel wrap volume
	    %detector = init_det();

	    my $AerogelWrap_dx       = $AerogelTile_dx + $AerogelTileSeparation*0.5 ;
	    my $AerogelWrap_dy       = $AerogelTile_dy + $AerogelTileSeparation*0.5 ;
	    my $AerogelWrap_dz       = $AerogelTile_dz ;

	    $detector{"name"}        = "AerogelWrapBottomVolume$AerogelTileNumber.inSec$sector";
	    $detector{"mother"}      = "FrontalSystemBottom.$sector";
	    $detector{"description"} = "Aerogel Tile $AerogelTileNumber - Raw_${_iraw}";
	    $detector{"color"}       = "ffd633";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$AerogelWrap_dx*mm $AerogelWrap_dy*mm $AerogelWrap_dz*mm";
	    $detector{"material"}    = "Component";
	    $detector{"style"}       = 0;

	    print_det(\%configuration, \%detector);


# aerogel tile volume
	    %detector = init_det();

	    $detector{"name"}        = "AerogelTileBottomVolume$AerogelTileNumber.inSec$sector";
	    $detector{"mother"}      = "FrontalSystemBottom.$sector";
	    $detector{"description"} = "Aerogel Tile $AerogelTileNumber - Raw_${_iraw}";
	    $detector{"color"}       = "ffd633";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$AerogelTile_dx*mm $AerogelTile_dy*mm $AerogelTile_dz*mm";
	    $detector{"material"}    = "Component";
	    $detector{"style"}       = 0;

	    print_det(\%configuration, \%detector);

# aerogel wrap: wrap - tile volume
	    %detector = init_det();

	    $detector{"name"}        = "AerogelFullWrapBottom$AerogelTileNumber.inSec$sector";
	    $detector{"mother"}      = "FrontalSystemBottom.$sector";
	    $detector{"description"} = "Aerogel Tile $AerogelTileNumber - Raw_${_iraw}";
	    $detector{"color"}       = "7575a3";
	    $detector{"pos"}         = "${AerogelTile_x}*mm ${AerogelTile_y}*mm ${AerogelTile_z}*mm";
	    $detector{"dimensions"}  = "0*mm";
	    $detector{"type"}        = "Operation: AerogelWrapBottomVolume$AerogelTileNumber.inSec$sector - AerogelTileBottomVolume$AerogelTileNumber.inSec$sector";
	    $detector{"material"}    = "Component";
	    $detector{"style"}       = 0;

	    print_det(\%configuration, \%detector);

	    # aerogel tile
	    %detector = init_det();

	    $detector{"name"}        = "AerogelFullTileBottom$AerogelTileNumber.inSec$sector";
	    $detector{"mother"}      = "FrontalSystemBottom.$sector";
	    $detector{"description"} = "Aerogel Tile $AerogelTileNumber - Raw_${_iraw}";
	    $detector{"pos"}         = "${AerogelTile_x}*mm ${AerogelTile_y}*mm ${AerogelTile_z}*mm";
	    $detector{"color"}       = "ffd633";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$AerogelTile_dx*mm $AerogelTile_dy*mm $AerogelTile_dz*mm";
	    $detector{"material"}    = "Component";
	    $detector{"style"}       = 0;

	    print_det(\%configuration, \%detector);


# cut the tiles and their wraps through the containing volume FrontalSystemBottom

	    # aerogel tile
	    %detector = init_det();

	    $detector{"name"}        = "AerogelTileBottom$AerogelTileNumber.inSec$sector";
	    $detector{"mother"}      = "FrontalSystemBottom.$sector";
	    $detector{"description"} = "Aerogel Tile $AerogelTileNumber - Raw_${_iraw}";
	    $detector{"color"}       = "ffd633";
	    $detector{"dimensions"}  = "0*mm";
	    $detector{"type"}        = "Operation: AerogelContainingVolumeBottom.$sector * AerogelFullTileBottom$AerogelTileNumber.inSec$sector";
	    $detector{"material"}    = "aerogel";
	    $detector{"style"}       = 0;

	    print_det(\%configuration, \%detector);

	    # aerogel wrap
	    %detector = init_det();

	    $detector{"name"}        = "AerogelWrapBottom$AerogelTileNumber.inSec$sector";
	    $detector{"mother"}      = "FrontalSystemBottom.$sector";
	    $detector{"description"} = "Aerogel Wrap $AerogelTileNumber - Raw_${_iraw}";
	    $detector{"color"}       = "7575a3";
	    $detector{"dimensions"}  = "0*mm";
	    $detector{"type"}        = "Operation: AerogelContainingVolumeBottom.$sector * AerogelFullWrapBottom$AerogelTileNumber.inSec$sector";
	    $detector{"material"}    = "G4_AIR";
	    $detector{"style"}       = 1;

	    print_det(\%configuration, \%detector);

=begin GHOSTCODE

=end GHOSTCODE

=cut


	} # it closes the loop on the aerogel tiles

    } # it closes the loop on the raws


}

sub build_frontal_system_top
{

# start creating the volume representing the frame occupancy
    my $sector = shift;

    my %detector = init_det();
    $detector{"name"}        = "FrontalSystemTop.$sector";
    $detector{"mother"}      = "rich_box.$sector";
    $detector{"description"} = "System containing the frontal, top mirror and the corresponding aerogel tiles";
    $detector{"pos"}         = " ${FrontalSystemTop_x}*mm ${FrontalSystemTop_y}*mm ${FrontalSystemTop_z}*mm";
    $detector{"rotation"}    = "0*deg 0*deg 0*deg";
    $detector{"color"}       =  "adad85";
    $detector{"type"}        = "G4Trap";
    $detector{"dimensions"}  = "$FrontalSystemTop_dz*mm $FrontalSystemTop_th*deg $FrontalSystemTop_ph*deg $FrontalSystemTop_dy1*mm $FrontalSystemTop_dx1*mm $FrontalSystemTop_dx2*mm $FrontalSystemTop_alp1*deg $FrontalSystemTop_dy2*mm $FrontalSystemTop_dx3*mm $FrontalSystemTop_dx4*mm $FrontalSystemTop_alp2*deg";
    $detector{"material"}    = "Gas_inGap";
    $detector{"style"}       = 0;

    print_det(\%configuration, \%detector);

# now define the mirror, that is the frame minus its width = 2mm - it is contained inside the frame volume

    my $FrontalMirrorTop_dx1   = $FrontalSystemTop_dx1 - $FrontalMirrorFrameWidth*cos( $OpeningAngle/$RAD ) ; 
    my $FrontalMirrorTop_dx2   = $FrontalSystemTop_dx2 - $FrontalMirrorFrameWidth*cos( $OpeningAngle/$RAD ) ; 
    my $FrontalMirrorTop_dx3   = $FrontalSystemTop_dx3 - $FrontalMirrorFrameWidth*cos( $OpeningAngle/$RAD ) ;  
    my $FrontalMirrorTop_dx4   = $FrontalSystemTop_dx4 - $FrontalMirrorFrameWidth*cos( $OpeningAngle/$RAD ) ;  
    my $FrontalMirrorTop_dy1   = $FrontalSystemTop_dy1 - $FrontalMirrorFrameWidth ; 
    my $FrontalMirrorTop_dy2   = $FrontalSystemTop_dy2 - $FrontalMirrorFrameWidth ;   

    %detector = init_det();
    $detector{"name"}        = "FrontalMirrorTop.$sector";
    $detector{"mother"}      = "FrontalSystemTop.$sector";
    $detector{"description"} = "System containing the frontal, top mirror and the corresponding aerogel tiles";
    $detector{"pos"}         = "0*mm 0*mm $FrontalMirror_z*mm";
    $detector{"color"}       =  "99ffff";
    $detector{"type"}        = "G4Trap";
    $detector{"dimensions"}  = "$FrontalMirror_dz*mm $FrontalSystemTop_th*deg $FrontalSystemTop_ph*deg $FrontalMirrorTop_dy1*mm $FrontalMirrorTop_dx1*mm $FrontalMirrorTop_dx2*mm $FrontalSystemTop_alp1*deg $FrontalMirrorTop_dy2*mm $FrontalMirrorTop_dx3*mm $FrontalMirrorTop_dx4*mm $FrontalSystemTop_alp2*deg";
    $detector{"material"}    = "CarbonFiber";
    $detector{"style"}       = 1;

    print_det(\%configuration, \%detector);


# now the define the frame that contains the mirror and the aerogel
# volume to cut

    %detector = init_det();
    $detector{"name"}        = "FrontalFrameVolumeTop.$sector";
    $detector{"mother"}      = "FrontalSystemTop.$sector";
    $detector{"description"} = "System containing the frontal, top mirror and the corresponding aerogel tiles";
    $detector{"color"}       =  "99ffff";
    $detector{"type"}        = "G4Trap";
    $detector{"dimensions"}  = "$FrontalSystemTop_dz*mm $FrontalSystemTop_th*deg $FrontalSystemTop_ph*deg $FrontalMirrorTop_dy1*mm $FrontalMirrorTop_dx1*mm $FrontalMirrorTop_dx2*mm $FrontalSystemTop_alp1*deg $FrontalMirrorTop_dy2*mm $FrontalMirrorTop_dx3*mm $FrontalMirrorTop_dx4*mm $FrontalSystemTop_alp2*deg";
    $detector{"material"}    = "Component";
    $detector{"style"}       = 0;

    print_det(\%configuration, \%detector);

    %detector = init_det();

    $detector{"name"}        = "FrontalFrameTop.$sector";
    $detector{"mother"}      = "FrontalSystemTop.$sector";
    $detector{"description"} = "Frame containing the frontal, top mirror and the corresponding aerogel tiles";
    $detector{"dimensions"}  = "0*mm";
    $detector{"type"}        = "Operation: FrontalSystemTop.$sector - FrontalFrameVolumeTop.$sector";
    $detector{"material"}    = "Aluminum";
    $detector{"style"}       = 1;

    print_det(\%configuration, \%detector);


# now define the volume used to cut the aerogel tiles so that they have the proper shape in the edges of the box

    %detector = init_det();

    $detector{"name"}        = "AerogelContainingVolumeTop.$sector";
    $detector{"mother"}      = "FrontalSystemTop.$sector";
    $detector{"description"} = "System containing the frontal, top mirror and the corresponding aerogel tiles";
    $detector{"pos"}         = "0*mm 0*mm $FrontalMirror_z*mm";
    $detector{"color"}       =  "99ffff";
    $detector{"type"}        = "G4Trap";
    $detector{"dimensions"}  = "$FrontalSystemTop_dz*mm $FrontalSystemTop_th*deg $FrontalSystemTop_ph*deg $FrontalMirrorTop_dy1*mm $FrontalMirrorTop_dx1*mm $FrontalMirrorTop_dx2*mm $FrontalSystemTop_alp1*deg $FrontalMirrorTop_dy2*mm $FrontalMirrorTop_dx3*mm $FrontalMirrorTop_dx4*mm $FrontalSystemTop_alp2*deg";
    $detector{"material"}    = "Component";
    $detector{"style"}       = 0;

    print_det(\%configuration, \%detector);




# define the tiles through a loop
# first group, in correspondence of the top mirror, is composed of 4 raws
    # loop on the raws
    for(my $_iraw = 0; $_iraw < 4; $_iraw++){

	# to calculate the effective number of tiles per raw, calculate its length at the top level - such a calculation has to be done separately for left and rigth, since aerogel tiles are symmetric around the center of the box
	my $EffectiveSemiXLength = $FrontalSystemTop_dx1 + ( 2*$AerogelTile_dy + $AerogelTileSeparation)*$_iraw*abs($TanOpeningAngle); # - 2*$AerogelOffset_dx ;

	# factor 2 comes from the fact that we considered only the semi length
	my $nTileInARaw = 2*POSIX::ceil( $EffectiveSemiXLength/( 2*$AerogelTile_dx + $AerogelTileSeparation ) );

	print " n tile in the raw $_iraw is $nTileInARaw\n" ;

	# calculate tile y position, that is common to the whole raw
	my $AerogelTile_y        = -$FrontalMirrorTop_dy1 + $AerogelTile_dy*( 1 + 2*$_iraw) + $AerogelTileSeparation*$_iraw ;

	# loop now on the number of tiles per raw
	for(my $_itile = 0; $_itile < $nTileInARaw; $_itile++){

	    $AerogelTileNumber++ ;

	    my $AerogelTile_x        = -( $nTileInARaw - 1 )*( $AerogelTile_dx + $AerogelTileSeparation*0.5 ) + $_itile*( 2*$AerogelTile_dx + $AerogelTileSeparation );

#	    print " $AerogelTile_x - $AerogelTile_y for tile $_itile " ;

	    print " Tile n $AerogelTileNumber " ;

# shape the wrap

# aerogel wrap volume
	    %detector = init_det();

	    my $AerogelWrap_dx       = $AerogelTile_dx + $AerogelTileSeparation*0.5 ;
	    my $AerogelWrap_dy       = $AerogelTile_dy + $AerogelTileSeparation*0.5 ;
	    my $AerogelWrap_dz       = $AerogelTile_dz ;

	    $detector{"name"}        = "AerogelWrapTopVolume$AerogelTileNumber.inSec$sector";
	    $detector{"mother"}      = "FrontalSystemTop.$sector";
	    $detector{"description"} = "Aerogel Tile $AerogelTileNumber - Raw_${_iraw}";
	    $detector{"color"}       = "ffd633";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$AerogelWrap_dx*mm $AerogelWrap_dy*mm $AerogelWrap_dz*mm";
	    $detector{"material"}    = "Component";
	    $detector{"style"}       = 0;

	    print_det(\%configuration, \%detector);


# aerogel tile volume
	    %detector = init_det();

	    $detector{"name"}        = "AerogelTileTopVolume$AerogelTileNumber.inSec$sector";
	    $detector{"mother"}      = "FrontalSystemTop.$sector";
	    $detector{"description"} = "Aerogel Tile $AerogelTileNumber - Raw_${_iraw}";
	    $detector{"color"}       = "ffd633";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$AerogelTile_dx*mm $AerogelTile_dy*mm $AerogelTile_dz*mm";
	    $detector{"material"}    = "Component";
	    $detector{"style"}       = 0;

	    print_det(\%configuration, \%detector);

# aerogel wrap: wrap - tile volume
	    %detector = init_det();

	    $detector{"name"}        = "AerogelFullWrapTop$AerogelTileNumber.inSec$sector";
	    $detector{"mother"}      = "FrontalSystemTop.$sector";
	    $detector{"description"} = "Aerogel Tile $AerogelTileNumber - Raw_${_iraw}";
	    $detector{"color"}       = "7575a3";
	    $detector{"pos"}         = "${AerogelTile_x}*mm ${AerogelTile_y}*mm ${AerogelTile_z}*mm";
	    $detector{"dimensions"}  = "0*mm";
	    $detector{"type"}        = "Operation: AerogelWrapTopVolume$AerogelTileNumber.inSec$sector - AerogelTileTopVolume$AerogelTileNumber.inSec$sector";
	    $detector{"material"}    = "Component";
	    $detector{"style"}       = 0;

	    print_det(\%configuration, \%detector);

	    # aerogel tile
	    %detector = init_det();

	    $detector{"name"}        = "AerogelFullTileTop$AerogelTileNumber.inSec$sector";
	    $detector{"mother"}      = "FrontalSystemTop.$sector";
	    $detector{"description"} = "Aerogel Tile $AerogelTileNumber - Raw_${_iraw}";
	    $detector{"pos"}         = "${AerogelTile_x}*mm ${AerogelTile_y}*mm ${AerogelTile_z}*mm";
	    $detector{"color"}       = "ffd633";
	    $detector{"type"}        = "Box";
	    $detector{"dimensions"}  = "$AerogelTile_dx*mm $AerogelTile_dy*mm $AerogelTile_dz*mm";
	    $detector{"material"}    = "Component";
	    $detector{"style"}       = 0;

	    print_det(\%configuration, \%detector);


# cut the tiles and their wraps through the containing volume FrontalSystemTop

	    # aerogel tile
	    %detector = init_det();

	    $detector{"name"}        = "AerogelTileTop$AerogelTileNumber.inSec$sector";
	    $detector{"mother"}      = "FrontalSystemTop.$sector";
	    $detector{"description"} = "Aerogel Tile $AerogelTileNumber - Raw_${_iraw}";
	    $detector{"color"}       = "ffd633";
	    $detector{"dimensions"}  = "0*mm";
	    $detector{"type"}        = "Operation: AerogelContainingVolumeTop.$sector * AerogelFullTileTop$AerogelTileNumber.inSec$sector";
	    $detector{"material"}    = "aerogel";
	    $detector{"style"}       = 0;

	    print_det(\%configuration, \%detector);

	    # aerogel wrap
	    %detector = init_det();

	    $detector{"name"}        = "AerogelWrapTop$AerogelTileNumber.inSec$sector";
	    $detector{"mother"}      = "FrontalSystemTop.$sector";
	    $detector{"description"} = "Aerogel Wrap $AerogelTileNumber - Raw_${_iraw}";
	    $detector{"color"}       = "7575a3";
	    $detector{"dimensions"}  = "0*mm";
	    $detector{"type"}        = "Operation: AerogelContainingVolumeTop.$sector * AerogelFullWrapTop$AerogelTileNumber.inSec$sector";
	    $detector{"material"}    = "G4_AIR";
	    $detector{"style"}       = 1;

	    print_det(\%configuration, \%detector);

=begin GHOSTCODE

=end GHOSTCODE

=cut


	} # it closes the loop on the aerogel tiles

    } # it closes the loop on the raws


}



1;

