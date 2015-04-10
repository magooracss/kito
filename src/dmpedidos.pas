unit dmpedidos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;


type

  { TDM_Pedidos }

  TDM_Pedidos = class(TDataModule)
    Pedidos: TRxMemoryData;
    PedidosDetalles: TRxMemoryData;
    PedidosEstados: TRxMemoryData;
    DELPedidos: TZQuery;
    DELPedidosDetalles: TZQuery;
    DELPedidosEstados: TZQuery;
    INSPedidos: TZQuery;
    INSPedidosDetalles: TZQuery;
    INSPedidosEstados: TZQuery;
    PedidosbDescuento: TLongintField;
    PedidosbFacturado: TLongintField;
    PedidosbVisible: TLongintField;
    Pedidoscliente_id: TStringField;
    PedidosDetallesbDescuento: TLongintField;
    PedidosDetallesbVisible: TLongintField;
    PedidosDetallescantidad: TFloatField;
    PedidosDetallesid: TStringField;
    PedidosDetalleslistaPrecio_id: TLongintField;
    PedidosDetallespedido_id: TStringField;
    PedidosDetallesporcentajeAplicar: TFloatField;
    PedidosDetallespreciosSubtotal: TFloatField;
    PedidosDetallesprecioTotal: TFloatField;
    PedidosDetallesprecioUnitario: TFloatField;
    PedidosestadoActual_id: TStringField;
    PedidosEstadosbVisible: TLongintField;
    PedidosEstadosfecha: TDateTimeField;
    PedidosEstadosid: TStringField;
    PedidosEstadosNotas: TStringField;
    PedidosEstadospedido_id: TStringField;
    PedidosEstadostipoEstado_id: TLongintField;
    Pedidosfactura_id: TStringField;
    PedidosfAEntregar: TDateTimeField;
    PedidosfFacturacion: TDateTimeField;
    PedidosfToma: TDateTimeField;
    PedidosgastosEnvio: TFloatField;
    Pedidosid: TStringField;
    PedidosmontoAplicar: TFloatField;
    Pedidosnumero: TLongintField;
    PedidospagoAnticipado: TFloatField;
    PedidosporcentajeAplicar: TFloatField;
    PedidosTotalPedido: TFloatField;
    Pedidostransportista_id: TStringField;
    PedidostxNotas: TStringField;
    Pedidosvendedor_id: TStringField;
    qEstadosBVISIBLE: TSmallintField;
    qEstadosID: TLongintField;
    qEstadosTIPOESTADO: TStringField;
    SELPedidos: TZQuery;
    SELPedidosDetalles: TZQuery;
    SELPedidosEstados: TZQuery;
    SELPedidosBDESCUENTO: TSmallintField;
    SELPedidosBFACTURADO: TSmallintField;
    SELPedidosBVISIBLE: TSmallintField;
    SELPedidosCLIENTE_ID: TStringField;
    SELPedidosDetallesBDESCUENTO: TSmallintField;
    SELPedidosDetallesBVISIBLE: TSmallintField;
    SELPedidosDetallesCANTIDAD: TFloatField;
    SELPedidosDetallesID: TStringField;
    SELPedidosDetallesLISTAPRECIO_ID: TLongintField;
    SELPedidosDetallesPEDIDO_ID: TStringField;
    SELPedidosDetallesPORCENTAJEAPLICAR: TFloatField;
    SELPedidosDetallesPRECIOSUBTOTAL: TFloatField;
    SELPedidosDetallesPRECIOTOTAL: TFloatField;
    SELPedidosDetallesPRECIOUNITARIO: TFloatField;
    SELPedidosDetallesPRODUCTO_ID: TStringField;
    SELPedidosESTADOACTUAL_ID: TStringField;
    qEstados: TZQuery;
    SELPedidosEstadosBVISIBLE: TSmallintField;
    SELPedidosEstadosFECHA: TDateField;
    SELPedidosEstadosID: TStringField;
    SELPedidosEstadosNOTAS: TStringField;
    SELPedidosEstadosPEDIDO_ID: TStringField;
    SELPedidosEstadosTIPOESTADO_ID: TLongintField;
    SELPedidosFACTURA_ID: TStringField;
    SELPedidosFAENTREGAR: TDateField;
    SELPedidosFFACTURACION: TDateField;
    SELPedidosFTOMA: TDateField;
    SELPedidosGASTOSENVIO: TFloatField;
    SELPedidosID: TStringField;
    SELPedidosMONTOAPLICAR: TFloatField;
    SELPedidosNUMERO: TLongintField;
    SELPedidosPAGOANTICIPADO: TFloatField;
    SELPedidosPORCENTAJEAPLICAR: TFloatField;
    SELPedidosTOTALPEDIDO: TFloatField;
    SELPedidosTRANSPORTISTA_ID: TStringField;
    SELPedidosTXNOTAS: TStringField;
    SELPedidosVENDEDOR_ID: TStringField;
    UPDPedidos: TZQuery;
    UPDPedidosDetalles: TZQuery;
    UPDPedidosEstados: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure PedidosAfterInsert(DataSet: TDataSet);
    procedure PedidosDetallesAfterInsert(DataSet: TDataSet);
    procedure PedidosEstadosAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure Grabar;
    procedure Nuevo;
    procedure LevantarPedido(refPedido: GUID_ID);
  end;

var
  DM_Pedidos: TDM_Pedidos;

implementation

{$R *.lfm}

{ TDM_Pedidos }

procedure TDM_Pedidos.PedidosAfterInsert(DataSet: TDataSet);
begin
  Pedidosid.AsString:= DM_General.CrearGUID;
  Pedidosnumero.AsInteger:= -1;
  Pedidoscliente_id.AsString:= GUIDNULO;
  PedidostxNotas.AsString:= EmptyStr;
  Pedidosvendedor_id.AsString:= GUIDNULO;
  PedidosfToma.AsDateTime:= Now;
  PedidosfAEntregar.AsDateTime:= Now;
  PedidospagoAnticipado.AsFloat:= 0;
  Pedidostransportista_id.AsString:= GUIDNULO;
  PedidosgastosEnvio.AsFloat:= 0;
  PedidosestadoActual_id.AsString:= GUIDNULO;
  PedidosbFacturado.AsInteger:= 0;
  PedidosfFacturacion.AsDateTime:= 0;
  Pedidosfactura_id.AsString:= GUIDNULO;
  PedidosporcentajeAplicar.AsFloat:= 0;
  PedidosmontoAplicar.AsFloat:= 0;
  PedidosbDescuento.AsInteger:= 1;
  PedidosTotalPedido.AsFloat:= 0;
  PedidosbVisible.AsInteger:=1;
end;

procedure TDM_Pedidos.DataModuleCreate(Sender: TObject);
begin
  qEstados.Open;
end;

procedure TDM_Pedidos.PedidosDetallesAfterInsert(DataSet: TDataSet);
begin
  PedidosDetallesid.AsString:= DM_General.CrearGUID;
  PedidosDetallespedido_id.AsString:= Pedidosid.AsString;
  PedidosDetalleslistaPrecio_id.AsInteger:= 0;
  PedidosDetallesprecioUnitario.AsFloat:= 0;
  PedidosDetallesporcentajeAplicar.AsFloat:= 0;
  PedidosDetallesbDescuento.AsInteger:= 1;
  PedidosDetallespreciosSubtotal.AsFloat:= 0;
  PedidosDetallesprecioTotal.AsFloat:=0;
  PedidosDetallescantidad.AsFloat:=0;
  PedidosDetallesbVisible.AsInteger:= 1;
end;

procedure TDM_Pedidos.PedidosEstadosAfterInsert(DataSet: TDataSet);
begin
  PedidosEstadosid.AsString:= DM_General.CrearGUID;
  PedidosEstadospedido_id.AsString:= Pedidosid.AsString;
  PedidosEstadosfecha.AsDateTime:= Now;
  PedidosEstadostipoEstado_id.AsInteger:= 0;
  PedidosEstadosNotas.AsString:= EmptyStr;
  PedidosEstadosbVisible.AsInteger:= 1;
end;

procedure TDM_Pedidos.Grabar;
begin
  DM_General.GrabarDatos(SELPedidos, INSPedidos, UPDPedidos, Pedidos, 'id');
  DM_General.GrabarDatos(SELPedidosDetalles, INSPedidosDetalles, UPDPedidosDetalles, PedidosDetalles, 'id');
  DM_General.GrabarDatos(SELPedidosEstados, INSPedidosEstados, UPDPedidosEstados, PedidosEstados, 'id');
end;

procedure TDM_Pedidos.Nuevo;
begin
  DM_General.ReiniciarTabla(Pedidos);
  DM_General.ReiniciarTabla(PedidosDetalles);
  DM_General.ReiniciarTabla(PedidosEstados);
  Pedidos.Insert;
end;

procedure TDM_Pedidos.LevantarPedido(refPedido: GUID_ID);
begin
  DM_General.ReiniciarTabla(Pedidos);
  DM_General.ReiniciarTabla(PedidosDetalles);
  DM_General.ReiniciarTabla(PedidosEstados);

  With SELPedidos do
  begin
    if active then close;
    ParamByName('refPedido').asString:= refPedido;
    Open;
    Pedidos.LoadFromDataSet(SELPedidos, 0, lmAppend);
    Close;
  end;
  { TODO : Falta levantar detalles y estados}
end;

end.

