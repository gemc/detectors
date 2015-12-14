/// \file HitProcess.h
/// Defines the Process Hit Base Class.\n
/// It contains the factory method HitProcess_Factory
/// that returns a pointer to a HitProcess.\n
/// There are two methods that returns geant4 raw information / step, and integrated over all steps:
/// - integrateRaw: returns geant4 raw information integrated over the hit
/// - allRaws: returns all geant4 raw information step by step\n\n
///
/// There are three pure virtual methods to treat the hit:
/// - integrateDgt: returns digitized information integrated over the hit
/// - signalVT: returns a V(t) function
/// - multiDgt: returns multiple digitized information / hit
///
/// The pure virtual method processID returns a (new) identifier
/// containing hit sharing information
///
/// \author \n Maurizio Ungaro
/// \author mail: ungaro@jlab.org\n\n\n
#ifndef HIT_PROCESS_H
#define HIT_PROCESS_H 1

// gemc headers
#include "detector.h"
#include "Hit.h"
#include "outputFactory.h"
#include "options.h"



/// \class trueInfos
/// <b> trueInfos </b>\n\n
/// This trueInfos is istantiated by the hit Process routine to retrieve the trye information.\n
class trueInfos
{
	public:
		trueInfos(MHit*);
		~trueInfos(){;}
	
		unsigned int nsteps;
		double eTot;
		double x, y, z;
		double lx, ly, lz;
		double time;
};



/// \class HitProcess
/// <b> HitProcess </b>\n\n
/// This HitProcess is istantiated by the factory method HitProcess_Factory.\n
/// HitProcess is registered in a map<string, HitProcess>, with key referred by the detector hitType.\n
/// There are two methods that returns geant4 raw information / step, and integrated over all steps:
/// - integrateRaw: returns geant4 raw information integrated over the hit
/// - allRaws: returns all geant4 raw information step by step\n\n
///
/// There are three pure virtual methods to treat the hit:
/// - integrateDgt: returns digitized information integrated over the hit
/// - signalVT: returns a V(t) function
/// - multiDgt: returns multiple digitized information / hit
///
/// The pure virtual method processID returns a (new) identifier
/// containing hit sharing information
///
class HitProcess
{
	public:
		virtual ~HitProcess(){;}
		void init(string name, goptions go,map<string, double> gp)
		{
			HCname    = name;
			gemcOpt   = go;
			gpars     = gp;
			verbosity = gemcOpt.optMap["HIT_VERBOSITY"].arg;
			log_msg   = "  > " + HCname + "  Hit Process ";
		}
			
		// local initializations
		// init_subclass is used at the END of the event level
		// by the hit process routine
		// NOTICE:
		// Variables in the processID of the sensitive detector
		// should be initialized in the CONSTRUCTOR of the class

		// notice, this is executed for each class instantiation (each event basically)
		// we don't want to connect to DB here!
		// use static members insted as in FTOF template

		virtual void initWithRunNumber(int runno) {;}
		
		// - integrateRaw: returns geant4 raw information integrated over the hit
	    // - add the info in the bank if INTEGRATEDRAW is TRUE
		map<string, double> integrateRaw(MHit*, int, bool);
		
		// - allRaws: returns all geant4 raw information step by step\n\n
		// this is not virtual, its declared in hitProcess.cc and common to all
		map< string, vector <double> > allRaws(MHit*, int);
		
		// - integrateDgt: returns digitized information integrated over the hit
		virtual map<string, double> integrateDgt(MHit*, int) = 0;
		
		// - signalVT: returns a V(t) function
		virtual map< double, double > signalVT(MHit*) ;
	
		// - quantum signal: V(t) in ADC channel, reported every bunch time
		virtual map< int, int > quantumS(map< double, double >, MHit*) ;
	
		// - multiDgt: returns multiple digitized information / hit
		virtual map< string, vector <int> > multiDgt(MHit*, int) = 0;
		
		// The pure virtual method processID returns a (new) identifier
		// containing hit sharing information
		virtual vector<identifier> processID(vector<identifier>, G4Step*, detector) = 0;
		
	protected:
		
		// hit collection name
		string HCname;
		goptions gemcOpt;
		map<string, double> gpars;
		double verbosity;
		string log_msg;
	
		inline double DGauss(double x, double *par, double Edep, double stepTime)
		{
			double t0   = par[0] + stepTime;     // delay + start time of signal so that peak is t0 + rise. 
			double rise = par[1]/3;              // rise time, equal to sigma of first gaussian.
			double fall = par[2]/3;              // fall time, equal to sigma of second gaussian
			double ampl = Edep*par[3]/2;         // amplitude of the signal mV/MeV - divided by 2 cause it's 2 gaussians
			
			double peak = t0 + 3*rise;
			
//			cout << t0 << " " << rise << " " << fall << " " << ampl << " " << peds <<
//			 peds - ampl*exp(-0.5*pow((x-peak)/rise, 2)) - ampl*exp(-0.5*pow((x-peak)/fall, 2)) << endl;
			
			return  - ampl*exp(-0.5*pow((x-peak)/rise, 2)) - ampl*exp(-0.5*pow((x-peak)/fall, 2));
		}
};

// Define HitProcess as a pointer to a function that returns a pointer
typedef HitProcess *(*HitProcess_Factory)();

// Return HitProcess from the Hit Process Map
HitProcess *getHitProcess(map<string, HitProcess_Factory> *hitProcessMap, string);

// returns the list of Hit Factories registered
set<string> getListOfHitProcessHit(map<string, HitProcess_Factory>);





#endif
