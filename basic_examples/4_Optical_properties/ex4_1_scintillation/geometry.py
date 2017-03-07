from gemc_api_geometry import *

def makeGeometry(configuration):
	build_scintillator(configuration)

def build_scintillator(configuration):
	detector = MyDetector()	
	detector.name = "scintillator"
	detector.mother = "root"
	detector.description = "scintillator"
	detector.pos = "0*cm 0.*cm 0.*cm"
	detector.rotation = "0*deg 0*deg 0*deg"
	detector.color = "3399cc"
	detector.type = "Box"
	detector.dimensions = "1.*cm 1.*cm 1.*cm"
	detector.material = "EJ_232"
	detector.mfield = "no"
	detector.visible = 1
	detector.style = 1
	
	print_det(configuration, detector)
