#!/usr/bin/python
#
# Author: Maurik Holtrop (UNH)
# Date: February 24, 2014


import sys

#################################################################################################
#
# Geometry engine setup.
#
#################################################################################################
#
# Some globals for convenient unit conversion.
#
cm = 1
mm = 0.1
inch = 2.54*cm


#################################################################################################

import argparse

def main(argv=None):
        ################################################################################################################################
    if argv is None:
        argv = sys.argv
        
    parser = argparse.ArgumentParser(
                description="""Master HPS geometry writer. 
                This code will create TEXT tables for GEMC, or fill MySQL tables for GEMC.
                The options allow you to choose from different geometry combinations, and allow you to choose
                for a single file (MySQL table) or one file (table) per system.""",
                epilog="""For more information, or errors, please email: maurik@physics.unh.edu """)
    parser.add_argument('-n','--name',help='Name of the detector (default=hps)',default="hps")
    parser.add_argument('-v','--variation',help='Variation for the detector (default=depends on other choices!)',default=None)
    parser.add_argument('-i','--identity',type=int,help='Identity or id for the detector variation. Set to -1 to auto-increment. (default=1)',default=1)
    parser.add_argument('-f','--fast',action="store_true",help='Fast variation of beamline, use constant magnetic fields.')
    parser.add_argument('-S','--nofrascati',action="store_true",help='Do not include the Frascati dipole magnets')
    parser.add_argument('-F','--fullmuon',action="store_true",help='Use the Full muon detector instead of the Lite version')
    parser.add_argument('-T','--testmuon',action="store_true",help='Use the Test muon detector instead of the Lite version')
    parser.add_argument('-s','--shift', action="store_true",help='Shift the geometry so that the target is at (0,0,0)')
    parser.add_argument('-a','--align', action="store_true",help='Add in the flux alignment targets.')
    parser.add_argument('-t','--txt',action='store_true',help='Produce a TEXT file for output (default)')
    parser.add_argument('-m','--mysql',action='store_true',help='Produce a MySQL table for output. You must also specify -host -database -user -password')
    parser.add_argument('-H','--host',help='Name of the database host computer',default="localhost")
    parser.add_argument('-D','--database',help='Name of the database',default="hps_2014")
    parser.add_argument('-u','--user',help='User name for the database',default="clasuser")
    parser.add_argument('-p','--passwd',help='Password for connecting to the database',default="")
    parser.add_argument('-M','--multi',action='store_true',help='Create separate tables for each detector component.')

#    parser.add_argument('-t','--table',help='Table name override for storing the MySQL table.',default=None)

    parser.add_argument('-q','--quiet',action="store_true",help='Tries to suppress extra output (depends also on the included Write engines!)')
    parser.add_argument('-d','--debug',action="count",help='Increase debug level by one.')
    args = parser.parse_args(argv[1:])

    if args.debug:
        print "Debug level is: "+str(args.debug)

    if not args.variation:
        if args.fast:
            args.variation="fast"
        else:
            args.variation="original"

        if args.nofrascati:
            args.variation=args.variation+"-short"
        if args.fullmuon:
            args.variation=args.variation+"-full"
        if args.testmuon:
            args.variation=args.variation+"-test"
        if args.shift:
            args.variation=args.variation+"-shift"
    
    if not args.mysql and not args.txt:
        args.txt=True
    elif args.mysql:
        import MySQLdb

    if not args.quiet:
        if args.multi:
            print "Creating multiple tables for the detectors with variation label = "+args.variation + " and id ="+str(args.identity)
        else:
            print "Creating tables for detector name = "+args.name + " with variation label = "+args.variation + " and id ="+str(args.identity)
        
 
    from GeometryEngine import Geometry, GeometryEngine, Sensitive_Detector

    sys.path.append("beamline")
    sys.path.append("ecal") 
    sys.path.append("muon")
    sys.path.append("svt") 

    import Write_HPS_beamline

    if args.shift:
        print "Shifting Geometry."
        Write_HPS_beamline.Alignment_Choice=1

    import Write_HPS_ecal

    import Write_HPS_svt

    if args.fullmuon:
        import Write_HPS_muon
    elif args.testmuon:
        import Write_HPS_muon_side_flux_test
    else:
            import Write_HPS_muon_lite

    gen = []                 
    if args.multi:
        gen.append(GeometryEngine(Write_HPS_beamline.Standard_Table_Name,variation=args.variation,iden=args.identity))
    else:
        gen.append(GeometryEngine(args.name,variation=args.variation,iden=args.identity))
 
    gen[len(gen)-1].debug = args.debug
    Write_HPS_beamline.calculate_dipole_geometry(gen[len(gen)-1])
    if not args.nofrascati:
        Write_HPS_beamline.calculate_frascati_magnets(gen[len(gen)-1])
    if args.align:
        Write_HPS_beamline.calculate_alignment_targets(gen[len(gen)-1])
    Write_HPS_beamline.calculate_ps_vacuum(gen[len(gen)-1])
    if not args.fullmuon:
        Write_HPS_beamline.calculate_muon_lite_vacuum(gen[len(gen)-1])
    
    active=0
    if args.align:
        active=1    
    
    Write_HPS_beamline.calculate_target_geometry(gen[len(gen)-1],radlen=0.125,active=active)
    if args.align:
        Write_HPS_beamline.calculate_alignment_targets(gen[len(gen)-1])
 
    if args.multi:
        gen.append(GeometryEngine(Write_HPS_ecal.Standard_Table_Name,variation=args.variation,iden=args.identity))
        gen[len(gen)-1].debug = args.debug

    Write_HPS_ecal.calculate_ecal_mother_geometry(gen[len(gen)-1])
    Write_HPS_ecal.calculate_ecal_geometry(gen[len(gen)-1])
    Write_HPS_ecal.calculate_ecal_vacuum_geometry(gen[len(gen)-1])
#    Write_HPS_ecal.calculate_ecal_box_geometry(gen[len(gen)-1])
    Write_HPS_ecal.calculate_ecal_crystalbox_geometry(gen[len(gen)-1])
    Write_HPS_ecal.calculate_ecal_coolingsys_geometry(gen[len(gen)-1])

    Write_HPS_svt.calculate_svt_hit_planes(gen[len(gen)-1])

    if args.fullmuon:
        if args.multi:
            gen.append(GeometryEngine(Write_HPS_muon.Standard_Table_Name,variation=args.variation,iden=args.identity))
            gen[len(gen)-1].debug = args.debug

        Write_HPS_muon_lite.calculate_muon_lite_geometry(gen[len(gen)-1])
    elif args.testmuon:
        if args.multi:
            gen.append(GeometryEngine(Write_HPS_muon_side_flux_test.Standard_Table_Name,variation=args.variation,iden=args.identity))
            gen[len(gen)-1].debug = args.debug

        Write_HPS_muon_side_flux_test.calculate_muon_side_test_geometry(gen[len(gen)-1])
    else:
        if args.multi:
            gen.append(GeometryEngine(Write_HPS_muon_lite.Standard_Table_Name,variation=args.variation,iden=args.identity))
            gen[len(gen)-1].debug = args.debug

        Write_HPS_muon_lite.calculate_muon_lite_geometry(gen[len(gen)-1])

    for g in gen:
        if args.mysql:
            if not args.quiet: print "Writing tables to MySQL for "+g._Detector+" with variation="+args.variation
            g.MySQL_OpenDB(args.host,args.user,args.passwd,args.database)
            g.MySQL_Write()

        if args.txt:
            if not args.quiet: print "Writing tables to TEXT for "+g._Detector+" with variation="+args.variation
            g.TXT_Write()




if __name__ == "__main__":
    sys.exit(main())



