
//============================================================
// This script prints volumes for SVT detector
//============================================================
import org.jlab.geom.base.*;
import org.jlab.clasrec.utils.*;
import org.jlab.detector.geant4.*;

//import java.util.Map;
//import java.util.HashMap;
//import java.util.LinkedHashMap;

import SVTFactory.SVTGeant4Factory;

// todo: add getConstantsSVT() to DataBaseLoader
//ConstantProvider cp = DataBaseLoader.getConstantsSVT();

// load the CCDB tables manually for now
DatabaseConstantProvider cp = new DatabaseConstantProvider( 10, "default");
cp.loadTable( SVTGeant4Factory.getCcdbPath() +"svt");
cp.loadTable( SVTGeant4Factory.getCcdbPath() +"region");
cp.loadTable( SVTGeant4Factory.getCcdbPath() +"fiducial");
cp.loadTable( SVTGeant4Factory.getCcdbPath() +"alignment");
cp.loadTable( SVTGeant4Factory.getCcdbPath() +"material");
//cp.show();
//println cp.toString();

SVTGeant4Factory factory = new SVTGeant4Factory( cp );
factory.makeVolumes();

def outFile = new File("bst__volumes_java.txt");
outFile.newWriter().withWriter { w ->
	w<<factory;
}

factory.putParameters();

def axisName = ["x", "y", "z"];
def parFile = new File("bst__parameters_java.txt");
def writer=parFile.newWriter();

for( Map.Entry< String, String > entry : factory.getParameters().entrySet() ){
  writer << sprintf("%s | %s | %s | %s | %s\n",
  entry.getKey(),
  entry.getValue(),
  factory.getProperty("author"),
  factory.getProperty("email"),
  factory.getProperty("date")
  );
}

writer.close();
