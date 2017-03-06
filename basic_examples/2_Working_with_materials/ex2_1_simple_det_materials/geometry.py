from gemc_api_geometry import *

def makeGeometry(configuration):
	# volume fields can be given either as named arguments in the MyDetector() call or  assigned later to the instance variable
	detector = MyDetector(name="my_det", mother="root")	
	detector.description = "Si detector"
	detector.pos = "0.*cm 0.*cm 0.*cm"
	detector.rotation = "0*deg 0*deg 0*deg"
	detector.color = "f4a988"
	detector.type = "Tube"
	# Tube shape dimensions are:  inner_radius, outer_radius, half-length, starting_angle, total angle
	# A non-zero inner radius will produce a hollow tube.  The angles allow for an angular cut in the cross section
	detector.dimensions = "0.*cm 1.*cm 5.*mm 0*deg 360*deg"
	detector.material = "G4_Si"	# G4_Si is a GEANT4 defined element name
							# When using only built-in materials, a separate materials file is not needed
	detector.mfield = "no"
	detector.visible = 1			# 1 to display volume with the full geometry, 0 to leave hidden
	detector.style = 1			# 1 displays volume as a solid, 0 displays as wireframe
	detector.sensitivity = "flux"	# Every track through the volume will generate a hit
	detector.hit_type = "flux"		# Every track through the volume will generate a hit
	detector.identifiers = "1"		# Identifies the detector being hit:  for FLUX detector this is an integer value
	
	print_det(configuration, detector)


	detector = MyDetector(name="scint_det", mother="root", pos="0*cm 0*cm 5*cm", \
		type="Box", dimensions="1*cm 1*cm 1*cm", material="scintillator", style=1)
	print_det(configuration, detector)
	
	detector = MyDetector(name="water_det", mother="root", pos="0*cm 0*cm 10*cm", \
		type="Box", dimensions="1*cm 1*cm 1*cm", material="water", style=1)
	print_det(configuration, detector)

	detector = MyDetector(name="my_air_det", mother="root", pos="0*cm 0*cm 15*cm", \
		type="Box", dimensions="1*cm 1*cm 1*cm", material="my_air", style=1)
	print_det(configuration, detector)

	detector = MyDetector(name="my_lucite_det", mother="root", pos="0*cm 0*cm 20*cm", \
		type="Box", dimensions="1*cm 1*cm 1*cm", material="my_lucite", style=1)
	print_det(configuration, detector)
	