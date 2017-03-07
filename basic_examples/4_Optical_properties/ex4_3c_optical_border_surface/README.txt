#=======================================
#	README Optical border surface
#	this example requires gemc_2.6 or higher (see gemc changelog for fixes to border surface ordering)
#=======================================

This folder has a simple example of how the optical border surface works in gemc.

Optical physics is turned on simply by adding the keyword 'Optical' to the physics list.  In the gcard file, there is a line like this:
	<option name="PHYSICS" value="STD + FTFP_BERT + Optical"/>

To assign optical properties to a material, define a list of photon energies (photonEnergy) at which the optical parameters will be provided.  Then provide a list of values for at least one optical property evaluated at those energies, for example, indexOfRefraction or absorptionLength.  More details are given in the python API used by this example.

An optical surface is defined in gemc through the use of the mirror definition.  This is not limited to mirrors but is a general definition for any optical boundary.  To assign a boundary, set the 'sensitivity' field of a volume to 'mirror: mirror_name' and the hit_type field to 'mirror'.  Then create a mirror definition file (see the python or perl api) that contains a definition for 'mirror_name'.  The mirror definition provides information about the surface characteristics and the scattering model.  A material can be assigned to the boundary layer without having to build a physical volume for it, for example, to apply a thin paint.  The optical properties for the boundary material can either be specified in the mirror definition or retrieved from the defined material properties by giving the material name in the matOptProps field.

There are two types of optical boundaries defined in GEANT4 and gemc.  The first is a "SkinSurface" and consists of the entire surface of a volume.  It is selected by putting "SkinSurface" in the 'border' field of the mirror definition. The boundary properties do not depend on the direction of the photon (though it can be front- or back-painted) and all faces of the volume are given the same properties.  The second type is a border surface.  This is an ordered boundary consisting of the region over which the faces of two neighboring volumes touch.  A border surface is selected by entering the name of the bordering volume in the 'border' field of the mirror definition. Any value of the 'border' field that is not 'SkinSurface' is expected to be the name of a bordering volume in gemc.  The boundary applies to photons moving from the primary volume (the one setting a mirror sensitivity) toward the secondary volume (the one listed in the 'border' field of the mirror definition). This allows one to set different optical properties for the surface depending on which way the photon is going.  It is not necessary that either volume be enclosed inside the other, they only need to have some part of their surfaces in contact.

In this example, a rod-shaped scintillator is only partially enclosed by a larger cylinder (envelope) with a hole in it for the scintillator to slide into.  The larger cylinder is a vacuum material and is only there to define a border surface with the scintillator rod that includes part of the side of the rod and one end.  Optical properties have been added to the vacuum to allow photons to propagate out of the scintillator rod.  The index of refraction of the scintillator has been artificially reduced to 1.0 to reduce reflections from the mismatch of refractive indices and make it easier to focus on the effect of the optical boundary definition.

The mirror definition is defined as a fully reflective paint applied to the bordering surface of the scintillator rod and the larger envelope volume.  A 15 MeV proton is fired into the rod along the axis to produce scintillation light.  It is seen that the light is completely reflected inside the rod except where the rod extends outside the enveloping volume.  

The example should be able to run directly in gemc with the provided text input files and  the gcard option 
file using the command:
	gemc.command example.gcard

If one wants to generate the text input files from the provided python scripts, the location of the python api files should be added to the PYTHONPATH. If installing via the DMG, add the following path for gemc-2.6:
export PYTHONPATH=$PYTHONPATH:/Applications/gemc-2.6.app/gemc.app/Contents/Resources/api/python
Adjust version number for a different gemc version

When this is done, generate the project files using:
	./example.py config.dat
WARNING:  this will overwrite the original project text files.



#=======================================
#	gemc mirrors definition
#
#	This file defines a MyMirror class that holds values to define an optical boundary.  In gemc, any type of optical boundary
#	is described as a "mirror", regardless of its use or reflective quality.
#
#	Each mirror definition is an instance of the class. All of the instance variables are strings.
#
#	Class members (all members are text strings):
#	name			- The name of the mirror definition
#	description			-  A description of the mirror definition
#	type				- The surface type (see below).  Example:  "dielectric_dielectric" or "dielectric_metal"
#	finish			- The type of finish of the optical surface (see below for options). Example:  "polishedfrontpainted"
#	model			- The optical model to use for the surface (see below for options)
#	border			- "SkinSurface" if the optical boundary represents the entire outside surface of a volume
#					- For a border surface defined as the contact area between two neighboring volumes, use the
#					- name of the bordering volume.  Optical surfaces are ordered in GEANT4 and gemc.
#	matOptProps		- use the name of a material with optical properties to use as the boundary properties
#					- The material does not have to be the same as either bordering volume, i.e., a thin paint
#					- if "notDefined" then use the properties defined in the following variables to define the boundary
#	photonEnergy		- a list of photon energies at which to evaluate the following optical properties
#	indexOfRefraction	- a list of boundary material refractive indices evaluated at the energies in photonEnergy
#	reflectivity			- a list of boundary material reflectivities evaluated at the energies in photonEnergy
#	efficiency			- a list of photoelectric absorption efficiencies evaluated at the energies in photonEnergy
#					- efficiency is used in "dielectric_metal" boundaries where the photon is either reflected or
#					- absorbed by the metal with this efficiency.  Can be used as the quantum efficiency in a PMT.
#	specularlobe		- defines scattering properties of a rough optical surface
#	specularspike		- defines scattering properties of a rough optical surface
#	backscatter			- defines scattering properties of a rough optical surface

# =================================================================
# Available finish in materials/include/G4OpticalSurface.hh:
#
# polished,                    // smooth perfectly polished surface
# polishedfrontpainted,        // smooth top-layer (front) paint
# polishedbackpainted,         // same is 'polished' but with a back-paint
#
# ground,                      // rough surface
# groundfrontpainted,          // rough top-layer (front) paint
# groundbackpainted,           // same as 'ground' but with a back-paint
#
# polishedlumirrorair,         // mechanically polished surface, with lumirror
# polishedlumirrorglue,        // mechanically polished surface, with lumirror & meltmount
# polishedair,                 // mechanically polished surface
# polishedteflonair,           // mechanically polished surface, with teflon
# polishedtioair,              // mechanically polished surface, with tio paint
# polishedtyvekair,            // mechanically polished surface, with tyvek
# polishedvm2000air,           // mechanically polished surface, with esr film
# polishedvm2000glue,          // mechanically polished surface, with esr film & meltmount
#
# etchedlumirrorair,           // chemically etched surface, with lumirror
# etchedlumirrorglue,          // chemically etched surface, with lumirror & meltmount
# etchedair,                   // chemically etched surface
# etchedteflonair,             // chemically etched surface, with teflon
# etchedtioair,                // chemically etched surface, with tio paint
# etchedtyvekair,              // chemically etched surface, with tyvek
# etchedvm2000air,             // chemically etched surface, with esr film
# etchedvm2000glue,            // chemically etched surface, with esr film & meltmount
#
# groundlumirrorair,           // rough-cut surface, with lumirror
# groundlumirrorglue,          // rough-cut surface, with lumirror & meltmount
# groundair,                   // rough-cut surface
# groundteflonair,             // rough-cut surface, with teflon
# groundtioair,                // rough-cut surface, with tio paint
# groundtyvekair,              // rough-cut surface, with tyvek
# groundvm2000air,             // rough-cut surface, with esr film
# groundvm2000glue             // rough-cut surface, with esr film & meltmount

# Available models in materials/include/G4OpticalSurface.hh:
#
# glisur,                      // original GEANT3 model
# unified,                     // UNIFIED model
# LUT                          // Look-Up-Table model

# Available surface types in materials/include/G4SurfaceProperty.hh
#
# dielectric_metal,            // dielectric-metal interface
# dielectric_dielectric,       // dielectric-dielectric interface
# dielectric_LUT,              // dielectric-Look-Up-Table interface
# firsov,                      // for Firsov Process
# x_ray                        // for x-ray mirror process

# Border Volume Types:
#
# SkinSurface: surface of a volume
# Border Surface: surface between two volumes (second volume must exist)

# =================================================================
