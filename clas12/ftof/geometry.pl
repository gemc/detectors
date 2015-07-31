#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/io");
use utils;
use parameters;
use geometry;
use math;

use Math::Trig;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   geometry.pl <configuration filename>\n";
 	print "   Will create the CLAS12 Forward Time of Flight (ftof) using the variation specified in the configuration file\n";
 	print "   Note: The passport and .visa files must be present to connect to MYSQL. \n\n";
	exit;
}

# Make sure the argument list is correct
# If not pring the help
if( scalar @ARGV != 1)
{
	help();
	exit;
}

# Loading configuration file from argument
our %configuration = load_configuration($ARGV[0]);

# One can change the "variation" here if one is desired different from the config.dat
# $configuration{"variation"} = "myvar";

# Load the parameters
our %parameters    = get_parameters(%configuration);

# utility to derive secondary parameters from originals
require "./utils.pl";
calculate_ftof_parameters();

my $panel1a_n = $parameters{"ftof.panel1A.ncounters"};
my $panel1b_n = $parameters{"ftof.panel1B.ncounters"};
my $panel2_n  = $parameters{"ftof.panel2.ncounters"};

define_mothers();
build_counters();

# define ftof sectors
sub define_mothers
{
	for(my $s=1; $s<=6; $s++)
	{
		build_panel1a_mother($s);
		build_panel1b_mother($s);
		build_panel2_mother($s);
	}
}

sub build_panel1a_mother
{
	my $sector = shift;
	
	my %detector = init_det();
	$detector{"name"}        = "ftof_p1a_s".$sector;
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Forward TOF - Panel 1a - Sector ".$sector;
	$detector{"pos"}         = panel_1a_pos($sector);
	$detector{"rotation"}    = panel_1a_rot($sector);
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Trd";
	$detector{"dimensions"}  = panel_1a_dims();
	$detector{"material"}    = "G4_AIR";
	$detector{"mfield"}      = "no";
	$detector{"ncopy"}       = "1";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);
}

sub build_panel1b_mother
{
	my $sector = shift;
	
	my %detector = init_det();
	$detector{"name"}        = "ftof_p1b_s".$sector;
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Forward TOF - Panel 1b - Sector ".$sector;
	$detector{"pos"}         = panel_1b_pos($sector);
	$detector{"rotation"}    = panel_1b_rot($sector);
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Trd";
	$detector{"dimensions"}  = panel_1b_dims();
	$detector{"material"}    = "G4_AIR";
	$detector{"mfield"}      = "no";
	$detector{"ncopy"}       = "1";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);
}

sub build_panel2_mother
{
	my $sector = shift;
	
	my %detector = init_det();
	$detector{"name"}        = "ftof_p2_s".$sector;
	$detector{"mother"}      = "fc";
	$detector{"description"} = "Forward TOF - Panel 2 - Sector ".$sector;
	$detector{"pos"}         = panel_2_pos($sector);
	$detector{"rotation"}    = panel_2_rot($sector);
	$detector{"color"}       = "000000";
	$detector{"type"}        = "Trd";
	$detector{"dimensions"}  = panel_2_dims();
	$detector{"material"}    = "G4_AIR";
	$detector{"mfield"}      = "no";
	$detector{"ncopy"}       = "1";
	$detector{"visible"}     = 1;
	$detector{"style"}       = 0;
	print_det(\%configuration, \%detector);
}

# Paddles
sub build_counters
{
	for(my $s=1; $s<=6; $s++)
	{
		build_panel1a_counters($s);
		build_panel1b_counters($s);
		build_panel2_counters($s);
	}
}

sub build_panel1a_counters
{
	my $sector = shift;
	my $mother = "ftof_p1a_s".$sector;
	
	for(my $n=1; $n<=$panel1a_n; $n++)
	{
		my %detector = init_det();
		$detector{"name"}         = "panel1a_sector$sector"."_paddle_".$n;
		$detector{"mother"}       = $mother;
		$detector{"description"}  = "paddle $n - Panel 1B - Sector $sector";
		$detector{"pos"}          = panel_1a_counter_pos($n);
		$detector{"rotation"}     = "0*deg 0*deg 0*deg";
		$detector{"color"}        = "ff11aa";
		$detector{"type"}         = "Box";
		$detector{"dimensions"}   = panel_1a_counter_dims($n);
		$detector{"material"}     = "scintillator";
		$detector{"mfield"}       = "no";
		$detector{"visible"}      = 1;
		$detector{"style"}        = 1;
		$detector{"sensitivity"}  = "ftof_p1a";
		$detector{"hit_type"}     = "ftof_p1a";
		$detector{"identifiers"}  = "sector manual $sector panel manual 1 paddle manual $n";
		print_det(\%configuration, \%detector);
	}
}

sub build_panel1b_counters
{
	my $sector = shift;
	my $mother = "ftof_p1b_s".$sector;
	
	for(my $n=1; $n<=$panel1b_n; $n++)
	{
		my %detector = init_det();
		$detector{"name"}         = "panel1b_sector$sector"."_paddle_".$n;
		$detector{"mother"}       = $mother;
		$detector{"description"}  = "paddle $n - Panel 1B - Sector $sector";
		$detector{"pos"}          = panel_1b_counter_pos($n);
		$detector{"rotation"}     = "0*deg 0*deg 0*deg";
		$detector{"color"}        = "111ffaa";
		$detector{"type"}         = "Box";
		$detector{"dimensions"}   = panel_1b_counter_dims($n);
		$detector{"material"}     = "scintillator";
		$detector{"mfield"}       = "no";
		$detector{"visible"}      = 1;
		$detector{"style"}        = 1;
		$detector{"sensitivity"}  = "ftof_p1b";
		$detector{"hit_type"}     = "ftof_p1b";
		$detector{"identifiers"}  = "sector manual $sector panel manual 2 paddle manual $n";
		print_det(\%configuration, \%detector);
	}
}

sub build_panel2_counters
{
	my $sector = shift;
	my $mother = "ftof_p2_s".$sector;
	
	for(my $n=1; $n<=$panel2_n; $n++)
	{
		my %detector = init_det();
		$detector{"name"}         = "panel2_sector$sector"."_paddle_".$n;
		$detector{"mother"}       = $mother;
		$detector{"description"}  = "paddle $n - Panel 2 - Sector $sector";
		$detector{"pos"}          = panel_2_counter_pos($n);
		$detector{"rotation"}     = "0*deg 0*deg 0*deg";
		$detector{"color"}        = "ff11aa";
		$detector{"type"}         = "Box";
		$detector{"dimensions"}   = panel_2_counter_dims($n);
		$detector{"material"}     = "scintillator";
		$detector{"mfield"}       = "no";
		$detector{"visible"}      = 1;
		$detector{"style"}        = 1;
		$detector{"sensitivity"}  = "ftof_p2";
		$detector{"hit_type"}     = "ftof_p2";
		$detector{"identifiers"}  = "sector manual $sector  panel manual 3  paddle manual $n";
		print_det(\%configuration, \%detector);
	}
}
