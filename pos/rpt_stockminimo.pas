unit rpt_stockminimo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, RLXLSFilter, RLPDFFilter, RLXLSXFilter,
  RLReport, Forms, Controls, Graphics, Dialogs, dmlistados, dmgeneral;

type

  { TfrmStockMinimo }

  TfrmStockMinimo = class(TForm)
    ds: TDataSource;
    rep_StockMinimo: TRLReport;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDetailGrid1: TRLDetailGrid;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLPDFFilter1: TRLPDFFilter;
    RLSystemInfo1: TRLSystemInfo;
    RLXLSFilter1: TRLXLSFilter;
    RLXLSXFilter1: TRLXLSXFilter;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    dmQ: TDM_Listados;
  public
    procedure  RunReport (rptAction: TReportAction);
  end;

var
  frmStockMinimo: TfrmStockMinimo;

implementation

{$R *.lfm}

{ TfrmStockMinimo }

procedure TfrmStockMinimo.FormCreate(Sender: TObject);
begin
  dmQ:= TDM_Listados.Create(self);
end;

procedure TfrmStockMinimo.FormDestroy(Sender: TObject);
begin
  dmQ.Free;
end;

procedure TfrmStockMinimo.RunReport(rptAction: TReportAction);
begin
  dmQ.ProdDebajoStockMinimo;

  DM_General.runReport(rep_StockMinimo, rptAction, 'resumenCaja');

end;

end.

