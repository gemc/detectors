#=======================================
#	README Cerenkov
#=======================================

This folder has a simple example of how the Cerenkov optical process works in gemc.

Cerenkov radiation is activated by turning on the optical physics and then assigning optical properties to a material. 

Optical physics is turned on simply by adding the keyword 'Optical' to the physics list.  In the gcard file, there is a line like this:
	<option name="PHYSICS" value="STD + FTFP_BERT + Optical"/>

To assign optical properties to a material, define a list of photon energies (photonEnergy) at which the optical parameters will be provided.  Then provide a list of values for at least one optical property evaluated at those energies, for example, indexOfRefraction or absorptionLength.  More details are given in the python API used by this example and also below.  Only the indexOfRefraction property is required to produce Cerenkov radiation.

The example is a simple 10 cm cube of water hit with a 140 MeV muon.  The Cerenkov photons are emitted in a cone around the particle track.  The muon energy can be varied up and down to see the cone angle change.  Notice that the default G4_WATER material from GEANT4 does not have optical properties.  These had to be added by creating a new optical water material based on G4_WATER.  The index defined here is just a simple example for illustration.  The photons do not leave the cube because the hall material defaults to "Vacuum" which has no defined optical properties.  An optical photon cannot propagate in a material with no optical properties.  This will be discussed further in a later example on optical boundaries.

The example should be able to run directly in gemc with the provided text input files and  the gcard option 
file using the command:
	gemc.command example.gcard

If one wants to generate the text input files from the provided python scripts, the location of the python api files should be added to the PYTHONPATH. If installing via the DMG, add the following path for gemc-2.6:
export PYTHONPATH=$PYTHONPATH:/Applications/gemc-2.6.app/gemc.app/Contents/Resources/api/python
Adjust version number for a different gemc version

When this is done, generate the project files using:
	./example.py config.dat
WARNING:  this will overwrite the original project text files.




#	*****  These values set optical properties for materials.  They can be ignored (left to default values) if not using optical physics.
#
#	photonEnergy		- A list of photon energies at which any other optical parameters will be provided
#					- Not required (leave as default "none" if not using optical physics)
#					- if any optical parameter (indexOfRefraction, reflectivity, etc.) is defined, photonEnergy MUST also be defined
#					- provide as a list of energies with units, for example:  "1.0*eV 2.0*eV 3.0*eV 4.0*eV 5.0*eV 6.0*eV"
#	indexOfRefraction	- A list of the refractive index evaluated at the energies named in photonEnergy "1.40 1.39 1.38 1.37 1.36"
#					- must have same number of elements in list as in photonEnergy - same for all optical parameters
#	absorptionLength	- A list of the material absorption length evaluated at the energies in photonEnergy
#					- includes units, for example:  "72.8*m 53.2*cm 39.1*cm"
#	reflectivity			- A list of reflectivity values evaluated at the energies in photonEnergy
#	efficiency			- A list of absorption efficiency evaluated at the energies in photonEnergy
#					- efficiency is only used for a dielectric-metal optical boundary where there is no refraction
#					- At this boundary the photon is either reflected or absorbed by the metal with this efficiency
#					- This parameter can be used to define a quantum efficiency for a PMT, for example
#
#	*****  The next values are about defining scintillators.  They can be ignored (left to default values) if not using a scintillator
#	***** Scintillators are assumed to have a fast and slow response component, defined by relative spectra
#
#	fastcomponent		- A list of the fast component relative spectra values evaluated at the energies in photonEnergy
#	slowcomponent		- A list of the fast component relative spectra values evaluated at the energies in photonEnergy
#	scintillationyield		- Characteristic light yield in photons/MeV e-, given as a single number not a list:  "8400."
#	resolutionscale		- Resolution scale broadens the statistical distribution of generated photons
#					- due to impurities typical of doped crystals like NaI(Tl) and CsI(Tl).  Can be narrower
#					- when the Fano factor plays a role.  Actual number of emitted photons in a step fluctuates
#					- around the mean number with width (ResolutionScale*sqrt(MeanNumberOfPhotons)
#					- Resolution scale is given as a single number, not a list:  "2.0"
#	fasttimeconstant		- (??) believe this is related to the scintillator pulse rise time.  Given as number with units: "1.6*ns"
#	slowtimeconstant	- (??) believe this is related to scintillator slow decay time. Given as number with units: "3.2*ns"
#	yieldratio			- relative strength of the fast component as a fraction of total scintillation yield:  "0.8"
#	rayleigh			- A list of the Rayleigh scattering attenuation coefficient evaluated at the energies in photonEnergy
#
#
#	******	Note that photon energies can be obtained from the wavelength:
#			lambda * nu = c	where lambda is wavelength, c is the speed of light, and nu is frequency
#			E = h * nu		where h is Plank's constant
#			A handy relation for estimating is that h*c ~ 197 eV*nm
