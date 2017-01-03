//============================================================
// This script prints volumes for PCAL detector
//============================================================
import org.jlab.geom.base.*;
import org.jlab.detector.geant4.v2.*;

CTOFGeant4Factory factory = new CTOFGeant4Factory();

def outFile = new File("ctof__volumes_java.txt");
outFile.newWriter().withWriter { w ->
	w<<factory;
}

def dirName = args[0];
new File(dirName).mkdir();

factory.getComponents().forEach{ volume ->
	if(volume.getType()=="Stl"){
		volume.getPrimitive().toCSG().toStlFile(sprintf("%s/%s.stl", [dirName, volume.getName()]));
	}
}

