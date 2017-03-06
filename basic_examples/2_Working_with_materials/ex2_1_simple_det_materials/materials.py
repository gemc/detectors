#=====================================
#
#	There are several ways to define a material in gemc.  These all come from the underlying material
#	definitions in GEANT4:
#	1. Use a predefined material from the GEANT4 and NIST materials lists.
#		In this case gemc does not need an external definition from a materials input file, the detector may call directly
#		For example, use "G4_WATER" or "G4_Fe" in the detector material field
#	2. Define a material using the chemical formula (# of atoms per element)
#		See examples below.
#	3. Define a material using the fractional mass.  It is suggested to use the GEANT4 predefined elements
#		as the components when using fractional masses.  See example below.
#	4. Redefine an existing material or add properties to it
#		This might happen if you want to add optical properties to an existing compound like "G4_PLEXIGLASS"
#		Define a material with 1 component and use the existing compound name for that component.
#		Add or change material properties for the new material.  See example below
#
#=====================================

from gemc_api_materials import *

def define_materials(configuration):
	# Define using the chemical formula by specifying the number of atoms of each element
	# Scintillator
	scintillator = MyMaterial(name="scintillator", description="scintillator material", density="1.032",
		ncomponents="2",  components="C 9 H 10")
	print_mat(configuration, scintillator);
	# Water
	water = MyMaterial(name="water", description="water material", density="1.000",
		ncomponents="2",  components="H 2 O 1")
	print_mat(configuration, water);

	# Define using a fractional amount
	# MyAir
	my_air = MyMaterial(name="my_air", description="homemade air", density="0.001290",
		ncomponents="2",  components="G4_N 0.7 G4_O 0.3")
	print_mat(configuration, my_air);

	# Redefine an existing material
	# MyAir
	my_lucite = MyMaterial(name="my_lucite", description="plexiglass with optics", density="1.19",
		ncomponents="1",  components="G4_PLEXIGLASS 1.0")
	my_lucite.photonEnergy = "1.77*eV 6.2*eV"
	my_lucite.indexOfRefraction = "1.5 1.5"
	print_mat(configuration, my_lucite);
