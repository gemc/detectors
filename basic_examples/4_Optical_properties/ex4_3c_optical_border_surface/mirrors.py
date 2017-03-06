from gemc_api_mirrors import *

def define_mirrors(configuration):

	# define the border surface
	# For a border surface, the 'border' property contains the name of the touching volume that defines the common surface
	# Order matters.  This surface is defined for photons inside the scintillator going toward the envelope volume
	# A material can be assigned to the border to define surface properties (like paint) without needing a physical volume for the surface
	lg_mir = MyMirror(name="scint_surface", description="border between scintillator and the envelope volume")
	lg_mir.type = "dielectric_dielectric"
	lg_mir.finish = "polishedfrontpainted"
	lg_mir.model = "unified"
	lg_mir.border = "scintillator_env"
	lg_mir.matOptProps = "EJ_510"
	
	print_mir(configuration, lg_mir)	