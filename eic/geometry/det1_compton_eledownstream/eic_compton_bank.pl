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
    my $bankId = 2002;
    my $bankname = "eic_compton";
    
    insert_bank_variable(\%configuration, $bankname, "bankid", $bankId, "Di", "$bankname bank ID");
    insert_bank_variable(\%configuration, $bankname, "hitn",   99,   "Di", "Hit Number");
    
    insert_bank_variable(\%configuration, $bankname, "pid",     1,   "Di", "ID of the first particle entering the sensitive volume");
    insert_bank_variable(\%configuration, $bankname, "mpid",    2,   "Di", "ID of the mother of the first particle entering the sensitive volume");
    insert_bank_variable(\%configuration, $bankname, "tid",     3,   "Di", "Track ID of the first particle entering the sensitive volume");
    insert_bank_variable(\%configuration, $bankname, "mtid",    4,   "Di", "Track ID of the mother of the first particle entering the sensitive volume");
    insert_bank_variable(\%configuration, $bankname, "otid",    5,   "Di", "Track ID of the original track that generated the first particle entering the sensitive volume");
    insert_bank_variable(\%configuration, $bankname, "trackE",  6,   "Dd", "Energy of the track");
    insert_bank_variable(\%configuration, $bankname, "totEdep", 7,   "Dd", "Total Energy Deposited");
    insert_bank_variable(\%configuration, $bankname, "avg_x",   8,   "Dd", "Average X position in global reference system");
    insert_bank_variable(\%configuration, $bankname, "avg_y",   9,   "Dd", "Average Y position in global reference system");
    insert_bank_variable(\%configuration, $bankname, "avg_z",  10,   "Dd", "Average Z position in global reference system");
    insert_bank_variable(\%configuration, $bankname, "avg_lx", 11,   "Dd", "Average X position in local reference system");
    insert_bank_variable(\%configuration, $bankname, "avg_ly", 12,   "Dd", "Average Y position in local reference system");
    insert_bank_variable(\%configuration, $bankname, "avg_lz", 13,   "Dd", "Average Z position in local reference system");
    insert_bank_variable(\%configuration, $bankname, "px",     14,   "Dd", "x component of momentum of the particle entering the sensitive volume");
    insert_bank_variable(\%configuration, $bankname, "py",     15,   "Dd", "y component of momentum of the particle entering the sensitive volume");
    insert_bank_variable(\%configuration, $bankname, "pz",     16,   "Dd", "z component of momentum of the particle entering the sensitive volume");
    insert_bank_variable(\%configuration, $bankname, "vx",     17,   "Dd", "x component of primary vertex of the particle entering the sensitive volume");
    insert_bank_variable(\%configuration, $bankname, "vy",     18,   "Dd", "y component of primary vertex of the particle entering the sensitive volume");
    insert_bank_variable(\%configuration, $bankname, "vz",     19,   "Dd", "z component of primary vertex of the particle entering the sensitive volume");
    insert_bank_variable(\%configuration, $bankname, "mvx",    20,   "Dd", "x component of primary vertex of the mother of the particle entering the sensitive volume");
    insert_bank_variable(\%configuration, $bankname, "mvy",    21,   "Dd", "y component of primary vertex of the mother of the particle entering the sensitive volume");
    insert_bank_variable(\%configuration, $bankname, "mvz",    22,   "Dd", "z component of primary vertex of the mother of the particle entering the sensitive volume");
    insert_bank_variable(\%configuration, $bankname, "avg_t",  23,   "Dd", "Average time");
    insert_bank_variable(\%configuration, $bankname, "id",     24,   "Di", "id number");

}
define_bank();

