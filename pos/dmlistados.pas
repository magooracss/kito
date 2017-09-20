unit dmlistados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZDataset
  ,dmgeneral;

type

  { TDM_Listados }

  TDM_Listados = class(TDataModule)
    qDebajoStockMinimo: TZQuery;
    qProdMovEntreFechas: TZQuery;
    qProdVentasEntreFechas: TZQuery;
    qProdVentasEntreFechasCANTIDAD: TFloatField;
    qProdVentasEntreFechasCODIGO: TStringField;
    qProdVentasEntreFechasCOLOR: TStringField;
    qProdVentasEntreFechasMARCA: TStringField;
    qProdVentasEntreFechasNOMBRE: TStringField;
    qProdVentasEntreFechasTALLE: TStringField;
    qVentasEntreFechas: TZQuery;
    qVentasEntreFechasCANTIDAD: TFloatField;
    qVentasEntreFechasCODIGO: TStringField;
    qVentasEntreFechasCOLOR: TStringField;
    qVentasEntreFechasMARCA: TStringField;
    qVentasEntreFechasNOMBRE: TStringField;
    qVentasEntreFechasTALLE: TStringField;
  private
    { private declarations }
  public
    procedure ProdDebajoStockMinimo;
    procedure VentasProductosEntreFechas (fIni, Ffin: TDate);
    procedure VentasProductoEntreFechas (refProducto: GUID_ID; fIni, fFin: TDate);
  end;

var
  DM_Listados: TDM_Listados;

implementation

{$R *.lfm}

{ TDM_Listados }

procedure TDM_Listados.ProdDebajoStockMinimo;
begin

end;

procedure TDM_Listados.VentasProductosEntreFechas(fIni, Ffin: TDate);
begin
  with qVentasEntreFechas do
  begin
    if active then close;
    ParamByName('fIni').asDate:= fIni;
    ParamByName('fFin').asDate:= fFin;
    Open;
  end;
end;

procedure TDM_Listados.VentasProductoEntreFechas(refProducto: GUID_ID; fIni,
  fFin: TDate);
begin
  with qProdVentasEntreFechas do
  begin
    if active then close;
    ParamByName('producto_id').AsString:= refProducto;
    ParamByName('fIni').asDate:= fIni;
    ParamByName('fFin').asDate:= fFin;
    Open;
  end;

end;

end.

