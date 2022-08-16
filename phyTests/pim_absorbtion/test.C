#include <string>
#include <TTree.h>
#include <TFile.h>
#include <TH1F.h>

#include <TH1.h>
#include <TH2.h>
#include <TH3.h>
#include <TStyle.h>
#include <TCanvas.h>
#include <TChain.h>
#include <TFile.h>
#include <time.h>
#include <stdlib.h>

#include <vector>
#include <iostream>


void test()
{
	TFile* f = new TFile("out.root");
	TTree* tree = (TTree *) f -> Get("flux");
	
	vector<double>* pid  = new vector<double>;
	vector<double>* trackE  = new vector<double>;
	double flPid = 0;
	double fltrackE = 0;
	cout << pid << " " << trackE << endl;
	
	tree -> SetBranchAddress("pid",&pid);
	tree -> SetBranchAddress("trackE",&trackE);
	
	pid-> clear();
	trackE-> clear();
	
	// Create histos
	
	TH1F *v_mu1  = new TH1F("#nu_{#mu}", "", 300, 0., 300.);
	TH1F *v_mu2  = new TH1F("#bar{#nu}_{#mu}", "", 300, 0., 300.);
	TH1F *v_e1  = new TH1F("#nu_{e}", "", 300, 0., 300.);
	TH1F *v_e2  = new TH1F("#bar{#nu}_{e}", "", 300, 0., 300.);
	
	Int_t nentries = (Int_t)tree -> GetEntries();
	cout << "n : "    <<  nentries  <<  endl;
	
	
	
	for(int i=0;i<nentries;i++){
		tree -> GetEntry(i);
		Int_t nn=pid->size();
		
		for(int ii=0; ii<nn; ii++) {
			
			fltrackE=(*trackE)[ii];
			flPid=(*pid)[ii];
			
			if(flPid==12)   {
				v_e1 -> Fill(fltrackE);
			} else if(flPid==-12) {
				v_e2 -> Fill(fltrackE);
			}
			else if(flPid==14) {
				v_mu1 -> Fill(fltrackE);
			}
			else if(flPid==-14) {
				v_mu2 -> Fill(fltrackE);
			}
		}
	}
	
	
	TCanvas *c1  =  new TCanvas("c1","neutrino energy");
	c1-> SetLogy();
	c1-> SetLineWidth(5);
	v_mu1 -> GetXaxis()->SetTitle("Energy(MeV)");
	v_mu1 -> SetLineColor(2);
	v_mu1 -> Draw("hist");
	int m1 = v_mu1->GetEntries();
	v_mu2 -> SetLineColor(4);
	v_mu2 -> Draw("histsame");
	int m2 = v_mu2->GetEntries();
	v_e1 -> SetLineColor(6);
	v_e1 -> Draw("histsame");
	int e1 = v_e1->GetEntries();
	v_e2 -> SetLineColor(8);
	v_e2 -> Draw("histsame");
	int e2 = v_e2->GetEntries();
	int i1 = v_mu1->Integral(26,55);
	int i2 = v_mu2->Integral(26,55);
	int i3 = v_e1->Integral(26,55);
	int i4 = v_e2->Integral(26,55);
	
	
	c1->BuildLegend();
	
	cout << "nu_mu : "    <<  m1  <<  ",   nu_mu* : "   <<  m2 <<  ",   nu_e : " << e1  <<  ",   nu_e* : " << e2 <<  endl;
	cout << "nu_mu(25~55MeV) : "  <<  i1 <<  ",   nu_mu*(25~55MeV) : " << i2  << ",   nu_e(25~55MeV) : "  << i3 <<",   nu_e(25~55MeV) : "   << i4 << endl;
	
}
