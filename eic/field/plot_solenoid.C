#include <iomanip>
#include <iostream>
using namespace std;

void plot_solenoid(string input_filename)
{

ifstream input(input_filename.c_str());
if (input.good()) cout << "open file " << input_filename << " OK" <<endl;
else {cout << "can't open the file" << endl; return;}

// reads and discard the first 13 lines of text
char textline[200];
for (int k = 0; k<13; k++) input.getline(textline,200);

//==================================
// <mfield>
//        <description name="meic_det1_solenoid_dual_v2" factory="ASCII" comment="meic_det1_solenoid_dual_v2"/>
//        <symmetry type="cylindrical-z" format="map" integration="RungeKutta" minStep="1*mm"/>
//        <map>
//                <coordinate> 
//                        <first  name="transverse" npoints="301"   min="0"  max="300"  units="cm"/>
//                        <second name="longitudinal"   npoints="1601"  min="-800" max="800"  units="cm"/>
//                </coordinate>
//                <field unit="gauss"/>
//                <interpolation type="none"/>
//                <shift z="0" units="cm"/>
//        </map>
// </mfield>
// 0.00000000000      -800.000000000     -0.174481412155E-13  284.949770458    
// 0.00000000000      -799.000000000     -0.175181225970E-13  286.092653150    
// 0.00000000000      -798.000000000     -0.175884881363E-13  287.241809614    
// 0.00000000000      -797.000000000     -0.176592405707E-13  288.397284555    
//================================== 

// double Rmin,Rmax,Zmin,Zmax;
// int Num_R,Num_Z;
// char textline[200];
// string pl;

  // reads and discard the first 13 lines of text
// for (int k = 0; k<13; k++) input.getline(textline,200);

//================================== 
//(Rmin,Zmin) = (0.0,-300)
// (Rmax,Zmax) = (300,475)
// R and Z increments:   300   775
//================================== 

//readin R and Z info
// input.getline(textline,200);
// input >> textline >> textline >> textline;
// pl=textline;
// int pl_first= pl.find(",");pl_last= pl.rfind(",");pl_init=1;pl_end=pl.size()-1;
// Rmin=atof(pl.substr(pl_init,pl_first).c_str());
// Zmin=atof(pl.substr(pl_last+1,pl_end).c_str());
// cout << "Rmin " << Rmin << " Zmin " << Zmin << endl; 
// // input.getline(textline,200);
// input >> textline >> textline >> textline;
// pl=textline;
// pl_first= pl.find(",");pl_last= pl.rfind(",");pl_init=1;pl_end=pl.size()-1;
// Rmax=atof(pl.substr(pl_init,pl_first).c_str());
// Zmax=atof(pl.substr(pl_last+1,pl_end).c_str());
// cout << "Rmax " << Rmax << " Zmax " << Zmax << endl; 
// input >> textline >> textline >> textline >> textline >> Num_R >> Num_Z; //reads the line like "R and Z increments:   300   775"
// cout << "R and Z increments:\t" << Num_R << "\t" << Num_Z << endl;
// const int constNum_R=Num_R+1,constNum_Z=Num_Z+1;
// cout << "please put " << constNum_R << " " << constNum_Z << " instead into database" << endl;
// cout << "the units are in cm and G" << endl;

char filename[100];
sprintf(filename, "%s",input_filename.substr(0,input_filename.rfind(".")).c_str());

char output_filename[100];
sprintf(output_filename, "%s.root",filename);
TFile *rootfile=new TFile(output_filename, "recreate");

double Rmin=0,Rmax=399,Zmin=-400,Zmax=500;
int Num_R=400,Num_Z=901;
double halfbinwidth=0.5;

// double Rmin=0,Rmax=399,Zmin=0,Zmax=499;
// int Num_R=400,Num_Z=500;
// double halfbinwidth=0.5;

// double Rmin=0,Rmax=300,Zmin=-800,Zmax=800;
// int Num_R=301,Num_Z=1601;
// double halfbinwidth=0.5;

const int constNum_R=Num_R,constNum_Z=Num_Z;

TH1F *hBz_axis = new TH1F("Bz_axis","Bz;Z(cm)",Num_Z,Zmin-halfbinwidth,Zmax+halfbinwidth);

TH2F *hBr = new TH2F("Br","Br;Z(cm);R(cm)",Num_Z,Zmin-halfbinwidth,Zmax+halfbinwidth,Num_R,Rmin-halfbinwidth,Rmax+halfbinwidth);
TH2F *hBz = new TH2F("Bz","Bz;Z(cm);R(cm)",Num_Z,Zmin-halfbinwidth,Zmax+halfbinwidth,Num_R,Rmin-halfbinwidth,Rmax+halfbinwidth);
TH2F *hB = new TH2F("B","B;Z(cm);R(cm)",Num_Z,Zmin-halfbinwidth,Zmax+halfbinwidth,Num_R,Rmin-halfbinwidth,Rmax+halfbinwidth);
TH2F *hdBzdr = new TH2F("dBzdr","dBz/dz;Z(cm);R(cm);;Z(cm);R(cm)",Num_Z,Zmin-halfbinwidth,Zmax+halfbinwidth,Num_R,Rmin-halfbinwidth,Rmax+halfbinwidth);
TH2F *hdBrdz = new TH2F("dBrdz;Z(cm);R(cm);","dBr/dz;Z(cm);R(cm)",Num_Z,Zmin-halfbinwidth,Zmax+halfbinwidth,Num_R,Rmin-halfbinwidth,Rmax+halfbinwidth);
TH2F *hFI = new TH2F("Field Index","Field Index;Z(cm);R(cm)",Num_Z,Zmin-halfbinwidth,Zmax+halfbinwidth,Num_R,Rmin-halfbinwidth,Rmax+halfbinwidth);
TH2F *hBperp = new TH2F("Bperp","abs(B) perpendicular to path;Z(cm);R(cm)",Num_Z,Zmin-halfbinwidth,Zmax+halfbinwidth,Num_R,Rmin-halfbinwidth,Rmax+halfbinwidth);

// reads in R Z Br Bz (R increase first when Z fixed)
string R_s[constNum_R][constNum_Z],Z_s[constNum_R][constNum_Z],Br_s[constNum_R][constNum_Z],Bz_s[constNum_R][constNum_Z];
double  R,Z,Br,Bz;
double B,Bperp;
for (int i = 0; i<constNum_R; i++) {
for (int j = 0; j<constNum_Z; j++) {    
	input >> R_s[i][j] >> Z_s[i][j] >> Br_s[i][j] >> Bz_s[i][j];
	R=atof(R_s[i][j].c_str()); 
	Z=atof(Z_s[i][j].c_str());
	Br=atof(Br_s[i][j].c_str());
	Bz=atof(Bz_s[i][j].c_str());
	B=sqrt(Br*Br+Bz*Bz);
	Bperp=fabs(B*sin(atan(Br/Bz)-atan(R/Z)));
// 	Bperp=B*sin(atan(Br/Bz)-atan(R/Z));	
	
// 	cout << R << "\t" << Z << "\t" << Br << "\t" << Bz << endl; 

	if (int(R)==0) hBz_axis->Fill(Z,Bz);
	hBr->Fill(Z,R,Br);
	hBz->Fill(Z,R,Bz);
	hB->Fill(Z,R,B);
// 	hdBzdr->Fill(Z,R,dBzdr);
// 	hdBrdz->Fill(Z,R,dBrdz);
// 	hFI->Fill(Z,R,FI);
	hBperp->Fill(Z,R,Bperp);
	
// 	input.getline(textline,200); //get the rest of line
//       cout.width(10);
//       cout.setf(0,ios::floatfield);
//       cout.setf(ios::fixed,ios::floatfield);
//     cout.precision(6);
//     cout << scientific << 
//     cout << R[i][j] << "\t" <<  Z[i][j] <<  "\t" <<  Br[i][j] <<  "\t" <<  Bz[i][j] << endl; 
// 	cout << j << "\t" << i << "\r";
  }
}
//     cout << R << "\t" <<  Z <<  "\t" <<  Br <<  "\t" <<  Bz << endl;  
input.close();
cout << "finish reading in" << endl;

rootfile->Write();
rootfile->Flush();
cout << "output rootfile " << output_filename << endl;

gStyle->SetPalette(1);
gStyle->SetOptStat(0);

TCanvas *c_fieldBz = new TCanvas("fieldBz","fieldBz",800,600);
hBz_axis->Draw();
c_fieldBz->SaveAs(Form("%s_fieldBz.png",filename));

TCanvas *c_fieldmap = new TCanvas("fieldmap","fieldmap",1600,1000);
c_fieldmap->Divide(2,2);
c_fieldmap->cd(1);
hBr->Draw("colz");
c_fieldmap->cd(2);
hBz->Draw("colz");
c_fieldmap->cd(3);
hB->Draw("colz");
c_fieldmap->cd(4);
hBperp->Draw("colz");
c_fieldmap->SaveAs(Form("%s_fieldmap.png",filename));

TCanvas *c_fieldmap_log = new TCanvas("fieldmap_log","fieldmap_log",1600,1000);
c_fieldmap_log->Divide(2,2);
c_fieldmap_log->cd(1);
gPad->SetLogz(1);
hBr->Draw("colz");
c_fieldmap_log->cd(2);
gPad->SetLogz(1);
hBz->Draw("colz");
c_fieldmap_log->cd(3);
gPad->SetLogz(1);
hB->Draw("colz");
c_fieldmap_log->cd(4);
gPad->SetLogz(1);
hBperp->Draw("colz");
c_fieldmap_log->SaveAs(Form("%s_fieldmap_log.png",filename));

}
