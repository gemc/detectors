/* 
 * File:   DrawPlots.cc
 * Author: rafopar
 *
 * Created on November 2, 2023, 10:29 AM
 */

#include <cstdlib>

using namespace std;

void HistoCosmetics(TH1D*);

/*
 * 
 */
void DrawPlots(int thickness) {

    gStyle->SetOptStat(0);
    TCanvas *c1 = new TCanvas("c1", "", 1800, 1200);
    c1->SetTopMargin(0.2);

    TLatex *lat1 = new TLatex();
    lat1->SetNDC();
    lat1->SetTextFont(42);
    lat1->SetTextSize(0.04);

    TFile *file_in = new TFile(Form("PhotonSpectra_Sn_%d_Micron.root", thickness), "Read");

    TH1D *h_EPhot1 = (TH1D*) file_in->Get("h_EPhot1");
    h_EPhot1->SetTitle("; Photon Energy [MeV]");
//    h_EPhot1->SetTitleSize(0.05, "X");
//    h_EPhot1->SetTitleOffset(1.2, "X");
//    h_EPhot1->SetLabelSize(0.05, "X");
//    h_EPhot1->SetLabelSize(0.05, "Y");
    HistoCosmetics(h_EPhot1);
    TH1D *h_phiPhot1 = (TH1D*) file_in->Get("h_phiPhot1");
    h_phiPhot1->SetTitle("; Photon angle #phi [deg]");
    HistoCosmetics(h_phiPhot1);
    TH1D *h_cosThPhot1 = (TH1D*) file_in->Get("h_cosThPhot1");
    h_cosThPhot1->SetTitle("; Photon Cos(#theta)");
    HistoCosmetics(h_cosThPhot1);    
    TH1D *h_Eelectron1 = (TH1D*) file_in->Get("h_Eelectron1");
    h_Eelectron1->SetTitle("; Electron Energy [MeV]");
    HistoCosmetics(h_Eelectron1);
    TH1D *h_phiElectron1 = (TH1D*) file_in->Get("h_phiElectron1");
    h_phiElectron1->SetTitle("; Electron angle #phi [deg]");
    HistoCosmetics(h_phiElectron1);
    TH1D *h_cosThElectron1 = (TH1D*) file_in->Get("h_cosThElectron1");
    h_cosThElectron1->SetTitle("; Electron Cos(#theta)");
    HistoCosmetics(h_cosThElectron1);

    c1->Divide(3, 2, 0.001, 0.04);
    c1->cd(1)->SetLogy();
    c1->cd(1)->SetLogx();
    c1->cd(1)->SetTopMargin(0);
    c1->cd(1)->SetRightMargin(0.01);
    c1->cd(1)->SetBottomMargin(0.12);
    h_EPhot1->Draw();
    c1->cd(2)->SetLogy(0);
    c1->cd(2)->SetLogx(0);
    c1->cd(2)->SetTopMargin(0);
    c1->cd(2)->SetRightMargin(0.01);
    c1->cd(2)->SetBottomMargin(0.12);
    h_phiPhot1->SetMinimum(0);
    h_phiPhot1->Draw();
    c1->cd(3);
    c1->cd(3)->SetTopMargin(0);
    c1->cd(3)->SetRightMargin(0.01);
    c1->cd(3)->SetBottomMargin(0.12);
    h_cosThPhot1->Draw();
    c1->cd(4)->SetLogy();
    c1->cd(4)->SetTopMargin(0);
    c1->cd(4)->SetRightMargin(0.01);
    c1->cd(4)->SetBottomMargin(0.12);
    //c1->cd(4)->SetLogx();
    h_Eelectron1->Draw();
    c1->cd(5)->SetLogy(0);
    c1->cd(5)->SetLogx(0);
    c1->cd(5)->SetTopMargin(0);
    c1->cd(5)->SetRightMargin(0.01);
    c1->cd(5)->SetBottomMargin(0.12);
    h_phiElectron1->SetMinimum(0);
    h_phiElectron1->Draw();
    c1->cd(6);
    c1->cd(6)->SetTopMargin(0);
    c1->cd(6)->SetRightMargin(0.01);
    c1->cd(6)->SetBottomMargin(0.12);
    h_cosThElectron1->Draw();
    c1->cd(0);
    lat1->DrawLatex(0.45, 0.97, Form("Tin: %d #mum", thickness));

    c1->Print(Form("Figs/Photon_Studies_Tin_%dum.pdf", thickness));
    c1->Print(Form("Figs/Photon_Studies_Tin_%dum.png", thickness));
    c1->Print(Form("Figs/Photon_Studies_Tin_%dum.root", thickness));

}

void HistoCosmetics(TH1D *h) {

    h->SetTitleSize(0.05, "X");
    h->SetTitleOffset(1.2, "X");
    h->SetLabelSize(0.05, "X");
    h->SetLabelSize(0.05, "Y");
}