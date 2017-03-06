from gemc_api_geometry import *
from math import cos, sin, radians


def makeCTOF(configuration, parameters):
	global R, Rin, Rout, DZ, NUM_BARS, theta0, dx1, dx2, dy, dz
	# Assign paramters to local variables
	inches = 2.54		# This is in the gemc api math module
	NUM_BARS = int(parameters["ctof_number_of_bars"])
	dx1    =   parameters["bar_top_width"]*inches/2.0      # width at top,cm
	dx2    =   parameters["bar_bottom_width"]*inches/2.0   # width at bottom, cm
	dy     =   parameters["bar_length"]*inches/2.0         # length, cm
	dz     =   parameters["bar_heigth"]*inches/2.0         # heigth, cm
	if configuration.variation == "green":
		NUM_BARS = 8
	if configuration.variation == "red":
		dy = 4.0	# cm
	theta0 = 360./NUM_BARS                                  # double the angle of one of the trapezoid sides
	# midway between R_outer and R_inner - cm
	R =  25.0 + dz + 0.1
	# allowing a gap to contain the paddles
	Rin = R - dz - 0.1
	Rout = R + dz + 0.1
	DZ = dy

	build_mother(configuration)
	build_paddles(configuration)

def build_mother(configuration):
	detector = MyDetector()	
	detector.name = "ctof"
	detector.mother = "root"
	detector.description = "Central TOF Mother Volume"
	detector.pos = "0*cm 0.0*cm 0*mm"
	detector.rotation = "0*deg 0*deg 0*deg"
	detector.color = "000000"
	detector.type = "Tube"
	
	detector.dimensions = "%5.1f*cm %5.1f*cm %5.1f*cm 0*deg 360*deg" %(Rin, Rout, DZ)
	detector.material = "G4_AIR"
	detector.mfield = "no"
	detector.visible = 0
	detector.style = 0
	detector.sensitivity = "no"
	detector.hit_type = "no"
	detector.identifiers = "no"
	
	print_det(configuration, detector)

def build_paddles(configuration):
	for n in range(0, NUM_BARS):
		detector = MyDetector();

		detector.name = "paddle_%02d" % (n-1)
		detector.mother = "ctof"
		detector.description = "Central TOF Scintillator number %d" % n
		
		# positioning
		# The angle $theta is defined off the y-axis (going clockwise) so $x and $y are reversed
		theta  = (n-1)*theta0
		theta2 = theta + 90
		x      = "%6.3f" % (R*cos(radians(theta)))
		y      = "%6.3f" % (R*sin(radians(theta)))
		z      = "0"
		detector.pos = "%s*cm %s*cm %s*cm" % (x, y, z)
		detector.rotation = "90*deg %6.2f*deg 0*deg" % theta2
		if configuration.variation == "original":
			detector.color = "66bbff"
		if configuration.variation == "red":
			detector.color = "ff0000"
		if configuration.variation == "green":
			detector.color = "00ff00"
		detector.type = "Trd"
		detector.dimensions = "%5.1f*cm %5.1f*cm %5.1f*cm %5.1f*cm %5.1f*cm" % (dx1, dx2, dy, dy, dz)
		detector.material = "scintillator"
		detector.mfield = "no"
		detector.visible = 1
		detector.style = 1
		detector.sensitivity = "ctof"
		detector.hit_type = "ctof"
		detector.identifiers = "paddle manual %d" % n
		
		print_det(configuration, detector)
