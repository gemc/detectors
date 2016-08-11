package coatjava;

use strict;
use warnings;

# volumes.pl returns the array of hashes (6 hashes)
# number of entries in each hash is equal to the number of volumes (all mothers+all daughters)
# keys of hashes consist of volume names (constructed in COATJAVA SVT factory)
# e.g. per each volume with 'volumeName':
# mothers['volumeName'] = 'name of mothervolume'
# positions['volumeName'] = 'x y z'
# rotations['volumeName'] = 'rotationOrder: angleX angleY angleZ' (e.g. 'xyz: 90*deg 90*deg 90*deg')
# types['volumeName'] = 'name of volumeType (Trd, Box etc.)'
# dimensions['volumeName'] = 'dimensions of volume (e.g. 3 values for Box, 5 values for Trd etc.'
# ids['volumeName'] = 'region# sector# module#'

my ($mothers, $positions, $rotations, $types, $dimensions, $ids);

my $nregions;
my @nsectors;

sub makeBST
{
	($mothers, $positions, $rotations, $types, $dimensions, $ids) = @main::volumes;

    $nregions = $main::parameters{"nregions"};
    for(my $r=1; $r<=$nregions; $r++ )
    {
        $nsectors[$r-1] = $main::parameters{"nsectors_r".$r};
    }
}

1;
