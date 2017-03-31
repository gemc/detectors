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

use Math::Trig;
# use Math::MatrixReal;
# use Math::VectorReal;

# system("rm meic_det1_simple__*txt");

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
# our %parameters    = get_parameters(%configuration);
our %parameters    = get_parameters(%configuration);
$configuration{"detector_name"} = "meic_det1_dual_barrel";

##############################################################################

require "meic_det1_solenoid_dual_barrel.pl";
make_meic_det1_solenoid_dual();
# require "meic_det1_solenoid_dual.pl";
# require "meic_det1_beamline_e.pl";
# require "meic_det1_beamline_p.pl";
require "meic_det1_magnet_ele_dipole.pl";
make_meic_det1_magnet_ele_dipole();
require "meic_det1_magnet_ele_quadrupole.pl";
make_meic_det1_magnet_ele_quadrupole();
require "meic_det1_magnet_ion_dipole.pl";
make_meic_det1_magnet_ion_dipole();
require "meic_det1_magnet_ion_quadrupole.pl";
make_meic_det1_magnet_ion_quadrupole();
#ele compton and tagger
require "meic_det1_ele_compton.pl";
make_meic_det1_ele_compton();
require "meic_det1_ele_tagger.pl";
make_meic_det1_ele_tagger();
# require "meic_det1_virtual_ion.pl";
# make_meic_det1_virtual_ion();
# require "meic_det1_ec_barrel.pl";
# require "meic_det1_ec_upstream.pl";
# require "meic_det1_ec_downstream.pl";
# require "meic_det1_dirc.pl";
# require "meic_det1_cher.pl";
# require "meic_det1_rich.pl";
require "meic_det1_virtual_ec_barrel.pl";
make_meic_det1_virtual_ec_barrel();
require "meic_det1_virtual_ec_eleside.pl";
make_meic_det1_virtual_ec_eleside();
require "meic_det1_virtual_ec_ionside.pl";
make_meic_det1_virtual_ec_ionside();
require "meic_det1_virtual_rich.pl";
make_meic_det1_virtual_rich();
require "meic_det1_virtual_ion.pl";
make_meic_det1_virtual_ion();
require "meic_det1_virtual_ele.pl";
make_meic_det1_virtual_ele();

# Hit definition
# Execute only when there are changes
# require "meic_det1_hit.pl";
# flux_hit();

# banks
# require "meic_det1_bank.pl";
# define_flux_bank();