//============================================================
// This script prints volumes for FTOF detector
//============================================================
import org.jlab.geom.base.*;
import org.jlab.clasrec.utils.*;
import org.jlab.detector.geant4.*;

ConstantProvider  cp = DataBaseLoader.getConstantsFTOF();
//cp.show();

FTOFGeant4Factory  factory = new FTOFGeant4Factory(cp);

def outFile = new File("ftof__volumes_original.txt");
outFile << factory;

