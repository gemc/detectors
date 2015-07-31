#!/usr/bin/python
#
import sys
sys.path.append("..")

try:
    import ROOT
except:
    print "It seems you do not have ROOT setup, or PyROOT is not enabled in your ROOT distribution. Sorry."
    sys.exit()

from GeometryROOT import GeometryROOT
from GeometryEngine import Geometry,GeometryEngine
import Write_HPS_ecal

gen= GeometryEngine("hps")
Write_HPS_ecal.calculate_ecal_mother_geometry(gen,mother="root")
Write_HPS_ecal.calculate_ecal_geometry(gen)
Write_HPS_ecal.calculate_ecal_vacuum_geometry(gen,style=0)
Write_HPS_ecal.calculate_ecal_crystalbox_geometry(gen)
Write_HPS_ecal.calculate_ecal_coolingsys_geometry(gen)

rr = GeometryROOT()
rr.Create_root_volume()
rr.Build_volumes(gen)
browse = ROOT.TBrowser()
rr.Draw("ogl")
print "You can now access the geometry through the ROOT browser, and with the 'rr' object."
print "ROOT may cause Python to crash upon exit.... no worries, just annoying"


