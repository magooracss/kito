unit dmlistados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZDataset
  ,dmgeneral
  ;

const
  LST_StockMinimo = 0; //Listado de stock mínimo
  LST_ProductosDevueltosDetalle = 1; //Productos devueltos en un intervalo de tiempo
  LST_ProductosDevueltosTotalizado = 2; //Productos devueltos en un intervalo de tiempo Totalizados
  LST_ProductosConsumidos = 3; //Productos vendidos en un intervalo de tiempo
  LST_ListaDePrecios = 4; // Lista de precios


type

  { TDM_Listados }

  TDM_Listados = class(TDataModule)
    qListados: TZQuery;
    qGruposListadosBVISIBLE: TSmallintField;
    qGruposListadosGRUPOLISTADO: TStringField;
    qGruposListadosID: TLongintField;
    qListadosBVISIBLE: TSmallintField;
    qListadosGRUPOLISTADO_ID: TLongintField;
    qListadosID: TLongintField;
    qListadosIDX: TLongintField;
    qListadosLISTADO: TStringField;
    qListaPrecioBVISIBLE: TSmallintField;
    qListaPrecioID: TLongintField;
    qListaPrecioLISTAPRECIO: TStringField;
    qLstListaPrecios: TZQuery;
    qLstListaPreciosCODIGO: TStringField;
    qLstListaPreciosLISTAPRECIO: TStringField;
    qLstListaPreciosMONTO: TFloatField;
    qLstListaPreciosNOMBRE: TStringField;
    qLstProdConsTiempoCODIGO: TStringField;
    qLstProdConsTiempoNOMBRE: TStringField;
    qLstProdConsTiempoTOTALPRODUCTO: TFloatField;
    qLstProductosDevTotalizados: TZQuery;
    qLstProdConsTiempo: TZQuery;
    qLstProductosDevTotalizadosCODIGO: TStringField;
    qLstProductosDevTotalizadosNOMBRE: TStringField;
    qLstProductosDevTotalizadosTOTALDESCARTADO: TFloatField;
    qLstProductosDevTotalizadosTOTALDEVUELTO: TFloatField;
    qLstProductosDevueltosCODIGO: TStringField;
    qLstProductosDevueltosDESCARTADO: TFloatField;
    qLstProductosDevueltosDEVUELTO: TFloatField;
    qLstProductosDevueltosFECHA: TDateField;
    qLstProductosDevueltosNOMBRE: TStringField;
    qLstStockMinimo: TZQuery;
    qGruposListados: TZQuery;
    qLstProductosDevueltos: TZQuery;
    qListaPrecio: TZQuery;
    qLstStockMinimoCODIGO: TStringField;
    qLstStockMinimoDISPONIBLE: TFloatField;
    qLstStockMinimoMINIMO: TFloatField;
    qLstStockMinimoNOMBRE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure LevantarReporte (elReporte: string; var consulta: TZQuery);
  public
    procedure ListadoPorGrupo (refGrupo: integer);

    procedure StockMinimimo;
    procedure ProductosDevueltosDetalle (fechaIni, fechaFin: TDate);
    procedure ProductosDevueltosTotalizado (fechaIni, fechaFin: TDate);
    procedure ProductosConsumidos (fechaIni, fechaFin: TDate);
    procedure ListaDePrecios (refLista: integer);

  end;

var
  DM_Listados: TDM_Listados;

implementation
{$R *.lfm}

{ TDM_Listados }

procedure TDM_Listados.DataModuleCreate(Sender: TObject);
begin
  qGruposListados.Open;
end;

procedure TDM_Listados.LevantarReporte(elReporte: string; var consulta: TZQuery
  );
begin
  DM_General.LevantarReporte(elReporte, consulta);
  DM_General.EjecutarReporte;
end;

procedure TDM_Listados.ListadoPorGrupo(refGrupo: integer);
begin
  with qListados do
  begin
    if active then close;
    ParamByName('grupoListado_id').asInteger:= refGrupo;
    Open;
  end;
end;

procedure TDM_Listados.StockMinimimo;
const
  reporte = 'stockminimo.lrf';
begin
  with qLstStockMinimo do
  begin
    if active then close;
    Open;
    LevantarReporte(reporte, qLstStockMinimo);
  end;
end;

procedure TDM_Listados.ProductosDevueltosDetalle(fechaIni, fechaFin: TDate);
const
  reporte = 'prodDevDetalle.lrf';
begin
  with qLstProductosDevueltos do
  begin
    if active then close;
    ParamByName('fechaIni').AsDate:= fechaIni;
    ParamByName('fechaFin').AsDate:= fechaFin;
    Open;
    LevantarReporte(reporte, qLstProductosDevueltos);
  end;
end;

procedure TDM_Listados.ProductosDevueltosTotalizado(fechaIni, fechaFin: TDate);
const
  reporte = 'prodDevTotalizado.lrf';
begin
  with qLstProductosDevTotalizados do
  begin
    if active then close;
    ParamByName('fechaIni').AsDate:= fechaIni;
    ParamByName('fechaFin').AsDate:= fechaFin;
    Open;
    DM_General.LevantarReporte(reporte, qLstProductosDevTotalizados);
    DM_General.AgregarVariableReporte('fechaIni', DateToStr(fechaIni));
    DM_General.AgregarVariableReporte('fechaFin', DateToStr(fechaFin));
    DM_General.EjecutarReporte;
  end;
end;

procedure TDM_Listados.ProductosConsumidos(fechaIni, fechaFin: TDate);
const
  reporte = 'prodConsTiempo.lrf';
begin
  with qLstProdConsTiempo do
  begin
    if active then close;
    ParamByName('fechaIni').AsDate:= fechaIni;
    ParamByName('fechaFin').AsDate:= fechaFin;
    Open;
    DM_General.LevantarReporte(reporte, qLstProdConsTiempo);
    DM_General.AgregarVariableReporte('fechaIni', DateToStr(fechaIni));
    DM_General.AgregarVariableReporte('fechaFin', DateToStr(fechaFin));
    DM_General.EjecutarReporte;
  end;
end;

procedure TDM_Listados.ListaDePrecios(refLista: integer);
const
  reporte = 'listaprecio.lrf';
begin
  with qLstListaPrecios do
  begin
    if active then close;
    ParamByName('listaprecio_id').AsInteger:= refLista;
    Open;
    LevantarReporte(reporte, qLstListaPrecios);
  end;
end;

end.

