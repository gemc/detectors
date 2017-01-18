//============================================================
// This script prints volumes for PCAL detector
//============================================================
import org.jlab.geom.base.*;
import org.jlab.clasrec.utils.*;
import org.jlab.detector.geant4.v2.*;
import org.jlab.detector.base.DetectorType;
import org.jlab.detector.base.GeometryFactory;

ConstantProvider cp = GeometryFactory.getConstants(DetectorType.EC)

PCALGeant4Factory factory = new PCALGeant4Factory(cp);

def outFile = new File("pcal__volumes_java.txt");
outFile.newWriter().withWriter { w ->
	w<<factory;
}

