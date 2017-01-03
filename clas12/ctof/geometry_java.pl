# Written by Andrey Kim (kenjo@jlab.org)
package coatjava;

use strict;
use warnings;

use geometry;
use GXML;

my ($mothers, $positions, $rotations, $types, $dimensions, $ids);

my $npaddles = 48;

sub makeCTOF
{
	($mothers, $positions, $rotations, $types, $dimensions, $ids) = @main::volumes;

	build_fake_mother();

	my $dirName = shift;
	build_gxml($dirName);
}

sub build_gxml
{
	my $dirName = shift;
	my $gxmlFile = new GXML($dirName);

	build_paddles($gxmlFile);
	build_upLightGuides($gxmlFile);
	build_downLightGuides($gxmlFile);

	$gxmlFile->print();
}

sub build_paddles
{
	my $gxmlFile = shift;
	for(my $ipaddle=1; $ipaddle<=$npaddles; $ipaddle++){
		my %detector = init_det();

		my $vname                = sprintf("sc%02d", $ipaddle);

		$detector{"name"}        = $vname;
		$detector{"pos"}         = $positions->{$vname};
		$detector{"rotation"}    = $rotations->{$vname};

		$detector{"color"}       = "444444";
		$detector{"material"}    = "scintillator";
		$detector{"sensitivity"}    = "ctof";
		$detector{"identifiers"}    = sprintf("paddle manual %d", $ipaddle);

		$gxmlFile->add(\%detector);
	}
}


sub build_upLightGuides
{
	my $gxmlFile = shift;
	for(my $ipaddle=1; $ipaddle<=$npaddles; $ipaddle++){
		my %detector = init_det();

		my $vname                = sprintf("lgu%02d", $ipaddle);

		$detector{"name"}        = $vname;
		$detector{"pos"}         = $positions->{$vname};
		$detector{"rotation"}    = $rotations->{$vname};

		$detector{"color"}       = "666666";
		$detector{"material"}    = "scintillator";

		$gxmlFile->add(\%detector);
	}
}


sub build_downLightGuides
{
	my $gxmlFile = shift;
	for(my $ipaddle=1; $ipaddle<=$npaddles; $ipaddle++){
		my %detector = init_det();

		my $vname                = sprintf("lgd%02d", $ipaddle);

		$detector{"name"}        = $vname;
		$detector{"pos"}         = $positions->{$vname};
		$detector{"rotation"}    = $rotations->{$vname};

		$detector{"color"}       = "666666";
		$detector{"material"}    = "scintillator";

		$gxmlFile->add(\%detector);
	}
}


sub build_fake_mother
{
	my %detector = init_det();
	
	$detector{"name"}        = "ctof";
	$detector{"mother"}      = "root";
	$detector{"description"} = "Central TOF Mother Volume";
	$detector{"pos"}         = "0*cm 0.0*cm 0*mm";
	$detector{"rotation"}    = "0*deg 0*deg 0*deg";
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Tube";
	
	$detector{"dimensions"}  = "0*cm 1*cm 1*cm 0*deg 360*deg";
	$detector{"material"}    = "G4_AIR";
	$detector{"mfield"}      = "no";
	$detector{"visible"}     = 0;
	$detector{"style"}       = 1;
	$detector{"exist"}       = 0;

	print_det(\%main::configuration, \%detector);
}

1;
