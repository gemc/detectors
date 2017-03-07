#=======================================
#	README Fresnel reflection and refraction
#=======================================

This folder has a simple example of how photons propagate between two optical materials in gemc.

Optical physics is turned on simply by adding the keyword 'Optical' to the physics list.  In the gcard file, there is a line like this:
	<option name="PHYSICS" value="STD + FTFP_BERT + Optical"/>

Optical photons in gemc may travel freely between two volumes in contact with each other as long as both are assigned a material with a defined index of refraction.  There is no requirement to define an optical boundary between the two volumes.  To define an index of refraction, provide a list of photon energies to the 'photonEnergy' field of the material definition as well as a list of refractive indices evaluated at those energies to the 'indexOfRefraction' field.

Photons crossing the boundary will be either transmitted, reflected, or refracted according to Snell's Law based on the two respective indices.  Total internal reflection will occur below the critical angle.

The example has two adjacent boxes, one of air and one of water.  Photons are generated in the air and sent toward the water at various angles.  Reflection and refraction can be seen as well as total internal reflection.  There is an occasional refracted ray below the critical angle.  This may reflect an issue with minimum step size?  The photons do not leave the boxes because the hall material defaults to "Vacuum" which has no defined optical properties.  An optical photon will not enter a material with no optical properties. 

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
