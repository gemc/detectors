//============================================================
// This script prints volumes for ATOF detector
//============================================================
import org.jlab.geom.base.*;
import org.jlab.clasrec.utils.*;
import org.jlab.geom.detector.alert.ATOF.*;
import org.jlab.detector.units.SystemOfUnits.Length;
import org.jlab.detector.base.DetectorType;
import org.jlab.detector.base.GeometryFactory;
import org.jlab.detector.calib.utils.DatabaseConstantProvider;
import org.jlab.geom.prim.Point3D;

import GeoArgParse
def variation = GeoArgParse.getVariation(args);
def runNumber = GeoArgParse.getRunNumber(args);

// not really used at the moment
DatabaseConstantProvider cp = new DatabaseConstantProvider(runNumber, variation);
//provider.loadTable("/geometry/cnd/cndgeom");
//ConstantProvider cp = GeometryFactory.getConstants(DetectorType.FTOF, runNumber, variation);

//MYFactory_ATOF factory = new MYFactory_ATOF();
AlertTOFFactory factory = new AlertTOFFactory();
Detector atof = factory.createDetectorCLAS(cp);

def parFile = new File("atof__parameters_"+variation+".txt");
def writer1=parFile.newWriter();

def outFile = new File("atof__volumes_"+variation+".txt");
def writer2=outFile.newWriter();

// dump the geometry in GEMC format
// may want to add mother volume
int nsectors = atof.getNumSectors();


//double ATOF_Z_length = 279.7; // mm, atof paddles total lenght in z

for(int isec=0; isec<nsectors; isec++) 
{
	int nsuperlayers = atof.getSector(isec).getNumSuperlayers();
	for(int isl=0; isl<nsuperlayers; isl++) 
	{
		int nlayers = atof.getSector(isec).getSuperlayer(isl).getNumLayers();
		for(int ilay=0; ilay<nlayers; ilay++) 
		{
			int ncomponents = atof.getSector(isec).getSuperlayer(isl).getLayer(ilay).getNumComponents();
			//if(isec==0 && isl==0 && ilay==0) writer1 << "ahdc.layer.ncomponents | " << ncomponents << "\n"; 
			if(ncomponents!=0) 
			{
				writer1 << "atof.sector" << isec << ".superlayer"<< isl << ".layer"<< ilay <<".ncomponents | " << ncomponents << "| na | number of counters in module | sergeyeva | sergeyeva@ipno.in2p3.fr | none | none | 15 June 2020 \n";

				for(int icomp=isec*4; icomp<isec*4+ncomponents; icomp++) 
				{
					Component comp = atof.getSector(isec).getSuperlayer(isl).getLayer(ilay).getComponent(icomp);
					writer2<< gemcString(isec, isl, ilay, comp);
				}
			}
		}
	} 	
}



writer1.close();
writer2.close();

// need to be updated with correct format for trapezoide
public String gemcString(int sector, int superlayer,int layer, Component comp) {
        StringBuilder str = new StringBuilder();
	/*
	for (int ip = 0; ip < comp.getNumVolumePoints(); ip++) {
	    Point3D p = comp.getVolumePoint(ip);
            str.append(String.format("%14.6f*cm | %14.6f*cm | %14.6f*cm ||", p.x(), p.y(), p.z())); 
        }
	*/
	// reading top face vertices of ATOF cell and storing their x,y coordinates
	Point3D p0 = comp.getVolumePoint(0);
	double top_x_0 = p0.x();
	double top_y_0 = p0.y();
	Point3D p1 = comp.getVolumePoint(1);
	double top_x_1 = p1.x();
	double top_y_1 = p1.y();
	Point3D p2 = comp.getVolumePoint(2);
	double top_x_2 = p2.x();
	double top_y_2 = p2.y();
	Point3D p3 = comp.getVolumePoint(3);
	double top_x_3 = p3.x();
	double top_y_3 = p3.y();
	// reading bottom face vertices of ATOF cell and storing their x,y coordinates
	Point3D p4 = comp.getVolumePoint(4);
	double bottom_x_4 = p4.x();
	double bottom_y_4 = p4.y();
	Point3D p5 = comp.getVolumePoint(5);
	double bottom_x_5 = p5.x();
	double bottom_y_5 = p5.y();
	Point3D p6 = comp.getVolumePoint(6);
	double bottom_x_6 = p6.x();
	double bottom_y_6 = p6.y();
	Point3D p7 = comp.getVolumePoint(7);
	double bottom_x_7 = p7.x();
	double bottom_y_7 = p7.y();

		// component name should be added
        	str.append(String.format("sector%d_superlayer%d_layer%d_paddle%d | root", sector, superlayer, layer, (comp.getComponentId()+1)));
		
		// Giving the origin point of coordinate system in which the trapezoide vertices are defined
		//str.append(String.format("| %8.4f*mm %8.4f*mm %8.4f*mm | ", 0.0, 0.0, ((comp.getLine().midpoint().z()-15.0)-150.0+15.0))); // in mm
		
		if(superlayer == 0)
		{
			str.append(String.format("| %8.4f*mm %8.4f*mm %8.4f*mm | ", 0.0, 0.0, ((comp.getLine().midpoint().z() - 279.7/2)))); // in mm
		}
		if(superlayer == 1)
		{
			str.append(String.format("| %8.4f*mm %8.4f*mm %8.4f*mm | ", 0.0, 0.0, ((comp.getLine().midpoint().z() - 279.7/2)))); // in mm
		}

		// these should be the rotation angles 	
        	double[] rotate = [0, 0, 0];
        	for (int irot = 0; irot < rotate.length; irot++)
		{
           		str.append(String.format(" %8.4f*deg ", Math.toDegrees(rotate[rotate.length - irot - 1])));
       		}

		// geant4 volume type
		String type = "G4GenericTrap"
        	str.append(String.format("| %8s |", type));
		// to add the half-length in Z axis, coatjava class dimensions are in mm!
		if(superlayer == 0)
		{
			str.append(String.format(" %8.4f*mm ", 279.7/2.0));	
		}
		if(superlayer == 1)
		{
			str.append(String.format(" %8.4f*mm ", 27.7/2.0));	
		}

		// need to be corrected according to geant4 volume definition 
		
			str.append(String.format("%14.6f*mm %14.6f*mm ", top_x_0, top_y_0));
			str.append(String.format("%14.6f*mm %14.6f*mm ", top_x_1, top_y_1));
			str.append(String.format("%14.6f*mm %14.6f*mm ", top_x_2, top_y_2));
			str.append(String.format("%14.6f*mm %14.6f*mm ", top_x_3, top_y_3));
		
			str.append(String.format("%14.6f*mm %14.6f*mm ", bottom_x_4, bottom_y_4));
			str.append(String.format("%14.6f*mm %14.6f*mm ", bottom_x_5, bottom_y_5));
			str.append(String.format("%14.6f*mm %14.6f*mm ", bottom_x_6, bottom_y_6));
			str.append(String.format("%14.6f*mm %14.6f*mm ", bottom_x_7, bottom_y_7));
	
		// currently only writing the component id but should save all necessary identifiers according to detector definition
        	str.append(" | ");
        	str.append(String.format("%d %d %d %d", sector, superlayer, layer, (comp.getComponentId()+1)));

		str.append("\n");
        
        return str.toString();
}
