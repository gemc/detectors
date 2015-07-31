void draw_c4f10n()
{
	TLatex lab;
	lab.SetTextFont(102);
	lab.SetTextColor(kBlue+2);
	lab.SetNDC();

	TCanvas *NN = new TCanvas("NN","Refraction index", 800, 600);

	TGraph *ri = new TGraph(NP, lambda, c4f10n);
	ri->SetMarkerSize(0.8);
	ri->SetMarkerStyle(20);
	ri->Draw("AP");

	lab.SetTextSize(0.04);
	lab.DrawLatex(.28,.95, "Refraction index of C4F10 ");

	lab.SetTextColor(kBlack);
	lab.DrawLatex(.85,.03, "nm") ;


	if(PRINT != "no")
		NN->Print(Form("refraction_index%s", PRINT.c_str()));
}



// number of photons as a function of energy and particle
void draw_W()
{
	TLatex lab;
	lab.SetTextFont(102);
	lab.SetTextColor(kBlue+2);
	lab.SetNDC();

	TCanvas *NN = new TCanvas("NN","n. photo-electrons yield", 800, 600);

  TF2 *momF;

	if(PART == 0)
	{
		momF = dndxdlFelectron;
    momF->SetParameter(0, eMass);
	}
	if(PART == 1)
	{
		momF = dndxdlFpion;
    momF->SetParameter(0, piMass);
	}
	if(PART == 2)
	{
		momF = dndxdlFkaon;
    momF->SetParameter(0, kMass);
	}

	momF->SetParameter(1, MIRROR);
	momF->SetParameter(2, PMT);
	momF->SetParameter(3, GAS);


	momF->Draw("surfFB");


	lab.SetTextSize(0.05);
	lab.DrawLatex(.25,.95, "photo-electron yield dN/d#lambdadx");

	lab.SetTextSize(0.04);
	lab.SetTextColor(kBlack);
	lab.SetTextAngle(10);


	lab.SetTextAlign(32);
	lab.DrawLatex(.6, .78, Form("%s",  pname[PART].c_str()));
	lab.DrawLatex(.6, .73, Form("%s mirror", mirname[MIRROR].c_str()));
	lab.DrawLatex(.6, .68, Form("%s pmt", pmtname[PMT].c_str()));
	lab.DrawLatex(.6, .63, Form("%s gas", gasname[GAS].c_str()));


	lab.SetTextAlign(11);
  lab.DrawLatex(.58,.04, "photon wavelength [nm]");
	lab.SetTextSize(0.034);
	lab.SetTextAngle(-31);
  lab.DrawLatex(.07,.25, "Particle Momentum [GeV]");

	if(PRINT != "no")
		NN->Print(Form("photon_yield_spectrum_%s_gas%s_mirror%s_pmt%s%s",
                   pname[PART].c_str(), gasname[GAS].c_str(), mirname[MIRROR].c_str(), pmtname[PMT].c_str(),  PRINT.c_str()));
}





// draw quantum efficiencies
void draw_qes()
{
	TLatex lab;
	lab.SetTextFont(102);
	lab.SetTextColor(kBlue+2);
	lab.SetNDC();

	TCanvas *QE = new TCanvas("QE","Quantum Efficiencies", 800, 600);

	TGraph *stdg = new TGraph(NP, lambda, stdPmt_qe);
	TGraph *uvgg = new TGraph(NP, lambda, uvgPmt_qe);
	TGraph *qtzg = new TGraph(NP, lambda, qtzPmt_qe);

  stdg->SetMarkerSize(1.6);

  stdg->SetMarkerStyle(33);
  uvgg->SetMarkerStyle(21);
  qtzg->SetMarkerStyle(8);

  stdg->SetMarkerColor(kBlack);
  uvgg->SetMarkerColor(kBlue);
  qtzg->SetMarkerColor(kRed);

  stdg->Draw("AP");
  uvgg->Draw("Psame");
  qtzg->Draw("Psame");

	lab.SetTextSize(0.04);
	lab.DrawLatex(.1,.95, "Quantum Efficiencies of Std, UV glass and Quartz");

	lab.SetTextColor(kBlack);
	lab.DrawLatex(.85,.03, "nm") ;


	TLegend *lpmts  = new TLegend(0.64, 0.65, 0.90, 0.8);
	lpmts->AddEntry(stdg, "Standard PMT", "P");
	lpmts->AddEntry(uvgg, "UV glass PMT", "P");
	lpmts->AddEntry(qtzg, "Quartz PMT", "P");
	lpmts->SetBorderSize(0);
	lpmts->SetFillColor(0);
	lpmts->Draw();

	if(PRINT != "no")
		QE->Print(Form("quantum_efficiency%s", PRINT.c_str()));


}

// draw quantum efficiencies
void draw_reflectivities()
{
	TLatex lab;
	lab.SetTextFont(102);
	lab.SetTextColor(kBlue+2);
	lab.SetNDC();

	TCanvas *RF = new TCanvas("RF","Reflectivities", 800, 600);

	TGraph *ltcc = new TGraph(NP, lambda, ltcc_refl);
	TGraph *eciw = new TGraph(NP, lambda, ecis_witn);
	TGraph *ecis = new TGraph(NP, lambda, ecis_samp);

  ltcc->SetMarkerSize(1.6);

  ltcc->SetMarkerStyle(33);
  eciw->SetMarkerStyle(21);
  ecis->SetMarkerStyle(8);

  ltcc->SetMarkerColor(kBlack);
  eciw->SetMarkerColor(kBlue);
  ecis->SetMarkerColor(kRed);

	ecis->SetMinimum(0.4);
	
	//  eciw->Draw("AP");
	ecis->Draw("AP");
  ltcc->Draw("Psame");
	//  ecis->Draw("Psame");

	lab.SetTextSize(0.04);
	lab.DrawLatex(.13,.95, "Reflectivities of LTCC Mirrors and ECI re-coats");

	lab.SetTextColor(kBlack);
	lab.DrawLatex(.85,.03, "nm") ;


	TLegend *lmirs  = new TLegend(0.6, 0.55, 0.88, 0.75);
	lmirs->AddEntry(ltcc, "LTCC Mirror", "P");
	//	lmirs->AddEntry(eciw, "ECI Witness", "P");
	lmirs->AddEntry(ecis, "ECI Mirror Re-coated", "P");
	lmirs->SetBorderSize(0);
	lmirs->SetFillColor(0);
	lmirs->Draw();

	if(PRINT != "no")
		RF->Print(Form("reflectivity%s", PRINT.c_str()));
}





void plot_yields()
{
	TLatex lab;
	lab.SetTextFont(102);
	lab.SetTextColor(kBlue+2);
	lab.SetNDC();

	TCanvas *YY = new TCanvas("YY", "Photon Yields", 800, 600);


	PART = 0;
	integrate_yield();
	TGraph *ele_yield = new TGraph(MNP, electron_m, electron_n);

	PART = 1;
	integrate_yield();
	TGraph *pio_yield = new TGraph(MNP, pion_m, pion_n);

	PART = 2;
	integrate_yield();
	TGraph *kao_yield = new TGraph(MNP, kaon_m, kaon_n);


  ele_yield->SetMarkerSize(1.6);
  ele_yield->SetMarkerStyle(33);
  pio_yield->SetMarkerStyle(21);
  kao_yield->SetMarkerStyle(8);

  ele_yield->SetMarkerColor(kBlack);
  pio_yield->SetMarkerColor(kBlue);
  kao_yield->SetMarkerColor(kRed);

	ele_yield->SetMinimum(0);
  ele_yield->Draw("AP");
  pio_yield->Draw("Psame");
  kao_yield->Draw("Psame");

	lab.SetTextAlign(32);
	lab.DrawLatex(.86, .65, Form("%s mirror", mirname[MIRROR].c_str()));
	lab.DrawLatex(.86, .60, Form("%s pmt", pmtname[PMT].c_str()));
	lab.DrawLatex(.86, .55, Form("%s gas", gasname[GAS].c_str()));



	TLegend *lstudy  = new TLegend(0.12, 0.6, 0.3, 0.75);
	lstudy->AddEntry(ele_yield, "electrons", "P");
	lstudy->AddEntry(pio_yield, "pions", "P");
	lstudy->AddEntry(kao_yield, "kaons", "P");
	lstudy->SetBorderSize(0);
	lstudy->SetFillColor(0);
	lstudy->Draw();

	lab.SetTextSize(0.04);
	lab.SetTextAlign(11);
  lab.DrawLatex(.5,.03, "particle momentum [GeV]");

	lab.SetTextSize(0.05);
  lab.DrawLatex(.28,.94, "Photo-electron Yield / cm");

	if(PRINT != "no")
		YY->Print(Form("photon_yield_gas%s_mirror%s_pmt%s%s",
                   gasname[GAS].c_str(), mirname[MIRROR].c_str(), pmtname[PMT].c_str(), PRINT.c_str()));

}

// calculate the effect of re-coating the mirrors and using different PMTs
void normalized_yields_mirrors()
{

	TCanvas *YR = new TCanvas("YR", "Photon Yields Ratios", 800, 600);

	PART = 0;
	GAS  = 1;
	MIRROR = 1;
	PMT    = 2;
	integrate_yield();

	
	double unfocusing = 1.5;

	double pion_ratio_1[MNP];  // same mirror, same PMT
	PART = 1;
	GAS  = 1;
	MIRROR = 1;
	PMT    = 2;
	integrate_yield();
	for(int i=0; i<MNP; i++)
	{
		pion_ratio_1[i] = pion_n[i] / electron_n[i]/unfocusing;
	}

	double pion_ratio_2[MNP];  // improved mirror, same PMT
	PART = 1;
	GAS  = 1;
	MIRROR = 3;
	PMT    = 2;
	integrate_yield();
	for(int i=0; i<MNP; i++)
	{
		pion_ratio_2[i] = pion_n[i] / electron_n[i]/unfocusing;
	}

	double pion_ratio_3[MNP];  // same mirror, improved PMT
	PART = 1;
	GAS  = 1;
	MIRROR = 1;
	PMT    = 3;
	integrate_yield();
	for(int i=0; i<MNP; i++)
	{
		pion_ratio_3[i] = pion_n[i] / electron_n[i]/unfocusing;
	}

	double pion_ratio_4[MNP];  // improved mirror, improved PMT
	PART = 1;
	GAS  = 1;
	MIRROR = 3;
	PMT    = 3;
	integrate_yield();
	for(int i=0; i<MNP; i++)
	{
		pion_ratio_4[i] = pion_n[i] / electron_n[i]/unfocusing;
	}

	TGraph *pi1 = new TGraph(MNP, pion_m, pion_ratio_1);
	TGraph *pi2 = new TGraph(MNP, pion_m, pion_ratio_2);
	TGraph *pi3 = new TGraph(MNP, pion_m, pion_ratio_3);
	TGraph *pi4 = new TGraph(MNP, pion_m, pion_ratio_4);

  pi1->SetMarkerStyle(33);
  pi2->SetMarkerStyle(21);
  pi3->SetMarkerStyle(8);
  pi4->SetMarkerStyle(29);

	pi1->SetMarkerSize(1.6);
	pi4->SetMarkerSize(1.6);
  pi1->SetMarkerColor(kBlack);
  pi2->SetMarkerColor(kBlue);
  pi3->SetMarkerColor(kRed);
  pi4->SetMarkerColor(kGreen);

	pi1->SetMinimum(0);
	pi1->SetMaximum(1.8);
	pi1->Draw("AP");
	//  pi2->Draw("Psame");
 //  pi3->Draw("Psame");
 // pi4->Draw("Psame");

	TLegend *lstudy  = new TLegend(0.12, 0.65, 0.42, 0.85);
	lstudy->AddEntry(pi1, "Same Mirror, Same PMT", "P");
	//	lstudy->AddEntry(pi2, "Re-coated Mirror, Same PMT", "P");
//	lstudy->AddEntry(pi3, "Same Mirror, Coated PMT", "P");
//	lstudy->AddEntry(pi4, "Re-coated Mirror, Coated PMT", "P");
	lstudy->SetBorderSize(0);
	lstudy->SetFillColor(0);
	lstudy->Draw();

	TLatex lab;
	lab.SetTextFont(102);
	lab.SetTextColor(kBlue+2);
	lab.SetNDC();
	lab.SetTextSize(0.034);
  lab.DrawLatex(.4,.03, "Particle Momentum               [GeV]");


	if(PRINT != "no")
		YR->Print(Form("photon_yield_ratios_%s_gas%s_mirror%s_pmt%s%s",
                   pname[PART].c_str(), gasname[GAS].c_str(), mirname[MIRROR].c_str(), pmtname[PMT].c_str(), PRINT.c_str()));
	
  
}




void draw_window_gain()
{
	TLatex lab;
	lab.SetTextFont(102);
	lab.SetTextColor(kBlue+2);
	lab.SetNDC();

	TCanvas *WG = new TCanvas("WG","Window gain", 800, 600);




	//	windowMore_nocut_nose->Draw();
	//	windowMore_nocut_nonose->Draw("same");
	windowMore_cut_nose->Draw("");
	windowMore_cut_nonose->Draw("same");



	TLegend *lwindow  = new TLegend(0.65, 0.78, 0.9, 0.88);
//	lwindow->AddEntry(windowMore_nocut_nonose, "No Cut, No Nose", "L");
//	lwindow->AddEntry(windowMore_nocut_nose, "No Cut, Nose", "L");
	lwindow->AddEntry(windowMore_cut_nonose, "No Nose", "L");
	lwindow->AddEntry(windowMore_cut_nose, "Nose", "L");
	lwindow->SetBorderSize(0);
	lwindow->SetFillColor(0);
	lwindow->Draw();



	lab.SetTextSize(0.05);
	lab.DrawLatex(.18,.95, "C4F10 gas gain (middle of LTCC)");

	lab.SetTextColor(kBlack);
	lab.DrawLatex(.85,.03, "cm") ;

	lab.SetTextAngle(90);
	lab.DrawLatex(.05,.63, "% gas gain") ;



	if(PRINT != "no")
		WG->Print(Form("window_addition_gain%s", PRINT.c_str()));
}








