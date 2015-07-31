#!/usr/bin/python
import sys
from Write_HPS_ecal import *

if __name__ == "__main__":
    ##############################################################################################
    Detector = "hps_ecal_gdml"

    Variation= "original"

    print "Recreating tables for "+Detector
    print_parameters()

    geo_en = GeometryEngine(Detector)
 

    Box_Half_depth = 2000
    geo_en.add(geom = Geometry(
                         name = "ECAL",
                         mother="root",
                         description="world_volume",
                         pos=[0,0,0],
                         pos_units="mm",
                         rot=[0,0,0],
                         rot_units="rad",
                         col="ffff55",
                         g4type="Box",
                         dimensions=[Box_Half_width_back + 2 * Plate_side_thickness,
                                     Box_height / 2.,
                                     Box_Half_depth ],
                         dims_units="mm",
                         material="Vacuum",
                         style=0,
                         visible=1
                         ))


    origin=[21.42,0,z_location]  # Note: this is in mm

    calculate_ecal_crystalbox_geometry(geo_en,origin=origin)
    calculate_ecal_coolingsys_geometry(geo_en,origin=origin)
    calculate_ecal_vacuum_geometry(geo_en,origin=origin)

    print "geo_en     length = ",len(geo_en._Geometry)
#    print "geo_en_vac length = ",len(geo_en_vac._Geometry)
    #
    # Now write the tables to the MySQL database
    #

    geo_en.TXT_Write(Variation)



