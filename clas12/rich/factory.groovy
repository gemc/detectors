//============================================================
// This script prints volumes for RICH detector
//============================================================
import org.jlab.geom.base.*;
import org.jlab.detector.geant4.v2.RICHGeant4Factory;
import java.nio.file.Files;

RICHGeant4Factory factory = new RICHGeant4Factory();


//def sector = args[1];

def variation = args[0];

def name = sprintf("rich__volumes_%s.txt", [variation]);
System.out.print("making volumes and copying stls, variation: ");
System.out.println(variation);

def outFile = new File(name);
outFile.newWriter().withWriter { w ->
        		w<<factory;
			}				       

def dirName = sprintf("cad_%s",[variation]);
new File(dirName).mkdir();

factory.getAllVolumes().forEach{ volume ->
	if(volume.getType()=="Stl"){
		if(volume.getName() == "RICH_s4"){
			System.out.println("Skipping download of mother volume stl file (temporary)");
			//if(variation == "default" || variation == "rgc_summer2022"){
			//	volume.getPrimitive().copyToStlFile(sprintf("%s/%s.stl", [dirName, "RICH"+"_s1"]));
			//	volume.getPrimitive().copyToStlFile(sprintf("%s/%s.stl", [dirName, "RICH"+"_s4"]));	             
			//}
			//else if(variation == "rga_fall2018"){
			//	volume.getPrimitive().copyToStlFile(sprintf("%s/%s.stl", [dirName, "RICH"+"_s4"]));	             
			//}
		}
		else{
			if(variation == "default" || variation == "rgc_summer2022"){
				volume.getPrimitive().copyToStlFile(sprintf("%s/%s.stl", [dirName, volume.getName()+"_s1"]));
				volume.getPrimitive().copyToStlFile(sprintf("%s/%s.stl", [dirName, volume.getName()+"_s4"]));
			}
			else if(variation == "rga_fall2018"){
				volume.getPrimitive().copyToStlFile(sprintf("%s/%s.stl", [dirName, volume.getName()+"_s4"]));
			}
		}
	}
}
