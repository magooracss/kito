unit dmpedidos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;

const
  FORMULARIO_PEDIDO = 'frmPedido.lrf';

  EST_TOMADO = 1; //Estado Tomado
  EST_ARMADO = 2; //Estado Armado
  EST_TRANSP = 3; //Estado En Transporte
  EST_ENTREGADO = 4; // Estado Entregado
  EST_RECHAZADO = 5; // Estado Rechazado
  EST_DEVPARCIAL = 6; //Estado Devolución parcial
  EST_FACTURADO = 7; //Estado Facturado


type

  { TDM_Pedidos }

  TDM_Pedidos = class(TDataModule)
    Pedidos: TRxMemoryData;
    PedidosbDescuento: TLongintField;
    PedidosbFacturado: TLongintField;
    PedidosbVisible: TLongintField;
    Pedidoscliente_id: TStringField;
    PedidosDetalles: TRxMemoryData;
    PedidosDetallesbDescuento: TLongintField;
    PedidosDetallesbVisible: TLongintField;
    PedidosDetallescantidad: TFloatField;
    PedidosDetallesid: TStringField;
    PedidosDetalleslistaPrecio_id: TLongintField;
    PedidosDetalleslxCodigo: TStringField;
    PedidosDetalleslxListaPrecio: TStringField;
    PedidosDetalleslxProducto: TStringField;
    PedidosDetallespedido_id: TStringField;
    PedidosDetallesporcentajeAplicar: TFloatField;
    PedidosDetallesprecioSubtotal: TFloatField;
    PedidosDetallesprecioTotal: TFloatField;
    PedidosDetallesprecioUnitario: TFloatField;
    PedidosDetallesprecio_id: TStringField;
    PedidosDetallesproducto_id: TStringField;
    PedidosestadoActual_id: TStringField;
    PedidosEstados: TRxMemoryData;
    DELPedidos: TZQuery;
    DELPedidosDetalles: TZQuery;
    DELPedidosEstados: TZQuery;
    INSPedidos: TZQuery;
    INSPedidosDetalles: TZQuery;
    INSPedidosEstados: TZQuery;
    PedidosEstadosbVisible: TLongintField;
    PedidosEstadosfecha: TDateTimeField;
    PedidosEstadosid: TStringField;
    PedidosEstadoslxEstado: TStringField;
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
    qDetallesPedidoPRECIO_ID: TStringField;
    qPedidosDetalleProducto: TZQuery;
    qDetallesPedidoBDESCUENTO: TSmallintField;
    qDetallesPedidoBVISIBLE: TSmallintField;
    qDetallesPedidoCANTIDAD: TFloatField;
    qDetallesPedidoID: TStringField;
    qDetallesPedidoLISTAPRECIO_ID: TLongintField;
    qDetallesPedidoLXCODIGO: TStringField;
    qDetallesPedidoLXLISTAPRECIO: TStringField;
    qDetallesPedidoLXPRODUCTO: TStringField;
    qDetallesPedidoPEDIDO_ID: TStringField;
    qDetallesPedidoPORCENTAJEAPLICAR: TFloatField;
    qDetallesPedidoPRECIOSUBTOTAL: TFloatField;
    qDetallesPedidoPRECIOTOTAL: TFloatField;
    qDetallesPedidoPRECIOUNITARIO: TFloatField;
    qDetallesPedidoPRODUCTO_ID: TStringField;
    qEstadoPorID: TZQuery;
    qEstadoPorIDBVISIBLE: TSmallintField;
    qEstadoPorIDID: TLongintField;
    qEstadoPorIDTIPOESTADO: TStringField;
    qEstadosBVISIBLE: TSmallintField;
    qEstadosID: TLongintField;
    qEstadosTIPOESTADO: TStringField;
    qPedidosDetalleProductoBDESCUENTO: TSmallintField;
    qPedidosDetalleProductoBVISIBLE: TSmallintField;
    qPedidosDetalleProductoCANTIDAD: TFloatField;
    qPedidosDetalleProductoID: TStringField;
    qPedidosDetalleProductoLISTAPRECIO_ID: TLongintField;
    qPedidosDetalleProductoPEDIDO_ID: TStringField;
    qPedidosDetalleProductoPORCENTAJEAPLICAR: TFloatField;
    qPedidosDetalleProductoPRECIOSUBTOTAL: TFloatField;
    qPedidosDetalleProductoPRECIOTOTAL: TFloatField;
    qPedidosDetalleProductoPRECIOUNITARIO: TFloatField;
    qPedidosDetalleProductoPRECIO_ID: TStringField;
    qPedidosDetalleProductoPRODUCTO_ID: TStringField;
    qPedidosEstadosHistorialBVISIBLE: TSmallintField;
    qPedidosEstadosHistorialFECHA: TDateField;
    qPedidosEstadosHistorialID: TStringField;
    qPedidosEstadosHistorialLXESTADO: TStringField;
    qPedidosEstadosHistorialNOTAS: TStringField;
    qPedidosEstadosHistorialPEDIDO_ID: TStringField;
    qPedidosEstadosHistorialTIPOESTADO_ID: TLongintField;
    qPrecio: TZQuery;
    qPrecioALICUOTAIVA_ID: TLongintField;
    qPrecioBOFERTA: TSmallintField;
    qPrecioBVISIBLE: TSmallintField;
    qPrecioBVISIBLE1: TSmallintField;
    qPrecioID: TStringField;
    qPrecioID1: TStringField;
    qPrecioIVA: TFloatField;
    qPrecioIVA1: TFloatField;
    qPrecioLISTAPRECIO_ID: TLongintField;
    qPrecioLISTAPRECIO_ID1: TLongintField;
    qPrecioMONTO: TFloatField;
    qPrecioMONTO1: TFloatField;
    qPrecioOFERTAFIN: TDateField;
    qPrecioOFERTAINI: TDateField;
    qPrecioPRODUCTO_ID: TStringField;
    qPrecioPRODUCTO_ID1: TStringField;
    SELPedidos: TZQuery;
    SELPedidosDetalles: TZQuery;
    qDetallesPedido: TZQuery;
    SELPedidosDetallesLXCODIGO: TStringField;
    SELPedidosDetallesLXLISTAPRECIO: TStringField;
    SELPedidosDetallesLXPRODUCTO: TStringField;
    SELPedidosDetallesPRECIO_ID: TStringField;
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
    qPedidosEstadosHistorial: TZQuery;
    SELPedidosEstadosBVISIBLE: TSmallintField;
    SELPedidosEstadosBVISIBLE2: TSmallintField;
    SELPedidosEstadosFECHA: TDateField;
    SELPedidosEstadosFECHA2: TDateField;
    SELPedidosEstadosID: TStringField;
    SELPedidosEstadosID2: TStringField;
    SELPedidosEstadosLXESTADO: TStringField;
    SELPedidosEstadosLXESTADO2: TStringField;
    SELPedidosEstadosNOTAS: TStringField;
    SELPedidosEstadosNOTAS2: TStringField;
    SELPedidosEstadosPEDIDO_ID: TStringField;
    SELPedidosEstadosPEDIDO_ID2: TStringField;
    SELPedidosEstadosTIPOESTADO_ID: TLongintField;
    SELPedidosEstadosTIPOESTADO_ID2: TLongintField;
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

    function TotalProductosPedidos: Double;
  public
    procedure Grabar;
    procedure Nuevo;
    procedure LevantarPedido(refPedido: GUID_ID);
    procedure VincularFactura (refPedido, refFactura: GUID_ID; fecha: TDate);
    procedure AjustarMontoPedido;
    procedure AjustarPreciosProducto;



    procedure NuevoProducto (productoID: GUID_ID; listaPrecioID: integer
                             ; cantidad: Double);
    procedure LevantarDetallePedido;
    function CantidadArticulosPedido: LongInt;

    procedure EliminarProducto;

    procedure LevantarPedidoHistorialEstados;
    procedure GrabarEstados;
    procedure LevantarEstadoActual;
    procedure CambiarEstado (estadoID: integer; fecha: TDateTime; obs: String);
    procedure BorrarEstado (idEstado: GUID_ID);

    procedure CambiarEstadoPedido(estadoID: integer; pedidoID: GUID_ID);

    procedure ImprimirFrmPedido (refPedido: GUID_ID);

  end;

var
  DM_Pedidos: TDM_Pedidos;

implementation
{$R *.lfm}
uses
  dmproductos
  ,dmvendedores
  ,dmtransportistas
  ,dmclientes
  ;

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
  PedidosDetallesproducto_id.AsString:= GUIDNULO;
  PedidosDetalleslistaPrecio_id.AsInteger:= 0;
  PedidosDetallesprecioUnitario.AsFloat:= 0;
  PedidosDetallesporcentajeAplicar.AsFloat:= 0;
  PedidosDetallesbDescuento.AsInteger:= 1;
  PedidosDetallesprecioSubtotal.AsFloat:= 0;
  PedidosDetallesprecioTotal.AsFloat:=0;
  PedidosDetallescantidad.AsFloat:=0;
  PedidosDetallesbVisible.AsInteger:= 1;
  PedidosDetallesprecio_id.asString:= GUIDNULO;
end;

procedure TDM_Pedidos.PedidosEstadosAfterInsert(DataSet: TDataSet);
begin
  PedidosEstadosid.AsString:= DM_General.CrearGUID;
  PedidosEstadospedido_id.AsString:= Pedidosid.AsString;
  PedidosEstadosfecha.AsDateTime:= Now;
  PedidosEstadostipoEstado_id.AsInteger:= 0;
  PedidosEstadosNotas.AsString:= '-';
  PedidosEstadosbVisible.AsInteger:= 1;
end;

procedure TDM_Pedidos.Grabar;
begin
  DM_General.cnxBase.StartTransaction;
  try
    DM_General.GrabarDatos(SELPedidos, INSPedidos, UPDPedidos, Pedidos, 'id');
    DM_General.GrabarDatos(SELPedidosDetalles, INSPedidosDetalles, UPDPedidosDetalles, PedidosDetalles, 'id');
    GrabarEstados;
    DM_General.cnxBase.Commit;
  Except
    DM_General.cnxBase.Rollback;
  end;
end;

procedure TDM_Pedidos.Nuevo;
begin
  DM_General.ReiniciarTabla(Pedidos);
  DM_General.ReiniciarTabla(PedidosDetalles);
  DM_General.ReiniciarTabla(PedidosEstados);
  Pedidos.Insert;
  CambiarEstado(EST_TOMADO, Now, ' ');
end;

procedure TDM_Pedidos.LevantarPedido(refPedido: GUID_ID);
begin
  DM_General.ReiniciarTabla(Pedidos);
  DM_General.ReiniciarTabla(PedidosDetalles);
  DM_General.ReiniciarTabla(PedidosEstados);

  With SELPedidos do
  begin
    if active then close;
    ParamByName('id').asString:= refPedido;
    Open;
    Pedidos.LoadFromDataSet(SELPedidos, 0, lmAppend);
    Close;
  end;

  LevantarDetallePedido;
  LevantarEstadoActual;
end;

procedure TDM_Pedidos.VincularFactura(refPedido, refFactura: GUID_ID;
  fecha: TDate);
begin
  LevantarPedido(refPedido);
  if((Pedidos.Active) and (Pedidos.RecordCount > 0)) then
  begin
    Pedidos.Edit;
    Pedidosfactura_id.AsString:= refFactura;
    PedidosfFacturacion.AsDateTime:= fecha;
    Pedidos.Post;
  end;
  Grabar;
end;

procedure TDM_Pedidos.AjustarMontoPedido;
var
  TotalProductos, TotalPedido: Double;
  MontoAplicar: Double;
begin
  TotalProductos:= TotalProductosPedidos;
  MontoAplicar:= 0;
  TotalPedido:= 0;
  with Pedidos do
  begin
    if (PedidosmontoAplicar.AsFloat <> 0)then
      MontoAplicar:= PedidosMontoAplicar.AsFloat
    else
      if (PedidosporcentajeAplicar.AsFloat <> 0) then
        MontoAplicar:= (PedidosporcentajeAplicar.asFloat * totalProductos) /100;

    if PedidosbDescuento.AsInteger = 1 then
      TotalPedido:= totalProductos - MontoAplicar
    else
      TotalPedido:= totalProductos + MontoAplicar;

    TotalPedido:= TotalPedido - PedidospagoAnticipado.AsFloat
                +  PedidosgastosEnvio.AsFloat  ;

    Edit;
    PedidosTotalPedido.AsFloat:= TotalPedido;
    Post;
  end;
end;

(*******************************************************************************
*** ESTADOS DE LOS PEDIDOS
*******************************************************************************)
procedure TDM_Pedidos.CambiarEstado(estadoID: integer; fecha: TDateTime;
  obs: String);
begin
  with qEstadoPorID do
  begin
    if active then close;
    ParamByName('id').asInteger:= estadoID;
    Open;
  end;

  with PedidosEstados do
  begin
    Insert;
    PedidosEstadostipoEstado_id.AsInteger:= estadoID;
    PedidosEstadosfecha.AsDateTime:= fecha;
    PedidosEstadosNotas.AsString:= obs;
    PedidosEstadoslxEstado.asString:= qEstadoPorIDTIPOESTADO.AsString;
    Post;
  End;

  With Pedidos do
  begin
    Edit;
    PedidosestadoActual_id.asString:= PedidosEstadosid.AsString;
    Post;
  end;
end;


procedure TDM_Pedidos.CambiarEstadoPedido(estadoID: integer; pedidoID: GUID_ID);
begin
  LevantarPedido(pedidoID);
  CambiarEstado(estadoID,Now, '-');
  Grabar;
end;




procedure TDM_Pedidos.LevantarPedidoHistorialEstados;
begin
  With qPedidosEstadosHistorial do
  begin
    if active then close;
    ParamByName('pedido_id').asString:= Pedidosid.AsString;
    Open;
  end;
end;

procedure TDM_Pedidos.GrabarEstados;
begin
   DM_General.GrabarDatos(SELPedidosEstados, INSPedidosEstados, UPDPedidosEstados, PedidosEstados, 'id');
end;

procedure TDM_Pedidos.LevantarEstadoActual;
begin
  DM_General.ReiniciarTabla(PedidosEstados);
  with SELPedidosEstados do
  begin
    if Active then Close;
    ParamByName('id').asString:= PedidosestadoActual_id.AsString;
    Open;
    PedidosEstados.LoadFromDataSet(SELPedidosEstados, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_Pedidos.BorrarEstado(idEstado: GUID_ID);
begin
  with DELPedidosEstados do
  begin
    ParamByName('id').AsString:= idEstado;
    ExecSQL;
  end;
  if PedidosestadoActual_id.AsString = idEstado then
  begin
    LevantarPedidoHistorialEstados;
    if qPedidosEstadosHistorial.RecordCount > 0 then
    begin
      with Pedidos do
      begin
        Edit;
        PedidosestadoActual_id.AsString:= qPedidosEstadosHistorialID.AsString;
        Post;
      end;
    end;
  end;

end;


(*******************************************************************************
*** PRODUCTOS PEDIDOS
*******************************************************************************)
function TDM_Pedidos.TotalProductosPedidos: Double;
var
  elTotal: Double;
  marca: TBookmark;
begin
  elTotal:= 0;
  marca:= PedidosDetalles.GetBookmark;

  with PedidosDetalles do
  begin
    First;
    While Not EOF do
    begin
      elTotal:= elTotal + PedidosDetallesprecioTotal.AsFloat;
      Next;
    end;
  end;
  Result:= elTotal;
  PedidosDetalles.GotoBookmark(marca);
  PedidosDetalles.FreeBookmark(marca);
end;

procedure TDM_Pedidos.NuevoProducto(productoID: GUID_ID;
  listaPrecioID: integer; cantidad: Double);
begin

  with PedidosDetalles do
  begin
    Insert;
    PedidosDetallesproducto_id.AsString:= productoID;
    PedidosDetalleslistaPrecio_id.AsInteger:= listaPrecioID;
    PedidosDetallescantidad.AsFloat:= cantidad;
    DM_Productos.Editar(productoID);
    PedidosDetalleslxCodigo.AsString:= DM_Productos.Productoscodigo.AsString;
    PedidosDetalleslxProducto.AsString:= DM_Productos.Productosnombre.AsString;
    PedidosDetalleslxListaPrecio.AsString:= DM_Productos.NombreListaPrecios(listaPrecioID);
    Post;
    AjustarPreciosProducto;
  end;
end;

procedure TDM_Pedidos.LevantarDetallePedido;
begin
  DM_General.ReiniciarTabla(PedidosDetalles);

  With qDetallesPedido do
  begin
    if active then close;
    ParamByName('pedido_id').AsString:= Pedidosid.AsString;
    Open;

    PedidosDetalles.LoadFromDataSet(qDetallesPedido, 0, lmAppend);
    close;
  end;
end;

function TDM_Pedidos.CantidadArticulosPedido: LongInt;
var
  marca: TBookmark;
  conteo, redondeo: LongInt;
begin
  with PedidosDetalles do
  begin
    marca:= GetBookmark;
    conteo:= 0;
    try
      First;
      While Not eof do
      begin
        redondeo:= round(PedidosDetallescantidad.AsFloat);
        if (PedidosDetallescantidad.AsFloat > redondeo) then //Todo artículo vale al menos 1
         Inc (redondeo);
        conteo:= conteo + redondeo;
        Next;
      end;
      GotoBookmark(marca);
    finally
      FreeBookmark(marca);
    end;
  end;
  Result:= conteo;
end;

procedure TDM_Pedidos.AjustarPreciosProducto;
var
  MontoAplicar: Double;
begin
  PedidosDetalles.Edit;

  if PedidosDetalleslistaPrecio_id.AsInteger <> 0 then //Si hay una lista de precios, no se carga manual
  begin
    with qPrecio do
    begin
      if active then close;
      ParamByName('producto_id').asString:= PedidosDetallesproducto_id.AsString;
      ParamByName('listaprecio_id').asInteger:= PedidosDetalleslistaPrecio_id.AsInteger;
      Open;
      if RecordCount > 0 then
      begin
        PedidosDetallesprecioUnitario.AsFloat:= qPrecioMONTO.AsFloat;
        PedidosDetallesprecio_id.AsString:= qPrecioID.AsString;
      end
      else
        PedidosDetallesprecioUnitario.AsFloat:= 0;
    end;
  end;

  MontoAplicar:= (( PedidosDetallesprecioUnitario.asFloat
                  * PedidosDetallesporcentajeAplicar.AsFloat) /100);

  if PedidosDetallesbDescuento.AsInteger = 1 then
    PedidosDetallesprecioSubtotal.AsFloat:= ( PedidosDetallesprecioUnitario.AsFloat
                                               - MontoAplicar)
  else
    PedidosDetallesprecioSubtotal.AsFloat:= ( PedidosDetallesprecioUnitario.AsFloat
                                             + MontoAplicar) ;

  PedidosDetallesprecioTotal.AsFloat:= ( PedidosDetallesprecioSubtotal.AsFloat
                                     * PedidosDetallescantidad.AsFloat);
  PedidosDetalles.Post;
  AjustarMontoPedido;
end;

procedure TDM_Pedidos.EliminarProducto;
begin
  if ((PedidosDetalles.Active)
      and (PedidosDetalles.RecordCount > 0) )then
  With DELPedidosDetalles do
  begin
    ParamByName('id').AsString:= PedidosDetallesid.AsString;
    ExecSQL;
    PedidosDetalles.Delete;
  end;
end;


procedure TDM_Pedidos.ImprimirFrmPedido(refPedido: GUID_ID);
begin
  LevantarPedido(refPedido);
  DM_General.LevantarReporte(FORMULARIO_PEDIDO, PedidosDetalles);
  DM_Clientes.Editar(Pedidoscliente_id.AsString);
  DM_General.AgregarVariableReporte('Cliente', DM_Clientes.RazonSocial);
  DM_General.AgregarVariableReporte('Cliente_Direccion', DM_Clientes.Domicilio);
  DM_Vendedores.Editar(Pedidosvendedor_id.AsString);
  DM_General.AgregarVariableReporte('Vendedor', DM_Vendedores.RazonSocial);
  DM_Transportistas.Editar(Pedidostransportista_id.AsString);
  DM_General.AgregarVariableReporte('Transportista',DM_Transportistas.RazonSocial);
  DM_General.EjecutarReporte;
end;


end.

