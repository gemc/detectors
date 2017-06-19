use strict;
use warnings;
our %detector;
our %configuration;
our %parameters;

use Getopt::Long;
use Math::Trig;

my $DetectorMother="root";
my $DetectorName = "meic_det1_magnet_ele";
my $NStrips = 200;

my $strip;
my $strip_position;

sub make_det1_compton_edetector_geometry
{

    for(my $i = 0; $i < ($NStrips); $i++)
    {

	$strip = $i + 1;
#	$strip_position = -0.0503698+${i}*(0.000010+0.000240); #-0.0653698+${i}*(0.000010+0.000240); # Full asymmetry on detector
	$strip_position = -0.0423698+${i}*(0.000010+0.000240); #-0.0653698+${i}*(0.000010+0.000240); # Centered on the zero-crossing
#	$strip_position = -0.0353698+${i}*(0.000010+0.000240); #-0.0653698+${i}*(0.000010+0.000240); #
    
	my %detector=init_det();
	$detector{"name"}        = "e_det_strip_$strip";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Compton Electron Detector Strip ${strip}";
	$detector{"pos"}         = "${strip_position}*m 0*m -32.5965318*m";
	$detector{"rotation"}    = "0.0*rad 0.0*rad 0.0*rad";
	$detector{"color"}       = "EE00EE"; 
	$detector{"type"}        = "Box";
	$detector{"dimensions"}  = "0.0120*cm 0.5000*cm 0.05*cm";
	$detector{"material"}    = "G4_Si";
        $detector{"mfield"}      = "no";
	$detector{"ncopy"}       = 1;
	$detector{"pMany"}       = 1;
	$detector{"exist"}       = 1;
	$detector{"visible"}     = 1;
	$detector{"style"}       = 1;
	$detector{"sensitivity"} = "flux";
	$detector{"hit_type"}    = "flux";
	$detector{"identifiers"} = "id manual $strip";
	print_det(\%configuration, \%detector);
    }
}
1;
