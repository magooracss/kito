unit dmlistados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZDataset
  ,dmgeneral
  ;

type

  { TDM_Listados }

  TDM_Listados = class(TDataModule)
    qLstStockMinimo: TZQuery;
    qLstStockMinimoCODIGO: TStringField;
    qLstStockMinimoDISPONIBLE: TFloatField;
    qLstStockMinimoMINIMO: TFloatField;
    qLstStockMinimoNOMBRE: TStringField;
  private
  public
    procedure StockMinimimo;
  end;

var
  DM_Listados: TDM_Listados;

implementation
{$R *.lfm}

{ TDM_Listados }


procedure TDM_Listados.StockMinimimo;
const
  reporte = 'stockminimo.lrf';
begin
  with qLstStockMinimo do
  begin
    if active then close;
    Open;
    DM_General.LevantarReporte(reporte, qLstStockMinimo);
    DM_General.EjecutarReporte;
  end;
end;

end.

