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

######################################
#
# Detector location overall
#
######################################

front_face_to_target = 177.           # Distance of front face of muon detector to the target.
dead_zone_angle = 0.015                 # 15 mrad dead zone.

#######################################
#
# Absorbers
#
#######################################

# abs_thickness=    [5.  for i in range(15) ]  # list of depths of the iron absorbers in cm (these are not half-depths)

# abs_total_width=  [109. for i in range(6) ]  # Widths of absorbers.
# abs_total_width+= [123. for i in range( 3) ]
# abs_total_width+= [136. for i in range( 3) ]
# abs_total_width+= [150. for i in range( 3) ]

# abs_total_height= [11.  for i in range(6) ]  # Height of absorbers.
# abs_total_height+=[12.  for i in range( 3) ]
# abs_total_height+=[13.  for i in range( 3) ]
# abs_total_height+=[14.  for i in range( 3) ]

abs_thickness=    [ 30., 15. , 15. , 15. ]  # list of depths of the iron absorbers in cm (these are not half-depths)
#
abs_total_width=  [109. for i in range(1) ]  # Widths of absorbers.
abs_total_width+= [123. for i in range(1) ]
abs_total_width+= [136. for i in range(1) ]
abs_total_width+= [150. for i in range(1) ]
#
abs_total_height= [11.  for i in range(1) ]  # Height of absorbers.
abs_total_height+=[12.  for i in range(1) ]
abs_total_height+=[13.  for i in range(1) ]
abs_total_height+=[14.  for i in range(1) ]


######################################
#
#  Hodoscopes
#
######################################
#
# Each layer has two planes of hodoscopes. One in the horizontal, one in the vertical
#
#
# hd_total_width =[108.  for i in range(6)]   # Horizontal width of layer
# hd_total_width+=[122.  for i in range(3)]
# hd_total_width+=[135.  for i in range(3)]
# hd_total_width+=[148.5 for i in range(3)]

# hd_total_height= [10.5 for i in range(6)]
# hd_total_height+=[11.5 for i in range(3)]
# hd_total_height+=[12.5 for i in range(3)]
# hd_total_height+=[13.5 for i in range(3)]    # Vertical height of layer
#
hd_total_width =[108.  for i in range(1)]   # Horizontal width of layer
hd_total_width+=[122.  for i in range(1)]
hd_total_width+=[135.  for i in range(1)]
hd_total_width+=[148.5 for i in range(1)]
#
hd_total_height= [10.5 for i in range(1)]
hd_total_height+=[11.5 for i in range(1)]
hd_total_height+=[12.5 for i in range(1)]
hd_total_height+=[13.5 for i in range(1)]    # Vertical height of layer
#

hd_thickness=1.                            # Thickness of all layers.
hd_spacing_z = 0.1                         # Spacing in the z direction between hodoscopes
hd_spacing_y = 0.01                        # Spacing in the y direction between hodoscopes
hd_spacing_x = 0.01                        # Spacing in the x direction between hodoscopes

hd_spacing_z_outer = 1.0                    # Spacing beteen hodoscopes and absorbers.

#
# The following sets up arrays with the distribution of the paddles.
#
# hd_horizontal_heights= [ [3.5,3.5,3.5] for i in range(6) ]
# hd_horizontal_heights+=[ [3.5,3.5,4.5] for i in range(3) ]
# hd_horizontal_heights+=[ [3.5,4.5,4.5] for i in range(3) ]
# hd_horizontal_heights+=[ [4.5,4.5,4.5] for i in range(3) ]
#
hd_horizontal_heights= [ [3.5,3.5,3.5] for i in range(1) ]
hd_horizontal_heights+=[ [3.5,3.5,4.5] for i in range(1) ]
hd_horizontal_heights+=[ [3.5,4.5,4.5] for i in range(1) ]
hd_horizontal_heights+=[ [4.5,4.5,4.5] for i in range(1) ]

#######################################
#
# Absorbers, derived quantities
#
#######################################

abs_angle_vertical_top = math.atan((front_face_to_target*math.tan(dead_zone_angle)+hd_total_height[0])/front_face_to_target )
# Angle of the top face of the absorbers.
abs_angle_vertical_bot = dead_zone_angle          # Angle of the bottom face of the absorbers.

abs_angle_horizontal  = math.atan( (abs_total_width[0]/2.)/ front_face_to_target )

abs_gap = 2*hd_thickness + 2*hd_spacing_z_outer + hd_spacing_z

abs_total_depth = sum(abs_thickness) + len(abs_thickness)*abs_gap

#print "abs_angle_vertical_top = ",abs_angle_vertical_top
#print "abs_angle_horizontal   = ",abs_angle_horizontal

#########################################
#
# Parameters for the Muon Mother Volume
#
##########################################
vacuum_plate_depth = sum(abs_thickness) + len(abs_thickness)*abs_gap
#print "vacuum_plate_depth = ",vacuum_plate_depth

muon_box_depth= vacuum_plate_depth + 0.1
muon_box_dims = [ (max(abs_total_width) + 1. + muon_box_depth*math.tan(abs_angle_horizontal))/2. ,  # Size of mother volume in x
                 (front_face_to_target+muon_box_depth)*math.tan(abs_angle_vertical_top) + max(abs_total_height),
                  muon_box_depth/2. ]
muon_box_center = [13.0571,  # cm offset to center the MD on the photon line.
                   0.,
                   front_face_to_target + muon_box_depth /2.]

######################################
#
# Bump up region.
#
######################################
# Looking down stream, so "left" is +x, positron side, front is small z.
#
# The bump shape is a trapezoid.
#
#  ()*0.1 = left edge of ECAL photon tube.
# + 8.8485= Shift of ps_mother volume.
# -13.0571= Shift to center MD on photon line.
# +2.     = Account for width of block and 1cm extra space.

Bump_left_front  = (17.92591721 + 225*math.tan(math.radians(1.747521)) + 13.)*0.1 + 8.8485 - 13.0571 + 2. # +5.779   # Matches left edge of vacuum system.
Bump_right_front = -25.
Bump_left_angle  = math.radians(1.747521)
Bump_left_back   = Bump_left_front + (vacuum_plate_depth)*math.tan(Bump_left_angle)
Bump_right_back  = -40.
Bump_right_angle = math.atan2(Bump_right_back- Bump_right_front, vacuum_plate_depth)
Bump_height      =  3.5    # = Thickness of first layer of scintillator.

#print "Bump_left_front = ", Bump_left_front
#print "Bump_right_front= ", Bump_right_front
#print "Bump_left_angle = ", Bump_left_angle
#print "Bump_left_back  = ", Bump_left_back
#print "Bump_right_back = ", Bump_right_back
#print "Bump_right_angle= ", Bump_right_angle
#print "Bump_height     = ", Bump_height

abs_notch_thick=[ Bump_height for i in range(len(abs_thickness))]  # The thicknes of the notch to cut out of the iron so we can fit the vacuum inside.

###################################################################
#
# Horizontal distribution of the paddles.
#
###################################################################
# not uniform per vertical row, so needs to be z,y,x array: [z][y][x]
#
# NOTE: A negative width indicates a GAP, i.e. no scintillator there.
#       Note that the build direction is from -x to +x, so from the electron side to the positron side.
#       So that is from RIGHT to LEFT, when looking down the beam pipe!

w=[ hd_total_width[i]/2 for i in range(len(hd_total_width))]    # Abbreviation for the table.

hd_horizontal_widths=[]
hd_horizontal_index=[]

local_z = 0
Bump_left=[]                  # Store the left and right bump x locations for later use.
Bump_left_vert=[]             # Vertical hodoscopes are a little further back, so bump width is different!
Bump_right=[]
Bump_right_vert=[]
hodo_z_location_local=[]      # Store the z locations for positioning the FLUX detectors.

third_paddle_width=12.
third_paddle_start=0.   # This must be 0 < start < width, else the divide will not fall on photon line.
                        # It could be set to Bump_left[i] (below in the loop) to coincide with the bump boundary.
for i in range(len(hd_total_width)):
    local_z += abs_thickness[i] + hd_spacing_z + hd_thickness/2.
#    print "Hodo local z location [",i,"] = ",local_z, " global = ",front_face_to_target +local_z
    hodo_z_location_local.append(local_z)
    Bump_left.append( Bump_left_front +(local_z + hd_thickness/2.) * math.tan(Bump_left_angle))
    Bump_right.append(Bump_right_front+(local_z + hd_thickness/2.) * math.tan(Bump_right_angle))
    Bump_left_vert.append( Bump_left_front +(local_z + hd_spacing_z + 3*hd_thickness/2.) * math.tan(Bump_left_angle))
    Bump_right_vert.append(Bump_right_front+(local_z + hd_spacing_z + 3*hd_thickness/2.) * math.tan(Bump_right_angle))
    hd_horizontal_widths+=[[
                       [w[i]+Bump_right[i], -(Bump_left[i] -Bump_right[i]),w[i]-Bump_left[i]],
                       [w[i]+ third_paddle_start -third_paddle_width, +third_paddle_width,w[i]-third_paddle_start],
#                       [w[i]+Bump_right[i], +(Bump_left[i] -Bump_right[i]),w[i]-Bump_left[i]],
#                       [w[i],w[i]],
                       [w[i],w[i]]
                       ]]
#    print "Bump_left - Bump_right =",(Bump_left[i] -Bump_right[i])
    iz=2*i
    hd_horizontal_index+=[[                # tuples (ix,iy,iz)
            [(-1,1,iz),(0,1,iz),(1,1,iz)],
            [(-1,2,iz),(0,2,iz), (1,2,iz)],
            [(-1,3,iz),(1,3,iz)]
            ]]
    local_z += 3*hd_thickness/2. + 2*hd_spacing_z

#
# Without a bump-up, this will be a simple fit, no cut hodoscopes:
#
# N=[ int(hd_total_width[i]/4.5 +0.99) for i in range(len(hd_total_width))]  # Fill N with the number of 4.5 wide paddles.
# hd_vert_widths=[
#                [4.5 for x in range(N[y])] for y in range(len(hd_total_width)) # Distribute the paddles in an array
#                ]
#
#hd_vert_heights=[
#                 [hd_total_height[y]] for y in range(len(hd_total_height))  # Distribute the paddles in an array
#                 ]
#
# With bump up:
#
# The distribution of the vertical hodoscopes is complicated by the "bump up" region. We need a boundary of the hodoscopes
# to coincide with the bumpup region. At the same time, we have a minimal hodoscope width of 2.25 cm, (1/2 the width of a standard one.)
#
# We are filling the hodoscope array right (-x) to left (+x).
# Right edge to Bump_right[i] is (Bump_right[i] - hd_total_width[i]/2) wide.
#
def Calculate_vertical_paddle_widths(Segment_width,i,side=0):

    Min_Paddle_Width = 3.5
    N_seg = int(Segment_width/(4.5 + hd_spacing_x)+ 0.99999)  # Rounded up number.
    Len_extra = N_seg*(4.5 + hd_spacing_x) - hd_spacing_x/2. - Segment_width
    if Len_extra < 0. or Len_extra > 4.5:
        print "ERROR --- Not calculating the paddle widths correctly. Layer ",i," has Len_extra = ",Len_extra, " N_seg = ",N_seg," Width = ",Segment_width

#    print "Len_extra = ",Len_extra,

    N_split_paddles     = int( Len_extra/(4.5 - Min_Paddle_Width) + 0.99999 )
    if N_split_paddles == 0:
        Width_split_paddles = 4.5
    else:
        Width_split_paddles = 4.5 - Len_extra/N_split_paddles

#    print " N_split_paddles = ",N_split_paddles,"  Width_split_paddles = ",Width_split_paddles

    if N_split_paddles > N_seg:
        print "ERROR -- Cannot fit the space with paddles of width > ",Min_Paddle_Width,"  Segment_width = ",Segment_width," N_seg=",N_seg," N_split_paddles = ",N_split_paddles,"  Width_split_paddles= ",Width_split_paddles
        exit


    tmp_row = []
    for j in range(N_seg):
        this_width = 4.5
        if side == -1 and j > N_seg - N_split_paddles -1:          # Split paddles on large x side
            this_width = Width_split_paddles
        if side == 0 and ( j < int(N_split_paddles/2+0.99999999) or j > N_seg - int(N_split_paddles/2) -1 ): # divide between both sides if N=2
            this_width = Width_split_paddles
        if side == 1 and j < N_split_paddles:                      # Split paddles on small x side
            this_width = Width_split_paddles

        tmp_row.append(this_width)

    sum_width_total=0
    for i in range(len(tmp_row)):
        sum_width_total += tmp_row[i]
        if(i < len(tmp_row)-1):
            sum_width_total += hd_spacing_x;

#    print "Segment width= ",str(Segment_width),"  N_seg=",N_seg,"   Sum width=",str(sum(tmp_row))," Sum width total",str(sum_width_total)
#    print "N_split_paddles=",str(N_split_paddles),"  ", tmp_row
#    print ""
    return(tmp_row)


hd_vert_widths=[]
hd_vert_heights=[]
hd_vert_index=[]

for i in range(len(hd_total_width)):
    Right_segment_width  = (Bump_right_vert[i] + hd_total_width[i]/2.)
    Center_segment_width = (Bump_left_vert[i] - Bump_right_vert[i] )
    Left_segment_width   = (hd_total_width[i]/2. - Bump_left_vert[i])

    Right = Calculate_vertical_paddle_widths(Right_segment_width,i,-1)
    Center= Calculate_vertical_paddle_widths(Center_segment_width,i,0)
    Left  = Calculate_vertical_paddle_widths(Left_segment_width,i,1)

    hd_vert_widths.append(Right + Center + Left)     # Store one row of the concatenated lists.
    hd_vert_heights.append( [ hd_total_height[i] ] ) # All are the same height. The bump is adjusting the height during placement.

#
# Here we calculate which paddle should have the 0 index. This should be the paddle in which x=0 occurs. It is between Bump_left and Bump_right
# so it falls in the center section, and will be on the Bump_left (positron, +x) side. We thus count how many paddles fit between Bump_left
# and x=0. This is expected to be in the 0 to 1 range

    N_Left=0
    Left_center_width=0
    for l in reversed(Center):   # itterate from the left, i.e. high x.
        Left_center_width += l
#        print "Left_center_width = ",Left_center_width," N_Left=",N_Left
        if Left_center_width < abs(Bump_left[i]):
            N_Left += 1
        else:
            break

#    print "For width ",Bump_left[i]," we have N_Right=",N_Left," Center[0]=",Center[len(Center)-1]," Center[1]=",Center[len(Center)-2]

    N_Right = len(Right) + len(Center) - N_Left
    N_Left += len(Left)

#  X Indexes are thus from -N_Right to 0 to N_Left
    iz = 2*i+1
    hd_vert_index.append( [ [(-N_Right + j,1, iz) for j in range(N_Right+N_Left +1) ] ] )  # note that y is only one layer!
#    print "Indexes: ",hd_vert_index[i]

#
# Right hand (-x) batch of vertical paddles:
#


# This will fit

###################################################################
#
# Extra Parameters for the Vacuum Box.
#
###################################################################
# Parameters estimated from the end of the ECAL vacuum box.
#

x_offset_wrt_MD  = 0      # 8.8485-13.0571        # Puts this back after moving MD by 130.571.
y_spacing_plates = 1.  # Gap between the vacuum plate and the Iron absorbers.
x_spacing_plates = 0.01

support_block_width = 1.
plate_thickness     = 0.5

plate1_left_edge_front  = Bump_left_front - x_spacing_plates   #+ left_extension # 33.4364 # + support_block_width
plate1_left_edge_rear   = Bump_left_back  - x_spacing_plates  #+ left_extension # + support_block_width
plate1_right_edge_front = Bump_right_front + x_spacing_plates  # + support_block_width
plate1_right_edge_rear  = Bump_right_back  + x_spacing_plates # -406.6155 # + support_block_width

plate2_left_edge_front  = plate1_right_edge_front + support_block_width
plate2_left_edge_rear   = plate1_right_edge_rear  + support_block_width

plate2_right_edge_front = -35.129 - 10.0 # + support_block_width
plate2_right_edge_rear  = -75.0   - 5.0 # -406.6155 # + support_block_width


############################################
#
# Calculate the parameters for the support blocks
#
###########################################

block_left_front = plate1_left_edge_front - support_block_width/2.
block_left_rear  = plate1_left_edge_rear  - support_block_width/2.
block_left_center = (block_left_front + block_left_rear)/2.
block_left_skew  = math.atan2( (block_left_rear - block_left_front),vacuum_plate_depth)

block_left_front_dy  = (2*(front_face_to_target*math.tan(dead_zone_angle)
                           + Bump_height - plate_thickness - y_spacing_plates) )
block_left_rear_dy   = (2*((front_face_to_target+ vacuum_plate_depth )*math.tan(dead_zone_angle)
                           + Bump_height - plate_thickness - y_spacing_plates))

block_middle_front = plate1_right_edge_front + support_block_width/2.
block_middle_rear  = plate1_right_edge_rear  + support_block_width/2.
block_middle_center = (block_middle_front + block_middle_rear)/2.
block_middle_skew  = math.atan2( (block_middle_rear - block_middle_front),vacuum_plate_depth)

block_middle_angle_x = dead_zone_angle

tweak = 0.001    # Because the volumes are not a 100% accurate due to angles, this helps avoid overlaps.
block_middle_front_dy  = Bump_height - plate_thickness - tweak
block_middle_rear_dy   = Bump_height - plate_thickness - tweak

block_middle_ypos    = ((front_face_to_target + vacuum_plate_depth/2.)*math.tan(dead_zone_angle)
                        + block_middle_front_dy/2.-y_spacing_plates + tweak/2. )

block_right_front = plate2_right_edge_front + support_block_width/2.
block_right_rear  = plate2_right_edge_rear  + support_block_width/2.
block_right_center= (block_right_front + block_right_rear)/2.
block_right_skew  = math.atan2( (block_right_rear - block_right_front),vacuum_plate_depth)

block_right_front_dy  = 2*(front_face_to_target*math.tan(dead_zone_angle) - plate_thickness - y_spacing_plates)
block_right_rear_dy   = 2*((front_face_to_target+vacuum_plate_depth)*math.tan(dead_zone_angle) - plate_thickness - y_spacing_plates)



#from Muon_Settings_15 import *                  # dirty way to set all the needed globals
#from Muon_Settings import *                  # dirty way to set all the needed globals


################################################################################################################################
#
# Volume Calculations
#
################################################################################################################################


def calculate_muon_mother_geometry(g_en,mother="root",origin=[0,0,0]):
    """ Create the mother volume for the Muon Detector. """

    if not isinstance(g_en,GeometryEngine):
        print "ERROR, I expected a GeometryEngine object as argument to create_ecal_sensitive_detector."
        return()
    

    pos=[x+y for (x,y) in zip(muon_box_center,origin)]

    g_en.add(geom = Geometry(name="MD",
                    mother=mother,
                    description="Muon Detector Mother Volume",
                    pos=pos,
                    pos_units="cm",
                    rot=[0,0,0],
                    rot_units="rad",
                    col="ffff00",
                    g4type="Box",
                    dimensions=muon_box_dims,
                    dims_units="cm",
                    material="Vacuum",
                    style=0)
               )

    return

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
                                   signalThreshold="0*MeV",
                                   timeWindow="80*ns",
                                   prodThreshold="1000*eV",
                                   maxStep="1*mm",
                                   riseTime="1*ns",
                                   fallTime="1*ns",
                                   mvToMeV="1",
                                   pedestal="0",
                                   delay="0*ns",
                                   bankId=700)

    muon_sens.add_bank_row("idx", "Index of paddle in horizontal direction", 1, "Di")
    muon_sens.add_bank_row("idy", "Index of paddle in vertical direction",   2, "Di")
    muon_sens.add_bank_row("idz", "Index of paddle in z-direction, along beam", 3, "Di")
    muon_sens.add_bank_row("adcl", "ADC value 'left' side", 4, "Di")
    muon_sens.add_bank_row("adcr", "ADC value 'right' side", 5, "Di")
    muon_sens.add_bank_row("tdcl", "TDC value 'left' side", 6, "Di")
    muon_sens.add_bank_row("tdcr", "TDC value 'right' side", 7, "Di")
    muon_sens.add_bank_row("hitn","Hit number", 99, "Di")
    
    return(muon_sens)

    
    



def calculate_muon_geometry(g_en,mother="MD",origin=[0,0,0]):
    """Create the main muon detector components, the iron absorbers and the plastic hodoscopes. """

    if not isinstance(g_en,GeometryEngine):
        print "ERROR, I expected a GeometryEngine object as argument to create_ecal_sensitive_detector."
        return()
     
################################################################################
#
# Find or setup the sensitive detector components.
#
################################################################################

    muon_sens = g_en.find_sensitivity("muon_hodo")  # First see if it exists already.
    if muon_sens == -1:
        muon_sens = create_muon_sensitive_detector()
        g_en.add_sensitivity(muon_sens)
          
#############################################
#
# Loop for building up the absorbers
#
############################################

    #
    # The Z coordinates that get increased each loop itteration.
    #
    z_locations_hd=[]   # Store the locations of the hodoscopes.

    local_z_front_face =  front_face_to_target - muon_box_center[2]    # Yes that is -muon_box_depth/2. if all stays same
    global_z_front_face = front_face_to_target                        #

#    print "Front face to target: ",front_face_to_target
#    print "local_z_front_face  : ",local_z_front_face
#    print "muon_box_depth/2    : ",muon_box_depth/2.

    for i in range(len(abs_thickness)):
        # This is the tangent difference in the fan out angles.
        tan_angle_diff = math.tan(abs_angle_vertical_top) -  math.tan(abs_angle_vertical_bot)

        z_loc_abs = local_z_front_face + abs_thickness[i]/2.
        x_loc_abs = 0.
        y_loc_bot_edge = (global_z_front_face + abs_thickness[i]/2.)*math.tan(abs_angle_vertical_bot)  # needs to fan out
        y_loc_abs = y_loc_bot_edge + (abs_total_height[i]/2. + abs_thickness[i]*tan_angle_diff/4.)

        # INSERT TOP IRON ABSORBER
        # The shape is a G4Trap,
        # see http://geant4.web.cern.ch/geant4/UserDocumentation/UsersGuides/ForApplicationDeveloper/html/ch04.html
        #

        trap_pdz  = abs_thickness[i]/2.
        trap_pdy1 = abs_total_width[i]/2.    # Width in x at front face, Due to 90 deg rotation, this is a Dy
        trap_pdy2 = abs_total_width[i]/2. + abs_thickness[i]*math.tan(abs_angle_horizontal)/2.

        trap_pdx1 = abs_total_height[i]/2.   # Height at the front face.
        trap_pdx2 = trap_pdx1

        trap_pdx3 = abs_total_height[i]/2. + abs_thickness[i]*tan_angle_diff/2.
        trap_pdx4 = trap_pdx3

        trap_ptheta =  -(abs_angle_vertical_top+abs_angle_vertical_bot)/2.

    #
    # Store the geometries temporarily, we may need to modify them by adding a notch to make room for a
    # bump up in the vacuum
    #
        geom1=Geometry(
                     name="MD_top_iron_"+str(i),
                     mother=mother,
                     description="Top iron absorber number "+str(i),
                     pos=[x_loc_abs, y_loc_abs, z_loc_abs],
                     pos_units="cm",
                     rot=[0.,0.,90.],
                     rot_units="deg",
                     col="888899",
                     g4type="G4Trap",
                     # G4Trap parameters. Note that the whole thing is rotated by 90 degrees around z.
                     dimensions=[trap_pdz,trap_ptheta, 0   , trap_pdy1, trap_pdx1, trap_pdx2, 0,  trap_pdy2, trap_pdx3, trap_pdx4, 0 ],
                     dims_units=[ "cm "  ,  "rad"    ,"rad",  "cm"   ,   "cm"    ,    "cm"  , "rad", "cm"  ,   "cm"   ,    "cm"  , "rad"],
                     material="Iron",
                     style = 0
                     )

        # INSERT BOTTOM IRON ABSORBER
        # This is just a mirror of the top in the z-x plane
        # Only modify the changed parameters and re-enter the volume
        geom2 = copy.deepcopy(geom1)
        geom2.name   = "MD_bot_iron_"+str(i)
        geom2.description = "Bottom iron absorber number "+str(i)
        geom2.pos[1]      = -geom1.pos[1]           # flip y-position
        geom2.dimensions[1]= -geom1.dimensions[1]    # flip trap_ptheta

        if abs_notch_thick[i] >  0:
 #           print "Notching absorber #"+str(i)

            #### TOP
            # First, make is a component at 0,0,0  ALSO undo the rotation. Why? because it is irrelevant since the rotation is not acted, but is confusing to keep.
            # Modify the TOP geometry to make the item a component and place it at [0,0,0] with [0,0,0] rotation
            geom1.material = "Component"
            geom1.pos= [0,0,0]
            geom1.rot= [0,0,0]
            geom1.name="MD_top_iron_a"+str(i)

            #### Bottom
            # First, make is a component at 0,0,0
            geom2.material = "Component"
            geom2.pos= [0,0,0]
            geom2.rot= [0,0,0]
            geom2.name="MD_bot_iron_a"+str(i)

        g_en.add(geom1)
        g_en.add(geom2)

        if abs_notch_thick[i] >  0:
            #
            # Dimensions of G4Trap for vacuum box, which we need for our cutout:
            # POS: -116.293*mm 0*mm 0*mm
            # DIMS: 425.*mm 4.796516*deg 3.14159265359*rad 29.33*mm 75.14*mm 75.14*mm 0*deg 29.33*mm 132.2788888*mm 132.2788888*mm 0*deg

            PZ1 = z_loc_abs - abs_thickness[i]/2.
            DZ_Front = PZ1 - (front_face_to_target - muon_box_center[2])  # local_z_front_face for absorber[0]
            PX1 = Bump_right_front + DZ_Front*math.tan(Bump_right_angle)
            PX2 = Bump_left_front  + DZ_Front*math.tan(Bump_left_angle)

            PXR1 = PX1 + abs_thickness[i]*math.tan(Bump_right_angle)
            PXR2 = PX2 + abs_thickness[i]*math.tan(Bump_left_angle)

            c_x_front = (PX1 + PX2 )/2.
            c_x_rear  = (PXR1+ PXR2)/2.
            c_x_middle = (c_x_front+c_x_rear)/2.
            c_angle   = math.atan2((c_x_rear-c_x_front),abs_thickness[i])
            w_front   = (PX2 - PX1)/2.
            w_rear    = (PXR2 - PXR1)/2.

        # We need to combine the angle of the skew and the slope (dead zone angle) of the
        # bottom edge of the iron plates. Use rotation matrixes to do the job.

            rot = Rotation().rotateY(c_angle).rotateX(-abs_angle_vertical_bot)
            vec = Vector(3)
            vec2 = rot*vec

            Skew_theta = vec2.theta()
            Skew_phi   = vec2.phi()

#            print "Skew_theta = ",Skew_theta
#            print "Skew_phi   = ",Skew_phi
#            print "x_loc_abs  = ",x_loc_abs
            #   (VX,L1,Skew,DY,DX1,DX2)=(-116.293,425.,4.796516,29.33,75.14+0.5,132.2788888+0.5)
            #   L2 = trap_pdz*10.1

            notch_tolerance = 0.004  # The notch is a little bit thicker, to make sure rendering engine does not leave a sliver.

            geom = Geometry(
                            name  ="MD_top_iron_b"+str(i),
                            mother=mother,
                            description="Top iron absorber cutout number "+str(i),
                            pos=[ (trap_pdx1+trap_pdx3)/2. - abs_notch_thick[i]/2.- notch_tolerance/2.,  # Position in y, at bottom edge.
                                   c_x_middle - x_loc_abs ,                           # position in x (after final rotation)
                                   0],
                            pos_units="cm",
                            rot="0*deg 0*deg 270*deg",
                            col="FF0000",
                            g4type="G4Trap",
                            dimensions=[abs_thickness[i]/2. + 0.001 , Skew_theta, Skew_phi,  abs_notch_thick[i]/2. + notch_tolerance , w_front, w_front, 0   , abs_notch_thick[i]/2. + notch_tolerance , w_rear, w_rear, 0 ],
                            dims_units=[       "cm"             ,   "rad"   ,    "rad",        "cm"           ,  "cm" ,   "cm" ,"rad",      "cm"            ,   "cm",  "cm" , "rad" ],
                            material="Component"
                            )
#
# Note: we made the cutout 10 micrometer longer to avoid confusion on the visual renderer which otherwise may leave a small sliver.
#



            g_en.add(geom)

            geom = Geometry(
                            name="MD_top_iron_"+str(i),
                            mother=mother,
                            description="Top iron absorber with notch  number "+str(i),
                            pos=[ x_loc_abs, y_loc_abs, z_loc_abs],
                            pos_units="cm",
                            rot=[0,0,90],
                            rot_units="deg",
                            col="888899",
                            g4type="Operation: MD_top_iron_a"+str(i)+" - MD_top_iron_b"+str(i),
                            dimensions=[0],
                            dims_units="cm",
                            material="Iron",
                            style=0
                            )
            g_en.add(geom)

            ### Bottom

            rot = Rotation().rotateY(c_angle).rotateX(abs_angle_vertical_bot)
            vec = Vector(3)
            vec2 = rot*vec

            Skew_theta = vec2.theta()
            Skew_phi   = vec2.phi()

            geom2 = Geometry(
                            name  ="MD_bot_iron_b"+str(i),
                            mother=mother,
                            description="Bottom iron absorber cutout number "+str(i),
                            pos=[ -(trap_pdx1+trap_pdx3)/2. +abs_notch_thick[i]/2.+ notch_tolerance/2. ,  # Position in y, at bottom edge.
                                   c_x_middle - x_loc_abs ,                           # position in x (after final rotation)
                                   0],
                            pos_units="cm",
                            rot="0*deg 0*deg 270*deg",
                            col="FF0000",
                            g4type="G4Trap",
                            dimensions=[abs_thickness[i]/2.+ notch_tolerance, Skew_theta, Skew_phi,  abs_notch_thick[i]/2.+ notch_tolerance ,w_front, w_front, 0   , abs_notch_thick[i]/2.+ notch_tolerance, w_rear, w_rear, 0 ],
                            dims_units=[       "cm"             ,   "rad"   ,    "rad",        "cm"           ,  "cm" ,   "cm" ,"rad",      "cm"            ,   "cm",  "cm" , "rad" ],
                            material="Component"
                            )
            g_en.add(geom2)

            geom2 = Geometry(
                            name="MD_bot_iron_"+str(i),
                            mother=mother,
                            description="Bottom iron absorber with notch number "+str(i),
                            pos=[ x_loc_abs, -y_loc_abs, z_loc_abs],
                            pos_units="cm",
                            rot=[0,0,90],
                            rot_units="deg",
                            col="888899",
                            g4type="Operation: MD_bot_iron_a"+str(i)+" - MD_bot_iron_b"+str(i),
                            dimensions=[0],
                            dims_units="cm",
                            material="Iron",
                            style=0
                            )
            g_en.add(geom2)


        #
        # Increment the z locations with the thickness of the layer.
        #
        local_z_rear_face = local_z_front_face + abs_thickness[i]
        global_z_rear_face= global_z_front_face+ abs_thickness[i]

        local_z_front_face  += abs_thickness[i] + hd_spacing_z*3 + 2*hd_thickness
        global_z_front_face += abs_thickness[i] + hd_spacing_z*3 + 2*hd_thickness

        ###################################################################
        #
        #  Place Hodoscopes
        #
        ###################################################################

        hd_z_location        = local_z_rear_face  + hd_spacing_z + hd_thickness/2.
        hd_z_location_global = global_z_rear_face + hd_spacing_z + hd_thickness/2.

        # Vertical layers.

#        hd_sum_total_height = sum(hd_horizontal_heights[i])+ (len(hd_horizontal_heights[i])-1)*hd_spacing_y
        hd_sum_total_width  = sum(hd_horizontal_widths[i][1] )+ (len(hd_horizontal_widths[i][1]) -1)*hd_spacing_x

        current_y_pos = hd_z_location_global*math.tan(dead_zone_angle) + hd_horizontal_heights[i][0]/2.

    # Store the Z location of the (next) hodoscope

        z_locations_hd.append(hd_z_location_global)

        # Horizontally oriented layers.

        for iy in range(len(hd_horizontal_heights[i])):

            current_x_pos = -hd_sum_total_width/2. + abs(hd_horizontal_widths[i][iy][0])/2.

            for ix in range(len(hd_horizontal_widths[i][iy])):

                hd_width = hd_horizontal_widths[i][iy][ix]     # lookup width
                hd_height= hd_horizontal_heights[i][iy]    # lookup height

                # print i,ix,iy,hd_width,hd_height,current_x_pos,current_y_pos
                Color = 'FF0000'

                #      if iy == 0 and ix > 0 and ix < 5:
                #        if ix%2:
                #          Color = '773300'
                #        else:
                #          Color = '990000'
                #        index_x = ix - 100 - len(hd_horizontal_widths[i][1])/2
                #      else:
                if ix%2:
                    if iy%2:
                        Color = 'BB5500'
                    else:
                        Color = 'FF9900'
                else:
                    if iy%2:
                        Color = 'AA2222'
                    else:
                        Color = 'DD2222'

                index_x,index_y,index_z = hd_horizontal_index[i][iy][ix]

                if hd_width > 0:

                    geom1 = Geometry(
                                    name="HD_Top_Hori_"+str(i)+"_"+str(ix)+"_"+str(iy+1) ,
                                    mother=mother,
                                    description="Hodoscope Top horizontal layer number "+str(i)+" ("+str(index_x)+","+str(iy+1)+")",
                                    pos= [current_x_pos, current_y_pos, hd_z_location],
                                    pos_units="cm",
                                    rot=[0,0,0],
                                    rot_units="rad",
                                    col=Color,
                                    g4type="Box",
                                    dimensions=[hd_width/2. , hd_height/2., hd_thickness/2.],
                                    dims_units= "cm",
                                    material="ScintillatorB",
                                    sensitivity=muon_sens.sensitivity(),
                                    hittype    =muon_sens.hitType(),
                                    identity   =muon_sens.identity(index_x,index_y,index_z)
                                    )
                    g_en.add(geom1)

                    # Bottom
                    geom2 = copy.deepcopy(geom1)
                    geom2.name="HD_Bot_Hori_"+str(i)+"_"+str(ix)+"_"+str(iy+1)
                    geom2.description="Hodoscope Bot horizontal layer number "+str(i)+" ("+str(index_x)+","+str(iy+1)+")"
                    geom2.pos[1] = -geom1.pos[1]
                    geom2.identity="ih manual "+str(index_x)+" iv manual "+str(-index_y)+" iz manual "+str(index_z)

                    g_en.add(geom2)

                if ix < len(hd_horizontal_widths[i][iy])-1:
                    current_x_pos += abs(hd_horizontal_widths[i][iy][ix])/2. + abs(hd_horizontal_widths[i][iy][ix+1])/2. + hd_spacing_x

            if iy < len(hd_horizontal_heights[i]) -1:
                current_y_pos += hd_horizontal_heights[i][iy]/2. + hd_horizontal_heights[i][iy+1]/2. + hd_spacing_y

        # Vertically oriented layers.

        hd_z_location         += hd_thickness + hd_spacing_z
        hd_z_location_global  += hd_thickness + hd_spacing_z

#        hd_sum_total_height = sum(hd_vert_heights[i])+ (len(hd_vert_heights[i])-1)*hd_spacing_y

        current_y_pos = hd_z_location_global*math.tan(dead_zone_angle) + hd_vert_heights[i][0]/2.

        z_locations_hd.append(hd_z_location_global)

        for iy in range(len(hd_vert_heights[i])):

            hd_sum_total_width = sum(hd_vert_widths[i])+ (len(hd_vert_widths[i])-1)*hd_spacing_x
            current_x_pos = -hd_sum_total_width/2. + hd_vert_widths[i][0]/2.     # -x edge, plus 1/2 the width of the first paddle.

            for ix in range(len(hd_vert_widths[i])):

                hd_width = hd_vert_widths[i][ix]     # lookup width
                hd_height= hd_vert_heights[i][iy]    # lookup height
            # print i,ix,iy,hd_width,hd_height,current_x_pos,current_y_pos

                Color = 'FF0000'
                if ix%2:
                    if iy%2:
                        Color = 'CC4444'
                    else:
                        Color = 'DD3333'
                else:
                    if iy%2:
                        Color = 'AA2222'
                    else:
                        Color = 'CC2222'

                index_x,index_y,index_z = hd_vert_index[i][iy][ix]

                bump_up=0
                if iy == 0 and current_x_pos + hd_vert_widths[i][ix]/2. > Bump_right_vert[i] and current_x_pos - hd_vert_widths[i][ix]/2. < Bump_left_vert[i]:
                    bump_up = Bump_height

                geom1 = Geometry(
                                name="HD_Top_Vert_"+str(i)+"_"+str(ix)+"_"+str(iy+1),
                                mother=mother,
                                description="Hodoscope Top vertical layer number "+str(i)+" ("+str(index_x)+","+str(iy+1)+")",
                                pos= [current_x_pos, current_y_pos + bump_up/2., hd_z_location],
                                pos_units="cm",
                                rot=[0,0,90],
                                rot_units="deg",
                                col=Color,
                                g4type="Box",
                                dimensions=[hd_vert_heights[i][iy]/2. - bump_up/2. , hd_vert_widths[i][ix]/2. , hd_thickness/2.],
                                dims_units= "cm",
                                material="ScintillatorB",
                                sensitivity=muon_sens.sensitivity(),
                                hittype=muon_sens.hitType(),
                                identity=muon_sens.identity(index_x, index_y,index_z)
                                )
                # Bottom
                geom2 = copy.deepcopy(geom1)
                geom2.name="HD_Bot_Vert_"+str(i)+"_"+str(ix)+"_"+str(iy+1)
                geom2.description="Hodoscope Bot vertical layer number "+str(i)+" ("+str(index_x)+","+str(iy+1)+")"
                geom2.pos[1] = -geom1.pos[1]
                geom2.rot[2] = -geom1.rot[2]
                geom2.identity="ih manual "+str(index_x)+" iv manual "+str(-index_y)+" iz manual "+str(index_z)

                g_en.add(geom1)
                g_en.add(geom2)

                if ix < len(hd_vert_widths[i])-1:
                    current_x_pos += hd_vert_widths[i][ix]/2. + hd_vert_widths[i][ix+1]/2. + hd_spacing_x

            if iy < len(hd_vert_heights[i]) -1:
                current_y_pos += hd_vert_heights[i][iy]/2. + hd_vert_heights[i][iy+1]/2. + hd_spacing_y

#    print "float hd_zlocations = {",
#    for i in range(len(z_locations_hd)-1):
#        print z_locations_hd[i],",",
#    print z_locations_hd[len(z_locations_hd)-1],"};"

    return(g_en)

def calculate_muon_flux_geometry(g_flux,mother="MD",origin=[0,0,0]):
    """ Place a FLUX counter in front of every hodoscope layer.
    This allows to correlate the particles that make up the hit,
    allows to count how often a hodoscope got more than one hit.
    """
    for i in range(len(hodo_z_location_local)):
        flux_y_pos = (hodo_z_location_local[i] + front_face_to_target) *math.tan(dead_zone_angle) + hd_total_height[i]/2.
        flux_z_pos =  hodo_z_location_local[i] - muon_box_depth/2. - hd_thickness/2. - Flux_thick/2.

        geom=Geometry(
                      name="Flux_Top_a_"+str(i),
                      mother=mother,
                      description="Top Flux counter for layer "+str(i),
                      pos= [0, 0, 0],
                      pos_units="cm",
                      rot= [0,0,0],
                      rot_units="rad",
                      col="FFFF00",
                      g4type="Box",
                      dimensions=[hd_total_width[i]/2. , hd_total_height[i]/2., Flux_thick/2. ],
                      dims_units="cm",
                      material="Component",
                      style=0,
                      sensitivity="FLUX",
                      hittype="FLUX",
                      identity="id manual "+str(i+101)
                      )
        g_flux.add(geom)

#
# Enter a mirrored one for the bottom
#
        geom2 = copy.deepcopy(geom)
        geom2.name="Flux_Bot_a_"+str(i)
        geom2.description="Bottom Flux counter for layer "+str(i)
        geom2.pos[1] = -geom.pos[1]
        g_flux.add(geom2)

#
# Cutout part to be subtracted.
#

        geom=Geometry(
                      name="Flux_Top_b_"+str(i),
                      mother=mother,
                      description="Subtraction part of Top Flux counter for layer "+str(i),
                      pos= [(Bump_left[i]+Bump_right[i])/2., -hd_total_height[i]/2. +abs_notch_thick[i]/2., 0],
                      pos_units="cm",
                      rot= [0,0,0],
                      rot_units="rad",
                      col="FFFF00",
                      g4type="Box",
                      dimensions=[  (Bump_left[i] - Bump_right[i])/2. + 0.001, abs_notch_thick[i]/2. + 0.001, Flux_thick/2. + 0.001 ],
                      dims_units="cm",
                      material="Component",
                      style=0,
                      sensitivity="FLUX",
                      hittype="FLUX",
                      identity="id manual "+str(i)
                      )
        g_flux.add(geom)

#
# Enter a mirrored one for the bottom
#
        geom2 = copy.deepcopy(geom)
        geom2.name="Flux_Bot_b_"+str(i)
        geom2.description="Bottom Flux counter for layer "+str(i)
        geom2.pos[1] = -geom.pos[1]
        g_flux.add(geom2)

#
# Place the combined volume
#

        geom=Geometry(
                      name="Flux_Top_"+str(i),
                      mother=mother,
                      description="Top Flux counter for layer w. subtraction "+str(i),
                      pos= [0, flux_y_pos, flux_z_pos],
                      pos_units="cm",
                      rot= [0,0,0],
                      rot_units="rad",
                      col="FFFF00",
                      g4type="Operation: Flux_Top_a_"+str(i)+" - Flux_Top_b_"+str(i),
                      dimensions=[  0 ],
                      dims_units="cm",
                      material="Vacuum",
                      style=0,
                      sensitivity="FLUX",
                      hittype="FLUX",
                      identity="id manual "+str(i)
                      )
        g_flux.add(geom)

#
# Enter a mirrored one for the bottom
#
        geom2 = copy.deepcopy(geom)
        geom2.name="Flux_Bot_"+str(i)
        geom2.description="Bottom Flux counter for layer "+str(i)
        geom2.pos[1] = -geom.pos[1]
        geom2.g4type="Operation: Flux_Bot_a_"+str(i)+" - Flux_Bot_b_"+str(i)
        g_flux.add(geom2)

#
# Flux detector in the cutout region, to see what we missed.
# We need to take into account that we cannot have overlap with the vacuum plates.
# BL and BR are the equivalent of Bump_left and Bump_right, but not at the position of the Flux detector.

        BL = Bump_left_front +(flux_z_pos+ muon_box_depth/2.) * math.tan(Bump_left_angle)
        BR = Bump_right_front +(flux_z_pos+ muon_box_depth/2.) * math.tan(Bump_right_angle)
        xwidth= ((BL - BR)
                 - support_block_width/math.cos(block_middle_skew)
                 - support_block_width/math.cos(block_left_skew)
                 - 2.*x_spacing_plates - 0.005 )
        ywidth= abs_notch_thick[i] - plate_thickness - y_spacing_plates

        xpos= ((BL + BR)/2.
               + support_block_width/math.cos(block_middle_skew)
               - support_block_width/math.cos(block_left_skew))
        ypos= flux_y_pos -hd_total_height[i]/2. + ywidth/2. - 0.005


        geom=Geometry(
                      name="Flux_Top_cutout_"+str(i),
                      mother=mother,
                      description="Flux detector in cutout gap top"+str(i),
                      pos= [xpos, ypos, flux_z_pos + hd_thickness + Flux_thick/2.],
                      pos_units="cm",
                      rot= [0,0,0],
                      rot_units="rad",
                      col="FFFF00",
                      g4type="Box",
                      dimensions=[xwidth/2. , ywidth/2., Flux_thick/2.],
                      dims_units="cm",
                      material="Vacuum",
                      style=0,
                      sensitivity="FLUX",
                      hittype="FLUX",
                      identity="id manual "+str(-i)
                      )
        g_flux.add(geom)

        geom2 = copy.deepcopy(geom)
        geom2.name = "Flux_Bot_cutout_"+str(i)
        geom2.description="Flux detector in cutout gap bottom "+str(i)
        geom2.pos[1] = -geom.pos[1]
        g_flux.add(geom2)

    return(g_flux)


def calculate_muon_vacuum_box(g_en_vac):
    ##########################################################################################################
    #
    # Calcuate the geometery of the VACUUM BOX to fit inside the iron absorbers.
    #
    ##########################################################################################################
    #
    #
    #

    ############################################
    #
    # Calculate the parameters for the plates 1
    #
    ###########################################
    #
    # Plate 1  - on the left (positron) side, inside the bump up region.
    #
    center_x_front = (plate1_left_edge_front + plate1_right_edge_front ) /2.
    center_x_rear  = (plate1_left_edge_rear  + plate1_right_edge_rear  ) /2.
    center_x_middle = (center_x_front + center_x_rear) /2.

    skew_angle = math.atan2((center_x_rear - center_x_front),vacuum_plate_depth)
    tilt_angle = dead_zone_angle

    skew_vector = Rotation().rotateY(skew_angle).rotateX( -tilt_angle) * Vector(3) # Rotation* Z vector
    plate_theta = skew_vector.theta()
    plate_phi   = skew_vector.phi()

#    print "skew_vector = ",skew_vector
#    print "Skew  angles:    Y =",skew_angle,"     X =",-tilt_angle
#    print "Plate angles: theta=",plate_theta,"  phi=",plate_phi

    skew2_vector = Rotation().rotateY(skew_angle).rotateX( tilt_angle) * Vector(3) # Rotation* Z vector
    plate2_theta = skew2_vector.theta()
    plate2_phi   = skew2_vector.phi()

#    print "skew2_vector = ",skew2_vector
#    print "Skew2  angles:    Y =",skew_angle,"     X =",tilt_angle
#    print "Plate2 angles: theta=",plate2_theta,"  phi=",plate2_phi

    width_front     = plate1_left_edge_front - plate1_right_edge_front
    width_rear      = plate1_left_edge_rear  - plate1_right_edge_rear

    center_y_front =  front_face_to_target*math.tan(dead_zone_angle)+ Bump_height - plate_thickness/2. - y_spacing_plates
    center_y_rear   = center_y_front + vacuum_plate_depth*math.tan(tilt_angle)
    center_y_middle = (center_y_front + center_y_rear)/2.

    center_z_middle = 0.

    angle_x=0.
    angle_y=0.
    angle_z=0.

    ################################################
    #
    # Place the volumes Plate 1
    #
    ################################################

    top_dims=[]      # Enter the G4Trap parameters separately.
    top_units=[]
    top_dims.append(vacuum_plate_depth/2.)    ; top_units.append("cm")
    top_dims.append(plate_theta)       ; top_units.append("rad")   # Angle of trap centerline.
    top_dims.append(plate_phi )        ; top_units.append("rad")
    top_dims.append(plate_thickness/2.); top_units.append("cm")
    top_dims.append(width_front/2.)    ; top_units.append("cm")
    top_dims.append(width_front/2.)    ; top_units.append("cm")
    top_dims.append( 0 )               ; top_units.append("rad")
    top_dims.append(plate_thickness/2.); top_units.append("cm")
    top_dims.append(width_rear/2.)     ; top_units.append("cm")
    top_dims.append(width_rear/2.)     ; top_units.append("cm")
    top_dims.append(0 )                ; top_units.append("deg")

    # Top plate
    geom1=Geometry(
                  name="m_Vacuum_Top_Plate1",
                  mother="MD",
                  description="Muon Detector Vacuum Top Plate1",
                  pos=[center_x_middle + x_offset_wrt_MD , center_y_middle, center_z_middle],
                  pos_units="cm",
                  rot=[angle_x, angle_y, angle_z],
                  rot_units="rad",
                  col="DDDDDD",
                  g4type="G4Trap",
                  dimensions=top_dims,
                  dims_units=top_units,
                  material="StainlessSteel"
                  )
    g_en_vac.add(geom1)

    # Bottom plate

    # G4Trap parameters.
    bot_dims=[]      # Enter the G4Trap parameters separately.
    bot_units=[]
    bot_dims.append(vacuum_plate_depth/2.)    ; bot_units.append("cm")
    bot_dims.append(plate2_theta)      ; bot_units.append("rad")   # Angle of trap centerline.
    bot_dims.append(plate2_phi )       ; bot_units.append("rad")
    bot_dims.append(plate_thickness/2.); bot_units.append("cm")
    bot_dims.append(width_front/2.)    ; bot_units.append("cm")
    bot_dims.append(width_front/2.)    ; bot_units.append("cm")
    bot_dims.append( 0 )               ; bot_units.append("rad")
    bot_dims.append(plate_thickness/2.); bot_units.append("cm")
    bot_dims.append(width_rear/2.)     ; bot_units.append("cm")
    bot_dims.append(width_rear/2.)     ; bot_units.append("cm")
    bot_dims.append(0 )                ; bot_units.append("deg")

    geom2 = copy.deepcopy(geom1)
    geom2.name="m_Vacuum_Bottom_Plate1"
    geom2.description="Muon Detector Vacuum Bottom Plate1"
    geom2.pos[1] = -geom1.pos[1]
    geom2.rot[1] = -geom1.rot[1]
    geom2.dimensions=bot_dims
    geom2.dims_units=bot_units

    g_en_vac.add(geom2)

    ############################################
    #
    # Calculate the parameters for the plates 2
    # Exact same as for plate1, except input parameters (yes, could be a routine)
    ###########################################
    #
    # Plate 2  - on the left (positron) side, inside the bump up region.
    #
    center_x_front = (plate2_left_edge_front + plate2_right_edge_front ) /2.
    center_x_rear  = (plate2_left_edge_rear  + plate2_right_edge_rear  ) /2.
    center_x_middle = (center_x_front + center_x_rear) /2.

    skew_angle = math.atan2((center_x_rear - center_x_front),vacuum_plate_depth)
    tilt_angle = dead_zone_angle

    skew_vector = Rotation().rotateY(skew_angle).rotateX( -tilt_angle) * Vector(3) # Rotation* Z vector
    plate_theta = skew_vector.theta()
    plate_phi   = skew_vector.phi()

#    print "skew_vector = ",skew_vector
#    print "Skew  angles:    Y =",skew_angle,"     X =",-tilt_angle
#    print "Plate angles: theta=",plate_theta,"  phi=",plate_phi

    skew2_vector = Rotation().rotateY(skew_angle).rotateX( tilt_angle) * Vector(3) # Rotation* Z vector
    plate2_theta = skew2_vector.theta()
    plate2_phi   = skew2_vector.phi()

#    print "skew2_vector = ",skew2_vector
#    print "Skew2  angles:    Y =",skew_angle,"     X =",tilt_angle
#    print "Plate2 angles: theta=",plate2_theta,"  phi=",plate2_phi

    width_front     = plate2_left_edge_front - plate2_right_edge_front
    width_rear      = plate2_left_edge_rear  - plate2_right_edge_rear

    center_y_front =  front_face_to_target*math.tan(dead_zone_angle) - plate_thickness/2. - y_spacing_plates
    center_y_rear   = center_y_front + vacuum_plate_depth*math.tan(tilt_angle)
    center_y_middle = (center_y_front + center_y_rear)/2.

    center_z_middle = 0.

    angle_x=0.
    angle_y=0.
    angle_z=0.

    ################################################
    #
    # Place the volumes Plate 2
    #
    ################################################

    # Top plate 2

    top_dims=[]      # Enter the G4Trap parameters separately.
    top_units=[]
    top_dims.append(vacuum_plate_depth/2.); top_units.append("cm")
    top_dims.append(plate_theta)   ; top_units.append("rad")   # Angle of trap centerline.
    top_dims.append(plate_phi )    ; top_units.append("rad")
    top_dims.append(plate_thickness/2.); top_units.append("cm")
    top_dims.append(width_front/2.); top_units.append("cm")
    top_dims.append(width_front/2.); top_units.append("cm")
    top_dims.append( 0 );            top_units.append("rad")
    top_dims.append(plate_thickness/2.); top_units.append("cm")
    top_dims.append(width_rear/2.); top_units.append("cm")
    top_dims.append(width_rear/2.); top_units.append("cm")
    top_dims.append(0 ) ;           top_units.append("deg")

    geom1=Geometry(
                  name="m_Vacuum_Top_Plate2",
                  mother="MD",
                  description="Muon Detector Vacuum Top Plate2",
                  pos=[ center_x_middle + x_offset_wrt_MD, center_y_middle, center_z_middle],
                  pos_units="cm",
                  rot= [angle_x, angle_y, angle_z ],
                  rot_units="rad",
                  col="DDDDDD",
                  g4type="G4Trap",
                  dimensions=top_dims,
                  dims_units=top_units,
                  material="StainlessSteel"
                  )
    g_en_vac.add(geom1)

    # Bottom plate 2
    # G4Trap parameters.

    bot_dims=[]      # Enter the G4Trap parameters separately.
    bot_units=[]
    bot_dims.append(vacuum_plate_depth/2.); bot_units.append("cm")
    bot_dims.append(plate2_theta)   ; bot_units.append("rad")   # Angle of trap centerline.
    bot_dims.append(plate2_phi )    ; bot_units.append("rad")
    bot_dims.append(plate_thickness/2.); bot_units.append("cm")
    bot_dims.append(width_front/2.); bot_units.append("cm")
    bot_dims.append(width_front/2.); bot_units.append("cm")
    bot_dims.append( 0 );            bot_units.append("rad")
    bot_dims.append(plate_thickness/2.); bot_units.append("cm")
    bot_dims.append(width_rear/2.); bot_units.append("cm")
    bot_dims.append(width_rear/2.); bot_units.append("cm")
    bot_dims.append(0 ) ;           bot_units.append("deg")

    geom2 = copy.deepcopy(geom1)
    geom2.name="m_Vacuum_Bottom_Plate2"
    geom2.description="Muon Detector Vacuum Bottom Plate2"
    geom2.pos[1] = -geom1.pos[1]
    geom2.rot[1]=  -geom1.rot[1]
    geom2.dimensions=bot_dims
    geom2.dims_units=bot_units

    g_en_vac.add(geom2)

    # Left block
    left_dims=[]      # Enter the G4Trap parameters separately.
    left_units=[]
    left_dims.append(vacuum_plate_depth/2.); left_units.append("cm")
    left_dims.append(block_left_skew); left_units.append("rad")   # Angle of trap centerline.
    left_dims.append(0            )    ; left_units.append("rad")
    left_dims.append(block_left_front_dy/2.); left_units.append("cm")
    left_dims.append(support_block_width/2.); left_units.append("cm")
    left_dims.append(support_block_width/2.); left_units.append("cm")
    left_dims.append( 0 );            left_units.append("rad")
    left_dims.append(block_left_rear_dy/2.); left_units.append("cm")
    left_dims.append(support_block_width/2.); left_units.append("cm")
    left_dims.append(support_block_width/2.); left_units.append("cm")
    left_dims.append(0 ) ;           left_units.append("deg")

    geom1=Geometry(
                  name="m_Vacuum_Left_Block",
                  mother="MD",
                  description="Muon Detector Vacuum left block",
                  pos=[block_left_center + x_offset_wrt_MD, 0, center_z_middle],
                  pos_units="cm",
                  rot=[angle_x, -angle_y, angle_z],
                  rot_units="rad",
                  col="DDDDDD",
                  g4type="G4Trap",
                  dimensions=left_dims,
                  dims_units=left_units,
                  material="StainlessSteel",
                )

    g_en_vac.add(geom1)

    # Middle block top

    # Middle block dims
    mid_dims=[]      # Enter the G4Trap parameters separately.
    mid_units=[]
    mid_dims.append(vacuum_plate_depth/2.); mid_units.append("cm")
    mid_dims.append(block_middle_skew); mid_units.append("rad")   # Angle of trap centerline.
    mid_dims.append(0            )    ; mid_units.append("rad")
    mid_dims.append(block_middle_front_dy/2.); mid_units.append("cm")
    mid_dims.append(support_block_width/2.); mid_units.append("cm")
    mid_dims.append(support_block_width/2.); mid_units.append("cm")
    mid_dims.append( 0 );            mid_units.append("rad")
    mid_dims.append(block_middle_rear_dy/2.); mid_units.append("cm")
    mid_dims.append(support_block_width/2.); mid_units.append("cm")
    mid_dims.append(support_block_width/2.); mid_units.append("cm")
    mid_dims.append(0 ) ;           mid_units.append("deg")

    geom2 = copy.deepcopy(geom1)
    geom2.name="m_Vacuum_Middle_Block_top"
    geom2.description="Muon Detector Vacuum middle block top"
    geom2.pos=[block_middle_center + x_offset_wrt_MD, block_middle_ypos, center_z_middle]
    geom2.rot=[ block_middle_angle_x, angle_y,  angle_z ]
    geom2.dimensions=mid_dims
    geom2.dims_units=mid_units

    g_en_vac.add(geom2)

    # Middle block bottom

    geom3=copy.deepcopy(geom2)
    geom3.name="m_Vacuum_Middle_Block_bottom"
    geom3.description="Muon Detector Vacuum middle block bottom"
    geom3.pos=[block_middle_center + x_offset_wrt_MD, -block_middle_ypos, center_z_middle]
    geom3.rot=[ -block_middle_angle_x, angle_y,  angle_z ]
    geom3.dimensions=mid_dims
    geom3.dims_units=mid_units

    g_en_vac.add(geom3)

    # Right block

    # Right block dims
    right_dims=[]      # Enter the G4Trap parameters separately.
    right_units=[]
    right_dims.append(vacuum_plate_depth/2.); right_units.append("cm")
    right_dims.append(block_right_skew); right_units.append("rad")   # Angle of trap centerline.
    right_dims.append(0            )    ; right_units.append("rad")
    right_dims.append(block_right_front_dy/2.); right_units.append("cm")
    right_dims.append(support_block_width/2.); right_units.append("cm")
    right_dims.append(support_block_width/2.); right_units.append("cm")
    right_dims.append( 0 );            right_units.append("rad")
    right_dims.append(block_right_rear_dy/2.); right_units.append("cm")
    right_dims.append(support_block_width/2.); right_units.append("cm")
    right_dims.append(support_block_width/2.); right_units.append("cm")
    right_dims.append(0 ) ;           right_units.append("deg")

    geom4=copy.deepcopy(geom3)
    geom4.name="m_Vacuum_Right_Block"
    geom4.description="Muon Detector Vacuum right block"
    geom4.pos=[ block_right_center + x_offset_wrt_MD ,  0 , center_z_middle]
    geom4.rot=[angle_x, -angle_y, angle_z ]
    geom4.dimensions = right_dims
    geom4.dims_units = right_units

    g_en_vac.add(geom4)

    return(g_en_vac)


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
        
