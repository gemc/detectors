use strict;
use warnings;
use Getopt::Long;
use Math::Trig;

our %configuration;


# wall from target is 1m in z direction.
# we want the outside radii to be at 35 degrees  (1*tg 35 = 0.7  and 1.6*tg 35 = 1.12)
# thickness is 60cm
# inside it's the usual beamline (no FT) which is a 5 degrees cone so (1*tg5 = 0.087  1.6*tg5 = 1.4)
#
#
#           /   |
#         /     |
#   1m   | 60cm |
#        |
#  T
#        |
#        |      |
#         \     |
#           \   |

sub build_ddvcsCone
{
	$configuration{"variation"} = "60cm" ;
	my %detector = init_det();
	$detector{"name"}        = "ddvcsCone";
	$detector{"mother"}      = "root";
	$detector{"description"} = "volume containing cherenkov gas";
	$detector{"color"}       = "aabbbb";
	$detector{"type"}        = "Polycone";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 70*mm 105*mm 0.7*m 1.12*m  1*m 1.6*m";
	$detector{"material"}    = "G4_Fe";
	$detector{"style"}       = "1";
	print_det(\%configuration, \%detector);
	
	$configuration{"variation"} = "80cm" ;
	%detector = init_det();
	$detector{"name"}        = "ddvcsCone";
	$detector{"mother"}      = "root";
	$detector{"description"} = "volume containing cherenkov gas";
	$detector{"color"}       = "aabbbb";
	$detector{"type"}        = "Polycone";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 70*mm 105*mm 0.7*m 1.12*m  1*m 1.8*m";
	$detector{"material"}    = "G4_Fe";
	$detector{"style"}       = "1";
	print_det(\%configuration, \%detector);

	$configuration{"variation"} = "100cm" ;
	%detector = init_det();
	$detector{"name"}        = "ddvcsCone";
	$detector{"mother"}      = "root";
	$detector{"description"} = "volume containing cherenkov gas";
	$detector{"color"}       = "aabbbb";
	$detector{"type"}        = "Polycone";
	$detector{"dimensions"}  = "0*deg 360*deg 2*counts 70*mm 105*mm 0.7*m 1.12*m  1*m 2.0*m";
	$detector{"material"}    = "G4_Fe";
	$detector{"style"}       = "1";
	print_det(\%configuration, \%detector);
}

