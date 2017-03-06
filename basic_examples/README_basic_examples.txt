#=======================================
#	basic examples README
#=======================================

This folder contains a series of very simple examples for using various features of gemc.  It is hoped that the user can take these basic ideas and use them in their own more complicated projects.

The instructions to run and build each example are given in README.txt files in each folder.


The examples are divided into several general categories.

1_Simple_detector:
Äúex1_1_simple_det		The simplest gemc project with 1 sensitive detector
Äúex1_2_add_digitization	Shows how to use a digitization factory to save hit data

2_Working_with_materials:
ex2_1_det_materials		Shows different ways to define a material in gemc

3_Working_with_geometry:
Äúex3_1_building_shapesù	Examples of using the Geant4 solids, including boolean operations
Äúex3_2_parameters_and_variations	Shows how to use a parameter file to import geometry values
Äú
4_Optical_properties:
Äúex4_1_scintillation			Shows how to define optical properties for scintillation
Äúex4_2_cerenkov_radiation  	Shows how to define materials to generate Cerenkov photons
ex4_3a_optical_fresnel_refraction	Shows reflection and refraction at the boundary of two optical materials
ex4_3b_optical_skin_surface	Shows a parabolic mirror by adding a reflective coating to a shaped glass block
ex4_3c_optical_border_surface	Shows an optical boundary at the border between two volumes with touching surfaces
Äú
5_Working_with_fields:
Äúex5_1_uniform_field		Simple dipole magnet with a uniform magnetic field