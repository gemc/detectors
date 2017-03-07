
from gemc_api_materials import *


def define_materials(configuration):
	
	# water with index of refraction
	water = MyMaterial(name="water", description="optical water", \
		ncomponents="1",  components="G4_WATER 1", photonEnergy="1.0*eV 6.0*eV", indexOfRefraction="1.33 1.33")
	print_mat(configuration, water);

	# air with index of refraction
	air = MyMaterial(name="air", description="optical air", \
		ncomponents="1",  components="G4_AIR 1", photonEnergy="1.0*eV 6.0*eV", indexOfRefraction="1.0 1.0")
	print_mat(configuration, air);
