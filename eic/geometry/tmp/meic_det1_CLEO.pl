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
$configuration{"detector_name"} = "meic_det1_CLEO";

#####Load geometry ########################################################
#solenoid
# require "meic_det1_solenoid_simple.pl";
# make_meic_det1_solenoid_simple();
# require "meic_det1_solenoid_dual.pl";
# make_meic_det1_solenoid_dual
require "meic_det1_solenoid_CLEO.pl";
make_meic_det1_solenoid_CLEO();
#beamline
# require "meic_det1_beamline_ele.pl";
# make_meic_det1_beamline_e();
# require "meic_det1_beamline_ion.pl";
# make_meic_det1_beamline_p();
# beamline magnet
require "meic_det1_magnet_ele_dipole.pl";
require "meic_det1_magnet_ele_quadrupole.pl";
require "meic_det1_magnet_ion_dipole.pl";
require "meic_det1_magnet_ion_quadrupole.pl";
make_meic_det1_magnet_ele_dipole();
make_meic_det1_magnet_ele_quadrupole();
make_meic_det1_magnet_ion_dipole();
make_meic_det1_magnet_ion_quadrupole();
#ec
require "meic_det1_ec_barrel.pl";
require "meic_det1_ec_upstream.pl";
# require "meic_det1_ec_upstream_close.pl";
require "meic_det1_ec_downstream.pl";
make_meic_det1_ec_barrel();
make_meic_det1_ec_upstream();
# make_meic_det1_ec_upstream_close();
make_meic_det1_ec_downstream();
#dirc	
require "meic_det1_dirc.pl";
make_meic_det1_dirc();
#cher
require "meic_det1_cher.pl";
make_meic_det1_cher();
#rich
require "meic_det1_rich.pl";
make_meic_det1_rich();
#tracking
require "meic_det1_tracking_barrel.pl";
# require "meic_det1_tracking_middle.pl";
require "meic_det1_tracking_side.pl";
require "meic_det1_tracking_vertex.pl";
make_meic_det1_tracking_barrel();
# make_meic_det1_tracking_middle();
make_meic_det1_tracking_side_upstream();
make_meic_det1_tracking_side_downstream();
make_meic_det1_tracking_vertex();
require "meic_det1_virtual_ec_barrel.pl";
make_meic_det1_virtual_ec_barrel();
require "meic_det1_virtual_ec_upstream.pl";
make_meic_det1_virtual_ec_upstream();
require "meic_det1_virtual_ec_downstream.pl";
make_meic_det1_virtual_ec_downstream();
require "meic_det1_virtual_ion.pl";
make_meic_det1_virtual_ion();
