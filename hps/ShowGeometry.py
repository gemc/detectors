#!/usr/bin/python
#
import sys
sys.path.append("beamline")
sys.path.append("ecal")
sys.path.append("muon")

try:
    import ROOT
except:
    print "It seems you do not have ROOT setup, or PyROOT is not enabled in your ROOT distribution. Sorry."
    sys.exit()

from GeometryROOT import GeometryROOT
from GeometryEngine import Geometry,GeometryEngine
import Write_HPS_beamline
import Write_HPS_ecal
import Write_HPS_muon_lite

gen= GeometryEngine("hps")
# gen.TXT_Read_Geometry("beamline__geometry_original.txt")
Write_HPS_beamline.calculate_dipole_geometry(gen)
Write_HPS_beamline.calculate_frascati_magnets(gen)
Write_HPS_beamline.calculate_ps_vacuum(gen)
Write_HPS_beamline.calculate_target_geometry(gen,radlen=0.125,active=1)
Write_HPS_beamline.calculate_muon_lite_vacuum(gen)
#Write_HPS_beamline.calculate_alignment_targets(gen)
Write_HPS_ecal.calculate_ecal_mother_geometry(gen)
Write_HPS_ecal.calculate_ecal_geometry(gen)
Write_HPS_ecal.calculate_ecal_vacuum_geometry(gen)
Write_HPS_ecal.calculate_ecal_crystalbox_geometry(gen)
Write_HPS_ecal.calculate_ecal_coolingsys_geometry(gen)

# Write_HPS_ecal.calculate_ecal_box_geometry(gen)
# Write_HPS_muon_lite.calculate_muon_lite_geometry(gen)

rr = GeometryROOT()
rr.Create_root_volume()
rr.Build_volumes(gen)
browse = ROOT.TBrowser()
rr.Draw("ogl")
print "You can now access the geometry through the ROOT browser, and with the 'rr' object."
print "ROOT may cause Python to crash upon exit.... no worries, just annoying"


