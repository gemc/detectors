use strict;
use warnings;

our %configuration;

our $TorusZpos;
our $SteelFrameLength;
our $mountTotalLength;            # total length of the torus Mount

my $torusZstart = $TorusZpos - $SteelFrameLength;
my $torusZEnd   = $TorusZpos + $SteelFrameLength;

my $microgap = 0.1;

sub vacuumLine()
{
	# corrected physicists design vacuum line
	# straight aluminum pipe with vacucum inside
	
	# up to the torus the beampipe is 2.0mm thick.
	# inside the torus is 3mm
	
	my $nplanes = 6;
	my $tzs     = $torusZstart + $microgap;
	my $tze     = $torusZEnd   + 655;
	
	my @iradius_vbeam  =  (  27.4, 27.4, 37.4, 37.4, 130,  130);
	my @oradius_vbeam  =  (  29.4, 29.4, 39.4, 39.4, 132,  132);
	my @z_plane_vbeam  =  ( 433.9, $tzs, $tzs, $tze, $tze, 8000 );
	
	
	
	if( $configuration{"variation"} eq "realityWithFT" )
	{
		@z_plane_vbeam  =  ( 750.0, $tzs, $tzs, $tze, $tze, 8000 );
	}
	
	
	# aluminum pipe
	my %detector = init_det();
	$detector{"name"}        = "aluminumBeamPipe";
	$detector{"mother"}      = "root";
	$detector{"description"} = "aluminum beampipe";
	$detector{"color"}       = "aaffff";
	$detector{"type"}        = "Polycone";
	my $dimen = "0.0*deg 360*deg $nplanes*counts";
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." 0.0*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $oradius_vbeam[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $z_plane_vbeam[$i]*mm";}
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	# vacuum pipe
	%detector = init_det();
	$detector{"name"}        = "vacuumBeamPipe";
	$detector{"mother"}      = "aluminumBeamPipe";
	$detector{"description"} = "vacuum inside aluminum beampipe";
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Polycone";
	$dimen = "0.0*deg 360*deg $nplanes*counts";
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." 0.0*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $iradius_vbeam[$i]*mm";}
	for(my $i = 0; $i <$nplanes; $i++) {$dimen = $dimen ." $z_plane_vbeam[$i]*mm";}
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = "G4_Galactic";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
}


