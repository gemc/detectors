#!/usr/bin/python
#
# Author: Maurik Holtrop (UNH)  November, 2012
# Update: Maurik Holtrop (UNH)  March, 2013    -- Use GeometryEngine
#

import math
import copy
import sys
sys.path.append("..")  # Add the directory one up to the search path.
from Rotations import Rotation,Vector
from GeometryEngine import GeometryEngine, Geometry, Sensitive_Detector

# Version of the muon detector with segmented hodoscopes.
# These are the variables you should adjust to your liking (all in cm or radians):
# (and don't forget to put a . in floating pt vars!!)
# Please also look at the diagram that goes with these

Standard_Table_Name="hps_muon"


def create_muon_sensitive_detector():
    ########################################################
    #
    # Setup the sensitive detectors for the Muon Detector.
    #
    # The details of these parameters will need updating when realistic detector descriptions are available.
    #
    ########################################################
    
    muon_sens = Sensitive_Detector(name="muon_hodo",
                                   description="Muon Hodoscopes",
                                   identifiers="idh idv idz",
                                   signalThreshold="1*MeV",
                                   timeWindow="80*ns",
                                   prodThreshold="1000*eV",
                                   maxStep="1*mm",
                                   riseTime="1*ns",
                                   fallTime="1*ns",
                                   mvToMeV="1",
                                   pedestal="0",
                                   delay="0*ns",
                                   bankId=700)
    
    muon_sens.add_bank_row("idh", "Index of paddle in horizontal direction", 1, "Di")
    muon_sens.add_bank_row("idv", "Index of paddle in vertical direction",   2, "Di")
    muon_sens.add_bank_row("idz", "Index of paddle in z-direction, along beam", 3, "Di")
    muon_sens.add_bank_row("adcl", "ADC value 'left' side", 4, "Di")
    muon_sens.add_bank_row("adcr", "ADC value 'right' side", 5, "Di")
    muon_sens.add_bank_row("tdcl", "TDC value 'left' side", 6, "Di")
    muon_sens.add_bank_row("tdcr", "TDC value 'right' side", 7, "Di")
    muon_sens.add_bank_row("hitn","Hit number", 99, "Di")
    
    return(muon_sens)

vacuumHeight = 7.62
height = 25.  #previously 25 cm
width = 117.  #previously 80 cm
xoffset = 9.
scintdepth = 3.
scintwidth = 4.5


connectorXStart = 23.
connectorWidth = width/2+xoffset-connectorXStart
connectorXStartL = -22.1
connectorWidthL = connectorXStartL-(xoffset-width/2)

#leftGap=1.
#leftPlateThickness = 1.


def calculate_muon_scints(g_en, mother, origin, z, i):
    scintwidth = 4.5
    for j in range(0, (int)(width/scintwidth)):
        ist = repr(i)
        jst = repr(j)
        x = xoffset-width/2+scintwidth*(.5+j)
        y = vacuumHeight/2+height/2
        h = height
        if x-scintdepth/2>=connectorXStart:
            y -=vacuumHeight*.25
            h += vacuumHeight*.5
        #else if x+scintdepth/2 <= connectorXStartL
        #    y -=(leftGap+2*leftPlateThickness)*.25
        #    h +=
        if j%2 == 0 :
            color = "FF0000"
        else :
            color = "FF8000"
        geom = Geometry(name="MD_upper" + ist + "_" + jst,
                        mother=mother,
                        description="upper muon detector" + ist + " " + jst,
                        pos=[x, y, z],
                        pos_units="cm",
                        rot=[0., 0,0.],
                        rot_units="rad",
                        col=color,
                        g4type="Box",
                        dimensions=[scintwidth/2,h/2, scintdepth/2],
                        dims_units="cm",
                        
                        material="ScintillatorB",
                        sensitivity="muon_hodo",
                        hittype="muon_hodo",
                        style = 1,
                        identity="idh manual " + jst + " idv manual 1 idz manual " + ist
                        )
        g_en.add(geom)
        if j%2 == 1:
            color = "FF0000"
        else:
            color = "FF8000"
        geom = Geometry(name="MD_lower" + ist + "_" + jst,
                        mother=mother,
                        description="lower muon detector" + ist + " " + jst,
                        pos=[x, -y, z],
                        pos_units="cm",
                        rot=[0., 0,0.],
                        rot_units="rad",
                        col=color,
                        g4type="Box",
                        dimensions=[scintwidth/2,h/2, scintdepth/2],
                        dims_units="cm",
                        material="ScintillatorB",
                        sensitivity="muon_hodo",
                        hittype="muon_hodo",
                        style = 1,
                        identity="idh manual " + jst + " idv manual -1 idz manual " + ist
                )
        g_en.add(geom)





def calculate_muon_geometry(g_en, mother="root",origin = [0,0,0]):
    g_en.add_sensitivity(create_muon_sensitive_detector())
    z0 = 180
    
    
    
    absorberDepth = [20., 10., 10., 0]
    
    z = z0
    
    absorberMat = "Iron"
    
    
    #note: in next version put a hole in the muon detector from -22 to -30 in x and -5 to 5 in y.  This is because of high background in that region for 2.2 GeV runs.
    #The hole may need to be enlarged if the high background region is in a different location for 4.4 GeV runs.  
    imax = 3
    for i in range(0,imax):
        ist = repr(i)
        print ist
        ##now add the absorbers
        z += absorberDepth[i]/2.
        geom = Geometry(name="MD_upper iron" + ist,
                        mother=mother,
                        description="upper muon detector iron" + ist,
                        pos=[xoffset, vacuumHeight/2+height/2, z],
                        pos_units="cm",
                        rot=[0., 0,0.],
                        rot_units="rad",
                        col="888888",
                        g4type="Box",
                        dimensions=[width/2,height/2, absorberDepth[i]/2],
                        dims_units="cm",
                        
                        material=absorberMat,
                        style = 0,
        )
        g_en.add(geom)
        geom = Geometry(name="MD_lower iron" + ist,
                        mother=mother,
                        description="lower muon detector iron" + ist,
                        pos=[xoffset, -vacuumHeight/2-height/2,  z],
                        pos_units="cm",
                        rot=[0., 0,0.],
                        rot_units="rad",
                        col="888888",
                        g4type="Box",
                        dimensions=[width/2,height/2, absorberDepth[i]/2],
                        dims_units="cm",
                        
                        material=absorberMat,
                        style = 0,
        )
        g_en.add(geom)
        geom = Geometry(name="MD_connector iron" + ist,
                        mother=mother,
                        description="connector muon detector iron" + ist,
                        pos=[xoffset+width/2-connectorWidth/2, 0, z],
                        pos_units="cm",
                        rot=[0., 0,0.],
                        rot_units="rad",
                        col="888888",
                        g4type="Box",
                        dimensions=[connectorWidth/2,vacuumHeight/2,  absorberDepth[i]/2],
                        dims_units="cm",
                        
                        material=absorberMat,
                        style = 0,
                        )
        g_en.add(geom)
        """geom = Geometry(name="MD_connector_L iron" + ist,
                        mother=mother,
                        description="connector muon detector iron left" + ist,
                        pos=[xoffset-width/2+connectorWidthL/2, 0, z],
                        pos_units="cm",
                        rot=[0., 0,0.],
                        rot_units="rad",
                        col="888888",
                        g4type="Box",
                        dimensions=[connectorWidthL/2,vacuumHeight/2,  absorberDepth[i]/2],
                        dims_units="cm",
                        
                        material=absorberMat,
                        style = 0,
        )
        g_en.add(geom)"""
        #now add scintillator
        z += (scintdepth+absorberDepth[i])/2.
        print z
        
        calculate_muon_scints(g_en, mother, origin, z, i)
        z+=scintdepth/2
    dz = z+scintdepth/2-z0
    z = z-dz/2
    
    #The "full" left absorber configuration:  A simple block covers the entire length
    """
    geom = Geometry(name="MD_connector_L iron",
                    mother=mother,
                    description="connector muon detector iron left",
                    pos=[xoffset-width/2+connectorWidthL/2, 0, z],
                    pos_units="cm",
                    rot=[0., 0,0.],
                    rot_units="rad",
                    col="888888",
                    g4type="Box",
                    dimensions=[connectorWidthL/2,vacuumHeight/2,  dz/2],
                    dims_units="cm",
                    
                    material=absorberMat,
                    style = 0,
                    )
    g_en.add(geom)
    """
    shieldheight = 2.
    shieldextension = 4.
    geom = Geometry(name="MD_connector_L_iron_upper",
            mother=mother,
            description="muon detector iron left_upper",
            pos=[xoffset-width/2+connectorWidthL/2, vacuumHeight/2-shieldheight/2, z+shieldextension/2],
            pos_units="cm",
            rot=[0., 0,0.],
            rot_units="rad",
            col="888888",
            g4type="Box",
            dimensions=[connectorWidthL/2, shieldheight/2,  dz/2 + shieldextension/2],
            dims_units="cm",
            material=absorberMat,
            style = 0,
    )
    g_en.add(geom)
    geom = Geometry(name="MD_connector_L_iron_lower",
            mother=mother,
            description="muon detector iron left_lower",
            pos=[xoffset-width/2+connectorWidthL/2, -vacuumHeight/2+shieldheight/2, z+shieldextension/2],
            pos_units="cm",
            rot=[0., 0,0.],
            rot_units="rad",
            col="888888",
            g4type="Box",
            dimensions=[connectorWidthL/2, shieldheight/2,  dz/2 + shieldextension/2],
            dims_units="cm",
            material=absorberMat,
            style = 0,
    )
    g_en.add(geom)
    """geom = Geometry(name="MD_vacuum_flux_plane",
                    mother=mother,
                    description="flux monitor for the electrons going through left wall",
                    pos=[20, 0, z],
                    pos_units="cm",
                    rot=[0., 0,0.],
                    rot_units="rad",
                    col="888888",
                    g4type="Box",
                    dimensions=[connectorWidthL/2, shieldheight/2,  dz/2],
                    dims_units="cm",
                    material=absorberMat,
                    style = 0,
    )"""


def calculate_muon_infinite_plane(g_en, mother, origin):
    geom = Geometry(name="MD_infinite_plane",
                mother=mother,
                description="muon detector infinite plane",
                pos=[0, 0, 200],
                pos_units="cm",
                rot=[0., 0,0.],
                rot_units="rad",
                col="888888",
                g4type="Box",
                dimensions=[200, 200,  .5],
                dims_units="cm",
                material='Vacuum',
                style = 0,
                sensitivity='flux',
                hittype='flux',
                identity='id manual 111',

                )
    g_en.add(geom)



def calculate_muon_side_test_geometry(g_en,mother="root",origin=[0,0,0]):
    
    #calculate_muon_infinite_plane(g_en, mother, origin)
    #return
    calculate_muon_geometry(g_en, mother, origin)
    return
    #the anchor is near the corner of the ecal, where the "wings" of the muon detector come closest to the beamline
    anchorX = 25
    anchorZ = 200
    offsetX = -10
    #depth of the wing (in the outward direction)
    wingDepth = 100
    #height of the wing (in the y direction)
    wingHeight = 60
    wingExtentX = 70
    
    wingTilt = radians(20)
    wingLength = (wingExtentX-anchorX)/cos(wingTilt)
    absorberDepth = 15
    absorberZ = 1
    
    x0 = anchorX+wingLength/2.*cos(wingTilt)+wingDepth/2.*sin(wingTilt)
    z0 = anchorZ-wingLength/2.*sin(wingTilt)+wingDepth/2.*cos(wingTilt)
        
    wingR = Geometry(name="MD_R",
                         mother=mother,
                         description="mother volume of right wing of muon detector",
                         pos=[x0+offsetX, 0, z0],
                         pos_units="cm",
                         rot=[0.,-wingTilt,0.],
                         rot_units="rad",
                         col="008899",
                         g4type="Box",
                         dimensions=[wingLength/2,wingHeight/2, wingDepth/2],
                         dims_units="cm",
                         material="Vacuum",
                         style = 0
                         )
    wingL = copy.deepcopy(wingR)
    wingL.name = "MD_L"
    wingL.rot[1] = -wingR.rot[1]
    wingL.pos[0] = -wingL.pos[0]+2*offsetX
    
    g_en.add(wingR)
    g_en.add(wingL)
    
    z = -wingDepth/2.
    
    
    rightGeometry = []
    scintdepth = 1
    
    flux0=Geometry(
                       name="MD_R_flux_test",
                       mother="MD_R",
                       description="Left side flux muon detector ",
                       pos=[0, 0, z+scintdepth/2.],
                       pos_units="cm",
                       rot=[0.,0, 0],
                       rot_units="deg",
                       col="FF0000",
                       g4type="Box",
                       dimensions=[wingLength/2., wingHeight/2., scintdepth/2.],
                       dims_units="cm",
                       material="ScintillatorB",
                       sensitivity="flux",
                       hittype="flux",
                       style = 0,
                       identity="id manual 777"
                       )
    
    z+= scintdepth
    
    
    g_en.add(flux0)
    rightGeometry.append(flux0)
    
    nLayers = 4;
    
    for i in range(nLayers):
        
        ist = repr(i) 
        absorberR = geom1=Geometry(
                                       name="MD_R_absorber" + ist,
                                       mother="MD_R",
                                       description="Right side muon detector absorber" + ist,
                                       pos=[0, 0, z+absorberDepth/2],
                                       pos_units="cm",
                                       rot=[0.,0, 0],
                                       rot_units="deg",
                                       col="888899",
                                       g4type="Box",
                                       dimensions=[wingLength/2., wingHeight/2., absorberDepth/2.],
                                       dims_units="cm",
                                       material="Iron",
                                       style = 0,
                                       )
        
        rightGeometry.append(absorberR)
        g_en.add(absorberR)
        
        z+= absorberDepth
        
        flux0=Geometry(
                        name="MD_R_flux_test" + ist,
                        mother="MD_R",
                        description="Left side flux muon detector " + ist,
                        pos=[0, 0, z+scintdepth/2.],
                        pos_units="cm",
                       rot=[0.,0, 0],
                       rot_units="deg",
                       col="FF0000",
                       g4type="Box",
                       dimensions=[wingLength/2., wingHeight/2., scintdepth/2.],
                       dims_units="cm",
                       material="ScintillatorB",
                       sensitivity="flux",
                       hittype="flux",
                       style = 0,
                identity="id manual 70" + ist
            )
            
        g_en.add(flux0)
        rightGeometry.append(flux0)
        z+=scintdepth
    
    for r in rightGeometry:
        l = copy.deepcopy(r)
        l.name = r.name.replace("R", "L")
        l.mother = r.mother.replace("R", "L")
        l.description = r.description.replace("Right", "Left")
        l.pos[0]      = -r.pos[0]           # flip x-position
        l.rot[1]      = -r.rot[1]           # flip rotation
        l.identity    = r.identity.replace(" 7", " -7")
        g_en.add(l)
    
    
    return(g_en)







if __name__ == "__main__":
    ################################################################################################################################
    import sys
    
    
    DB_host="localhost"
    DB_user="clasuser"
    DB_passwd=""
    DB_name = "hps_2014"
    
    Detector      = "hps_muon"          #name of the detector (table)
    
    
    print "Recreating tables for "+Detector
    
    method="TXT"
    if sys.argv[0] == "TXT":
        print "TXT Engine"
    elif sys.argv[0] == "MySQL":
        print "MySQL Engine"
        method = "MySQL"
    
    geo_en = GeometryEngine(Detector)
    
    geo_en = calculate_muon_geometry(geo_en)
    geo_en = calculate_muon_vacuum_box(geo_en)
    
    print "geo_en     length = ",len(geo_en._Geometry)
    #
    # Now write the tables to the MySQL database
    #
    
    if method == "MySQL":
        geo_en.MySQL_OpenDB(DB_host,DB_user,DB_passwd,DB_name)
        geo_en.MySQL_New_Table(Detector)
        
        geo_en.MySQL_Write_Geometry()
    
    if method == "TXT":
        geo_en.TXT_Write("original")

