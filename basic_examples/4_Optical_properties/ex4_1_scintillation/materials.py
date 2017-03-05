
from gemc_api_materials import *


def define_materials(configuration):
	# EJ-232 Plastic Scintillator, Eljen Technologies - polyvinyltoluene
	# The optical properties are made up for this example, see the datasheet to obtain real values
	EJ_232 = MyMaterial(name="EJ_232", description="Eljen Technologies EJ-232 plastic scintillator", density="1.032",
		ncomponents="2",  components="C 9 H 10")
	EJ_232.photonEnergy = "1.0*eV 2.0*eV 4.0*eV 6.0*eV"
	EJ_232.indexOfRefraction = "1.40 1.40 1.40 1.40"
	EJ_232.absorptionLength = "1000.*m 1000.*m 1000.*m 1000.*m"
	EJ_232.reflectivity = "0.5 0.5 0.5 0.5"
	EJ_232.efficiency = "0.2 0.2 0.2 0.2"
	EJ_232.fastcomponent = "0.8 0.8 0.8 0.8"
	EJ_232.slowcomponent = "0.05 0.05 0.05 0.05"
	EJ_232.scintillationyield = "8400."		# Characteristic light yield in photons/MeV e-
	EJ_232.resolutionscale = "2.0"		# Resolution scale broadens the statistical distribution of generated photons
								#~ # due to impurities typical of doped crystals like NaI(Tl) and CsI(Tl).  Can be narrower
								#~ # when the Fano factor plays a role.  Actual number of emitted photons in a step fluctuates
								#~ # around the mean number with width (ResolutionScale*sqrt(MeanNumberOfPhotons)
	EJ_232.fasttimeconstant = "0.35*ns"	# Assuming this is rise time?  Pulse width FWHM is 1.3*ns
	EJ_232.slowtimeconstant = "1.6*ns"	# Assumung this is decay time?
	EJ_232.yieldratio = "0.8"		# relative strength of the fast component as a fraction of total scintillation yield
	print_mat(configuration, EJ_232);
	
