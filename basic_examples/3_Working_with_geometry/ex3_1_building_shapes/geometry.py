from gemc_api_geometry import *

def makeGeometry(configuration):
	build_simple_shapes(configuration)
	build_addition_shapes(configuration)
	build_subtraction_shapes(configuration)
	build_intersection_shapes(configuration)
	
def build_simple_shapes(configuration):
	# Make a box
	my_box = MyDetector(name="my_box", mother="root", pos="-5*cm 0*cm -5*cm", \
		type="Box", dimensions="1*cm 1*cm 1*cm", material="scintillator", style=0)
	print_det(configuration, my_box)
	
	# Make a sphere
	my_sphere = MyDetector(name="my_sphere", mother="root", pos="-5*cm 0*cm 0*cm", \
		type="Sphere", dimensions="0*cm 2*cm 0*deg 360*deg 0*deg 180*deg", 
		material="G4_Cu", style=1, color="33eeff3")
	print_det(configuration, my_sphere)
	
	# Make a cone
	my_cone = MyDetector(name="my_cone", mother="root", pos="-5*cm 0*cm 5*cm", \
		type="Cons", dimensions="8*mm 10*mm 4*mm 6*mm 1.5*cm 0.*deg 270.*deg", \
		material="G4_PLEXIGLASS", style=1, color="0000ff")
	print_det(configuration, my_cone)

	
def build_addition_shapes(configuration):
	# Make a box with a pointed end (addition)
	# Make a box
	# Note the material field is set to "Component".  color, material, field, etc are not needed
	# The first volume defines the coordinate system for positioning the remaining components
	# UNLESS the '@' is used in the "Operation: " field below to join them together
	box_a = MyDetector(name="box_a", mother="root", type="Box", \
		dimensions="1*cm 1*cm 1*cm", material="Component")
	print_det(configuration, box_a)

	# Make a trapezoid
	# This shape is positioned 1 cm up in y
	# Note that each component shape must be written to the geometry file in order for gemc to use it for addition
	trap_a = MyDetector(name="trap_a", mother="root", pos="0*cm 0*cm 2*cm", \
		type="Trd", dimensions="1*cm 1*mm 1*cm 1*mm 1*cm", material="Component")
	print_det(configuration, trap_a)

	# Join the two shapes together
	# The "Operation: " type with '+'  yields the union of the two shapes.  The second shape is positioned
	# with respect to the coordinate system of the first shape.  If "Operation:@ " is used, both shapes are positioned
	# relative to their mother volume, which is "root" in this example.
	# The dimension field is not needed since it is defined by the components.  Translations and rotations
	# can be applied to this final shape to move the completed solid as a whole
	my_add_shape = MyDetector(name="shape_add", mother="root", pos="5*cm 0*cm -5*cm", \
		rotation="30*deg 30*deg 0*deg", type="Operation: box_a + trap_a", \
		material="G4_WATER", style=1, color="00ff003")
	print_det(configuration, my_add_shape)
	
def build_subtraction_shapes(configuration):
	# Make a sphere with a hole in it (subtraction)
	
	# Make a sphere
	my_sphere1 = MyDetector(name="my_sphere1", mother="root", \
		type="Sphere", dimensions="0*cm 2*cm 0*deg 360*deg 0*deg 180*deg", \
		material="Component")
	print_det(configuration, my_sphere1)

	# Make a cylindrical hole
	hole1 = MyDetector(name="hole1", mother="root", type="Tube", \
		dimensions="0.*mm 2.*mm 2.5*cm 0.*deg 360.*deg", material="Component")
	print_det(configuration, hole1)
		
	# Subtract the hole from the sphere
	my_sphere2 = MyDetector(name="my_sphere2", mother="root", pos="5*cm 0*cm 0*cm", \
		type="Operation: my_sphere1 - hole1", material="G4_Cu", style=1, color="00ff003")
	print_det(configuration, my_sphere2)
	
	box_a = MyDetector(name="box_a", mother="root", type="Box", \
		dimensions="1*cm 1*cm 1*cm", material="Component")
	print_det(configuration, box_a)

	
def build_intersection_shapes(configuration):
	# Make an intesection of two tubes (solid intersection)
	
	# Make a tube
	my_tube = MyDetector(name="my_tube1", mother="root", \
		type="Tube", dimensions="1.6*cm 2*cm 4*cm 0*deg 360*deg", material="Component")
	print_det(configuration, my_tube)

	# Make another tube.  I don't actually need to create a new python detector object since gemc only cares
	# about what is written into the geometry file.  So I can just change the name and orientation of the first tube
	# That's probably not the clearest way of writing code, just here to show it works
	my_tube.name="my_tube2"
	my_tube.rotation="0*deg 90.*deg 0.*deg"
	print_det(configuration, my_tube)
		
	# Take the solid intersection of the two tubes.  Remember, the intersection happens in gemc, not here
	# in this python script so it doesn't matter that there aren't two distinct python objects for the two tubes
	my_intersect = MyDetector(name="my_intersect", mother="root", pos="5*cm 0*cm 5*cm", \
		type="Operation: my_tube1 * my_tube2", material="G4_Cu", style=1, color="ff00003")
	print_det(configuration, my_intersect)
