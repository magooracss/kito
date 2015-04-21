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
  LST_ListaClientesZona = 5; //Lista de clientes por zona
  LST_ListaClientesVendedor = 6; //Lista de clientes por Vendedor
  LST_ListaClientesCompleta = 7; //Todos los clientes
  LST_PedidosVendedor = 8; //Pedidos por vendedor entre fechas de tomado
  LST_PedidosCliente = 9; //Pedidos por cliente entre fechas de tomado
  LST_PedidosFechasTomado = 10; //Pedidos entre fechas de tomado
  LST_PedidosTransportista = 11; //Pedidos por transportista entre fechas de tomado
  LST_PedidosEstado = 12; //Pedidos por estado entre fechas de estado


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
    qLstListaClientesZonas: TZQuery;
    qLstListaTodosClientes: TZQuery;
    qLstListaClientesZonasCODIGO: TStringField;
    qLstListaClientesZonasCONDICIONFISCAL: TStringField;
    qLstListaClientesZonasCONTACTO: TStringField;
    qLstListaClientesZonasCUIT: TStringField;
    qLstListaClientesZonasDOMICILIO: TStringField;
    qLstListaClientesZonasLISTAPRECIO: TStringField;
    qLstListaClientesZonasLOCALIDAD: TStringField;
    qLstListaClientesZonasRAZONSOCIAL: TStringField;
    qLstListaClientesZonasTIPOCONTACTO: TStringField;
    qLstListaClientesZonasZONA: TStringField;
    qLstPedidosPorEstadoCLIENTE_CODIGO: TStringField;
    qLstPedidosPorEstadoCLIENTE_RAZONSOCIAL: TStringField;
    qLstPedidosPorEstadoFECHAESTADO: TDateField;
    qLstPedidosPorEstadoFTOMA: TDateField;
    qLstPedidosPorEstadoNUMERO: TLongintField;
    qLstPedidosPorEstadoTIPOESTADO: TStringField;
    qLstPedidosPorEstadoTOTALPEDIDO: TFloatField;
    qLstPedidosPorEstadoTRANSPORTISTA_CODIGO: TStringField;
    qLstPedidosPorEstadoTRANSPORTISTA_RAZONSOCIAL: TStringField;
    qLstPedidosPorEstadoVENDEDOR_CODIGO: TStringField;
    qLstPedidosPorEstadoVENDEDOR_RAZONSOCIAL: TStringField;
    qLstPedidosPorTransportista: TZQuery;
    qLstPedidosPorTransportistaCLIENTE_CODIGO: TStringField;
    qLstPedidosPorTransportistaCLIENTE_RAZONSOCIAL: TStringField;
    qLstPedidosPorTransportistaFECHAESTADO: TDateField;
    qLstPedidosPorTransportistaFTOMA: TDateField;
    qLstPedidosPorTransportistaNUMERO: TLongintField;
    qLstPedidosPorTransportistaTIPOESTADO: TStringField;
    qLstPedidosPorTransportistaTOTALPEDIDO: TFloatField;
    qLstPedidosPorTransportistaTRANSPORTISTA_CODIGO: TStringField;
    qLstPedidosPorTransportistaTRANSPORTISTA_RAZONSOCIAL: TStringField;
    qLstPedidosPorTransportistaVENDEDOR_CODIGO: TStringField;
    qLstPedidosPorTransportistaVENDEDOR_RAZONSOCIAL: TStringField;
    qLstPedidosTomados: TZQuery;
    qLstPedidosPorClienteCLIENTE_CODIGO: TStringField;
    qLstPedidosPorClienteCLIENTE_RAZONSOCIAL: TStringField;
    qLstPedidosPorClienteFECHAESTADO: TDateField;
    qLstPedidosPorClienteFTOMA: TDateField;
    qLstPedidosPorClienteNUMERO: TLongintField;
    qLstPedidosPorClienteTIPOESTADO: TStringField;
    qLstPedidosPorClienteTOTALPEDIDO: TFloatField;
    qLstPedidosPorClienteTRANSPORTISTA_CODIGO: TStringField;
    qLstPedidosPorClienteTRANSPORTISTA_RAZONSOCIAL: TStringField;
    qLstPedidosPorClienteVENDEDOR_CODIGO: TStringField;
    qLstPedidosPorClienteVENDEDOR_RAZONSOCIAL: TStringField;
    qLstPedidosPorVendedor: TZQuery;
    qLstListaTodosClientesCODIGO: TStringField;
    qLstListaTodosClientesCONDICIONFISCAL: TStringField;
    qLstListaTodosClientesCONTACTO: TStringField;
    qLstListaTodosClientesCUIT: TStringField;
    qLstListaTodosClientesDOMICILIO: TStringField;
    qLstListaTodosClientesLISTAPRECIO: TStringField;
    qLstListaTodosClientesLOCALIDAD: TStringField;
    qLstListaTodosClientesRAZONSOCIAL: TStringField;
    qLstListaTodosClientesTIPOCONTACTO: TStringField;
    qLstListaTodosClientesZONA: TStringField;
    qLstPedidosPorCliente: TZQuery;
    qLstPedidosPorVendedorCLIENTE_CODIGO: TStringField;
    qLstPedidosPorVendedorCLIENTE_RAZONSOCIAL: TStringField;
    qLstPedidosPorVendedorFECHAESTADO: TDateField;
    qLstPedidosPorVendedorFTOMA: TDateField;
    qLstPedidosPorVendedorNUMERO: TLongintField;
    qLstPedidosPorVendedorTIPOESTADO: TStringField;
    qLstPedidosPorVendedorTOTALPEDIDO: TFloatField;
    qLstPedidosPorVendedorTRANSPORTISTA_CODIGO: TStringField;
    qLstPedidosPorVendedorTRANSPORTISTA_RAZONSOCIAL: TStringField;
    qLstPedidosPorVendedorVENDEDOR_CODIGO: TStringField;
    qLstPedidosPorVendedorVENDEDOR_RAZONSOCIAL: TStringField;
    qLstPedidosPorEstado: TZQuery;
    qLstPedidosTomadosCLIENTE_CODIGO: TStringField;
    qLstPedidosTomadosCLIENTE_CODIGO1: TStringField;
    qLstPedidosTomadosCLIENTE_RAZONSOCIAL: TStringField;
    qLstPedidosTomadosCLIENTE_RAZONSOCIAL1: TStringField;
    qLstPedidosTomadosFECHAESTADO: TDateField;
    qLstPedidosTomadosFECHAESTADO1: TDateField;
    qLstPedidosTomadosFTOMA: TDateField;
    qLstPedidosTomadosFTOMA1: TDateField;
    qLstPedidosTomadosNUMERO: TLongintField;
    qLstPedidosTomadosNUMERO1: TLongintField;
    qLstPedidosTomadosTIPOESTADO: TStringField;
    qLstPedidosTomadosTIPOESTADO1: TStringField;
    qLstPedidosTomadosTOTALPEDIDO: TFloatField;
    qLstPedidosTomadosTOTALPEDIDO1: TFloatField;
    qLstPedidosTomadosTRANSPORTISTA_CODIGO: TStringField;
    qLstPedidosTomadosTRANSPORTISTA_CODIGO1: TStringField;
    qLstPedidosTomadosTRANSPORTISTA_RAZONSOCIAL: TStringField;
    qLstPedidosTomadosTRANSPORTISTA_RAZONSOCIAL1: TStringField;
    qLstPedidosTomadosVENDEDOR_CODIGO: TStringField;
    qLstPedidosTomadosVENDEDOR_CODIGO1: TStringField;
    qLstPedidosTomadosVENDEDOR_RAZONSOCIAL: TStringField;
    qLstPedidosTomadosVENDEDOR_RAZONSOCIAL1: TStringField;
    qPedidosTiposEstadosBVISIBLE: TSmallintField;
    qPedidosTiposEstadosID: TLongintField;
    qPedidosTiposEstadosTIPOESTADO: TStringField;
    qZonas: TZQuery;
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
    qPedidosTiposEstados: TZQuery;
    qZonasBVISIBLE: TSmallintField;
    qZonasID: TLongintField;
    qZonasZONA: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure LevantarReporte (elReporte: string; var consulta: TZQuery);
    procedure LevantarReporteFechas (elReporte: string; Fini, FFin: TDate; var consulta: TZQuery);
  public
    procedure ListadoPorGrupo (refGrupo: integer);

    procedure StockMinimimo;
    procedure ProductosDevueltosDetalle (fechaIni, fechaFin: TDate);
    procedure ProductosDevueltosTotalizado (fechaIni, fechaFin: TDate);
    procedure ProductosConsumidos (fechaIni, fechaFin: TDate);
    procedure ListaDePrecios (refLista: integer);
    procedure ListaClientesZonas (refZona: integer);
    procedure ListaClientesTodos;
    procedure PedidosVendedor(refVendedor: GUID_ID; fechaIni, fechaFin: TDate);
    procedure PedidosCliente(refCliente: GUID_ID; fechaIni, fechaFin: TDate);
    procedure PedidosFechaTomado (fechaIni, fechaFin: TDate);
    procedure PedidosTransportista(refTransportista: GUID_ID; fechaIni, fechaFin: TDate);
    procedure PedidosPorEstado (refEstado: integer; fechaIni, fechaFin: TDate );

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

procedure TDM_Listados.LevantarReporteFechas(elReporte: string; Fini,
  FFin: TDate; var consulta: TZQuery);
begin
  DM_General.LevantarReporte(elReporte, consulta);
  DM_General.AgregarVariableReporte('fechaIni', DateToStr(Fini));
  DM_General.AgregarVariableReporte('fechaFin', DateToStr(FFin));
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
    LevantarReporteFechas(reporte, fechaIni, fechaFin, qLstProductosDevTotalizados);
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

procedure TDM_Listados.ListaClientesZonas(refZona: integer);
const
  reporte = 'listaCliZonas.lrf';
begin
  with qLstListaClientesZonas do
  begin
    if active then close;
    ParamByName('zona_id').AsInteger:= refZona;
    Open;
    LevantarReporte(reporte, qLstListaClientesZonas);
  end;
end;

procedure TDM_Listados.ListaClientesTodos;
const
  reporte = 'listaClientes.lrf';
begin
  with qLstListaTodosClientes do
  begin
    if active then close;
    Open;
    LevantarReporte(reporte, qLstListaTodosClientes);
  end;
end;

procedure TDM_Listados.PedidosVendedor(refVendedor: GUID_ID; fechaIni,
  fechaFin: TDate);
const
  reporte = 'pedidosVendFToma.lrf';
begin
  with qLstPedidosPorVendedor do
  begin
    if active then close;
    ParamByName('vendedor_id').asString:= refVendedor;
    ParamByName('Fini').AsDate:= fechaIni ;
    ParamByName('FFin').AsDate:= fechaFin;
    Open;
    LevantarReporteFechas(reporte,fechaIni, fechaFin, qLstPedidosPorVendedor);
  end;
end;

procedure TDM_Listados.PedidosCliente(refCliente: GUID_ID; fechaIni,
  fechaFin: TDate);
const
  reporte = 'pedidosClienteFToma.lrf';
begin
  with qLstPedidosPorCliente do
  begin
    if active then close;
    ParamByName('cliente_id').asString:= refCliente;
    ParamByName('Fini').AsDate:= fechaIni ;
    ParamByName('FFin').AsDate:= fechaFin;
    Open;
    LevantarReporteFechas(reporte,fechaIni, fechaFin, qLstPedidosPorCliente);
  end;
end;

procedure TDM_Listados.PedidosFechaTomado(fechaIni, fechaFin: TDate);
const
  reporte = 'pedidosFToma.lrf';
begin
  with qLstPedidosTomados do
  begin
    if active then close;
    ParamByName('Fini').AsDate:= fechaIni;
    ParamByName('FFin').AsDate:= fechaFin;
    Open;
    LevantarReporteFechas(reporte,fechaIni, fechaFin, qLstPedidosTomados);
  end;
end;

procedure TDM_Listados.PedidosTransportista(refTransportista: GUID_ID;
  fechaIni, fechaFin: TDate);
const
  reporte = 'pedidosTransportistaFToma.lrf';
begin
  with qLstPedidosPorTransportista do
  begin
    if active then close;
    ParamByName('transportista_id').asString:= refTransportista;
    ParamByName('Fini').AsDate:= fechaIni ;
    ParamByName('FFin').AsDate:= fechaFin;
    Open;
    LevantarReporteFechas(reporte,fechaIni, fechaFin, qLstPedidosPorTransportista);
  end;
end;

procedure TDM_Listados.PedidosPorEstado(refEstado: integer; fechaIni,
  fechaFin: TDate);
const
  reporte = 'pedidosEstadosFecha.lrf';
begin
  with qLstPedidosPorEstado do
  begin
    if active then close;
    ParamByName('tipoEstado_id').AsInteger:= refEstado;
    ParamByName('Fini').AsDate:= fechaIni ;
    ParamByName('FFin').AsDate:= fechaFin;
    Open;
    LevantarReporteFechas(reporte,fechaIni, fechaFin, qLstPedidosPorEstado);
  end;
end;

end.

