from gemc_api_mirrors import *

def define_mirrors(configuration):
	# front painted mirror definition
	mir = MyMirror(name="front_mirror", description="front painted mirror skin surface")
	mir.type = "dielectric_dielectric"
	mir.finish = "polishedfrontpainted"
	mir.model = "unified"
	mir.border = "SkinSurface"
	mir.matOptProps = "mirror_coating"
	print_mir(configuration, mir)
