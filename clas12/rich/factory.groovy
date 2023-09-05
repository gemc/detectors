//============================================================
// This script prints volumes for RICH detector
//============================================================
import org.jlab.geom.base.*;
import org.jlab.detector.geant4.v2.RICHGeant4Factory;


RICHGeant4Factory factory = new RICHGeant4Factory();


def sector = args[1];

def name = "rich__volumes.txt"
println(sector)
if(sector=='4'){
	name = "rich__volumes_sector4.txt";
}
else{
    name = "rich__volumes_sector4and1.txt";
}


def outFile = new File(name);
outFile.newWriter().withWriter { w ->
        		w<<factory;
			}				       



def dirName = args[0];
new File(dirName).mkdir();

factory.getAllVolumes().forEach{ volume ->
	if(volume.getType()=="Stl"){
		if(volume.getName() == "RICH_s4"){
		        volume.getPrimitive().copyToStlFile(sprintf("%s/%s.stl", [dirName, "RICH"+"_s"+sector]));
		}
		else{
			volume.getPrimitive().copyToStlFile(sprintf("%s/%s.stl", [dirName, volume.getName()+"_s"+sector]));

		}
	}
}
