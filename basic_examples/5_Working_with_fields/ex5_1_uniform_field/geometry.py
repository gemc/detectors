from gemc_api_geometry import *

def makeGeometry(configuration):
	build_dipole_magnet(configuration)
	build_field_volume(configuration)
	
def build_field_volume(configuration):
	# The problem with assigning a field to the iron magnet yoke is that the hole in it is exactly where we
	# need the field to be.  Overcoming this by defining an invisible volume the shape of the yoke that will
	# overlap the magnet and provide the field through the entire volume.  Hopefully doesn't cause problems
	# with overlapping geometry.  If it did, could assign the field only to the hole.
	# Assign the magnetic field to this volume.  A field can be assigned to any volume, even vacuum or invisible
	d_field = MyDetector(name="dfield", type="Tube", \
		dimensions="20*cm 60*cm 20*cm 90.*deg 90*deg", material="Vacuum", \
		mfield="dipoleZ", visible=0)
	print_det(configuration, d_field)
	
	
def build_dipole_magnet(configuration):
	# The 'magnet' is going to be a solid block of iron with a hole in it.
	# Make the full block first:  using a vertical "tube" to get an arc with a rectangular cross section
	# Each volume has to be defined in the geometry text file for gemc to do the subtraction
	d_outside = MyDetector(name="dout", type="Tube", \
		dimensions="20*cm 60*cm 20*cm 90.*deg 90*deg", material="Component", mfield="dipoleZ")
	print_det(configuration, d_outside)
	
	# Now make the hole:  same thing but smaller and extends past the previous faces in angular arc
	# to be sure it cuts the end faces when we subtract it from the larger block
	d_hole = MyDetector(name="dhole", type="Tube", \
		dimensions="36*cm 44*cm 3*cm 89.*deg 92.*deg", material="Component")
	print_det(configuration, d_hole)

	# Now subtract the hole from the block to get our "dipole" magnet yoke
	# The material, color, rotations, etc. can all be assigned to this final shape rather than the components
	dipole = MyDetector(name="dipole", mother="root", description="my dipole magnet", \
		pos="0*cm 0*cm 0*cm", rotation="0*deg 0*deg 0*deg", \
		color="3399cc3", type="Operation: dout - dhole", material="G4_Fe",
		visible=1, style=1)
	print_det(configuration, dipole)
