use strict;
use warnings;

our %configuration;
our $toRad ;


my $CwidthU =   13.0;    # Upstream   crystal width in mm (side of the squared front face)
my $CwidthD =   17.0;    # Downstream crystal width in mm (side of the squared front face)
my $Clength =  200.0;    # Crystal length in mm

my $CZpos      =  500.0;    # Position of the front face of the crystals
my $entryAngle = 7*$toRad;
my $exitAngle  = 30*$toRad;


my $microgap = 0.1;

my $rminU = $CZpos*tan($entryAngle);
my $rmaxU = $CZpos*tan($exitAngle);

my $rminD = $rminU + $Clength*tan($entryAngle);
my $rmaxD = $rmaxU + $Clength*tan($exitAngle);


sub make_mucal_mvolume
{	
	my @mucal_zpos    = ( $CZpos - $microgap, $CZpos + $Clength + $microgap );
	my @mucal_iradius = ( $rminU - $microgap, $rminD - $microgap );
	my @mucal_oradius = ( $rmaxU - $microgap, $rmaxU - $microgap );

	my $nplanes = 2;
	
	my $dimen = "0.0*deg 360*deg $nplanes*counts";
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $mucal_iradius[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $mucal_oradius[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $mucal_zpos[$i]*mm";}

	
   my %detector = init_det();
   $detector{"name"}        = "mucal";
   $detector{"mother"}      = "root";
   $detector{"description"} = "muon calorimeter mother volume";
   $detector{"color"}       = "a50021";
   $detector{"type"}        = "Polycone";
   $detector{"dimensions"}  = $dimen;
   $detector{"material"}    = "G4_AIR";
   $detector{"style"}       = 1;
   print_det(\%configuration, \%detector);
}




# PbWO4 Crystal;
sub make_mucal_crystals
{
	my $nCrystal = 2*$rmaxU / $CwidthU;
	
	for(my $iX = 0; $iX < $nCrystal; $iX++)
	{
		for(my $iY = 0; $iY < $nCrystal; $iY++)
		{
			my $centerX = - $rmaxU + $iX*$CwidthU + 0.5*$CwidthU;
			my $centerY = - $rmaxU + $iY*$CwidthU + 0.5*$CwidthU;
			
			my $x12 = ($centerX - 0.5*$CwidthU)*($centerX - 0.5*$CwidthU);
			my $x22 = ($centerX + 0.5*$CwidthU)*($centerX + 0.5*$CwidthU);
			my $y12 = ($centerY - 0.5*$CwidthU)*($centerY - 0.5*$CwidthU);
			my $y22 = ($centerY + 0.5*$CwidthU)*($centerY + 0.5*$CwidthU);
			
			my $rad1 = sqrt($x12 + $y12);
			my $rad2 = sqrt($x22 + $y22);
			my $rad3 = sqrt($x12 + $y22);
			my $rad4 = sqrt($x22 + $y12);
			
			if($rad1 > $rminU + $microgap && $rad1 < $rmaxU - $microgap &&
				$rad2 > $rminU + $microgap && $rad2 < $rmaxU - $microgap &&
				$rad3 > $rminU + $microgap && $rad3 < $rmaxU - $microgap &&
				$rad4 > $rminU + $microgap && $rad4 < $rmaxU - $microgap
				)
			{
				
				
				my %detector = init_det();
				$detector{"name"}        = "mucal_cr_" . $iX . "_" . $iY ;
				$detector{"mother"}      = "mucal";
				$detector{"description"} = "ft crystal (h:" . $iX . ", v:" . $iY . ")";
				my $zPos = $CZpos;
				$detector{"pos"}         = "$centerX*mm $centerY*mm $zPos*mm";
				$detector{"color"}       = "a50021";
				$detector{"type"}        = "Box" ;
				my $dx = $CwidthU / 2.0;
				$detector{"dimensions"}  = "$dx*mm $dx*mm 1*mm";
				$detector{"material"}    = "G4_PbWO4";
				$detector{"style"}       = 0;
				print_det(\%configuration, \%detector);
				
				
			}
		}
	}
}

sub make_mu_cal
{
   make_mucal_mvolume();
	make_mucal_crystals();
}
















