use strict;
use warnings;

our %configuration;
our %parameters;


## Assign parameters to local variables:

my $sectors  = 24; # $parameters{"sectors"};  
my $layers  = 3; # $parameters{"layers"};   # per sector
my $paddles = 2; # $parameters{"paddles"};  # per layer

my $length1 = 66.572; # $parameters{"paddles_length1"};  # length of paddles in each layer, numbered outwards from center
my $length2 = 70; # $parameters{"paddles_length2"};
my $length3 = 73.428; # $parameters{"paddles_length3"};

my $lengthLG1 = 9.5; # length of light guides in each layer, numbered outwards from center                            <--------<<
my $lengthLG2 = 9.32;
my $lengthLG3 = 7.748;

my $lgthLG1 = 86.83;									  ##       ####
my $lgthLG2 = 83.70;									#############     length of long, angled part of light guides
my $lgthLG3 = 80.43;									  ##       ####

my $angleLG1 = 35;
my $angleLG2 = 37.5;
my $angleLG3 = 40;

my $r0 = 29; # $parameters{"inner_radius"};   # doesn't include the wrapping
my $r1 = 38.2; # $parameters{"outer_radius"};

my $z_offset1 = -3.528; # $parameters{"z0_layer1"};  # offset of center of paddles in layer 1 from center of mother volume
my $z_offset2 = -1.014; # $parameters{"z0_layer2"};
my $z_offset3 = 0.7; # $parameters{"z0_layer3"};

my $mother_offset = -2.185; # $parameters{"z0_mothervol"}; # offset of center of mother volume from magnet center

my $mother_clearance = 0.05; # $parameters{"mothervol_z_gap"};    # cm, clearance at either end of mother volume
my $mother_gap1      = 0.05; # $parameters{"mothervol_gap_in"};   # cm, clearance on the inside of mother volume (just to fit in wrapping)
my $mother_gap2      = 0.36; # $parameters{"mothervol_gap_out"};  # cm, clearance on outside of mother volume (to allow for the corners of the trapezoid paddles)

my $layer_gap  = 0.1; # $parameters{"layer_gap"};
my $paddle_gap = 0.05; # $parameters{"paddle_gap"};
my $block_gap  = 0.4; # $parameters{"sector_gap"};  # gap either side of each sector

my $wrap_thickness = 0.003; # $parameters{"wrap_thickness"};  # total thickness of wrapping material

my $uturn_r_1  = 4.012; # $parameters{"uturn_i_radius"};  # larger radius of uturn for inner layer
my $uturn_r_2  = 4.42; # $parameters{"uturn_m_radius"};  # larger radius of uturn for middle layer
my $uturn_r_3  = 4.828; # $parameters{"uturn_o_radius"};  # larger radius of uturn for outer layer

my @length      = ($length1, $length2, $length3);                      # full length of the paddles
my @lengthLG    = ($lengthLG1, $lengthLG2, $lengthLG3);                # full length of the light guides                          <--------<<
my @lengthLGang = ($lgthLG1, $lgthLG2, $lgthLG3);                      # length of light guides at angle                          <--------<<
my @angleLGang  = ($angleLG1, $angleLG2, $angleLG3);                   # angle of light guides at angle                           <--------<<
my @uturn_r     = ($uturn_r_1, $uturn_r_2, $uturn_r_3);                # uturn radius values
my @z_offset    = ($z_offset1, $z_offset2, $z_offset3);                # offset of center of each paddle wrt center of magnet
my $angle_slice = 360.0/($paddles*$sectors);                                    # degrees, angle corresponding to one segment in phi
my $dR          = ($r1 - $r0 - (($layers-1) * $layer_gap)) / $layers;  # thickness of one layer (assuming all layers are equally thick)

my @zfOS        = (3.16, 1.58, 0);                                     #                                                          <--------<<

my @pcolor = ('33dd66', '239a47', '145828');  # paddle colors by layer
my @lcolor = ('eeeeee', 'cccccc', 'aaaaaa');  # light guide colors by layer                                                       <--------<<
my $wcolor = 'af3cff';  # wrapping color
my $ucolor =  '3c78ff';  # u-turn color

my $half_diff = 0;
my $momdz     = 0;

####################################################################################
=pod

Hierarchy:	24 sectors, 3 layers, 2 components (paddles).
			Each layer of each sector has one u-turn associated with it.

The CND consists of 24 sectors (blocks), each with 3 layers of 2 paddles coupled
at the downstream end by a lightguide u-turn.

Looking downstream, one sector:
	                    ____  ____
	Upper layer  (#3)   \___||___/
	Middle layer (#2)    \__||__/
	Lower layer  (#1)     \_||_/

	Left paddle (#1), right paddle (#2).

Looking downstream, the x-axis (phi=0) is to the left (9 o'clock) and the y-axis
points upwards (12 o'clock).

Sector numbering increases clockwise from 1-24.

=cut
####################################################################################


sub build_cndUpstream
{
	build_cndMother();
	build_lightguides();
}


# Mother Volume
sub build_cndMother
{
	my $longest_half1 = 100.;
	my $longest_half2 = 0.;
	# my $shortest_half2 = 0.;
	for(my $j=0; $j<$layers; $j++)
	{
		my $temp_dz1 = 0.5 * $length[$j] - $z_offset[$j] + $lengthLG[$j];  #upstream half
		my $temp_dz2 = 0.5 * $length[$j] + $z_offset[$j] + $uturn_r[$j];  #downstream half
		
		if ($longest_half1 > $temp_dz1){
			$longest_half1 = $temp_dz1;
		}
		if ($longest_half2 < $temp_dz2){
			$longest_half2 = $temp_dz2;
		}
	}
	
	my $mother_dz = ($longest_half1 + $longest_half2) * 0.5 + $mother_clearance;
	my $mother_mid = $mother_dz-($length3-$length2)*2.2;
	$half_diff = 0.5 * ($longest_half2 - $longest_half1);
	$momdz     = -$mother_dz - 0.11; #                                                                             <--------<<
	my $IR = $r0 - $mother_gap1;
	my $OR = $r1 + $mother_gap2;
	my $MR = $OR - $dR;
	my $zpos = $mother_offset + $half_diff + 140; #                                                              <--------<<
	
	my $nplanes = 3; #6 5             72.86
	my @z_plane = ($momdz-$lengthLGang[0]-5, $momdz-3.2, $momdz);
	my @oradius = (               $OR+77.86,      $OR+5,  $OR+1);
	my @iradius = (               $IR+60.80,        $IR,    $IR);

	my %detector = init_det();
	$detector{"name"}        = "cndUpstream";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Central Neutron Detector";
	$detector{"pos"}         = "0*cm 0*cm $zpos*cm";
	$detector{"rotation"}    = "180*deg 0*deg 0*deg";
	$detector{"color"}       = "33bb99";
	$detector{"type"}        = "Polycone";
	my $dimen = "0.0*deg 360*deg $nplanes*counts";
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $iradius[$i]*cm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $oradius[$i]*cm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $z_plane[$i]*cm";}
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = "G4_AIR";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);
}

# Lightguides ************************************************
sub build_lightguides
{

	for(my $i=1; $i<=$sectors; $i++){ # ##########################################################################################35555555555

		for(my $j=1; $j<=$layers; $j++){

			my $innerRadius = $r0 + ($j-1)*$dR + ($j-1)*$layer_gap;
			my $outerRadius = $innerRadius + $dR;

			my $dz = $lengthLG[$j-1] / 2.0;
			my $z = sprintf("%.3f", $z_offset[$j-1]);

			# x-positions of paddle's angled side's bottom and top vertices

			my $bottom_x = $innerRadius*tan(rad($angle_slice)) - (0.5*$block_gap)/(cos(rad($angle_slice)));
			my $top_x = $outerRadius*tan(rad($angle_slice)) - (0.5*$block_gap)/(cos(rad($angle_slice)));

			for(my $k=1; $k<=$paddles; $k++){
				
				# increment sector angle by 15 deg for every sector
				# start position is at 9 o'clock when looking downstream!

				my $theta = -(($i-1)*(2*$angle_slice))-$angle_slice+90.0;                           #                      ##
				my $xphi  = -$angleLGang[$j-1]*cos(rad($theta));                                                   #     ####
				my $yphi  = $angleLGang[$j-1]*sin(rad($theta));                                                    #   ###########################
				my $xpo   = -10*cos(rad($theta));                                                   #                    ####
				my $ypo   = 10*sin(rad($theta));                                                    #                      ##
				my $zpo   = 0;
				my $zlgth = $lengthLGang[$j-1] / 2.0;
				my $vdx   = 10*cos(rad($theta));

########################################
=pod

Vertex positions to use in lightguide creation can be found above in paddle creation.

=cut
######################################## 

				#odd (left) lightguides
				if ($k%2 == 1)
				{	
					#required vertices
					my $ver1x = (0.5)*$paddle_gap;
					my $ver1y = $innerRadius;
					my $ver2x = (0.5)*$paddle_gap;
					my $ver2y = $outerRadius;
					my $ver3x = $top_x;
					my $ver3y = $outerRadius;
					my $ver4x = $bottom_x;
					my $ver4y = $innerRadius;

					my @vh    = (60.80, 64.22, 67.49);
					 my $v1x   = $ver1x+2;
					my $v1y   = $ver1y+$vh[$j-1];
					 my $v2x   = $ver2x+2;
					my $v2y   = $ver2y+$vh[$j-1];
					 my $v3x   = $ver3x+2;
					my $v3y   = $ver3y+$vh[$j-1];
					my $v4x   = $ver4x+2;
					my $v4y   = $ver4y+$vh[$j-1];
					
					my $z_final = $z-$half_diff-$length[$j-1]/2-$lengthLG[$j-1]/2;     # <--------<<
					my $dzfin   = $lengthLGang[$j-1]/2;
					my $z_fin   = $momdz - $dzfin - $zfOS[$j-1]; # $z-$half_diff-$length[$j-1]-$lengthLG[$j-1]/2-5;                         #<--------<<
					my $name_string = join('','lgCND_S',$i,'_L',$j,'_C',$k);		# <--------<<
					my $desc_string = join('','Central Neutron Detector, S ',$i,', L ',$j,', C ',$k);		
					my $id_string = join('','sector manual ',$i,' layer manual ',$j,' component manual ',$k);							

					my %detector = init_det();
					$detector{"name"}        = $name_string;
					$detector{"mother"}      = "cndUpstream";
					$detector{"description"} = $desc_string;
					$detector{"pos"}         = "0*cm 0*cm $z_final*cm";
					$detector{"color"}       = $lcolor[$j-1];                        # <--------<<
					$detector{"rotation"}    = "0*deg 0*deg $theta*deg";
					$detector{"type"}        = "G4GenericTrap";
					$detector{"dimensions"}  = "$dz*cm $ver1x*cm $ver1y*cm $ver2x*cm $ver2y*cm $ver3x*cm $ver3y*cm $ver4x*cm $ver4y*cm $ver1x*cm $ver1y*cm $ver2x*cm $ver2y*cm $ver3x*cm $ver3y*cm $ver4x*cm $ver4y*cm";
					$detector{"material"}    = "G4_PLEXIGLASS";
					$detector{"visible"}     = 1;
					$detector{"style"}       = 1;
					$detector{"ncopy"}       = $i;
					$detector{"sensitivity"} = "cnd";
					$detector{"hit_type"}    = "cnd";
					$detector{"identifiers"} = $id_string;
					print_det(\%configuration, \%detector);

					$name_string = join('','longlgCND_S',$i,'_L',$j,'_C',$k);		# <--------<<
					$desc_string = join('','Central Neutron Detector, S ',$i,', L ',$j,', C ',$k);		
					$id_string = join('','sector manual ',$i,' layer manual ',$j,' component manual ',$k);		

					# my %detector = init_det();
					$detector{"name"}        = $name_string;
					$detector{"mother"}      = "cndUpstream";
					$detector{"description"} = $desc_string;
					$detector{"pos"}         = "0*cm 0*cm $z_fin*cm";
					$detector{"color"}       = 991111; # $lcolor[$j-1];                        # <--------<<
					$detector{"rotation"}    = "0*deg 0*deg $theta*deg";
					$detector{"type"}        = "G4GenericTrap";
					$detector{"dimensions"}  = "$dzfin*cm $v1x*cm $v1y*cm $v2x*cm $v2y*cm $v3x*cm $v3y*cm $v4x*cm $v4y*cm $ver1x*cm $ver1y*cm $ver2x*cm $ver2y*cm $ver3x*cm $ver3y*cm $ver4x*cm $ver4y*cm";
					$detector{"material"}    = "G4_PLEXIGLASS";
					$detector{"visible"}     = 1;
					$detector{"style"}       = 1;
					$detector{"ncopy"}       = $i;
					$detector{"sensitivity"} = "cnd";
					$detector{"hit_type"}    = "cnd";
					$detector{"identifiers"} = $id_string;
					print_det(\%configuration, \%detector);

				}

				else
				{				
					#required vertices
					my $ver1x = -$bottom_x;
					my $ver1y = $innerRadius;
					my $ver2x = -$top_x;
					my $ver2y = $outerRadius;
					my $ver3x = -(0.5)*$paddle_gap;
					my $ver3y = $outerRadius;
					my $ver4x = -(0.5)*$paddle_gap;
					my $ver4y = $innerRadius;
					
					my @vh    = (60.80, 64.22, 67.49);
					 my $v1x   = $ver1x-2;
					my $v1y   = $ver1y+$vh[$j-1];
					 my $v2x   = $ver2x-2;
					my $v2y   = $ver2y+$vh[$j-1];
					 my $v3x   = $ver3x-2;
					my $v3y   = $ver3y+$vh[$j-1];
					 my $v4x   = $ver4x-2;
					my $v4y   = $ver4y+$vh[$j-1];

					my $z_final = $z-$half_diff-$length[$j-1]/2-$lengthLG[$j-1]/2;
					my $dzfin   = $lengthLGang[$j-1]/2;
					my $z_fin   = $momdz - $dzfin - $zfOS[$j-1]; # $z-$half_diff-$length[$j-1]-$lengthLG[$j-1]/2-5;                         #<--------<<
					my $name_string = join('','lgCND_S',$i,'_L',$j,'_C',$k);	
					my $desc_string = join('','Central Neutron Detector, S ',$i,', L ',$j,', C ',$k);		
					my $id_string = join('','sector manual ',$i,' layer manual ',$j,' component manual ',$k);							

					my %detector = init_det();
					$detector{"name"}        = $name_string;
					$detector{"mother"}      = "cndUpstream";
					$detector{"description"} = $desc_string;
					$detector{"pos"}         = "0*cm 0*cm $z_final*cm";
					$detector{"color"}       = $lcolor[$j-1];
					$detector{"rotation"}    = "0*deg 0*deg $theta*deg";
					$detector{"type"}        = "G4GenericTrap";
					$detector{"dimensions"}  = "$dz*cm $ver1x*cm $ver1y*cm $ver2x*cm $ver2y*cm $ver3x*cm $ver3y*cm $ver4x*cm $ver4y*cm $ver1x*cm $ver1y*cm $ver2x*cm $ver2y*cm $ver3x*cm $ver3y*cm $ver4x*cm $ver4y*cm";
					$detector{"material"}    = "G4_LUCITE";
					$detector{"visible"}     = 1;
					$detector{"style"}       = 1;
					$detector{"ncopy"}       = $i;
					$detector{"sensitivity"} = "cnd";
					$detector{"hit_type"}    = "cnd";
					$detector{"identifiers"} = $id_string;
					print_det(\%configuration, \%detector);

					$name_string = join('','longlgCND_S',$i,'_L',$j,'_C',$k);		# <--------<<
					$desc_string = join('','Central Neutron Detector, S ',$i,', L ',$j,', C ',$k);		
					$id_string = join('','sector manual ',$i,' layer manual ',$j,' component manual ',$k);		

					# my %detector = init_det(); #########################################ANGLED LIGHT GUIDES
					$detector{"name"}        = $name_string;
					$detector{"mother"}      = "cndUpstream";
					$detector{"description"} = $desc_string;
					$detector{"pos"}         = "0*cm 0*cm $z_fin*cm"; # ($z_final-$lengthLG[$j-1]/2)*cm";
					$detector{"color"}       = 777777; # $lcolor[$j-1];                        # <--------<<
					$detector{"rotation"}    = "0*deg 0*deg $theta*deg";
					$detector{"type"}        = "G4GenericTrap";
					$detector{"dimensions"}  = "$dzfin*cm $v1x*cm $v1y*cm $v2x*cm $v2y*cm $v3x*cm $v3y*cm $v4x*cm $v4y*cm $ver1x*cm $ver1y*cm $ver2x*cm $ver2y*cm $ver3x*cm $ver3y*cm $ver4x*cm $ver4y*cm";
					$detector{"material"}    = "G4_PLEXIGLASS";
					$detector{"visible"}     = 1;
					$detector{"style"}       = 1;
					$detector{"ncopy"}       = $i;
					$detector{"sensitivity"} = "cnd";
					$detector{"hit_type"}    = "cnd";
					$detector{"identifiers"} = $id_string;
					print_det(\%configuration, \%detector);

				}
			}
		}
	}
}



1;
