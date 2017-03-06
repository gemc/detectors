from gemc_api_geometry import *

def makeGeometry(configuration):
	build_Cerenkov_radiator(configuration)

def build_Cerenkov_radiator(configuration):
	# Build the truncated cone radiator
	detector = MyDetector(name = "radiator", mother = "root", description = "MgF2 radiator", pos = "0*cm 0.0*cm -2.5*cm", \
		color = "f4a988", material = "water", style=1)	
	detector.type = "Box"
	detector.dimensions = "10.*cm 10.*cm 10.*cm"
	print_det(configuration, detector)
