#!/usr/bin/python
#
# Fixes some of the GDML that GeomConverter cannot deal with.
#







if __name__ == "__main__":
    
    import sys
    import re

    if len(sys.argv) < 2:
        print "Please supply the file."
        sys.exit()

    try:
        f = open(sys.argv[1])
    except:
        print "Error opening file."
        sys.exit()

    fo = open("fixed_"+sys.argv[1],"w")

    line = f.readline()

    solids_section=0
    structure_section=0

    while line:
        write=1

        if re.search("<MEE .*/>",line):    # Scrub the <MEE /> tags in the materials section.
            write=0

        if re.search("<solids>",line):    # Find <solid> section
            solids_section=1
            print "Solids on"

        if re.search("</solids>",line):    # Find <solid> section
            solids_section=0
            print "Solids off"

        if re.search("<structure>",line):    # Find <solid> section
            structure_section=1
            print "Structure on"

        if re.search("</structure",line):    # Find <solid> section
            structure_section=0
            print "Structure off"

        if structure_section:
            if  re.match(r'.*<volume name="ECAL">',line):
                line = re.sub(r'<volume name="ECAL">',r'<volume name="world_volume">',line)
            else:
                line = re.sub(r'<volume *name="([^"]*)">',r'<volume name="V_\1">',line)  # Fixup volume names.

            line = re.sub(r'<volumeref *ref="([^"]*)"/>',r'<volumeref ref="V_\1"/>',line)  # Fixup references to volume names.
            line = re.sub(r'<position *name="([^"]*)"([^/>]*)/>',r'<position name="V_\1"\2/>',line)  # Fixup references to volume names.
            line = re.sub(r'<physvol *name=.*>',r'<physvol>',line)

        line= re.sub(r'<world ref="ECAL"/>',r'<world ref="world_volume"/>',line)


        if write:
            fo.write(line)
    
        
        
        line = f.readline()
