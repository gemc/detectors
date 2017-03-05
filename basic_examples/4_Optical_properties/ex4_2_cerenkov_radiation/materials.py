
from gemc_api_materials import *


def define_materials(configuration):
	# Water with optical properties - parameter values are just made up for this example, use real values in a serious simulation
	mgf2 = MyMaterial(name="water", description="optical water", ncomponents="1",  components="G4_WATER 1")
	mgf2.photonEnergy = "1.0*eV 6.0*eV"
	mgf2.indexOfRefraction = "1.33 1.33"
	mgf2.absorptionLength = "25.*m 25.*m"
	print_mat(configuration, mgf2);
