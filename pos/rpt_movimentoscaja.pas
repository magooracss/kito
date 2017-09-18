unit rpt_movimentoscaja;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, RLReport, RLXLSFilter, RLPDFFilter,
  RLXLSXFilter, Forms, Controls, Graphics, Dialogs, dmcajamovimientos,
  dmgeneral;

type

  { Trpt }

  Trpt = class(TForm)
    ds: TDataSource;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDetailGrid1: TRLDetailGrid;
    RLDraw1: TRLDraw;
    RLLabel1: TRLLabel;
    lbFechas: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLPDFFilter1: TRLPDFFilter;
    RLXLSFilter1: TRLXLSFilter;
    RLXLSXFilter1: TRLXLSXFilter;
    sd: TSaveDialog;
    rep_Mov: TRLReport;
    RLSystemInfo1: TRLSystemInfo;
    txResumen: TRLMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rep_MovBeforePrint(Sender: TObject; var PrintIt: Boolean);
  private
    _fIni, _FFin: TDate;
    dmCaja: TDM_CajaMovimentos;
    procedure CargarDatos;
  public
     procedure  RunReport (fIni, fFin: TDate; rptAction: TReportAction);
  end;

var
  rpt: Trpt;

implementation

{$R *.lfm}

{ Trpt }

procedure Trpt.FormCreate(Sender: TObject);
begin
  dmCaja:= TDM_CajaMovimentos.Create(self);
  ds.DataSet:= dmCaja.CajaMovimientos;
end;

procedure Trpt.FormDestroy(Sender: TObject);
begin
  dmCaja.Free;
end;

procedure Trpt.rep_MovBeforePrint(Sender: TObject; var PrintIt: Boolean);
begin
  CargarDatos;
end;

procedure Trpt.CargarDatos;
var
  idx: integer;
begin
  lbFechas.Caption:= DateToStr(_fIni) + ' - ' + DateToStr (_fFin);
  dmCaja.CargarResumenFormaPago;
  if dmCaja.LenResumenFormaPago > 0 then
  begin
    txResumen.Lines.Clear;
    for idx:=  1 to dmCaja.LenResumenFormaPago do
    begin
      txResumen.Lines.Add(dmCaja.ResumenFormaPago[idx].formaPago
                         + ': '
                         + FormatFloat('$ ##########0.00',dmCaja.ResumenFormaPago[idx].monto)
                         );
    end;
  end;
end;

procedure Trpt.RunReport(fIni, fFin: TDate; rptAction: TReportAction);
begin
  _fIni:= fIni;
  _FFin:= fFin;
  dmCaja.LoadMovFechas(fIni, fFin);

  DM_General.runReport(rep_Mov, rptAction, 'resumenCaja');

end;

end.

