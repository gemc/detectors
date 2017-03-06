
from gemc_api_materials import *


def define_materials(configuration):
	
	# Scintillator
	scintillator = MyMaterial(name="scintillator", description="ctof scintillator material", density="1.032",
		ncomponents="2",  components="C 9 H 10")
	print_mat(configuration, scintillator);

	# Diamond
	#~ diamond = MyMaterial(name="diamond", description="diamond detector material", density="3.53",
		#~ ncomponents="1",  components="C 1")
	#~ print_mat(configuration, diamond);

