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
my $pipeL  = 1000;
my $Clength =  200.0;    # Crystal length in mm

my $CZpos  =  500.0;    # Position of the front face of the crystals

my $rminU = $CZpos*tan($entryAngle) - $microgap;
my $rminD = $rminU + $Clength*tan($entryAngle);

my $supportLength = 50;

my $rmaxU  = $CZpos*tan($exitAngle);
my $rmaxD  = $rmaxU + $Clength*tan($exitAngle);
my $rmaxD2 = $rmaxD + $supportLength*tan($exitAngle);



sub buildBeamPipe
{
	my %detector = init_det();
	$detector{"name"}        = "vaccumPipe";
	$detector{"mother"}      = "root";
	$detector{"description"} = "volume containing cherenkov gas";
	$detector{"color"}       = "aabbbb";
   my $pipeZPos = $pipeL + 400;
   $detector{"pos"}         = "0*cm 0*cm $pipeZPos";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$pipeIR*mm $pipeOR*mm $pipeL*mm 0*deg 360*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = "1";
   print_det(\%configuration, \%detector);
	
   
   my @mucal_zpos    = ( $CZpos , $CZpos +  $Clength + 2*$microgap, $CZpos +  $Clength + 2*$microgap, $CZpos +  $Clength + $supportLength);
   
   my $pipeORS = $pipeOR + $microgap;
   my @mucal_iradius = ( $pipeORS, $pipeORS           , $pipeORS           ,  $pipeORS                           );
   my @mucal_oradius = ( $rminU - $microgap, $rminD - $microgap            , $rmaxD            ,  $rmaxD2                           );

   
   my $nplanes = 4;
   
   my $dimen = "0.0*deg 360*deg $nplanes*counts";
   for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $mucal_iradius[$i]*mm";}
   for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $mucal_oradius[$i]*mm";}
   for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $mucal_zpos[$i]*mm";}

   
	%detector = init_det();
	$detector{"name"}        = "supportCone";
	$detector{"mother"}      = "root";
	$detector{"description"} = "volume containing cherenkov gas";
	$detector{"color"}       = "55ff55";
	$detector{"type"}        = "Polycone";
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = "1";
   print_det(\%configuration, \%detector);

}

