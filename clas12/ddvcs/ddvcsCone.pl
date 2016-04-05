use strict;
use warnings;
use Getopt::Long;
use Math::Trig;

our %configuration;
our $microgap;

our $CZpos;    # Position of the front face of the crystals
our $Clength;    # Crystal length in mm

our $supportLength;

our $pipeOR ;
our $CrminU;

our $Smax;

our $TSrmax;
our $TSThick;
our $TSLength;


sub buildBeamShield
{
	
   my $startz = $CZpos +  $Clength + $supportLength + $microgap;
	
   my $pipeORS = $pipeOR + $microgap;

	my @mucal_zpos    = ( $startz , $startz+ $TSThick  , $startz + $TSThick , $startz + $TSLength);
   my @mucal_iradius = ( $pipeORS, $pipeORS           , $pipeORS           ,  $pipeORS          );
   my @mucal_oradius = ( $Smax   , $TSrmax            , $CrminU            ,  $CrminU           );

   
   my $nplanes = 4;
   
   my $dimen = "0.0*deg 360*deg $nplanes*counts";
   for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $mucal_iradius[$i]*mm";}
   for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $mucal_oradius[$i]*mm";}
   for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $mucal_zpos[$i]*mm";}

   
	my %detector = init_det();
	$detector{"name"}        = "shieldCone";
	$detector{"mother"}      = "root";
	$detector{"description"} = "volume containing cherenkov gas";
	$detector{"color"}       = "555599";
	$detector{"type"}        = "Polycone";
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = "beamline_W";
	$detector{"style"}       = "1";
   print_det(\%configuration, \%detector);

}

