import org.jlab.geom.base.*;
import org.jlab.geom.*;
import org.jlab.geom.prim.*;
import org.jlab.clasrec.utils.*;
import org.jlab.clas.physics.*;
import org.jlab.geant.detector.ftof.*;
import org.jlab.geom.geant.*;


ConstantProvider  cp = DataBaseLoader.getConstantsFTOF();
cp.show();

FTOFGeant4Factory  factory = new FTOFGeant4Factory();
List<Geant4Basic>  geom    = factory.createLayer(cp,1);

System.out.println(" width = " + cp.getDouble("/geometry/ftof/panel1a/panel/paddlewidth",0));

System.out.println(geom.size());

for(Geant4Basic p : geom){
   System.out.println(p);
   int[] id         = p.getId();
   double[] params     = p.getParameters();
   double[] position   = p.getPosition();
   double[] rotation   = p.getRotation();
   String order     = p.getRotationOrder();
   System.out.println(p.getName() + " " 
      + id[0] + " " + id[1] + " " + id[2] + " | "
      + p.getType() + " | " 
      + " "); 
}
