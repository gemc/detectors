from gemc_api_geometry import *

def makeGeometry(configuration):
	# Build a front painted mirror
	mir_box = MyDetector(name="mir_box", mother="root", description="mirror block", \
		type="Box", dimensions="14.14*cm 14.14*cm 5.*cm", material="Component",  \
		pos="0.*cm 0*cm -0.2*cm")
	print_det(configuration, mir_box)
	
	# Build a paraboloid mirror
	para_solid = MyDetector(name="para_solid", mother="root", description="paraboloid mirror", \
		type="Paraboloid", dimensions="5*cm 0*cm 14.14*cm", material="Component", \
		pos="0.*cm 0*cm 0.*cm")
	print_det(configuration, para_solid)

	# Subtract the paraboloid solid from the box to get a concave mirror
	# Assign an optical boundary to the entire surface of the resulting solid
	mir_box = MyDetector(name="para_mirror", mother="root", description="parabolic mirror", \
		type="Operation:@ mir_box - para_solid", material="glass",  color="33f9e34", style=1, \
		pos="0.*cm 0*cm 0*cm", rotation="90*deg -90*deg 0*deg", sensitivity="mirror: front_mirror", hit_type="mirror")
	print_det(configuration, mir_box)
