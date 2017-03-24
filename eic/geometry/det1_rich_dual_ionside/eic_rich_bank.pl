use strict;
use warnings;

our %configuration;

# Variable Type is two chars.
# The first char:
#  R for raw integrated variables
#  D for dgt integrated variables
#  S for raw step by step variables
#  M for digitized multi-hit variables
#  V for voltage(time) variables
#
# The second char:
# i for integers
# d for doubles

sub define_bank
{
	# uploading the hit definition
	my $bankId = 500;
	my $bankname = "eic_rich";

	insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");

	insert_bank_variable(\%configuration, $bankname, "id",          90, "Di", "Volume ID");
	insert_bank_variable(\%configuration, $bankname, "hitn",        99, "Di", "hit number");
	
	insert_bank_variable(\%configuration, $bankname, "pid",         1, "Di", "Particle ID");
	insert_bank_variable(\%configuration, $bankname, "mpid",        2, "Di", "Mother Particle ID");
	insert_bank_variable(\%configuration, $bankname, "tid",         3, "Di", "track ID");
	insert_bank_variable(\%configuration, $bankname, "mtid",        4, "Di", "mother track ID");
	insert_bank_variable(\%configuration, $bankname, "otid",        5, "Di", "original track id");	
	insert_bank_variable(\%configuration, $bankname, "trackE",      6, "Dd", "totEdep");
	insert_bank_variable(\%configuration, $bankname, "totEdep",     7, "Dd", "Total Energy Deposited");
	insert_bank_variable(\%configuration, $bankname, "avg_x",       8, "Dd", "Average global x position");
	insert_bank_variable(\%configuration, $bankname, "avg_y",       9, "Dd", "Average global y position");
	insert_bank_variable(\%configuration, $bankname, "avg_z",      10, "Dd", "Average global z position");
	insert_bank_variable(\%configuration, $bankname, "avg_lx",     11, "Dd", "Average local  x position");
	insert_bank_variable(\%configuration, $bankname, "avg_ly",     12, "Dd", "Average local  y position");
	insert_bank_variable(\%configuration, $bankname, "avg_lz",     13, "Dd", "Average local  z position");
	insert_bank_variable(\%configuration, $bankname, "px",         14, "Dd", "x component of track momentum");
	insert_bank_variable(\%configuration, $bankname, "py",         15, "Dd", "y component of track momentum");
	insert_bank_variable(\%configuration, $bankname, "pz",         16, "Dd", "z component of track momentum");
	insert_bank_variable(\%configuration, $bankname, "vx",         17, "Dd", "x coordinate of primary vertex");
	insert_bank_variable(\%configuration, $bankname, "vy",         18, "Dd", "y coordinate of primary vertex");
	insert_bank_variable(\%configuration, $bankname, "vz",         19, "Dd", "z coordinate of primary vertex");
	insert_bank_variable(\%configuration, $bankname, "mvx",        20, "Dd", "x coordinate of mother vertex");
	insert_bank_variable(\%configuration, $bankname, "mvy",        21, "Dd", "y coordinate of mother vertex");
	insert_bank_variable(\%configuration, $bankname, "mvz",        22, "Dd", "z coordinate of mother vertex");	
	insert_bank_variable(\%configuration, $bankname, "avg_t",      23, "Dd", "Average t");

	insert_bank_variable(\%configuration, $bankname, "in_px",      24, "Dd", "entrance px");
	insert_bank_variable(\%configuration, $bankname, "in_py",      25, "Dd", "entrance py");
	insert_bank_variable(\%configuration, $bankname, "in_pz",      26, "Dd", "entrance pz");	
	insert_bank_variable(\%configuration, $bankname, "in_x",       27, "Dd", "entrance global x position");
	insert_bank_variable(\%configuration, $bankname, "in_y",       28, "Dd", "entrance global y position");
	insert_bank_variable(\%configuration, $bankname, "in_z",       29, "Dd", "entrance global z position");
	insert_bank_variable(\%configuration, $bankname, "in_t",       30, "Dd", "entrance time");
	insert_bank_variable(\%configuration, $bankname, "out_px",     31, "Dd", "exit px");
	insert_bank_variable(\%configuration, $bankname, "out_py",     32, "Dd", "exit py");
	insert_bank_variable(\%configuration, $bankname, "out_pz",     33, "Dd", "exit pz");	
	insert_bank_variable(\%configuration, $bankname, "out_x",      34, "Dd", "exit global x position");
	insert_bank_variable(\%configuration, $bankname, "out_y",      35, "Dd", "exit global y position");
	insert_bank_variable(\%configuration, $bankname, "out_z",      36, "Dd", "exit global z position");
	insert_bank_variable(\%configuration, $bankname, "out_t",      37, "Dd", "exit time");
	insert_bank_variable(\%configuration, $bankname, "nsteps",     38, "Di", "number of steps");	

}

1;










