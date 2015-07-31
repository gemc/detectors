import math
from GeometryEngine import GeometryEngine, Geometry

# Version of the muon detector with segmented hodoscopes.
# These are the variables you should adjust to your liking (all in cm or radians):
# (and don't forget to put a . in floating pt vars!!)
# Please also look at the diagram that goes with these

#DB_host="improv.unh.edu"

Detector      = "hps_muon"          #name of the detector (table)

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

print "abs_angle_vertical_top = ",abs_angle_vertical_top
print "abs_angle_horizontal   = ",abs_angle_horizontal

#########################################
#
# Parameters for the Muon Mother Volume
#
##########################################
vacuum_plate_depth = sum(abs_thickness) + len(abs_thickness)*abs_gap
print "vacuum_plate_depth = ",vacuum_plate_depth
muon_box_depth     =  vacuum_plate_depth + 0.1  # Size of mother volume in z
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
Bump_left_angle  = math.radians(1.747521)
Bump_left_back   = Bump_left_front + (vacuum_plate_depth)*math.tan(Bump_left_angle)
Bump_right_back  = -40.
Bump_right_angle = math.atan2(Bump_right_back- Bump_right_front, vacuum_plate_depth)
Bump_height      =  3.5    # = Thickness of first layer of scintillator.

print "Bump_left_front = ", Bump_left_front
print "Bump_right_front= ", Bump_right_front
print "Bump_left_angle = ", Bump_left_angle
print "Bump_left_back  = ", Bump_left_back
print "Bump_right_back = ", Bump_right_back
print "Bump_right_angle= ", Bump_right_angle
print "Bump_height     = ", Bump_height

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
    print "Hodo local z location [",i,"] = ",local_z, " global = ",front_face_to_target +local_z
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
    print "Bump_left - Bump_right =",(Bump_left[i] -Bump_right[i])
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

    print "Segment width= ",str(Segment_width),"  N_seg=",N_seg,"   Sum width=",str(sum(tmp_row))," Sum width total",str(sum_width_total)
    print "N_split_paddles=",str(N_split_paddles),"  ", tmp_row
    print ""
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


if __name__ == "__main__":
################################################################################################################################
    print "Run this from the Write_HPS_muon.py script."
