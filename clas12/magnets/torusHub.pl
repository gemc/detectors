use strict;
use warnings;

our %configuration;

# To check:
# - there is an additional plate for the warm bore shield

our $TorusLength;

my $microgap = 0.1;

# Torus Hub - it's aluminum
my $ColdHubLength = 82.68*$inches/2.0;   # 1/2 length
my $ColdHubIR     = 175.0/2.0 ;    # taken from new drawing by D. Kashy - 87.5mm
my $ColdHubOR     = 240.0/2.0 ;    # 32 mm thicknes according to the drawing

# Warm Bore Tube: it's the innermost part of the torus. Stainless Steel
my $WarmBoreLength = $TorusLength - $microgap;
my $WarmBoreIR      = 123.8/2.0 ;        # taken from new drawing by D. Kashy
my $WarmBoreOR      = 127.0/2.0 ;

# Warm Bore Tube Shield: heat shield torus from the inner part. Copper
my $BoreShieldLength = 2201.8/2.0;  # 1/2 length
my $BoreShieldIR     = 146.06/2.0 ;       # taken from new drawing by D. Kashy
my $BoreShieldOR     = 152.4/2.0 ;

sub torusHub()
{
	# main hub
	my %detector = init_det();
	$detector{"name"}        = "torusColdHub";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus Cold Hub";
	$detector{"color"}       = "ee66ee";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$ColdHubIR*mm $ColdHubOR*mm $ColdHubLength*mm  0.0*deg 360.0*deg";
	$detector{"material"}    = "G4_Al";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	# warm bore
	%detector = init_det();
	$detector{"name"}        = "torusWarmBore";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus Warm Bore";
	$detector{"color"}       = "eeee22";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$WarmBoreIR*mm $WarmBoreOR*mm $WarmBoreLength*mm  0.0*deg 360.0*deg";
	$detector{"material"}    = "G4_STAINLESS-STEEL";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
	
	# warm bore shield
	%detector = init_det();
	$detector{"name"}        = "torusWarmBoreShield";
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Torus Warm Bore";
	$detector{"color"}       = "ee66ee";
	$detector{"type"}        = "Tube";
	$detector{"dimensions"}  = "$BoreShieldIR*mm $BoreShieldOR*mm $BoreShieldLength*mm  0.0*deg 360.0*deg";
	$detector{"material"}    = "G4_Cu";
	$detector{"style"}       = 1;
	print_det(\%configuration, \%detector);
}


