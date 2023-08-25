# CLAS12 RICH gemc geometry

RICH geometry constructed as a combination of stl (stored in coatjava) and geant4 volumes.

STL (generated in CLAS12 reference frame for sector 4, rotate 180*deg around z for sector1):
RICH_s*: mother volume (original now edited to properly contain all optical equipment)
Layer 20*: aerogel tiles
Layer 30*: planar mirrors
Additional material budget: mirror support, wrapping, etc.

geant4 volumes:
PMTs and spherical Mirrors

Execute with
./rich_sector4.pl config.dat

Generates two configurations:
	  - sector4: RICH only in sector4 (run groups prior to summer 2023)
	  - sector4and1: RICH in both sector 4 and 1

Cad files for the two sectors currently stored separately, so cad and geometry files are imported in gcard as:
        <detector name="rich"         factory="TEXT" variation="sector4and1"/>
        <detector name ="cad_sector4/"    factory="CAD"/>
        <detector name ="cad_sector1/"    factory="CAD"/>

 