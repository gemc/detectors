#!/usr/bin/env python3

import sys, os
import argparse	# Used to parse the command line arguments
from gemc_api_utils import *
from gemc_api_parameters import *
from gemc_api_materials import *
from gemc_api_hit import *
from gemc_api_bank import *



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


# Loading configuration file and parameters
configuration = load_configuration(cfg_file)

# materials
from materials import define_materials
# banks definitions
from bank import define_bank
# hits definitions
from hit import define_hit

# hits
init_hits_file(configuration)
define_hit(configuration)

# bank definitions
init_bank_file(configuration)
define_bank(configuration)

# geometry
from geometry import *
init_geom_file(configuration)		#  Overwrites any existing geometry file and starts with an empty file ready to append detectors
makeGeometry(configuration)
	

