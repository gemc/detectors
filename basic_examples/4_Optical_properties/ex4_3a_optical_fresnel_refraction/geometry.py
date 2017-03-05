from gemc_api_geometry import *

def makeGeometry(configuration):
	# Make a box of water
	water_box = MyDetector(name="water_box", mother="root", description="a box of water", type="Box", \
		pos="0*cm 1*cm 0.*cm", dimensions="10*cm 1*cm 1*cm", material="water", style=1, color="0000ff4")
	print_det(configuration, water_box)

	# Make a box of air
	air_box = MyDetector(name="air_box", mother="root", description="a box of air", type="Box", \
		pos="0*cm -1*cm 0.*cm", dimensions="10*cm 1*cm 1*cm", material="air", style=1, color="ff00004")
	print_det(configuration, air_box)
