#ifndef MPrimaryGeneratorAction_h
#define MPrimaryGeneratorAction_h 1

// G4 headers
#include "G4VUserPrimaryGeneratorAction.hh"
#include "G4ParticleGun.hh"
#include "G4Event.hh"

// For reading StdHep files
#include "lStdHep.hh"
using namespace UTIL;


// gemc headers
#include "options.h"

// C++ headers
#include <fstream>


// Class definition
class MPrimaryGeneratorAction : public G4VUserPrimaryGeneratorAction
{
	public:
		MPrimaryGeneratorAction(goptions*);
		~MPrimaryGeneratorAction();
		
	public:
		void GeneratePrimaries(G4Event* anEvent);
		goptions *gemcOpt;
		double GEN_VERBOSITY;
  		double getBeamPol()
		{
			return beamPol;
		}
    
		// LUND information
		int nparticles;
		vector<double> lundUserDefined;   ///< user defined infos in the LUND header
	
	
	private:
		string input_gen;                 ///< Input Option: internal or external
		string cosmics;                   ///< cosmic ray option
		string hd_msg;                    ///< Head Message Log
		G4ParticleTable* particleTable;   ///< Geant4 Particle Table
		
		// Primary Beam
		G4ParticleDefinition *Particle;   ///< Particle type
		double mom,   dmom;               ///< beam momentum, delta momentum
		double theta, dtheta;             ///< theta, delta theta
		double phi,   dphi;               ///< phi, delta phi
		double vx, vy, vz;                ///< Beam Vertex coordinates
		double dvr, dvz;                  ///< Deltas Beam Vertex: Radius and z-vertex
		double polDeg, polTheta, polPhi;  ///< Polarization degree and  direction
		double ctheta;                    ///< customized theta direction for the z axis
		double cphi;                      ///< customize phi direction for the z axis
	
		double cosmicA, cosmicB, cosmicC; ///< cosmic ray model parameters
		double cminp, cmaxp, cMom;        ///< minimum and maximum cosmic ray momentum
		G4ThreeVector cosmicTarget;       ///< Location of area of interest for cosmic rays
		double cosmicRadius;              ///< radius of area of interest for cosmic rays
	
		// Generators Input Files
		ifstream  gif;                    ///< Generator Input File
		string    gformat;                ///< Generator Format. Supported: LUND.
		string    gfilename;              ///< Input Filename
    	double    beamPol;                ///< Beam Polarization as from the LUND format, it
	
		lStdHep   *stdhep_reader;         /// Handle to the object for reading StdHep files.
	
		// Luminosity Beam
		G4ParticleDefinition *L_Particle;  ///< Luminosity Particle type
		double L_mom,  L_dmom;             ///< Luminosity beam momentum, delta momentum
		double L_theta, L_dtheta;          ///< Luminosity theta,  delta theta
		double L_phi, L_dphi;              ///< Luminosity phi, delta phi, randomized phi
		double L_vx, L_vy, L_vz;           ///< Luminosity Beam Vertex coordinates
		double L_dvr,  L_dvz;              ///< Luminosity Deltas Beam Vertex: Radius and z-vertex
		int NP;                            ///< Number of Luminosity Particles per event
		double TWINDOW;                    ///< Time Window
		double TBUNCH;                     ///< Time Between Bunches
	
		// Luminosity Beam2
		G4ParticleDefinition *L2_Particle;    ///< Luminosity Particle type
		double L2_mom, L2_dmom;               ///< Luminosity beam momentum, delta momentum
		double L2_theta, L2_dtheta;           ///< Luminosity theta,  delta theta
		double L2_phi, L2_dphi;               ///< Luminosity phi, delta phi, randomized phi
		double L2_vx, L2_vy, L2_vz;           ///< Luminosity Beam Vertex coordinates
		double L2_dvr, L2_dvz;                ///< Luminosity Deltas Beam Vertex: Radius and z-vertex
		int NP2;                              ///< Number of Luminosity Particles per event
		double TBUNCH2;                       ///< Time Between Bunches
	
		G4ParticleGun* particleGun;
		void setBeam();
	
		double cosmicBeam(double, double);
	
};

#endif


