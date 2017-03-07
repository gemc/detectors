#!/usr/bin/python -B		# -B prevents writing compiled bytecode files. Otherwise python writes .pyc compiled versions of each module

# The location of the python api files should be in PYTHONPATH. If installing via the DMG, add the following path for gemc-2.5
# Adjust version number for a different gemc version
# export PYTHONPATH=$PYTHONPATH:/Applications/gemc-2.6.app/gemc.app/Contents/Resources/api/python

import sys, os
import argparse	# Used to parse the command line arguments
sys.path.append('/Users/jsgeorge/Documents/gemc/api/python')
from gemc_api_utils import *
from gemc_api_parameters import *
#~ from gemc_api_materials import *

#~ use strict;
#~ use lib ("$ENV{GEMC}/api/perl");
#~ use utils;
#~ use parameters;
#~ use geometry;
#~ use hit;
#~ use bank;
#~ use math;
#~ use materials;

#~ use Math::Trig;


# This section handles checking for the required configuration filename argument and also provides help and usage messages
desc_str = "   Will create the CLAS12 CTOF geometry, materials, bank and hit definitions.\n"
desc_str = desc_str + "Note: The passport and .visa files must be present if connecting to MYSQL."
parser = argparse.ArgumentParser(description=desc_str)
parser.add_argument("config_filename", help="The name of the experiment configuration file")
if len(sys.argv)==1:
    parser.print_help()
    sys.exit(1)
args = parser.parse_args()
cfg_file = args.config_filename
print(cfg_file)

# Loading configuration file and paramters
configuration = load_configuration(cfg_file)

# Global parameters - these should be read by the load_parameters from file or DB
parameters = get_parameters(configuration)	# returns a python dictionary of {key, value} pairs:  {parameter_name, parameter_value}

# materials
from materials import define_materials
# banks definitions
from bank import define_bank
# hits definitions
from hit import define_hit
# sensitive geometry
from geometry import *


# all the scripts must be run for every configuration
configs = ["original", "red", "green"]

for conf in configs:
	configuration.variation = conf
	
	# materials
	define_materials(configuration)
	
	# hits
	define_hit(configuration)
	
	# bank definitions
	define_bank(configuration)
	
	# geometry
	init_geom_file(configuration)		#  Overwrites any existing geometry file and starts with an empty file ready to append detectors
	makeCTOF(configuration, parameters)
	

