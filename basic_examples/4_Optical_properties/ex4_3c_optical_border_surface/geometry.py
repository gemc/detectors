from gemc_api_geometry import *

def makeGeometry(configuration):
	build_scintillator(configuration)

def build_scintillator(configuration):
	# Build the scintillator rod
	# The scintillator rod is assigned a mirror property called 'scint_surface' which is defined in the mirror definition file
	detector = MyDetector(name = "scintillator", mother = "root", description = "scintillator",  \
		color = "f4a988", material = "EJ_232", style=1)	
	detector.type = "Tube"		# Truncated cone:  3cm dia at top, 5cm dia at bottom, 5cm tall, solid
	detector.dimensions = "0.*cm 2.*cm 5.*cm 0*deg 360*deg"
	detector.sensitivity = "mirror: scint_surface"
	detector.hit_type = "mirror"
	print_det(configuration, detector)

	# Now copy the scintillator volume to a component volume to use as a subtraction solid (not sure if this is necessary)
	detector.name="scintillator_shape"
	detector.material="Component"
	detector.pos="0.*cm 0.*cm 0.*cm"
	print_det(configuration, detector)

	# Create a larger cylinder with a hole for the cylinder to fit into but sticking out of one end.  This will define
	# a border that covers part of the side of the scintillator and one end
	# This part is the larger cylinder, positioned +1 cm over in z
	d0 = MyDetector(name="cylinder_vol", mother="root", type="Tube", \
		dimensions="0*cm 2.5*cm 5.*cm 0*deg 360*deg", material="Component", style=1, pos="0*cm 0*cm 1.*cm")
	print_det(configuration, d0)
	# This part subtracts the shape of the scintillator rod
	# Note the '@' sign in the Operation definition means that both components positions are with respect to the mother volume
	detector = MyDetector(name="scintillator_env", mother="root", type="Operation:@ cylinder_vol - scintillator_shape", \
		material="vacOpt", style=1, color="0055884", pos="0*cm 0*cm 1.*cm")
	print_det(configuration, detector)
