
from gemc_api_materials import *

def define_materials(configuration):
	# Pyrex glass from the Geant4 NIST materials database, adding an index of refraction
	glass = MyMaterial(name="glass", description="pyrex glass", density="2.23",
		ncomponents="1",  components="G4_Pyrex_Glass 1")
	glass.photonEnergy = "1.0*eV 6.0*eV"
	glass.indexOfRefraction = "1.47 1.47"
	#~ glass.reflectivity = "0.99 0.99"
	print_mat(configuration, glass);
	
	# Aluminum mirror coating with high reflectivity
	mirror_coating = MyMaterial(name="mirror_coating", description="mirror coating", density="2.70",
		ncomponents="1",  components="G4_Al 1")
	mirror_coating.photonEnergy = "1.0*eV 6.0*eV"
	mirror_coating.indexOfRefraction = "1.2 1.2"
	mirror_coating.reflectivity = "0.97 0.97"
	print_mat(configuration, mirror_coating);
	
	# Vacuum optical
	vacOpt = MyMaterial(name="vacOpt", description="vacuum with optical properties",  \
		ncomponents="1",  components="G4_Galactic 1.0")
	vacOpt.photonEnergy = "1.0*eV 6.0*eV"
	vacOpt.indexOfRefraction = "1.00 1.00"
	vacOpt.absorptionLength = "1000.*m 1000.*m"
	#~ vacOpt.reflectivity = "0.01 0.01"
	#~ vacOpt.efficiency = "0.001 0.001"
	print_mat(configuration, vacOpt);
