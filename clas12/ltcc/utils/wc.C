{
	
	ifstream f("../parameters/wcEff.txt");
	
	TH1F *effi  = new TH1F("effi",  "effi",  100, 0.0, 1.0);
	
	TH1F *effi1R = new TH1F("effi1R", "effi1R", 6, -0.1, 1.1);
	TH1F *effi2R = new TH1F("effi2R", "effi2R", 6, -0.1, 1.1);
	TH1F *effi3R = new TH1F("effi3R", "effi3R", 6, -0.1, 1.1);
	
	
	for(int i=0; i<216; i++)
	{
		double e;
		f >> e;
		
		effi->Fill(e);
	}

	
	double threshold = 0.7;
	
	double bad   = effi->Integral(0, 50);
	double soso  = effi->Integral(50, threshold*100);
	double good  = effi->Integral(threshold*100, 100);
	double total = effi->Integral(0, 100);
	
	double maxH = effi->GetMaximum()/100;
	
	effi1R->SetBinContent(1, maxH*bad);
	effi1R->SetBinContent(2, maxH*bad);
	effi1R->SetBinContent(3, maxH*bad);
	effi2R->SetBinContent(4, maxH*soso);
	effi3R->SetBinContent(5, maxH*good);
	effi3R->SetBinContent(6, maxH*good);
	
	effi1R->SetFillColorAlpha(kRed,   0.3);
	effi2R->SetFillColorAlpha(kBlue,   0.3);
	effi3R->SetFillColorAlpha(kGreen,  0.3);

	
	effi->Draw();
	effi1R->Draw("same");
	effi2R->Draw("same");
	effi3R->Draw("same");
	effi->Draw("same");
	
	
	TLatex lab;
	lab.SetTextFont(102);
	lab.SetNDC();

	lab.SetTextColor(kRed-3);
	lab.DrawLatex(.15,.8, Form("bad:  %3.0f", bad)) ;
	lab.SetTextColor(kBlue-3);
	lab.DrawLatex(.15,.7, Form("soso: %3.0f", soso)) ;
	lab.SetTextColor(kGreen-3);
	lab.DrawLatex(.15,.6, Form("good: %3.0f", good)) ;

	
	
}










