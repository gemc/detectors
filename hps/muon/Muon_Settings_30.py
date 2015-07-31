import math
# Version of the muon detector with segmented hodoscopes.
# These are the variables you should adjust to your liking (all in cm or radians):
# (and don't forget to put a . in floating pt vars!!)
# Please also look at the diagram that goes with these

DB_host="localhost"
DB_name="hps_2014"

Table      = "muon_test4"        #name of the table
Vac_Table  = "muon_vacuum_test4"   #name of associated vacuum system table
Flux_Table = "muon_flux4"          #name of table with Flux detectors. Must be same as muon table.

Flux=1    #do you want the flux detectors? (0 or 1)
Flux_thick=.02    #thickness of the flux detectors

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

abs_thickness=    [2.5  for i in range(30) ]  # list of depths of the iron absorbers in cm (these are not half-depths)

abs_total_width=  [109. for i in range(12) ]  # Widths of absorbers.
abs_total_width+= [123. for i in range( 6) ]
abs_total_width+= [136. for i in range( 6) ]
abs_total_width+= [150. for i in range( 6) ]

abs_total_height= [11.  for i in range(12) ]  # Height of absorbers.
abs_total_height+=[12.  for i in range( 6) ]
abs_total_height+=[13.  for i in range( 6) ]
abs_total_height+=[14.  for i in range( 6) ]

#abs_thickness=    [ 30., 15. , 15. , 15. ]  # list of depths of the iron absorbers in cm (these are not half-depths)
#
#abs_total_width=  [109. for i in range(1) ]  # Widths of absorbers.
#abs_total_width+= [123. for i in range(1) ]
#abs_total_width+= [136. for i in range(1) ]
#abs_total_width+= [150. for i in range(1) ]
#
#abs_total_height= [11.  for i in range(1) ]  # Height of absorbers.
#abs_total_height+=[12.  for i in range(1) ]
#abs_total_height+=[13.  for i in range(1) ]
#abs_total_height+=[14.  for i in range(1) ]


######################################
#
#  Hodoscopes
#
######################################
#
# Each layer has two planes of hodoscopes. One in the horizontal, one in the vertical
#
#
hd_total_width =[108.  for i in range(12)]   # Horizontal width of layer
hd_total_width+=[122.  for i in range( 6)]
hd_total_width+=[135.  for i in range( 6)]
hd_total_width+=[148.5 for i in range( 6)]

hd_total_height= [10.5 for i in range(12)]
hd_total_height+=[11.5 for i in range( 6)]
hd_total_height+=[12.5 for i in range( 6)]
hd_total_height+=[13.5 for i in range( 6)]    # Vertical height of layer
#
#hd_total_width =[108.  for i in range(1)]   # Horizontal width of layer
#hd_total_width+=[122.  for i in range(1)]
#hd_total_width+=[135.  for i in range(1)]
#hd_total_width+=[148.5 for i in range(1)]
#
#hd_total_height= [10.5 for i in range(1)]
#hd_total_height+=[11.5 for i in range(1)]
#hd_total_height+=[12.5 for i in range(1)]
#hd_total_height+=[13.5 for i in range(1)]    # Vertical height of layer
#

hd_thickness=1.                            # Thickness of all layers.
hd_spacing_z = 0.1                         # Spacing in the z direction between hodoscopes
hd_spacing_y = 0.01                        # Spacing in the y direction between hodoscopes
hd_spacing_x = 0.01                        # Spacing in the x direction between hodoscopes

hd_spacing_z_outer = 0.2                    # Spacing beteen hodoscopes and absorbers.

#
# The following sets up arrays with the distribution of the paddles.
#
hd_horizontal_heights= [ [3.5,3.5,3.5] for i in range(12) ]
hd_horizontal_heights+=[ [3.5,3.5,4.5] for i in range( 6) ]
hd_horizontal_heights+=[ [3.5,4.5,4.5] for i in range( 6) ]
hd_horizontal_heights+=[ [4.5,4.5,4.5] for i in range( 6) ]
#
#hd_horizontal_heights= [ [3.5,3.5,3.5] for i in range(1) ]
#hd_horizontal_heights+=[ [3.5,3.5,4.5] for i in range(1) ]
#hd_horizontal_heights+=[ [3.5,4.5,4.5] for i in range(1) ]
#hd_horizontal_heights+=[ [4.5,4.5,4.5] for i in range(1) ]

#######################################
#
# Absorbers, derived quantities
#
#######################################

abs_angle_vertical_top = math.atan((front_face_to_target*math.tan(dead_zone_angle)+hd_total_height[0])/front_face_to_target )
# Angle of the top face of the absorbers.
abs_angle_vertical_bot = dead_zone_angle          # Angle of the bottom face of the absorbers.

abs_angle_horizontal  = math.atan( (109./2.)/ front_face_to_target )

abs_gap = 2*hd_thickness + 2*hd_spacing_z_outer + hd_spacing_z

abs_total_depth = sum(abs_thickness) + len(abs_thickness)*abs_gap

#########################################
#
# Parameters for the Muon Mother Volume
#
##########################################

muon_box_depth     = sum(abs_thickness) + len(abs_thickness)*abs_gap # Size of mother volume in z
muon_box_width     = max(abs_total_width) + 1. + muon_box_depth*math.tan(abs_angle_horizontal) # Size of mother volume in x
# Size of mother volume in y
muon_box_height    = (front_face_to_target+muon_box_depth)*math.tan(abs_angle_vertical_top)*2 + 2* max(abs_total_height)
muon_box_center_x = 13.0571  # cm offset to center the MD on the photon line.
muon_box_center_y = 0.
muon_box_center_z = front_face_to_target + muon_box_depth /2.

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
Bump_left_back   = Bump_left_front + (muon_box_depth)*math.tan(math.radians(1.747521))
Bump_right_back  = -40.

Bump_left_angle  = math.atan2(Bump_left_back - Bump_left_front, abs_total_depth - abs_gap)
Bump_right_angle = math.atan2(Bump_right_back- Bump_right_front, abs_total_depth - abs_gap)

Bump_height      =  3.5    # = Thickness of first layer of scintillator.

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
local_z = 0
Bump_left=[]                  # Store the left and right bump x locations for later use (vertical hodoscopes)
Bump_right=[]
hodo_z_location_local=[]      # Store the z locations for positioning the FLUX detectors.

for i in range(len(hd_total_width)):
    local_z += abs_thickness[i] + hd_spacing_z + hd_thickness/2.
    print "Hodo local z location [",i,"] = ",local_z, " golbal = ",front_face_to_target +local_z
    hodo_z_location_local.append(local_z)
    Bump_left.append(Bump_left_front + local_z * math.tan(Bump_left_angle))
    Bump_right.append(Bump_right_front+ local_z * math.tan(Bump_right_angle))
    hd_horizontal_widths+=[
                      [ [w[i]+Bump_right[i], -(Bump_left[i] -Bump_right[i]),w[i]-Bump_left[i]],[w[i],w[i]],[w[i],w[i]] ]]
    local_z += 3*hd_thickness/2. + 2*hd_spacing_z

N=[ int(hd_total_width[i]/4.5 +0.99) for i in range(len(hd_total_width))]  # Fill N with the number of 4.5 wide paddles.

hd_vert_widths=[
                [4.5 for x in range(N[y])] for y in range(len(hd_total_width)) # Distribute the paddles in an array
                ]

hd_vert_heights=[
                 [hd_total_height[y]] for y in range(len(hd_total_height))  # Distribute the paddles in an array
                 ]

###################################################################
#
# Extra Parameters for the Vacuum Box.
#
###################################################################
# Parameters estimated from the end of the ECAL vacuum box.
#

plate_depth = muon_box_depth;

x_offset_wrt_MD  = 0 # 8.8485-13.0571        # Puts this back after moving MD by 130.571.
y_spacing_plates = 0.05
x_spacing_plates = 0.05

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

block_left_front = plate1_left_edge_front - support_block_width/2.  - x_spacing_plates
block_left_rear  = plate1_left_edge_rear  - support_block_width/2.  - x_spacing_plates
block_left_center = (block_left_front + block_left_rear)/2.
block_left_skew  = math.atan2( (block_left_rear - block_left_front),plate_depth)

block_left_front_dy  = front_face_to_target*math.tan(dead_zone_angle) + Bump_height - plate_thickness - y_spacing_plates
block_left_rear_dy   = (front_face_to_target+ plate_depth )*math.tan(dead_zone_angle) + Bump_height - plate_thickness - y_spacing_plates

block_middle_front = plate1_right_edge_front + support_block_width/2.  + x_spacing_plates
block_middle_rear  = plate1_right_edge_rear  + support_block_width/2.  + x_spacing_plates
block_middle_center = (block_middle_front + block_middle_rear)/2.
block_middle_skew  = math.atan2( (block_middle_rear - block_middle_front),plate_depth)

block_middle_angle_x = dead_zone_angle

block_middle_front_dy  = Bump_height - plate_thickness - y_spacing_plates
block_middle_rear_dy   = Bump_height - plate_thickness - y_spacing_plates

block_middle_ypos    = (front_face_to_target + plate_depth/2.)*math.tan(dead_zone_angle) + block_middle_front_dy/2.

block_right_front = plate2_right_edge_front + support_block_width/2.
block_right_rear  = plate2_right_edge_rear  + support_block_width/2.
block_right_center= (block_right_front + block_right_rear)/2.
block_right_skew  = math.atan2( (block_right_rear - block_right_front),plate_depth)

block_right_front_dy  = front_face_to_target*math.tan(dead_zone_angle) - plate_thickness - y_spacing_plates
block_right_rear_dy   = (front_face_to_target+plate_depth)*math.tan(dead_zone_angle) - plate_thickness - y_spacing_plates


