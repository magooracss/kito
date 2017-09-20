unit rpt_ventasentrefechas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, RLXLSFilter, RLPDFFilter, RLXLSXFilter,
  RLReport, Forms, Controls, Graphics, Dialogs;

type

  { TForm1 }

  TForm1 = class(TForm)
    ds: TDataSource;
    rep_Mov: TRLReport;
    RLBand1: TRLBand;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLDetailGrid1: TRLDetailGrid;
    RLFechas: TRLLabel;
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
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

end.

