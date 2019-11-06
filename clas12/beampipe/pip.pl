#!/usr/bin/perl -w


use strict;
use lib ("$ENV{GEMC}/api/perl");
use utils;
use parameters;
use geometry;
use math;
use materials;

use Math::Trig;

# Help Message
sub help()
{
	print "\n Usage: \n";
	print "   pip.pl <configuration filename>\n";
 	print "   Will create the CLAS12 beampipe and materials\n";
 	print "   Note: The passport and .visa files must be present if connecting to MYSQL. \n\n";
	exit;
}

# Make sure the argument list is correct
if( scalar @ARGV != 1)
{
	help();
	exit;
}
# line 29
# Loading configuration file and paramters
our %configuration = load_configuration($ARGV[0]);


# Global pars - these should be read by the load_parameters from file or DB

# General:
our $inches = 25.4;

# materials [line 39]
require "./materials.pl";
# require "./ctof_materials.pl";

# vacuum line throughout the shields, torus and downstream
# require "./pipe.pl";

# require "./cryotube.pl";
# require "./flangespacer.pl";
# require "./cryoflange.pl";
# require "./flangetube.pl";
# require "./reducer.pl";
# require "./extensiontube.pl";
# require "./solid022.pl";
# require "./50micron.pl";
# require "./solid019.pl";
# require "./solid024.pl";
# require "./solid024Lflange.pl";
# require "./solid024Sflange.pl";
# require "./flange.pl";
# require "./basecone.pl";
# require "./reduceradapter001.pl";
# require "./solid020.pl";
# require "./basering.pl";
# require "./fibercollar.pl";
# require "./centeringring.pl";
# require "./ledadapter.pl";
# require "./solid012.pl";
# require "./distributiontube002.pl";
# require "./manifoldsupportring.pl";
# require "./distributiontube001.pl";
# require "./distributiontube003.pl";
# require "./condenser.pl";
# require "./basetube.pl";
# require "./cnd_pmtR10533.pl";
# require "./ctof_pmtshield.pl";
# require "./ctof_geometry.pl";
# require "./ctofpmts.pl";
# require "./cnd_geometry.pl";
 require "./ebox.pl";

my @allConfs = ("main");

foreach my $conf ( @allConfs )
{

	$configuration{"variation"} = $conf ;

	# materials [line 59]
	materials();

	# vacuum line throughout the shields, torus and downstream
	# temp includes the torus back nose
	# build_pipe();
	# build_cryotube();
	# build_flangespacer();
	# build_cryoflange();
	# build_flangetube();
	# build_reducer();
	# build_extensiontube();
	# build_solid022();
	# build_solid022_1();
	# build_solid022_2();
	# build_50micron();
	# build_solid019();
	# build_solid024();
	# build_solid024Lflange();
	# build_solid024Sflange();
	# build_flange();
	# build_basecone();
	# build_cellwall();
	# build_cellendcap();
	# build_reduceradapter001_1();
	# build_reduceradapter001_2();
	# build_solid020();
	# build_basering();
	# build_basering2();
	# build_forwardretainingring();
	# build_fibercollar();
	# build_centeringring();
	# build_ledadapter();
	# build_solid012();
	# build_distributiontube002_1();
	# build_distributiontube002_2();
	# build_distributiontube002_3();
	# build_celladapter002();
	# build_manifoldsupportring();
	# build_distributiontube001_0();
	# build_distributiontube001_1();
	# build_distributiontube001_2();
	# build_distributiontube001_3();
	# build_celladapter001_1();
	# build_celladapter001_2();
	# build_distributiontube003_1();
	# build_distributiontube003_2();
	# build_distributiontube003_3();
	# build_celladapter003();
	# build_condenser();
	# build_basetube();
	# build_quartzglasstube();
	# build_cnd_pmtR10533();
	# build_ctof_pmtshield();
	# build_ctof_pmtshield2();
	# build_ctof_pmtshield3();
	# build_ctof_pmtshieldcoil();
	# makeCTOF();
	# build_mother();
	# build_paddles();
	# makeCND();
	 build_ebox();

}



