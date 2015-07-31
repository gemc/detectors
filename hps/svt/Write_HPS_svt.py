#!/usr/bin/python
#
# Author: Holly Szumila (ODU)
# Date: June 27, 2014


# This script places the planes at the appropriate locations for the SVT.

# Notes:
#
# Geometry Notes:
# 
#
#
# Different approach from the ecal version 4:
#
# 1 Everything is in one big vacuum. This saves the vacuum box, which got rather complicated.
#
import math
#import MySQLdb
import sys

sys.path.append("..")    # Allow Python to find the Rotations.pyc and GeometryEngine.pyc in one directory up.
from Rotations import *
from GeometryEngine import Geometry, GeometryEngine, Sensitive_Detector


Standard_Table_Name="hps_svt"


#################################################################################################
#
# Global parameters. 
#
#
#################################################################################################

Strip_dX = 98.33/2 #mm

Strip_dY = 38.34/2 #mm

Strip_dZ = 0.32/2 #mm

zPos_1 = 10 #cm, Layer 1 from tgt
xPos = 6.7 #cm
yPos_1T = Strip_dY + 0.75 
yPos_1B = -yPos_1T

zPos_2 = 20 #cm, Layer 2 from tgt
yPos_2T = Strip_dY + 1.5
yPos_2B = -yPos_2T

zPos_3 = 30 #cm, Layer 3 from tgt
yPos_3T = Strip_dY + 2.25
yPos_3B = -yPos_3T

zPos_4 = 50 #cm, Layer 4 from tgt
yPos_4T = Strip_dY + 3.75
yPos_4B = -yPos_4T

zPos_5 = 70 #cm, Layer 5 from tgt
yPos_5T = Strip_dY + 5.25
yPos_5B = -yPos_5T 

zPos_6 = 90 #cm, Layer 6 from tgt
yPos_6T = Strip_dY + 6.75
yPos_6B = -yPos_6T

########################################

xPos -=8.865  #to compensate for the ps_field's displacement

###############Crystal Box encasing ECal Crystals###############################
def calculate_svt_hit_planes(g_en,mother="ps_field",origin=[0,0,0]):
    """This creates the hit planes at the correct locations for the SVT. """
    geo = Geometry( 
          name='Layer1Top',
          mother=mother,
          description='Layer 1 Top',
          pos=[xPos, yPos_1T, zPos_1],
          pos_units=['cm', 'mm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='ffbbcc',
          g4type='Box',
          dimensions=[Strip_dX, Strip_dY, Strip_dZ],
          dims_units=['mm', 'mm', 'mm'],
          material='Vacuum',
          sensitivity='flux',
          hittype='flux',
          identity='id manual 60',
          style=1,
          visible=1)
    g_en.add(geo)

    geo = Geometry( 
          name='Layer1Bottom',
          mother=mother,
          description='Layer 1 Bottom',
          pos=[xPos, yPos_1B, zPos_1],
          pos_units=['cm', 'mm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='ffbbcc',
          g4type='Box',
          dimensions=[Strip_dX, Strip_dY, Strip_dZ],
          dims_units=['mm', 'mm', 'mm'],
          material='Vacuum',
          sensitivity='flux',
          hittype='flux',
          identity='id manual 61',
          style=1,
          visible=1)
    g_en.add(geo)

    geo = Geometry( 
          name='Layer2Top',
          mother=mother,
          description='Layer 2 Top',
          pos=[xPos, yPos_2T, zPos_2],
          pos_units=['cm', 'mm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='ffbbcc',
          g4type='Box',
          dimensions=[Strip_dX, Strip_dY, Strip_dZ],
          dims_units=['mm', 'mm', 'mm'],
          material='Vacuum',
          sensitivity='flux',
          hittype='flux',
          identity='id manual 62',
          style=1,
          visible=1)
    g_en.add(geo)

    geo = Geometry( 
          name='Layer2Bottom',
          mother=mother,
          description='Layer 2 Bottom',
          pos=[xPos, yPos_2B, zPos_2],
          pos_units=['cm', 'mm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='ffbbcc',
          g4type='Box',
          dimensions=[Strip_dX, Strip_dY, Strip_dZ],
          dims_units=['mm', 'mm', 'mm'],
          material='Vacuum',
          sensitivity='flux',
          hittype='flux',
          identity='id manual 63',
          style=1,
          visible=1)
    g_en.add(geo)

    geo = Geometry( 
          name='Layer3Top',
          mother=mother,
          description='Layer 3 Top',
          pos=[xPos, yPos_3T, zPos_3],
          pos_units=['cm', 'mm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='ffbbcc',
          g4type='Box',
          dimensions=[Strip_dX, Strip_dY, Strip_dZ],
          dims_units=['mm', 'mm', 'mm'],
          material='Vacuum',
          sensitivity='flux',
          hittype='flux',
          identity='id manual 64',
          style=1,
          visible=1)
    g_en.add(geo)

    geo = Geometry( 
          name='Layer3Bottom',
          mother=mother,
          description='Layer 3 Bottom',
          pos=[xPos, yPos_3B, zPos_3],
          pos_units=['cm', 'mm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='ffbbcc',
          g4type='Box',
          dimensions=[Strip_dX, Strip_dY, Strip_dZ],
          dims_units=['mm', 'mm', 'mm'],
          material='Vacuum',
          sensitivity='flux',
          hittype='flux',
          identity='id manual 65',
          style=1,
          visible=1)
    g_en.add(geo)
     #double the width of the last 3 layers.
    geo = Geometry(
          name='Layer4Top',
          mother=mother,
          description='Layer 4 Top',
          pos=[xPos, yPos_4T, zPos_4],
          pos_units=['cm', 'mm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='ffbbcc',
          g4type='Box',
          dimensions=[Strip_dX*2, Strip_dY, Strip_dZ], #double the width of the last 3 layers.
          dims_units=['mm', 'mm', 'mm'],
          material='Vacuum',
          sensitivity='flux',
          hittype='flux',
          identity='id manual 66',
          style=1,
          visible=1)
    g_en.add(geo)

    geo = Geometry( 
          name='Layer4Bottom',
          mother=mother,
          description='Layer 4 Bottom',
          pos=[xPos, yPos_4B, zPos_4],
          pos_units=['cm', 'mm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='ffbbcc',
          g4type='Box',
          dimensions=[Strip_dX*2, Strip_dY, Strip_dZ], #double the width of the last 3 layers.
          dims_units=['mm', 'mm', 'mm'],
          material='Vacuum',
          sensitivity='flux',
          hittype='flux',
          identity='id manual 67',
          style=1,
          visible=1)
    g_en.add(geo)

    geo = Geometry( 
          name='Layer5Top',
          mother=mother,
          description='Layer 5 Top',
          pos=[xPos, yPos_5T, zPos_5],
          pos_units=['cm', 'mm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='ffbbcc',
          g4type='Box',
          dimensions=[Strip_dX*2, Strip_dY, Strip_dZ], #double the width of the last 3 layers.
          dims_units=['mm', 'mm', 'mm'],
          material='Vacuum',
          sensitivity='flux',
          hittype='flux',
          identity='id manual 68',
          style=1,
          visible=1)
    g_en.add(geo)

    geo = Geometry( 
          name='Layer5Bottom',
          mother=mother,
          description='Layer 5 Bottom',
          pos=[xPos, yPos_5B, zPos_5],
          pos_units=['cm', 'mm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='ffbbcc',
          g4type='Box',
          dimensions=[Strip_dX*2, Strip_dY, Strip_dZ], #double the width of the last 3 layers.
          dims_units=['mm', 'mm', 'mm'],
          material='Vacuum',
          sensitivity='flux',
          hittype='flux',
          identity='id manual 69',
          style=1,
          visible=1)
    g_en.add(geo)

    geo = Geometry( 
          name='Layer6Top',
          mother=mother,
          description='Layer 6 Top',
          pos=[xPos, yPos_6T, zPos_6],
          pos_units=['cm', 'mm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='ffbbcc',
          g4type='Box',
          dimensions=[Strip_dX*2, Strip_dY, Strip_dZ], #double the width of the last 3 layers.
          dims_units=['mm', 'mm', 'mm'],
          material='Vacuum',
          sensitivity='flux',
          hittype='flux',
          identity='id manual 70',
          style=1,
          visible=1,)
    g_en.add(geo)

    geo = Geometry( 
          name='Layer6Bottom',
          mother=mother,
          description='Layer 6 Bottom',
          pos=[xPos, yPos_6B, zPos_6],
          pos_units=['cm', 'mm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='ffbbcc',
          g4type='Box',
          dimensions=[Strip_dX*2, Strip_dY, Strip_dZ], #double the width of the last 3 layers.
          dims_units=['mm', 'mm', 'mm'],
          material='Vacuum',
          sensitivity='flux',
          hittype='flux',
          identity='id manual 71',
          style=1,
          visible=1,)
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

    Detector = "hps_svt"

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
 
    

    
    calculate_svt_hit_planes(geo_en)

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



