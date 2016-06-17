//============================================================
// This script prints volumes for FTOF detector
//============================================================
import org.jlab.geom.base.*;
import org.jlab.clasrec.utils.*;
import org.jlab.detector.geant4.*;

ConstantProvider  cp = DataBaseLoader.getConstantsDC(0, "");
//cp.show();

DCGeant4Factory factory = new DCGeant4Factory(cp);

def outFile = new File("dc__volumes_java.txt");
outFile.newWriter().withWriter { w ->
	w<<factory;
}

