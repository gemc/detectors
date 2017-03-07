#!/usr/bin/python -B		# -B prevents writing compiled bytecode files. Otherwise python writes .pyc compiled versions of each module

# The location of the python api files should be in PYTHONPATH. If installing via the DMG, add the following path for gemc-2.5
# Adjust version number for a different gemc version
# export PYTHONPATH=$PYTHONPATH:/Applications/gemc-2.6.app/gemc.app/Contents/Resources/api/python

import sys, os
import argparse	# Used to parse the command line arguments
from gemc_api_utils import *
from gemc_api_materials import *


# This section handles checking for the required configuration filename argument and also provides help and usage messages
desc_str = "   Will create the example geometry and materials definitions.\n"
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

# materials
from materials import define_materials
# geometry
from geometry import *

# all the scripts must be run for every configuration
allConfigs = ["original"]

for conf in allConfigs:
	configuration.variation = conf
	
	# materials
	init_materials_file(configuration)
	define_materials(configuration)

	# geometry
	init_geom_file(configuration)		#  Overwrites any existing geometry file and starts with an empty file
	makeGeometry(configuration)
	

