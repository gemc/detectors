use strict;
use warnings;

use Data::Dumper;

our %configuration;
our @volumes;

my ($mothers, $positions, $rotations, $types, $dimensions, $ids) = @volumes;
my @layernames = ("1a", "1b", "2");

sub makeFTOF
{
	foreach my $vname (sort keys %{ $mothers })
	{
		my ($sector, $layer, $paddle) = split(' ',$ids->{$vname});

		my %detector = init_det();

		$detector{"name"}		= $vname;
		$detector{"mother"}		= $mothers->{$vname};
		$detector{"pos"}		= $positions->{$vname};
		$detector{"rotation"}	= $rotations->{$vname};
		$detector{"type"}		= $types->{$vname};
		$detector{"dimensions"}	= $dimensions->{$vname};

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
			$detector{"description"}  = "paddle $paddle - Panel $layernames[$layer-1] - Sector $sector";
			$detector{"color"}        = "ff11aa";
			$detector{"material"}     = "scintillator";
			$detector{"mfield"}       = "no";
			$detector{"visible"}      = 1;
			$detector{"style"}        = 1;
			$detector{"sensitivity"}  = "ftof_p$layernames[$layer-1]";
			$detector{"hit_type"}     = "ftof_p$layernames[$layer-1]";
			$detector{"identifiers"}  = "sector manual $sector panel manual 1 paddle manual $paddle";
		}
		print_det(\%configuration, \%detector);
	}
}

