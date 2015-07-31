#!/usr/bin/python
#
# Author: Holly Szumila (ODU)
# Date: July 30,2014
# Update: July 30, 2014

# This script makes two sensitive planes for readout with cosmic ray muons. 
#

# Notes:
#
# Geometry Notes:
# 
#
#
import math
#import MySQLdb
import sys

sys.path.append("..")    # Allow Python to find the Rotations.pyc and GeometryEngine.pyc in one directory up.
from Rotations import *
from GeometryEngine import Geometry, GeometryEngine, Sensitive_Detector


Standard_Table_Name="hps_cosmics"


#################################################################################################
#
# Global parameters. 
#
#
###############################################################################


dX_length = 61.5/2 #cm
dY_length = 1.0/2 #cm
dZ_length = 10/2 #cm

posX = 10.0 #cm
posY = 125.0 #cm, positive
posZ = 147.3 #cm, center of ecal crystals

########################################


###############Two Scintillators above and below ECal##########################
def calculate_scintillators(g_en,mother="root",origin=[0,0,0]):
    """This creates flux planes for scintillators above an below ECal. """

################################################################################
#
# Find or setup the sensitive detector components.
#
################################################################################

    ecal_sens = g_en.find_sensitivity("ECAL")  # First see if it exists already.
    if ecal_sens == -1:
        ecal_sens = create_ecal_sensitive_detector()
        g_en.add_sensitivity(ecal_sens)

    ######################################################################################################


    
    geo = Geometry( 
          name='ScintillatorTop',
          mother=mother,
          description='Scintillator above ECal',
          pos=[posX, posY, posZ],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='ffbbcc',
          g4type='Box',
          dimensions=[dX_length, dY_length, dZ_length],
          dims_units=['cm', 'cm', 'cm'],
          material='Vacuum',
          sensitivity=ecal_sens.sensitivity(),
          hittype=ecal_sens.hitType(),
          identity=ecal_sens.identity("70","70"),
          style=1,
          visible=1)
    g_en.add(geo)

    geo = Geometry( 
          name='ScintillatorBottom',
          mother=mother,
          description='Scintillator below ECal',
          pos=[posX, -posY, posZ],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='ffbbcc',
          g4type='Box',
          dimensions=[dX_length, dY_length, dZ_length],
          dims_units=['cm', 'cm', 'cm'],
          material='Vacuum',
          sensitivity=ecal_sens.sensitivity(),
          hittype=ecal_sens.hitType(),
          identity=ecal_sens.identity("71","71"),
          style=1,
          visible=1)
    g_en.add(geo)



       

if __name__ == "__main__":
    ##############################################################################################
    import sys

#################################################################################################
#
# Geometry engine setup for local running
#
#################################################################################################

#
# Table Names.
#
    DB_host = "localhost"
    DB_name = "hps_2014"
    DB_user = "myname"  
    DB_passwd = "mypassword"

    Detector = "hps_cosmics"

    Variation= "original"

    print "Recreating tables for "+Detector

    method="TXT"
    if sys.argv[0] == "TXT":
        print "TXT Engine"
    elif sys.argv[0] == "MySQL":
        print "MySQL Engine"
        method = "MySQL"
                
    geo_en = GeometryEngine(Detector)
 
#    geo_en_vac = GeometryEngine(Detector_Vac)
 
    

    
    calculate_scintillators(geo_en)

    print "geo_en     length = ",len(geo_en._Geometry)
#    print "geo_en_vac length = ",len(geo_en_vac._Geometry)
    #
    # Now write the tables to the MySQL database
    #

    if method == "MySQL":
        geo_en.MySQL_OpenDB(DB_host,DB_user,DB_passwd,DB_name)
        geo_en.MySQL_New_Table(Detector)
        geo_en.MySQL_Write_Geometry()

    if method == "TXT":
        geo_en.TXT_Write(Variation)



