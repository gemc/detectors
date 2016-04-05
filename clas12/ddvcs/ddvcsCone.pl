use strict;
use warnings;
use Getopt::Long;
use Math::Trig;

our %configuration;
our $toRad ;


my $entryAngle = 7*$toRad;
my $exitAngle  = 30*$toRad;
my $microgap = 0.1;


my $pipeIR = 25;
my $pipeOR = 27.5;
my $pipeL  = 500;
my $Clength =  200.0;    # Crystal length in mm

my $CZpos  =  500.0;    # Position of the front face of the crystals

my $rminU = $CZpos*tan($entryAngle) - $microgap;
my $rminD = $rminU + $Clength*tan($entryAngle);

my $supportLength = 50;

my $rmaxU  = $CZpos*tan($exitAngle);
my $rmaxD  = $rmaxU + $Clength*tan($exitAngle);
my $rmaxD2 = $rmaxD + $supportLength*tan($exitAngle) + 10;
my $rmaxD3 = $rmaxD2 + 300*tan($exitAngle) + 10;



sub buildBeamShield
{
	
   my $startz = $CZpos +  $Clength + $supportLength + $microgap;
   my @mucal_zpos    = ( $startz, $startz+ 300, $startz + 300, $startz + 1500);
   
   my $pipeORS = $pipeOR + $microgap;
   my @mucal_iradius = ( $pipeORS, $pipeORS           , $pipeORS           ,  $pipeORS                           );
   my @mucal_oradius = ( $rmaxD2, $rmaxD3            , $rminU            ,  $rminU                           );

   
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

