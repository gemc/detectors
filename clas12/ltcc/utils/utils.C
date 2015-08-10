void setStyle()
{
	gStyle->SetPadLeftMargin(-0.08);
	gStyle->SetPadRightMargin(-0.04);
	gStyle->SetPadTopMargin(-0.06);
	gStyle->SetPadBottomMargin(-0.06);
	
	gStyle->SetPalette(1);
	gStyle->SetOptStat(0);
	gStyle->SetOptTitle(0);
	gStyle->SetFrameFillColor(kWhite);
	gStyle->SetCanvasColor(kWhite);
	gStyle->SetPadColor(kWhite);
	
	gStyle->SetCanvasBorderMode(0);
	gStyle->SetFrameBorderMode(0);
	gStyle->SetPadBorderMode(0);
}


void change_particle()
{
	PART++;
	if(PART==3) PART = 0;
	
	cout << " Particle selected: " << pname[PART] << endl;
}

void change_mirror()
{
	MIRROR++;
	if(MIRROR==4) MIRROR = 0;
	
	cout << " mirror selected: " << mirname[MIRROR] << endl;
}

void change_gas()
{
	GAS++;
	if(GAS==2) GAS = 0;
	
	cout << " Gas selected: " << gasname[GAS] << endl;
}

void change_pmt()
{
	PMT++;
	if(PMT==4) PMT = 0;
	
	cout << " PMT selected: " << pmtname[PMT] << endl;
}


void change_WC()
{
	WC++;
	if(WC==4) WC = 0;
	
	cout << " WC selected: " << wcname[WC] << endl;
}



void print_all_yields()
{
	PRINT = ".png";
	
	for(int p=0; p<3; p++)
	{
		PART = p;
		
		for(int m=0; m<4; m++)
		{
			MIRROR = m;
		}
		plot_yields();
		draw_W();
	}
}

double PoissonReal(const Double_t *k, const Double_t *lambda)
{
	return TMath::Exp(k[0]*TMath::Log(lambda[0])-lambda[0]) / TMath::Gamma(k[0]+1.);
}






