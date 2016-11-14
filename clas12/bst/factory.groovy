
//============================================================
// This script prints volumes for SVT detector
//============================================================
import org.jlab.geom.base.*;
import org.jlab.clasrec.utils.*;
import org.jlab.detector.geant4.*;

// coatjava-2.4
//import org.jlab.clasrec.utils.DatabaseConstantProvider;

// custom
//import SVTFactory.SVTConstants;
//import SVTFactory.SVTVolumeFactory;
//import Misc.Util;

// coatjava-3.0
import org.jlab.detector.calib.utils.DatabaseConstantProvider;
// JCSG
//import org.jlab.detector.geant4.v2.SVT.*;

//println "classpath dump:"
//this.class.classLoader.rootLoader.URLs.each{ println it }
//System.exit(0);

SVTConstants.VERBOSE = true;
DatabaseConstantProvider cp = SVTConstants.connect( false );

SVTVolumeFactory factory = new SVTVolumeFactory( cp, false ); // ideal geometry
//SVTConstants.loadAlignmentShifts("shifts_test.dat"); // load alignment shifts from file
//factory.setApplyAlignmentShifts( true ); // shifted geometry

factory.BUILDSENSORS = true; // include physical sensors (aka cards)
factory.makeVolumes();

Util.scaleDimensions( factory.getMotherVolume(), 0.5 ); // geant wants half-dimensions

def outFile = new File("bst__volumes_java.txt");
outFile.newWriter().withWriter{ w -> w << factory; }

factory.putParameters();

def axisName = ["x", "y", "z"];
def parFile = new File("bst__parameters_java.txt");
def writer=parFile.newWriter();

for( Map.Entry< String, String > entry : factory.getParameters().entrySet() )
{
  String key, value, unit;

  key = entry.getKey();
  value = entry.getValue();
  unit = "na";

  def notna = true;
  
  switch( key[0] )
  {
  case "n":
  case "b":
    notna = false;
  }

  if( notna )
  {
    switch( key )
    {
    //case "sector0":
    //case "phiStart":
      //unit = factory.getProperty("unit_angle");
      //break;
    default:
      unit = factory.getProperty("unit_length");
    }
  }
  
  writer << sprintf("%s | %s | %s | %s | %s | %s\n",
        key,
        value,
        unit,
        factory.getProperty("author"),
        factory.getProperty("email"),
        factory.getProperty("date")
        );
}

writer.close();
