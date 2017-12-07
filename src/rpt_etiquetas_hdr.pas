unit rpt_etiquetas_hdr;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, RLReport, RLPDFFilter, Forms,
  Controls, Graphics, Dialogs, dmhojaderuta, dmgeneral;

type

  { TrepEtiquetasHdR }

  TrepEtiquetasHdR = class(TForm)
    ds_Etiquetas: TDataSource;
    rep_etiquetasHdR: TRLReport;
    RLDBMemo1: TRLDBMemo;
    RLDBMemo2: TRLDBMemo;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDetailGrid1: TRLDetailGrid;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLPDFFilter1: TRLPDFFilter;
  private
    dmHdR: TDM_HojaDeRuta;
  public
    property dm: TDM_HojaDeRuta write dmHdR;
    procedure RunReport (rptAction: TReportAction);
  end;

var
  repEtiquetasHdR: TrepEtiquetasHdR;

implementation

{$R *.lfm}

{ TrepEtiquetasHdR }

procedure TrepEtiquetasHdR.RunReport(rptAction: TReportAction);
begin
  ds_Etiquetas.DataSet:= dmHdR.Etiquetas;

  DM_General.runReport(rep_etiquetasHdR, rptAction, 'etiquetasHdR');
end;

end.

