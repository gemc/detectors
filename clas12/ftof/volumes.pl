use strict;
use warnings;

use Data::Dumper;

our %configuration;
our @volumes;

# volumes.pl returns the array of hashes (6 hashes)
# number of entries in each hash is equal to the number of volumes (all mothers+all daughters)
# keys of hashes consist of volume names (constructed in COATJAVA FTOF factory)
# e.g. per each volume with 'volumeName':
# mothers['volumeName'] = 'name of mothervolume'
# positions['volumeName'] = 'x y z'
# rotations['volumeName'] = 'rotationOrder: angleX angleY angleZ' (e.g. 'xyz: 90*deg 90*deg 90*deg')
# types['volumeName'] = 'name of volumeType (Trd, Box etc.)'
# dimensions['volumeName'] = 'dimensions of volume (e.g. 3 values for Box, 5 values for Trd etc.'
# ids['volumeName'] = 'sector# layer# paddle#'
my ($mothers, $positions, $rotations, $types, $dimensions, $ids) = @volumes;

# name of FTOF layers
my @layernames = ("1a", "1b", "2");

sub makeFTOF
{
	foreach my $vname (sort keys %{ $mothers })
	{
		# extract sector# layer# and paddle# from volume ID (returned by COATJAVA)
		my ($sector, $layer, $paddle) = split(' ',$ids->{$vname});

		my %detector = init_det();

		$detector{"name"}		   = $vname;
		$detector{"mother"}     = $mothers->{$vname};
		$detector{"pos"}		   = $positions->{$vname};
		$detector{"rotation"}   = $rotations->{$vname};
		$detector{"type"}		   = $types->{$vname};
		$detector{"dimensions"}	= $dimensions->{$vname};

		# if the volume is mother volume (not a paddle)
		# then COATJAVA FTOF factory return paddle#=0
		# use paddle# to distinguish mother volumes from paddles volumes
		if ( $paddle == 0 ){
			$detector{"description"} = "Forward TOF - Panel $layernames[$layer-1] - Sector ".$sector;
			$detector{"color"}       = "000000";
			$detector{"material"}    = "G4_AIR";
			$detector{"mfield"}      = "no";
			$detector{"ncopy"}       = "1";
			$detector{"visible"}     = 1;
			$detector{"style"}       = 0;
		}
		else {
			$detector{"description"}  = "paddle $paddle - Layer $layer (panel $layernames[$layer-1]) - Sector $sector";
			$detector{"color"}        = "ff11aa";
			$detector{"material"}     = "scintillator";
			$detector{"mfield"}       = "no";
			$detector{"visible"}      = 1;
			$detector{"style"}        = 1;
			$detector{"sensitivity"}  = "ftof_p$layernames[$layer-1]";
			$detector{"hit_type"}     = "ftof_p$layernames[$layer-1]";
			$detector{"identifiers"}  = "sector manual $sector panel manual $layer paddle manual $paddle";
		}
		print_det(\%configuration, \%detector);
	}
}

sub make_pb
{
	# loop over sectors
	for (my $isect = 0; $isect < 6; $isect++)
	{
		my $sector = $isect +1;
		
		my %detector = init_det();
		$detector{"name"}         = "ftof_shield_sector$sector";
		$detector{"mother"}       = "ftof_p1b_s$sector";
		$detector{"description"}  = "Layer of lead - Sector $sector";
		$detector{"pos"}          = pb_pos();
		$detector{"rotation"}     = "0*deg 0*deg 0*deg";
		$detector{"color"}        = "dc143c";
		$detector{"type"}         = "Trd";
		#$detector{"dimensions"}   = pb_dims();
		$detector{"material"}     = "G4_Pb";
		$detector{"visible"}      = 1;
		$detector{"style"}        = 1;
		print_det(\%configuration, \%detector);
	}
}