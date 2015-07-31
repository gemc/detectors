import sys
sys.path.append("ecal")  # So that Python can find the ECAL geometries.
from GeometryEngine import GeometryEngine, Geometry, Sensitive_Detector
import ROOT
from GeometryROOT import GeometryROOT
import Write_HPS_ecal          # import and create the ECAL geometry

geo = GeometryEngine("ecal")   # Fire up the GeometryEngine.

Write_HPS_ecal.calculate_ecal_mother_geometry(geo,mother="root")
Write_HPS_ecal.calculate_ecal_box_geometry(geo)
Write_HPS_ecal.calculate_ecal_geometry(geo)
Write_HPS_ecal.calculate_ecal_vacuum_geometry(geo)

rr = GeometryROOT()            # Startup the ROOT Renderer.
rr.debug=2                    # Show each volume as it is created. Useful for debugging.
rr.Create_root_volume()        # Create the "root" volume, or the Hall. This is invisible.
rr.Build_volumes(geo)          # Build the "geo" of the ECAL
                               # You can add additional "geo"s by calling this again.

browse=ROOT.TBrowser()   # The browser will show a table of the geometries under "GEMC"

rr.Draw("ogl")           # Draw the whole thing using OpenGL (leave out option to draw wireframe)

print "Warning: ROOT will cause a crash when you exit. Blame the ROOT team. "

