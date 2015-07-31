#!/usr/bin/python
#
# Author: Maurik Holtrop (UNH)
# Date: February 24, 2014

import sys

#if not "GeometryEngine" in sys.modules:

sys.path.append("..")    # Allow Python to find the Rotations.pyc and GeometryEngine.pyc in one directory up.
from Rotations import *
from GeometryEngine import Geometry, GeometryEngine, Sensitive_Detector

sys.path.append("../ecal") 
import Write_HPS_ecal        # Including this allow us to get some useful parameters for the depth of the ECAL box.

Standard_Table_Name="hps_beamline"
#
# Some globals for convenient unit conversion.
#
cm = 1
mm = 0.1
inch = 2.54*cm

#################################################################################################
#
# Options:
#
#################################################################################################

Field_box_visibility=0   # Make the magnetic field volume visible.
Use_Fast_Fields=0        # Use constant fields, which run faster.
Alignment_Choice=2  # Choose Beam Alignment. For Physisc alignment choose 1.

#################################################################################################
#
# Configuration Area
#
#################################################################################################
# There are two sensible choices for the X-offset of things:
# Physics Perspective:
#      The target is at (0,0,0), so EVERYTHING is shifted because the target is not at the center of anything.
#      The target is also located at the very edge of the dipole.
# 
# Beam Alignment Perspective:
#      The beam comes into the hall at x=0,y=0. The target_z is at 0.
#      In this case the target is offset from (0,0,0), since the chicane moves the beam.
#      The z-location of the target is the same in both options: z=0.

Pair_Spectrometer_displacement_from_beam = 8.865*cm   # This is how much the PS is slid over from the beam.
PSZShift = 36.00*inch /2.       # Shift for the pair spectrometer so that target is at z=0
# MagnetSep = 95.*inch            # Separation of the CENTERS of the frascati magnets, relative to the center of the pair spectrometer
# target_xpos_psfield_sys = -2.1819*cm # -2.69 # The amount by which the target is shifted from the center of the Magnet.
MagnetSep = 85.87*inch            # Separation of the CENTERS of the frascati magnets, relative to the center of the pair spectrometer
target_xpos_psfield_sys = -2.142 # The amount by which the target is shifted from the center of the Magnet.

def Set_Alignment():
    """Helper function to set the variable that depend on the alignment choice. 
    This way, the alignment can be set from the outside."""

    if Alignment_Choice == 1:
        Pair_Spectrometer_X_offset = -target_xpos_psfield_sys # 
    else:
        Pair_Spectrometer_X_offset = Pair_Spectrometer_displacement_from_beam  # The pair spectrometer sideways displacement in X. 
          
    Frascati_Magnet_X_offset = Pair_Spectrometer_X_offset - Pair_Spectrometer_displacement_from_beam  
    target_xpos_root_sys = Pair_Spectrometer_X_offset + target_xpos_psfield_sys     # Location of target in mother = 7.770

    return(Pair_Spectrometer_X_offset,Frascati_Magnet_X_offset,target_xpos_root_sys)


def calculate_dipole_geometry(g_en,mother="root",origin=[0,0,0]):
    """Calculate the main detector region with the pair spectrometer magnet.
       For normal running, this is all that you need. For alignment check, you
       would also need to load the frascati magnets.
       All volumes are located relative to the origin at the target.
    """
################### PAIR SPECTROMETER ##################################
    
    (Pair_Spectrometer_X_offset,Frascati_Magnet_X_offset,target_xpos_root_sys) = Set_Alignment()

    print "Alignment Choice = "+str(Alignment_Choice)
    print "Pair_Spectrometer_X_offset="+str(Pair_Spectrometer_X_offset)
    print "Frascati_Magnet_X_offset  ="+str(Frascati_Magnet_X_offset)
    print "target_xpos_root_sys      ="+str(target_xpos_root_sys)

    PS_Field_pos     = [origin[0]+Pair_Spectrometer_X_offset,origin[1],origin[2]]

    PS_Dipole_dim     = [82.50*inch/2., 45.75*inch/2., 36.00*inch/2.]
    PS_Dipole_gap_dim = [18.00*inch, 10.25*inch, PS_Dipole_dim[2]+0.001 ]
    PS_Dipole_pos     = [0,            # because we are inside ps_field, which has the x offset already, we do not need: +Pair_Spectrometer_X_offset
                         0,
                         PSZShift]   # Positions Target at start of magnet.

    # Field region. We want the box for the field region to have (0,0,0) correspond to the mother (0,0,0)
    # This makes it easier to place other objects (the target, the vacuum box, the SVT) inside.
    # We do this by combining two boxes into one.
    # Important Note:
    # The BOX "ps_field" will be the boundary of the field. Make the box too small and some of the field
    # map will be truncated. BUT THE POSITIONS of the field map are determined by the coordinates in the
    # FIELD MAP FILE. This his how GEMC implemented this, instead of placing the field relative to the
    # center of the container, it places is relative to the center of the HALL.
    # This has serious consequences: Move the magnet, you do not move the field!
    
    ps_total_field_length = Write_HPS_ecal.Box_Start_z*mm + Write_HPS_ecal.Box_depth*mm - PSZShift        # PS_Dipole_dim[2] + 42*inch # - 15*inch
    ps_L1 = ps_total_field_length - PS_Dipole_dim[2]  # The 1/2 length of the first box, centered at (0,0,0)
    ps_L2 = PS_Dipole_dim[2]
    PS_field_dimx = PS_Dipole_dim[0] + 10. # PS_Dipole_gap_dim[0]-0.001
    PS_field_dimy = PS_Dipole_dim[1] + 10. # PS_Dipole_gap_dim[1]-0.001
# 
#    print "Calculating field: ps_L1="+str(ps_L1)+"  ps_L2="+str(ps_L2)
#

#   enlarge the field volume to enclose the wings of the muon detector
#    PS_field_dimx *=2


    g_en.add(Geometry(
          name='aps_field',
          mother=mother,
          description='Solid Holding PS Magnet Field Map, A',
          pos=[0.0, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='00ff00',
          g4type='Box',
          dimensions=[PS_field_dimx,PS_field_dimy,ps_L1],
          dims_units=['cm', 'cm', 'cm'],
          material='Component',
          visible=1,
          style=0))
 
 #extend the field to enclose daughter volumes "muon wings"
 #extension = 40
    g_en.add(Geometry( 
          name='bps_field',
          mother=mother,
          description='Solid Holding PS Magnet Map, B',
          pos=[0.0, 0.0, ps_L1+ps_L2],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='00ff00',
          g4type='Box',
          dimensions=[PS_field_dimx,PS_field_dimy,ps_L2],
          dims_units=['cm', 'cm', 'cm'],
          material='Component',
          visible=1,
          style=0))
 
    if Alignment_Choice==1:
        magfield = "hps_pair_spectrometer_shift"
    else:
        magfield = "hps_pair_spectrometer"
        
    g_en.add(Geometry( 
          name='ps_field',
          mother=mother,
          description='Solid Holding PS Magnet Map',
          pos=PS_Field_pos,
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='00ff00',
          g4type='Operation: aps_field + bps_field',
          material='Vacuum',
          magfield=magfield,
          visible=Field_box_visibility,
          style=0))

    # Now place the MAGNET iron itself. A box with a hole in it.
    
    g_en.add(Geometry( 
          name='ps_ayoke',
          mother="ps_field",
          description='Pair Spectrometer Yoke',
          col='000088',
          g4type='Box',
          dimensions=PS_Dipole_dim,
          dims_units=['cm', 'cm', 'cm'],
          material='Component'))
# 
#
    g_en.add(Geometry( 
          name='ps_gap',
          mother="ps_field",
          description='Pair Spectrometer Magnet Gap',
          col='000088',
          g4type='Box',
          dimensions=PS_Dipole_gap_dim,
          dims_units=['cm', 'cm', 'cm'],
          material='Component'))

    g_en.add(Geometry( 
          name='ps_magnet',
          mother="ps_field",
          description='Pair Spectrometer',
          pos=PS_Dipole_pos,
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='440000',
          g4type='Operation: ps_ayoke - ps_gap',
          dimensions=[0.0],
          dims_units=['cm'],
          material='G4_Fe',
          visible=1,
          style=0))
    
         
    return

def calculate_frascati_magnets(g_en,mother="root",origin=[0,0,0],which=0):
    """Calculate the geometry for the Frascati dipole magnets that are part of the chicane.
       The volumes are placed in 'mother', with an offset 'origin'
       If you set which to 1 or 2, then only the first or second Frascati is generated. """
       
    (Pair_Spectrometer_X_offset,Frascati_Magnet_X_offset,target_xpos_root_sys) = Set_Alignment()
       
    #Frascati magnet position
    frascati_magnet1_pos = [Frascati_Magnet_X_offset,0.0, -MagnetSep+ PSZShift];
    frascati_magnet2_pos = [Frascati_Magnet_X_offset,0.0, +MagnetSep+ PSZShift];

    #Frascati magnet dimension
    frascati_magnet_dim = [35.56,35.56,30.48];

    # Frascati magnet gap dimensions    
    fm_gap_dim = [22.225,4.0,frascati_magnet_dim[2]+0.01]                 # 27.7' - 10' 

    g_en.add(Geometry( 
          name='fm_yoke',
          mother=mother,
          description='Frascati Magnet Yoke',
          col='0000ff',
          g4type='Box',
          dimensions=frascati_magnet_dim,
          dims_units=['cm', 'cm', 'cm'],
          material='Component'))
# 
#
    g_en.add(Geometry( 
          name='fm_gap',
          mother=mother,
          description='Pair Spectrometer Magnet Gap',
          col='0000ff',
          g4type='Box',
          dimensions=fm_gap_dim,
          dims_units=['cm', 'cm', 'cm'],
          material='Component'))

    if which == 0 or which == 1:
        g_en.add(Geometry( 
          name='frascati_magnet1',
          mother=mother,
          description='Frascati Magnet 1',
          pos=frascati_magnet1_pos,
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='007700',
          g4type='Operation: fm_yoke - fm_gap',
          dimensions=[0.0],
          dims_units=['cm'],
          material='G4_Fe',
          visible=1,
          style=0))

    if which == 0 or which == 2:
        g_en.add(Geometry( 
          name='frascati_magnet2',
          mother=mother,
          description='Frascati Magnet 2',
          pos=frascati_magnet2_pos,
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='007700',
          g4type='Operation: fm_yoke - fm_gap',
          dimensions=[0.0],
          dims_units=['cm'],
          material='G4_Fe',
          visible=1,
          style=0))

    # Field regions.

    id_fgap_dim =[fm_gap_dim[0]-0.01,fm_gap_dim[1]-0.01,54.61]
    id_fgap_dim2 =[20.955-0.0001,2.54-0.0001,54.61]             # Must fit inside the last vacuum box.
 
    if Alignment_Choice==1:
        magfield1 = "hps_frascati_magnet_field1_394A_shift"
        magfield2 = "hps_frascati_magnet_field2_394A_shift"
    else:
        magfield1 = "hps_frascati_magnet_field1_394A"
        magfield2 = "hps_frascati_magnet_field2_394A"
  
    if which == 0 or which ==1:  
        g_en.add(Geometry( 
          name='frascati_magnet1_field',
          mother=mother,
          description='Frascati Magnet1 Field region',
          pos=frascati_magnet1_pos,
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='00ff00',
          g4type='Box',
          dimensions=id_fgap_dim,
          dims_units=['cm', 'cm', 'cm'],
          material="Vacuum",
          magfield=magfield1,
          visible=Field_box_visibility,
          style=0))

    if which == 0 or which ==2:
        g_en.add(Geometry( 
          name='frascati_magnet2_field',
          mother=mother,
          description='Frascati Magnet2 Field region',
          pos=frascati_magnet2_pos,
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='00ff00',
          g4type='Box',
          dimensions=id_fgap_dim2,
          dims_units=['cm', 'cm', 'cm'],
          material="Vacuum",
          magfield=magfield2,
          visible=Field_box_visibility,
          style=0))    
    
    return

def calculate_ps_vacuum(g_en,mother="ps_field",origin=[0,0,0],style=0):
    """ Add the vacuum system inside the Pair Spectrometer. This will contain the SVT, but is NOT its mother volume """
 
    visible=1
 
    geo = Geometry( 
          name='vca_box',
          mother=mother,
          description='PS Vacuum Box Frame',
          pos=[0.0, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          g4type='Box',
          dimensions=[22.7076, 10.16, 60.96],
          dims_units=['cm', 'cm', 'cm'],
          material='Component'
          )

    g_en.add(geo)

    geo = Geometry( 
          name='vca_vbox',
          mother=mother,
          description='PS Vacuum box Vacuum',
          pos=[0.0, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          g4type='Box',
          dimensions=[20.8026, 8.89, 61.06],
          dims_units=['cm', 'cm', 'cm'],
          material='Component'
          )
    
    g_en.add(geo)

    geo = Geometry( 
          name='vca_trd1',
          mother=mother,
          description='PS Vacuum Trapezoid ',
          pos=[0.0, 0.0, 80.1911],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          g4type='Trd',
          dimensions=[22.7076, 22.7076, 10.16, 20.64004, 19.2311],
          dims_units=['cm', 'cm', 'cm', 'cm', 'cm'],
          material='Component'
          )
    g_en.add(geo)

    geo = Geometry( 
          name='vca_vtrd1',
          mother=mother,
          description='PS Vacuum Trapezoid Vacuum',
          pos=[0.0, 0.0, 80.1911],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          g4type='Trd',
          dimensions=[20.8026, 20.8026, 8.89, 19.37004, 19.7311],
          dims_units=['cm', 'cm', 'cm', 'cm', 'cm'],
          material='Component'
          )
    
    g_en.add(geo)

    geo = Geometry( 
          name='vca_trd2',
          mother=mother,
          description='PS Vacuum Trapezoid ',
          pos=[0.0, 0.0, 87.5587315462297],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          g4type='Trd',
          dimensions=[22.7076, 36.83, 14.174322398093, 20.64004, 11.8634684537703],
          dims_units=['cm', 'cm', 'cm', 'cm', 'cm'],
          material='Component'
          )

    g_en.add(geo)

    geo = Geometry( 
          name='vca_vtrd2',
          mother=mother,
          description='PS Vacuum Trapezoid ',
          pos=[0.0, 0.0, 87.5587315462297],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          g4type='Trd',
          dimensions=[20.8026, 34.925, 12.904322398093, 19.37004, 12.3634684537703],
          dims_units=['cm', 'cm', 'cm', 'cm', 'cm'],
          material='Component'
          )
    
    g_en.add(geo)

    geo = Geometry( 
          name='vca_flange',
          mother=mother,
          description='PS Downstream Flange Frame',
          pos=[0.0, 0.0, 98.1522],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          g4type='Box',
          dimensions=[38.4175, 22.86, 1.27],
          dims_units=['cm', 'cm', 'cm'],
          material='Component'
          )

    g_en.add(geo)

    geo = Geometry( 
          name='vcb_frame',
          mother=mother,
          description='PS Vacuum Box + Tr1 Frame',
          pos=[0.0, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          g4type='Operation: vca_box + vca_trd1',
          dimensions=[0.0],
          dims_units=['cm'],
          material='Component'
          )
    
    g_en.add(geo)

    geo = Geometry( 
          name='vcc_frame',
          mother=mother,
          description='PS Vacuum Box + Tr2 Frame',
          pos=[0.0, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          g4type='Operation: vcb_frame + vca_trd2',
          dimensions=[0.0],
          dims_units=['cm'],
          material='Component'
          )
    
    g_en.add(geo)

    geo = Geometry( 
          name='vcd_frame',
          mother=mother,
          description='PS Vacuum Box + Flange',
          pos=[0.0, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          g4type='Operation: vcc_frame + vca_flange',
          dimensions=[0.0],
          dims_units=['cm'],
          material='Component'
          )
    
    g_en.add(geo)

    geo = Geometry( 
          name='vce_frame',
          mother=mother,
          description='PS Frame - Box',
          pos=[0.0, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          g4type='Operation: vcd_frame - vca_vbox',
          dimensions=[0.0],
          dims_units=['cm'],
          material='Component'
          )
    
    g_en.add(geo)

    geo = Geometry( 
          name='vcf_frame',
          mother=mother,
          description='PS Vacuum Box+Trapezoid Frame - Box - Tr1',
          pos=[0.0, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          g4type='Operation: vce_frame - vca_vtrd1',
          dimensions=[0.0],
          dims_units=['cm'],
          material='Component'
          )

    g_en.add(geo)

    geo = Geometry( 
          name='vcg_frame',
          mother=mother,
          description='PS Vacuum Box+Trapezoid Frame - Box Tr1 - Tr2',
          pos=[0.0, 0.0, 30.48 + 1.524],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='dcdcf2',
          g4type='Operation: vcf_frame - vca_vtrd2',
          dimensions=[0.0],
          dims_units=['cm'],
          material='StainlessSteel',
          style=style,
          visible=visible)

    g_en.add(geo)

def calculate_muon_lite_vacuum(g_en,mother="root",origin=[0,0,0]):
    """Auto generated method. """

    (Pair_Spectrometer_X_offset,Frascati_Magnet_X_offset,target_xpos_root_sys) = Set_Alignment()

    loc_front_face = Write_HPS_ecal.Box_Start_z/10. + Write_HPS_ecal.Box_depth/10.
    half_depth = 68.0212 + 2
    z_pos = loc_front_face + half_depth 

    geo = Geometry( 
          name='last_vacuum_chamber_outer',
          mother=mother,
          description='Last Vacuum Box',
          pos=[0.0, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='bbbbcc',
          g4type='Box',
          dimensions=[22.0726, 3.81, 68.0212],
          dims_units=['cm', 'cm', 'cm'],
          material='Component')

    g_en.add(geo)

    geo = Geometry( 
          name='last_vacuum_chamber_inner',
          mother=mother,
          description='Last Vacuum Box',
          pos=[0.0, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='bbbbcc',
          g4type='Box',
          dimensions=[20.955, 2.54, 73.1012],
          dims_units=['cm', 'cm', 'cm'],
          material='Component')

    g_en.add(geo)

    geo = Geometry( 
          name='upstream_flange_outer',
          mother=mother,
          description='Last Vacuum Chamber Flange',
          pos=[0.0, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='bbbbcc',
          g4type='Box',
          dimensions=[27.305, 8.001, 0.9525],
          dims_units=['cm', 'cm', 'cm'],
          material='Component')

    g_en.add(geo)

    geo = Geometry( 
          name='upstream_flange_inner',
          mother=mother,
          description='Last Vacuum Chamber Flange',
          pos=[0.33274, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='bbbbcc',
          g4type='Box',
          dimensions=[17.145, 3.175, 6.0325],
          dims_units=['cm', 'cm', 'cm'],
          material='Component')

    g_en.add(geo)

    geo = Geometry( 
          name='downstream_flange',
          mother=mother,
          description='Last Vacuum Chamber downstream Flange',
          pos=[0.0, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='bbbbcc',
          g4type='Box',
          dimensions=[22.0726, 3.81, 0.635],
          dims_units=['cm', 'cm', 'cm'],
          material='Component')

    g_en.add(geo)

    geo = Geometry( 
          name='electron_tube',
          mother=mother,
          description='Hole for Electrons',
          pos=[0.0, 0.0, 3.81],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='bbbbcc',
          g4type='Tube',
          dimensions=[2.8575, 3.175, 3.81, 0.0, 360.0],
          dims_units=['cm', 'cm', 'cm', 'deg', 'deg'],
          material='Component')

    g_en.add(geo)

    geo = Geometry( 
          name='electron_hole1',
          mother=mother,
          description='Hole for Electrons',
          pos=[0.0, 0.0, 3.81],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='bbbbcc',
          g4type='Tube',
          dimensions=[0.0, 2.8575, 8.89, 0.0, 360.0],
          dims_units=['cm', 'cm', 'cm', 'deg', 'deg'],
          material='Component')

    g_en.add(geo)

    geo = Geometry( 
          name='lv_photon_tube',
          mother=mother,
          description='Hole for Photons',
          pos=[15.8242, 0.0, 3.81],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='bbbbcc',
          g4type='Tube',
          dimensions=[2.8575, 3.175, 3.81, 0.0, 360.0],
          dims_units=['cm', 'cm', 'cm', 'deg', 'deg'],
          material='Component')

    g_en.add(geo)

    geo = Geometry( 
          name='photon_hole1',
          mother=mother,
          description='Hole for Photons',
          pos=[15.8242, 0.0, 3.81],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='bbbbcc',
          g4type='Tube',
          dimensions=[0.0, 2.8575, 8.89, 0.0, 360.0],
          dims_units=['cm', 'cm', 'cm', 'deg', 'deg'],
          material='Component')

    g_en.add(geo)

    geo = Geometry( 
          name='last_vacuum_chamber_frame',
          mother=mother,
          description='Last Vacuum Box',
          pos=[0.0, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='bbbbcc',
          g4type='Operation: last_vacuum_chamber_outer - last_vacuum_chamber_inner',
          dimensions=[0.0],
          dims_units=['cm'],
          material='Component')

    g_en.add(geo)

    geo = Geometry( 
          name='upstream_flange_frame',
          mother=mother,
          description='Last Vacuum Chamber Flange',
          pos=[-3.98526, 0.0, -68.9737],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='bbbbcc',
          g4type='Operation: upstream_flange_outer - upstream_flange_inner',
          dimensions=[0.0],
          dims_units=['cm'],
          material='Component')

    g_en.add(geo)

    geo = Geometry( 
          name='dsflange_etube',
          mother=mother,
          description='last flange with electron tube',
          pos=[0.0, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='bbbbcc',
          g4type='Operation: downstream_flange + electron_tube',
          dimensions=[0.0],
          dims_units=['cm'],
          material='Component')

    g_en.add(geo)

    geo = Geometry( 
          name='dsflange_etube2',
          mother=mother,
          description='last flange with electron tube',
          pos=[0.0, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='bbbbcc',
          g4type='Operation: dsflange_etube - electron_hole1',
          dimensions=[0.0],
          dims_units=['cm'],
          material='Component')

    g_en.add(geo)

    geo = Geometry( 
          name='dsflange_tubes',
          mother=mother,
          description='last flange with both tubes',
          pos=[0.0, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='bbbbcc',
          g4type='Operation: dsflange_etube2 + lv_photon_tube',
          dimensions=[0.0],
          dims_units=['cm'],
          material='Component')

    g_en.add(geo)

    geo = Geometry( 
          name='dsflange_tubes2',
          mother=mother,
          description='last flange with both tubes',
          pos=[0.0, 0.0, 68.6562],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='bbbbcc',
          g4type='Operation: dsflange_tubes - photon_hole1',
          dimensions=[0.0],
          dims_units=['cm'],
          material='Component')

    g_en.add(geo)

    geo = Geometry( 
          name='chamber_flange',
          mother=mother,
          description='Last Chamber with flange',
          pos=[0.0, 0.0, 0.0],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='bbbbcc',
          g4type='Operation: last_vacuum_chamber_frame + upstream_flange_frame',
          dimensions=[0.0],
          dims_units=['cm'],
          material='Component')
    g_en.add(geo)

    pos=[origin[0]+Frascati_Magnet_X_offset,origin[1],origin[2] + z_pos]
#    pos=[origin[0],origin[1],origin[2] + z_pos]
    
    geo = Geometry( 
          name='last_vacuum_chamber',
          mother=mother,
          description='Last Chamber with flange and holes for e and g',
          pos=pos,
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='bbbbcc',
          g4type='Operation: chamber_flange + dsflange_tubes2',
          dimensions=[0.0],
          dims_units=['cm'],
          material='StainlessSteel',
          visible=1,
          style=1)

    g_en.add(geo)


    return()


def calculate_target_geometry(g_en,mother="ps_field",origin=[0,0,0],radlen=0.125,active=0):
    """ Place the target in the pair spectrometer.
        radlen=0.125 chooses a radiation length of 0.125% X0
        radlen=0.250 chooses a radiation length of 0.250% X0     
        Choose active=1 to put a flux detector in the target. """
    
    thickness = radlen* 0.035

    if active:
        sensitivity = "flux"
        hittype     = "flux"
        identity    = "id manual 111"
    else:
        sensitivity = "no"
        hittype     = "no"
        identity    = ""
            
    
    g_en.add(Geometry(
          name="target",
          mother=mother,
          pos=[origin[0]+target_xpos_psfield_sys,origin[1],origin[2]],
          pos_units=["cm","cm","cm"],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='ff3344',
          g4type='Tube',
          dimensions=[0,10.,thickness,0,360],
          dims_units=['mm', 'mm', 'mm','deg','deg'],
          material="G4_W",
          visible=1,
          style=1,
          sensitivity=sensitivity,
          hittype=hittype,
          identity=identity
          ))
                       
    return


def calculate_alignment_targets(g_en,mother="root",origin=[0,0,0]):
    """Add some targets along the beamline to see if the path of the beam is where we want it to be."""

    # Beam Alignment Tube 1 at 10 m
    (Pair_Spectrometer_X_offset,Frascati_Magnet_X_offset,target_xpos_root_sys) = Set_Alignment()
    
    g_en.add(Geometry( 
          name='alignement_tube1',
          mother=mother,
          description='Beam alignment tube 1, at 10m',
          pos=[Frascati_Magnet_X_offset,0,1000.],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='005500',
          g4type='Tube',
          dimensions=[0,2,10,0,360],
          dims_units=['cm', 'cm', 'cm','deg','deg'],
          material="Vacuum",
          visible=1,
          style=1,
          sensitivity="flux",
          hittype="flux",
          identity="id manual 101"
          ))
    
    g_en.add(Geometry( 
          name='alignement_tube2',
          mother=mother,
          description='Beam alignment tube 2, at 20m',
          pos=[Frascati_Magnet_X_offset,0,1900.],
          pos_units=['cm', 'cm', 'cm'],
          rot=[0.0, 0.0, 0.0],
          rot_units=['deg', 'deg', 'deg'],
          col='005500',
          g4type='Tube',
          dimensions=[0,2,10,0,360],
          dims_units=['cm', 'cm', 'cm','deg','deg'],
          material="Vacuum",
          visible=1,
          style=1,
          sensitivity="flux",
          hittype="flux",
          identity="id manual 102"
          ))
    
    return

#################################################################################################

if __name__ == "__main__":
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

    Detector = "hps_beamline"
    Variation= "original"        # This variation has the fully mapped B-fields.
    
    print "Recreating tables for "+Detector

    method="TXT"
    if sys.argv[0] == "TXT":
        print "TXT Engine"
    elif sys.argv[0] == "MySQL":
        print "MySQL Engine"
        method = "MySQL"
                
    geo_en = GeometryEngine(Detector)
 
    calculate_dipole_geometry(geo_en,mother="root")
    calculate_frascati_magnets(geo_en)
    calculate_alignment_targets(geo_en)

    print "geo_en     length = ",len(geo_en._Geometry)
#    print "geo_en_vac length = ",len(geo_en_vac._Geometry)
    #
    # Now write the tables to the MySQL database
    #

    if method == "MySQL":
        geo_en.MySQL_OpenDB(DB_host,DB_user,DB_passwd,DB_name)
        geo_en.MySQL_New_Table(Detector)

#        geo_en_vac.set_database(geo_en.get_database() ) # Same database handle
#        geo_en_vac.MySQL_New_Table(Detector_Vac)

        geo_en.MySQL_Write_Geometry()
#        geo_en_vac.MySQL_Write_Geometry()

    if method == "TXT":
        geo_en.TXT_Write(Variation)
#        geo_en_vac.TXT_Write("original")


