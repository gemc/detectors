use strict;
use warnings;

our %configuration;

our $inches;
our $TorusZpos;
our $SteelFrameLength;

################################################################
#
# all dimensions are in mm
#
################################################################

# Downstream beamline is a 4cm thick pipe of lead, with OD = 350 mm
my $bp_zpos          = $TorusZpos + $SteelFrameLength ; # back plate z position
my $face_plate_LE    = 1.0*$inches/2.0;

##############################
# PIPE - after Torus Ring
##############################
my $thickness = 40.0;
my $dpipe_OR  = 350.0/2.0;
my $dpipe_IR  = $dpipe_OR - $thickness;
my $dpipe_le  = 1000.0;    # total length
my $dpipe_sp  = 0.0001;    # space between pipe and torus
my $lead_shield_thickness = 10.65*$inches; # max 17.65
#my $pipe_zpos =  $bp_zpos + $dpipe_le + $dpipe_sp + $lead_shield_thickness;
my $pipe_zpos =  $bp_zpos + $dpipe_le + $dpipe_sp + 17.65*$inches;

################################
# W SHIELD - after Torus Ring
################################
my $nplanes    = 4;
my $ColdHubIR  =  62.0 ;     # Warm bore tube ID is 124 as from DK drawing
# Numbers coming from ROOT macro
# Corner:            1              2            3             4
my @zplane   = (     0.0    ,     $lead_shield_thickness   ,    $lead_shield_thickness + 0.1     ,   300.0     );
my @oradius  = (   170.0    ,     170.0   ,     134.99    ,   134.99   );
my @iradius  = ( $ColdHubIR ,  $ColdHubIR ,   $ColdHubIR ,  $ColdHubIR );
my $zstart   = $bp_zpos + 1.0;

#########################################
# Vacuum Pipe: inside and after the torus
#########################################
my $TIR      = 37.6;                    # Torus ID is 75.2 mm
my $pthick   = 2.0;                     # Pipe thickness through the Torus Ring
my $gap      = 0.1;                     # gap between Torus ring and vacuum pipe
my $vpipe_le = 6000;                    # 6 meters long
my $pipe_back_shift = 39.6;             # to meet the moeller absorber
#my $vpipe_z  = $TorusZpos + $vpipe_le - $SteelFrameLength - $pipe_back_shift;  # z position - to meet the moeller absorber
#my $vpipe_OR = $TIR -  $gap;            #
my $vpipe_z  = $TorusZpos + $vpipe_le - $SteelFrameLength;  # z position - to meet the moeller absorber
my $vpipe_OR = 60.;    #  OR of shielding
my $vpipe_MR = 40;     #  OR of vacuum pipe
my $vpipe_IR = 37;     #  OR of vacuum

# this makes beamline that runs through torus
# as well as the shielding that surrounds it.
sub make_beamline_torus()
{
	my %detector = init_det();
# beamline shielding
	$detector{"name"}        = "beamline_pipe_shielding";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Pipe after Torus Ring";
	$detector{"pos"}         = "0*mm 0.0*mm $vpipe_z*mm";
	$detector{"color"}       = "999966";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm $vpipe_OR*mm $vpipe_le*mm 0.0*deg 360*deg";
	$detector{"material"}    = "beamline_W";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
# Alimunum inside
	$detector{"name"}        = "beamline_pipe";
	$detector{"mother"}      = "beamline_pipe_shielding";
	$detector{"description"} = "Aluminum Pipe after Torus Ring";
	$detector{"pos"}         = "0*mm 0.0*mm 0*mm";
	$detector{"color"}       = "87AFC7";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm $vpipe_MR*mm $vpipe_le*mm 0.0*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
# Vacuum inside
	$detector{"name"}        = "beamline_vacuum";
	$detector{"mother"}      = "beamline_pipe";
	$detector{"description"} = "Vacuum Pipe after Torus Ring";
	$detector{"pos"}         = "0*mm 0.0*mm 0*mm";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "0*mm $vpipe_IR*mm $vpipe_le*mm 0.0*deg 360*deg";
	$detector{"material"}    = "Vacuum";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub make_downstream_shielding
{

my($nose_l,$nose_or,$nose_material) = @_;

# we need to recalculate some parameters 
my @zplane   = (0.0, $lead_shield_thickness, $lead_shield_thickness +0.1,$nose_l+17.65*$inches);
my @oradius  = ($nose_or   ,$nose_or,     134.99    ,   134.99   );


# shield pipe
	my %detector = init_det();
	$detector{"name"}        = "pipe_after_torus_ring";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Pipe after Torus Ring";
	$detector{"color"}       = "993333";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0.0*mm $pipe_zpos*mm";
	$detector{"dimensions"}  = "$dpipe_IR*mm $dpipe_OR*mm $dpipe_le*mm 0.0*deg 360*deg";
	$detector{"material"}    = "beamline_W";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
# nose after torus (17.66 in room to work with)
	$detector{"name"}        = "pipe_after_torus_ring_shield";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Shielding after Torus Ring";
	$detector{"pos"}         = "0*mm 0.0*mm $zstart*mm";
	$detector{"color"}       = "0000ff";
	$detector{"type"}        = "Polycone";
	my $dimen = "0.0*deg 360*deg $nplanes*counts";
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $iradius[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $oradius[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $zplane[$i]*mm";}
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = $nose_material;
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}

sub make_orig
{
# shield pipe
	my %detector = init_det();
	$detector{"name"}        = "pipe_after_torus_ring";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Pipe after Torus Ring";
	$detector{"color"}       = "993333";
	$detector{"type"}        = "Tube";
	$detector{"pos"}         = "0*mm 0.0*mm $pipe_zpos*mm";
	$detector{"dimensions"}  = "$dpipe_IR*mm $dpipe_OR*mm $dpipe_le*mm 0.0*deg 360*deg";
	$detector{"material"}    = "beamline_W";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}
