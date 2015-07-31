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

Standard_Table_Name="hps_muon_lite"

######################################
#
# Detector location overall
#
######################################

front_face_to_target = 177. + 2.5     # Distance of front face of muon detector to the target plus flange thickness 
dead_zone_angle = 0.020               # mrad dead zone.

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

abs_thickness=    [ 20., 15. , 15. , 15. ]  # list of depths of the iron absorbers in cm (these are not half-depths)
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

hd_spacing_z_outer = 1.0                    # Spacing between hodoscopes and absorbers.

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
abs_angle_vertical_bot = 0 # dead_zone_angle          # Angle of the bottom face of the absorbers.
y_loc_bot_edge_fixed   = 3.85
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
hodo_z_location_local=[]      # Store the z locations for positioning the FLUX detectors.

third_paddle_width=12.
third_paddle_start=0.   # This must be 0 < start < width, else the divide will not fall on photon line.
                        # It could be set to Bump_left[i] (below in the loop) to coincide with the bump boundary.
for i in range(len(hd_total_width)):
    local_z += abs_thickness[i] + hd_spacing_z + hd_thickness/2.
#    print "Hodo local z location [",i,"] = ",local_z, " global = ",front_face_to_target +local_z
    hodo_z_location_local.append(local_z)
    hd_horizontal_widths+=[[
                       [w[i]+ third_paddle_start -third_paddle_width, +third_paddle_width,w[i]-third_paddle_start],
                       [w[i]+ third_paddle_start -third_paddle_width, +third_paddle_width,w[i]-third_paddle_start],
                       [w[i],w[i]]
                       ]]
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

# hd_vert_heights=[
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
 #   Right_segment_width  = (Bump_right_vert[i] + hd_total_width[i]/2.)
 #   Center_segment_width = (Bump_left_vert[i] - Bump_right_vert[i] )
 #   Left_segment_width   = (hd_total_width[i]/2. - Bump_left_vert[i])

    Center_segment_width = hd_total_width[i]

#    Right = Calculate_vertical_paddle_widths(Right_segment_width,i,-1)
    Center= Calculate_vertical_paddle_widths(Center_segment_width,i,0)
#    Left  = Calculate_vertical_paddle_widths(Left_segment_width,i,1)

    hd_vert_widths.append(Center)     # Store one row of the concatenated lists.
    hd_vert_heights.append( [ hd_total_height[i] ] ) # All are the same height. The bump is adjusting the height during placement.

#
# Here we calculate which paddle should have the 0 index. This should be the paddle in which x=0 occurs. It is between Bump_left and Bump_right
# so it falls in the center section, and will be on the Bump_left (positron, +x) side. We thus count how many paddles fit between Bump_left
# and x=0. This is expected to be in the 0 to 1 range

    N_Left=0
    Left_edge= -hd_total_width[i]/2.
    for l in reversed(Center):   # itterate from the left, i.e. high x.
        Left_edge += l
#        print "Left_center_width = ",Left_center_width," N_Left=",N_Left
        if Left_edge < 0:
            N_Left += 1
        else:
            break

#    print "For width ",Bump_left[i]," we have N_Right=",N_Left," Center[0]=",Center[len(Center)-1]," Center[1]=",Center[len(Center)-2]

    N_Right = len(Center) - N_Left

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
y_spacing_plates = 0.1  # Gap between the vacuum plate and the Iron absorbers.
# x_spacing_plates = 0.01

support_block_width = 1.
plate_thickness     = 0.5

#from Muon_Settings_15 import *                  # dirty way to set all the needed globals
#from Muon_Settings import *                  # dirty way to set all the needed globals


################################################################################################################################
#
# Volume Calculations
#
################################################################################################################################


def calculate_muon_lite_mother_geometry(g_en,mother="root",origin=[0,0,0]):
    """ Create the mother volume for the Muon Detector. """

    if not isinstance(g_en,GeometryEngine):
        print "ERROR, I expected a GeometryEngine object as argument to create_ecal_sensitive_detector."
        return()
    

    pos=[muon_box_center[0]+origin[0],
         muon_box_center[1]+origin[1]+muon_box_dims[1]+ 3.81,  # 3.81 is thickness of vacuum box.
         muon_box_center[2]+origin[2]]

    g_en.add(geom = Geometry(name="MD_top",
                    mother=mother,
                    description="Muon Detector Top Mother Volume",
                    pos=pos,
                    pos_units="cm",
                    rot=[0,0,0],
                    rot_units="rad",
                    col="ffff00",
                    g4type="Box",
                    dimensions=muon_box_dims,
                    dims_units="cm",
                    material="Vacuum",
                    visible=1,
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
                                   bankId=620)


    muon_sens.add_bank_row("idx", "Index of paddle in horizontal direction", 1, "Di")
    muon_sens.add_bank_row("idy", "Index of paddle in vertical direction",   2, "Di")
    muon_sens.add_bank_row("idz", "Index of paddle in z-direction, along beam", 3, "Di")
    muon_sens.add_bank_row("adcl", "ADC value 'left' side", 4, "Di")
    muon_sens.add_bank_row("adcr", "ADC value 'right' side", 5, "Di")
    muon_sens.add_bank_row("tdcl", "TDC value 'left' side", 6, "Di")
    muon_sens.add_bank_row("tdcr", "TDC value 'right' side", 7, "Di")
    muon_sens.add_bank_row("hitn","Hit number", 99, "Di")    

    return(muon_sens)

    
def calculate_muon_lite_geometry(g_en,mother="root",origin=[0,0,0]):
    """Create the main muon 'lite' detector components, the iron absorbers and the plastic hodoscopes. """

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
          
############################################################################
#    Reference Frame Correction
############################################################################
#
# Because of the vacuum box, we cannot have one big mother volume for muon.
# Instead, put everything in the root volume. But now we need to shift the
# reference point for all the object. We do this by moving the origin.

    origin = muon_box_center

#############################################
#
# Loop for building up the absorbers
#
############################################

    #
    # The Z coordinates that get increased each loop itteration.
    #
    z_locations_hd=[]   # Store the locations of the hodoscopes.

    local_z_front_face =  front_face_to_target - muon_box_center[2]   # Yes that is -muon_box_depth/2. if all stays same
    global_z_front_face = front_face_to_target                        #

#    print "Front face to target: ",front_face_to_target
#    print "local_z_front_face  : ",local_z_front_face
#    print "muon_box_depth/2    : ",muon_box_depth/2.

    for i in range(len(abs_thickness)):
        # This is the tangent difference in the fan out angles.
        tan_angle_diff = math.tan(abs_angle_vertical_top) -  math.tan(abs_angle_vertical_bot)

        z_loc_abs = local_z_front_face + abs_thickness[i]/2.
        x_loc_abs = 0.
        
        
        y_loc_bot_edge = y_loc_bot_edge_fixed # For muon lite, no fan out? 
        
        # y_loc_bot_edge = 1. + (global_z_front_face + abs_thickness[i]/2.)*math.tan(abs_angle_vertical_bot)  # needs to fan out
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
                     pos=[origin[0]+x_loc_abs, origin[1]+ y_loc_abs,origin[2]+ z_loc_abs],
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

        g_en.add(geom1)
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
                                    pos= [origin[0]+current_x_pos, origin[1]+ current_y_pos,origin[2]+ hd_z_location],
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

                geom1 = Geometry(
                                name="HD_Top_Vert_"+str(i)+"_"+str(ix)+"_"+str(iy+1),
                                mother=mother,
                                description="Hodoscope Top vertical layer number "+str(i)+" ("+str(index_x)+","+str(iy+1)+")",
                                pos= [origin[0]+current_x_pos, origin[1]+current_y_pos, origin[2]+ hd_z_location],
                                pos_units="cm",
                                rot=[0,0,90],
                                rot_units="deg",
                                col=Color,
                                g4type="Box",
                                dimensions=[hd_vert_heights[i][iy]/2., hd_vert_widths[i][ix]/2. , hd_thickness/2.],
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

    return

def calculate_muon_flux_geometry(g_flux,mother="MD",origin=[0,0,0]):
    """ Place a FLUX counter in front of every hodoscope layer.
    This allows to correlate the particles that make up the hit,
    allows to count how often a hodoscope got more than one hit.
    """
    Flux_thick=0.1
    
    for i in range(len(hodo_z_location_local)):
        flux_y_pos = (hodo_z_location_local[i] + front_face_to_target) *math.tan(dead_zone_angle) + hd_total_height[i]/2.
        flux_z_pos =  hodo_z_location_local[i] - muon_box_depth/2. - hd_thickness/2. - Flux_thick/2.

        geom=Geometry(
                      name="Flux_Top_a_"+str(i),
                      mother=mother,
                      description="Top Flux counter for layer "+str(i),
                      pos= [origin[0], origin[1]+flux_y_pos, origin[2]+flux_z_pos],
                      pos_units="cm",
                      rot= [0,0,0],
                      rot_units="rad",
                      col="FFFF00",
                      g4type="Box",
                      dimensions=[hd_total_width[i]/2. , hd_total_height[i]/2., Flux_thick/2. ],
                      dims_units="cm",
                      material="Vacuum",
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

    return


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

    geo_en = calculate_muon_lite_geometry(geo_en)
    geo_en = calculate_muon_lite_vacuum_box(geo_en)

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
        
