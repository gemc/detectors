#!/usr/bin/perl -w

use strict;
use lib ("$ENV{GEMC}/api/perl");
use lib ("$ENV{GEMC}/io");
use parameters;
use utils;

use geometry;
use hit;
use bank;
use math;

# use Math::Trig;
# use Math::MatrixReal;
# use Math::VectorReal;

# system("rm meic_det1__*txt");

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   detector.pl <configuration filename>\n";
 	print "   Will create the detector\n";
 	print "   Note: The passport and .visa files must be present to connect to MYSQL. \n\n";
	exit;
}

# Make sure the argument list is correct
if( scalar @ARGV != 1) 
{
	help();
	exit;
}


# Loading configuration file and paramters
my $config_file   = $ARGV[0];
our %configuration = load_configuration($config_file);

#if($#ARGV < 0){
#    do 'configs/pvdis_CLEO_nominal.pl';
#}else{
#    do 'configs/'.$ARGV[0];
#}

# One can change the "variation" here if one is desired different from the config.dat
$configuration{"detector_name"} = "meic_det1";
$configuration{"variation"} = "Original";

# To get the parameters proper authentication is needed.
our %parameters    = get_parameters(%configuration);
$configuration{"detector_name"} = "meic_det1_dual";

#####Load geometry ########################################################
#solenoid
# require "meic_det1_solenoid_simple.pl";
# make_meic_det1_solenoid_simple();
require "meic_det1_solenoid_dual.pl";
make_meic_det1_solenoid_dual();
#beamline
# require "meic_det1_beamline_ele.pl";
# make_meic_det1_beamline_e();
# require "meic_det1_beamline_ion.pl";
# make_meic_det1_beamline_p();
#beamline magnet
require "meic_det1_magnet_ele_dipole.pl";
require "meic_det1_magnet_ele_quadrupole.pl";
require "meic_det1_magnet_ion_dipole.pl";
require "meic_det1_magnet_ion_quadrupole.pl";
make_meic_det1_magnet_ele_dipole();
make_meic_det1_magnet_ele_quadrupole();
make_meic_det1_magnet_ion_dipole();
make_meic_det1_magnet_ion_quadrupole();
require "meic_det1_magnet_ion_dipolebig.pl";
make_meic_det1_magnet_ion_dipolebig();
#ele compton and tagger
require "meic_det1_ele_compton.pl";
make_meic_det1_ele_compton();
require "meic_det1_ele_tagger.pl";
make_meic_det1_ele_tagger();
#tof
require "meic_det1_tof_barrel.pl";
# require "meic_det1_tof_eleside.pl";
require "meic_det1_tof_ionside.pl";
make_meic_det1_tof_barrel();
# make_meic_det1_tof_eleside();
make_meic_det1_tof_ionside();
require "tof_modular_eleside/meic_det1_tof_modular_eleside.pl";
require "tof_modular_eleside/meic_det1_tof_modular_eleside_module.pl";
make_tof_modular_eleside();
#ec
require "meic_det1_ec_barrel.pl";
require "meic_det1_ec_eleside.pl";
require "meic_det1_ec_inner_eleside.pl";
require "meic_det1_ec_ionside.pl";
make_meic_det1_ec_barrel();
make_meic_det1_ec_eleside();
make_meic_det1_ec_inner_eleside();
make_meic_det1_ec_ionside();
require "meic_det1_zdc_ionside.pl";
make_meic_det1_zdc_ionside();
#hc
require "meic_det1_hc_ionside.pl";
make_meic_det1_hc_ionside();
#dirc
require "meic_det1_dirc.pl";
make_meic_det1_dirc();
#cher
# require "meic_det1_cher.pl";
# make_meic_det1_cher();
require "rich_modular_eleside/meic_det1_rich_modular_eleside.pl";
require "rich_modular_eleside/meic_det1_rich_modular_eleside_module.pl";
make_rich_modular_eleside();
require "meic_det1_hbd.pl";
make_meic_det1_hbd();
#rich
require "meic_det1_rich.pl";
make_meic_det1_rich();
# require "rich_modular_ionside/meic_det1_rich_modular_ionside.pl";
# require "rich_modular_ionside/meic_det1_rich_modular_ionside_module.pl";
# make_rich_modular_ionside();
#tracking
require "meic_det1_tracking_barrel.pl";
require "meic_det1_tracking_eleside.pl";
require "meic_det1_tracking_ionside.pl";
require "meic_det1_tracking_vertex.pl";
make_meic_det1_tracking_barrel();
make_meic_det1_tracking_eleside();
make_meic_det1_tracking_ionside();
make_meic_det1_tracking_vertex();
# require "meic_det1_tracking_middle.pl";
# make_meic_det1_tracking_middle();
# require "meic_det1_virtual_ec_barrel.pl";
# require "meic_det1_virtual_ec_eleside.pl";
# require "meic_det1_virtual_ec_ionside.pl";
# make_meic_det1_virtual_ec_barrel();
# make_meic_det1_virtual_ec_eleside();
# make_meic_det1_virtual_ec_ionside();
# require "meic_det1_virtual_ion.pl";
# make_meic_det1_virtual_ion();
