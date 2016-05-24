use strict;
use warnings;

our %configuration;
our @volumes;

# volumes.pl returns the array of hashes (6 hashes)
# number of entries in each hash is equal to the number of volumes (all mothers+all daughters)
# keys of hashes consist of volume names (constructed in COATJAVA DC factory)
# e.g. per each volume with 'volumeName':
# mothers['volumeName'] = 'name of mothervolume'
# positions['volumeName'] = 'x y z'
# rotations['volumeName'] = 'rotationOrder: angleX angleY angleZ' (e.g. 'xyz: 90*deg 90*deg 90*deg')
# types['volumeName'] = 'name of volumeType (Trd, Box etc.)'
# dimensions['volumeName'] = 'dimensions of volume (e.g. 3 values for Box, 5 values for Trd etc.'
# ids['volumeName'] = 'sector# region# layer#'

sub make_volume
{
	my $vname = shift;
	my ($mothers, $positions, $rotations, $types, $dimensions, $ids) = @volumes;

	# extract sector# layer# and paddle# from volume ID (returned by COATJAVA)
	my ($sector, $region, $superlayer, $layer) = split(' ',$ids->{$vname});

	my %detector = init_det();

	$detector{"name"}		   = $vname;
	$detector{"mother"}     = $mothers->{$vname};
	$detector{"pos"}		   = $positions->{$vname};
	$detector{"rotation"}   = $rotations->{$vname};
	$detector{"type"}		   = $types->{$vname};
	$detector{"dimensions"}	= $dimensions->{$vname};

	# if the volume is mother volume (not a paddle)
	# then COATJAVA DC factory return paddle#=0
	# use paddle# to distinguish mother volumes from paddles volumes
	if ( $superlayer == 0 ){
		$detector{"description"} = "CLAS12 Drift Chambers, Sector $sector Region $region";
		$detector{"color"}       = "aa0000";
		$detector{"material"}    = "dcgas";
		$detector{"mfield"}      = "no";
		$detector{"ncopy"}       = "1";
		$detector{"visible"}     = 1;
		$detector{"style"}       = 0;
	}
	else {
		$detector{"description"}  = "Region $region, Super Layer $superlayer, layer $layer, Sector $sector";
		$detector{"color"}        = "99aaff2";
		$detector{"material"}     = "dcgas";
		$detector{"mfield"}       = "no";
		$detector{"visible"}      = 1;
		$detector{"style"}        = 1;
		$detector{"sensitivity"}  = "dc";
		$detector{"hit_type"}     = "dc";
		$detector{"identifiers"}  = "sector manual $sector superlayer manual $superlayer layer manual $layer wire manual 1";
	}
	print_det(\%configuration, \%detector);
}

sub makeDC_java
{
	for(my $region=1; $region<=3; $region++)
	{
		for(my $s=1; $s<=6; $s++)
		{
			my $vname = "region$region"."_s$s";
			make_volume($vname);
		}
	}

	for(my $region=1; $region<=3; $region++)
	{
		my $superlayer_min = $region*2 - 1;
		my $superlayer_max = $region*2;
		for (my $isup = $superlayer_min; $isup < $superlayer_max+1 ; $isup++)
		{
			for (my $ilayer = 1; $ilayer < 7 ; $ilayer++)
			{
				for(my $s=1; $s<=6; $s++)
				{
					my $vname = "sl$isup"."_layer$ilayer"."_s$s";
					make_volume($vname);
				}
			}
		}
	}

}

1;
