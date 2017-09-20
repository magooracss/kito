unit rpt_movimientosentrefechas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, RLReport, RLXLSFilter, RLPDFFilter,
  RLXLSXFilter, Forms, Controls, Graphics, Dialogs, dmlistados, dmgeneral;

type

  { TrptMovEntreFechas }

  TrptMovEntreFechas = class(TForm)
    ds: TDataSource;
    rep_Mov: TRLReport;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDBText6: TRLDBText;
    RLDetailGrid1: TRLDetailGrid;
    RLGroup1: TRLGroup;
    RLLabel1: TRLLabel;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLFechas: TRLLabel;
    RLLabel7: TRLLabel;
    RLPDFFilter1: TRLPDFFilter;
    RLSystemInfo1: TRLSystemInfo;
    RLXLSFilter1: TRLXLSFilter;
    RLXLSXFilter1: TRLXLSXFilter;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    dm: TDM_Listados;
  public
    procedure  RunReport (fIni, fFin: TDate; rptAction: TReportAction);
  end;

var
  rptMovEntreFechas: TrptMovEntreFechas;

implementation

{$R *.lfm}

{ TrptMovEntreFechas }

procedure TrptMovEntreFechas.FormCreate(Sender: TObject);
begin
  dm:= TDM_Listados.Create(self);
  ds.DataSet:= dm.qVentasEntreFechas;

end;

procedure TrptMovEntreFechas.FormDestroy(Sender: TObject);
begin
  dm.Free;
end;

procedure TrptMovEntreFechas.RunReport(fIni, fFin: TDate;
  rptAction: TReportAction);
begin
  dm.VentasProductosEntreFechas(fIni, fFin);
  RLFechas.Caption:= DateToStr(Fini) + ' - ' + DateToStr(FFin);

  DM_General.runReport(rep_Mov, rptAction, 'ventasEntreFechas');
end;

end.

