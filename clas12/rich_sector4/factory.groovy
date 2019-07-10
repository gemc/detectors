//============================================================
// This script prints volumes for RICH detector
//============================================================
import org.jlab.geom.base.*;
import org.jlab.detector.geant4.v2.RICHGeant4Factory;


RICHGeant4Factory factory = new RICHGeant4Factory();

def outFile = new File("rich__volumes_java.txt");
outFile.newWriter().withWriter { w ->
	w<<factory;
}

def dirName = args[0];
new File(dirName).mkdir();

factory.getAllVolumes().forEach{ volume ->
	if(volume.getType()=="Stl"){
		volume.getPrimitive().copyToStlFile(sprintf("%s/%s.stl", [dirName, volume.getName()]));
	}
}
