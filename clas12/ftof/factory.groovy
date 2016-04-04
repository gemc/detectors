//============================================================
// This script prints volumes for FTOF detector
//============================================================
import org.jlab.geom.base.*;
import org.jlab.clasrec.utils.*;
import org.jlab.detector.geant4.*;

ConstantProvider  cp = DataBaseLoader.getConstantsFTOF();
//cp.show();

FTOFGeant4Factory factory = new FTOFGeant4Factory(cp);

def outFile = new File("ftof__volumes_original.txt");
outFile.newWriter().withWriter { w ->
	w<<factory;
}

def axisName = ["x", "y", "z"];
def parFile = new File("ftof__volpars_original.txt");
def writer=parFile.newWriter();

//loop over panel volumes
for(panels in factory.getMother().getChildren()){

	for(int idim = 0; idim < panels.getParameters().length; idim++){
		writer<<sprintf("%s | %.3f | %s | %s | %s | %s | %s | %s | %s\n",
			panels.getName()+".dimension"+idim,			//dimension0, 1, 2, 3 etc.
			panels.getParameters()[idim],					//parameter value
			panels.getUnits(),							//units
			"dimension " + idim,						//description of parameter (dimension)
			factory.getProperty("author"),				//author names
			factory.getProperty("email"),					//emails
			factory.getProperty("something"),				//some information
			factory.getProperty("something"),				//some information
			factory.getProperty("date")					//date
		);
	}

	//loop over axes for position X, Y, Z print
	for(int iaxis=0; iaxis<3; iaxis++){
		writer<<sprintf("%s | %.3f | %s | %s | %s | %s | %s | %s | %s\n",
			panels.getName()+".position"+axisName[iaxis],	//name of volume+position+axisname
			panels.getPosition()[iaxis],					//parameter value
			panels.getUnits(),							//units
			"position along " + axisName[iaxis] + " axis",	//description of parameter (position)
			factory.getProperty("author"),				//author names
			factory.getProperty("email"),					//emails
			factory.getProperty("something"),				//some information
			factory.getProperty("something"),				//some information
			factory.getProperty("date")					//date
		);
	}

	//print rotation sequence: e.g., zxy
	writer<<sprintf("%s | %s | %s | %s | %s | %s | %s | %s | %s\n",
		panels.getName()+".rotationSequence",	//name of parameter
		panels.getRotationOrder(),					//parameter value
		"none",									//no units needed for rotation sequence
		"rotation sequence",						//description of parameter (rotation sequence)
		factory.getProperty("author"),				//author names
		factory.getProperty("email"),					//emails
		factory.getProperty("something"),				//some information
		factory.getProperty("something"),				//some information
		factory.getProperty("date")					//date
	);

	//print rotation for each axis
	for(int iaxis=0; iaxis<3; iaxis++){
		axisLabel = panels.getRotationOrder().charAt(iaxis);	//axis label taken from sequence

		writer<<sprintf("%s | %.3f | %s | %s | %s | %s | %s | %s | %s\n",
			panels.getName()+".rotation"+axisLabel,			//name of volume+rotation+axisname
			panels.getRotation()[iaxis],					//parameter value
			"rad",									//units
			"rotation along " + axisLabel + " axis",		//description of parameter (rotation)
			factory.getProperty("author"),				//author names
			factory.getProperty("email"),					//emails
			factory.getProperty("something"),				//some information
			factory.getProperty("something"),				//some information
			factory.getProperty("date")					//date
		);
	}
}

writer.close();
