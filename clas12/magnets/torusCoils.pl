use strict;
use warnings;

our %configuration;

our $TorusLength;
our $TorusZpos;

my $microgap = 0.1;





sub makeSteelFrame
{
	
	# first make inner hexagon
	#
	
	my $nzplanes = 2;
	my $nsides   = 6;

	my $hexThickness = 6.35;
	my $hexIR = 200.0;
	my $hexOR = $hexIR + $hexThickness;
	
	my @oradius  = ( $hexOR, $hexOR);
	my @iradius  = ( $hexIR, $hexIR);
	
	my @ztorus   = (  0.0,  $TorusLength);

	my $dimen = "0.0*deg 360*deg $nsides*counts $nzplanes*counts";
	for(my $i = 0; $i < $nzplanes; $i++) {$dimen = $dimen ." $iradius[$i]*mm";}
	for(my $i = 0; $i < $nzplanes; $i++) {$dimen = $dimen ." $oradius[$i]*mm";}
	for(my $i = 0; $i < $nzplanes; $i++) {$dimen = $dimen ." $ztorus[$i]*mm";}

	
	my %detector = init_det();
	$detector{"name"}        = "steelHexFrame";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus SST Frame ";
	$detector{"color"}       = "ff8888";
	$detector{"type"}        = "Pgon";
	$detector{"dimensions"}  = $dimen;
	$detector{"material"}    = "Air";
	# $detector{"material"}    = "Component";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	
}







sub torusCoils()
{
	makeSteelFrame();
}
