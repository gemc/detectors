//============================================================
// This script prints volumes for PCAL detector
//============================================================
import org.jlab.geom.base.*;
import org.jlab.detector.geant4.v2.*;
import org.jlab.detector.base.DetectorType;
import org.jlab.detector.base.GeometryFactory;

import GeoArgParse
def variation = GeoArgParse.getVariation(args);
def runNumber = GeoArgParse.getRunNumber(args);

ConstantProvider cp = GeometryFactory.getConstants(DetectorType.CTOF,runNumber,variation)

CTOFGeant4Factory factory = new CTOFGeant4Factory();//cp);  // FIXME

def outFile = new File("ctof__volumes_java.txt");
outFile.newWriter().withWriter { w ->
	w<<factory;
}

def dirName = args[args.length-1];
new File(dirName).mkdir();

factory.getComponents().forEach{ volume ->
	if(volume.getType()=="Stl"){
		volume.getPrimitive().toCSG().toStlFile(sprintf("%s/%s.stl", [dirName, volume.getName()]));
	}
}

