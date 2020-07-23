#!/usr/bin/env python

import sys, os
import argparse	# Used to parse the command line arguments
from gemc_api_utils import *


# This section handles checking for the required configuration filename argument and also provides help and usage messages
desc_str = "   Will create the geometry, materials, bank and hit definitions.\n"
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

# geometry
from geometry import *
init_geom_file(configuration)		#  Overwrites any existing geometry file and starts with an empty file ready to append detectors
makeGeometry(configuration)
	

