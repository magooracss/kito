unit dmstock;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;

const
  MOV_INGRESO = 'I';
  MOV_EGRESO = 'E';

type

  { TDM_Stock }

  TDM_Stock = class(TDataModule)
    INSMovimientosStock: TZQuery;
    INSMovimientosStockDetalles: TZQuery;
    MovimientosStockbVisible: TLongintField;
    MovimientosStockDetallesbVisible: TLongintField;
    MovimientosStockDetallescantidad: TFloatField;
    MovimientosStockDetallesid: TStringField;
    MovimientosStockDetalleslxCodigo: TStringField;
    MovimientosStockDetalleslxNombre: TStringField;
    MovimientosStockDetallesmovimiento: TStringField;
    MovimientosStockDetallesmovimientosStock_id: TStringField;
    MovimientosStockDetallesprecioTotal: TFloatField;
    MovimientosStockDetallesprecioUnitario: TFloatField;
    MovimientosStockDetallesproducto_id: TStringField;
    MovimientosStockfecha: TDateTimeField;
    MovimientosStockid: TStringField;
    MovimientosStocklistaprecio_id: TLongintField;
    MovimientosStocknotas: TStringField;
    MovimientosStocknumero: TLongintField;
    MovimientosStockproveedor_id: TStringField;
    MovimientosStockremito: TStringField;
    qMovimientosProducto: TZQuery;
    qMovimientosProductoBVISIBLE: TSmallintField;
    qMovimientosProductoCANTIDAD: TFloatField;
    qMovimientosProductoID: TStringField;
    qMovimientosProductoMOVIMIENTO: TStringField;
    qMovimientosProductoMOVIMIENTOSSTOCK_ID: TStringField;
    qMovimientosProductoPRECIOTOTAL: TFloatField;
    qMovimientosProductoPRECIOUNITARIO: TFloatField;
    qMovimientosProductoPRODUCTO_ID: TStringField;
    qStockProductoARMADO: TFloatField;
    qStockProductoDISPONIBLE: TFloatField;
    qStockProductoID: TStringField;
    qStockProductoPEDIDOS: TFloatField;
    qStockProductoPRODUCTO_ID: TStringField;
    SELMovimientosStock: TZQuery;
    SELMovimientosStockBVISIBLE: TSmallintField;
    SELMovimientosStockDetallesBVISIBLE: TSmallintField;
    SELMovimientosStockDetallesCANTIDAD: TFloatField;
    SELMovimientosStockDetallesID: TStringField;
    SELMovimientosStockDetallesMOVIMIENTO: TStringField;
    SELMovimientosStockDetallesMOVIMIENTOSSTOCK_ID: TStringField;
    SELMovimientosStockDetallesPRECIOTOTAL: TFloatField;
    SELMovimientosStockDetallesPRECIOUNITARIO: TFloatField;
    SELMovimientosStockDetallesPRODUCTO_ID: TStringField;
    SELMovimientosStockFECHA: TDateField;
    SELMovimientosStockID: TStringField;
    SELMovimientosStockLISTAPRECIO_ID: TLongintField;
    SELMovimientosStockNOTAS: TStringField;
    SELMovimientosStockNUMERO: TLongintField;
    SELMovimientosStockPROVEEDOR_ID: TStringField;
    SELMovimientosStockREMITO: TStringField;
    SELMovimientosStockDetalles: TZQuery;
    SELStockARMADO: TFloatField;
    SELStockDISPONIBLE: TFloatField;
    SELStockID: TStringField;
    SELStockPEDIDOS: TFloatField;
    SELStockPRODUCTO_ID: TStringField;
    stock: TRxMemoryData;
    MovimientosStock: TRxMemoryData;
    MovimientosStockDetalles: TRxMemoryData;
    stockarmado: TFloatField;
    stockdisponible: TFloatField;
    stockid: TStringField;
    stockpedidos: TFloatField;
    stockproducto_id: TStringField;
    qStockProducto: TZQuery;
    SELStock: TZQuery;
    INSStock: TZQuery;
    DELMovimientosStockDetalles: TZQuery;
    UPDStock: TZQuery;
    UPDMovimientosStock: TZQuery;
    UPDMovimientosStockDetalles: TZQuery;
    procedure MovimientosStockAfterInsert(DataSet: TDataSet);
    procedure MovimientosStockDetallesAfterInsert(DataSet: TDataSet);
    procedure stockAfterInsert(DataSet: TDataSet);
  private
    function Getarmado: double;
    function Getdisponible: double;
    function GetidProducto: GUID_ID;
    function Getpedidos: double;
    procedure SetidProducto(AValue: GUID_ID);
  public
    property idProducto: GUID_ID read GetidProducto write SetidProducto;
    property disponible: double read Getdisponible;
    property pedidos: double read Getpedidos;
    property armado: double read Getarmado;

    procedure productoDisponible (cantidad: double); //carga los productos a pedir
    procedure productoPedido (cantidad: double); //Baja de Disponible, incrementa Pedidos
    procedure productoArmado (cantidad: double); //Baja de pedidos, incrementa Armados
    procedure productoEntregado (cantidad: Double); //Baja de Stock Armados

    procedure EditarStock (refProducto: GUID_ID; stkDisponible: double );
    procedure Grabar;
    procedure RecalcularStockProducto (refProducto: GUID_ID);

    procedure GrabarMovimientoStock;
    procedure NuevoMovimientoStock;
    procedure eliminarProductoMovimientoStock;
    procedure CargarMovimiento (refProducto: GUID_ID; cantidad, preciounitario
                               ,precioTotal: Double; elMovimiento: string; accion: TOperacion);
    procedure TotalMovimiento (refListaPrecios: integer; var TotalCargado, TotalListaPrecio: double);

    procedure RecalcularStockPorMovimiento;

  end;

var
  DM_Stock: TDM_Stock;

implementation
{$R *.lfm}
uses
  dmproductos
  ,dmpedidos
  ;

{ TDM_Stock }

procedure TDM_Stock.stockAfterInsert(DataSet: TDataSet);
begin
  stockid.AsString:= DM_General.CrearGUID;
  stockproducto_id.AsString:= GUIDNULO;
  stockdisponible.AsFloat:= 0;
  stockpedidos.AsFloat:= 0;
  stockarmado.AsFloat:= 0;
end;

procedure TDM_Stock.MovimientosStockAfterInsert(DataSet: TDataSet);
begin
  MovimientosStockid.AsString:= DM_General.CrearGUID;
  MovimientosStockproveedor_id.AsString:= GUIDNULO;
  MovimientosStocknumero.AsInteger:= -1;
  MovimientosStockfecha.AsDateTime:= Now;
  MovimientosStocklistaprecio_id.AsInteger:= 0;
  MovimientosStockremito.AsString:='0';
  MovimientosStocknotas.AsString:= ' ';
  MovimientosStockbVisible.AsInteger:=1;
end;

procedure TDM_Stock.MovimientosStockDetallesAfterInsert(DataSet: TDataSet);
begin
  MovimientosStockDetallesid.AsString:= DM_General.CrearGUID;
  MovimientosStockDetallesmovimientosStock_id.AsString:= MovimientosStockid.AsString;
  MovimientosStockDetallesproducto_id.AsString:= GUIDNULO;
  MovimientosStockDetallescantidad.AsFloat:= 0;
  MovimientosStockDetallesprecioUnitario.AsFloat:= 0;
  MovimientosStockDetallesprecioTotal.asFloat:= 0;
  MovimientosStockDetallesmovimiento.AsString:= MOV_INGRESO;

  MovimientosStockDetallesbVisible.AsInteger:= 1;
end;

function TDM_Stock.Getarmado: double;
begin
  if ((stock.Active) and (stock.RecordCount > 0)) then
    Result:= stockarmado.AsFloat
  else
    Result:= 0;
end;

function TDM_Stock.Getdisponible: double;
begin
  if ((stock.Active) and (stock.RecordCount > 0)) then
    Result:= stockdisponible.AsFloat
  else
    Result:= 0;
end;

function TDM_Stock.GetidProducto: GUID_ID;
begin
  if ((stock.Active) and (stock.RecordCount > 0)) then
    Result:= stockproducto_id.AsString
  else
    Result:= GUIDNULO;
end;

function TDM_Stock.Getpedidos: double;
begin
  if ((stock.Active) and (stock.RecordCount > 0)) then
    Result:= stockpedidos.AsFloat
  else
    Result:= 0;
end;

procedure TDM_Stock.SetidProducto(AValue: GUID_ID);
begin
  DM_General.ReiniciarTabla(stock);
  with qStockProducto do
  begin
    if active then close;
    ParamByName('producto_id').AsString:= AValue;
    Open;
    stock.LoadFromDataSet(qStockProducto, 0, lmAppend);
    Close;
  end;
end;


procedure TDM_Stock.productoDisponible(cantidad: double);
begin
  with Stock do
  begin
    Edit;
    stockdisponible.AsFloat:= stockdisponible.AsFloat + cantidad;
    Post;
  end;
end;

procedure TDM_Stock.productoPedido(cantidad: double);
begin
  with Stock do
  begin
    Edit;
    stockdisponible.AsFloat:= stockdisponible.AsFloat - cantidad;
    stockpedidos.AsFloat:= stockpedidos.AsFloat + cantidad;
    Post;
  end;
end;

procedure TDM_Stock.productoArmado(cantidad: double);
begin
  with Stock do
  begin
    Edit;
    stockpedidos.AsFloat:= stockpedidos.AsFloat - cantidad;
    stockarmado.AsFloat:= stockarmado.AsFloat + cantidad;
    Post;
  end;
end;

procedure TDM_Stock.productoEntregado(cantidad: Double);
begin
  with Stock do
  begin
    Edit;
    stockarmado.AsFloat:= stockarmado.AsFloat - cantidad;
    Post;
  end;
end;

procedure TDM_Stock.EditarStock(refProducto: GUID_ID; stkDisponible: double );
begin
  DM_General.ReiniciarTabla(stock);
  if qStockProducto.Active then qStockProducto.Close;
  qStockProducto.ParamByName('producto_id').asString := refProducto;
  qStockProducto.Open;
  if qStockProducto.RecordCount > 0 then
  begin
    stock.LoadFromDataSet(qStockProducto, 0, lmAppend);
    stock.Edit;
  end
  else
  begin
    stock.Insert;
    stockproducto_id.AsString:= refProducto;
  end;
  stockdisponible.asFloat:= StkDisponible;
  stock.Post;
  Grabar;

end;

procedure TDM_Stock.Grabar;
begin
  DM_General.GrabarDatos(SELStock, INSStock, UPDStock, stock, 'id');
end;

procedure TDM_Stock.RecalcularStockProducto(refProducto: GUID_ID);
var
  stkDisponible: double;
begin
  stkDisponible:= 0;

  qMovimientosProducto.Close;
  qMovimientosProducto.ParamByName('producto_id').AsString:= refProducto;
  qMovimientosProducto.Open;
  qMovimientosProducto.First;
  While NOT qMovimientosProducto.EOF do
  begin
    if qMovimientosProductoMOVIMIENTO.AsString = MOV_INGRESO then
       stkDisponible:= stkDisponible + qMovimientosProductoCANTIDAD.AsFloat
    else
       stkDisponible:= stkDisponible - qMovimientosProductoCANTIDAD.AsFloat;
    qMovimientosProducto.Next;
  end;

  DM_Pedidos.qPedidosDetalleProducto.Close;
  DM_Pedidos.qPedidosDetalleProducto.ParamByName('producto_id').AsString:= refProducto;
  DM_Pedidos.qPedidosDetalleProducto.Open;
  DM_Pedidos.qPedidosDetalleProducto.First;
  While NOT DM_Pedidos.qPedidosDetalleProducto.EOF do
  begin
    stkDisponible:= stkDisponible - DM_Pedidos.qPedidosDetalleProductoCANTIDAD.AsFloat;
    DM_Pedidos.qPedidosDetalleProducto.Next;
  end;

  EditarStock(refProducto, stkDisponible);
end;

procedure TDM_Stock.NuevoMovimientoStock;
begin
  DM_General.ReiniciarTabla(MovimientosStock);
  DM_General.ReiniciarTabla(MovimientosStockDetalles);

  MovimientosStock.Insert;
end;

procedure TDM_Stock.eliminarProductoMovimientoStock;
begin
  with DELMovimientosStockDetalles do
  begin
    ParamByName('id').AsString:= MovimientosStockDetallesid.AsString;
    ExecSQL;
    MovimientosStockDetalles.Delete;
  end;
end;

procedure TDM_Stock.CargarMovimiento(refProducto: GUID_ID; cantidad,
  preciounitario, precioTotal: Double; elMovimiento: string; accion: TOperacion);
begin
  with MovimientosStockDetalles do
  begin
    if accion = nuevo then
      Insert
    else
      Edit;
    MovimientosStockDetallesproducto_id.AsString:= refProducto;
    MovimientosStockDetallescantidad.AsFloat:= cantidad;
    MovimientosStockDetallesprecioUnitario.AsFloat:= preciounitario;
    MovimientosStockDetallesprecioTotal.AsFloat:= precioTotal;
    MovimientosStockDetallesmovimiento.AsString:= elMovimiento;
    DM_Productos.Editar(refProducto);
    MovimientosStockDetalleslxCodigo.AsString:= DM_Productos.Productoscodigo.AsString;
    MovimientosStockDetalleslxNombre.AsString:= DM_Productos.Productosnombre.AsString;
    Post;
  end;
end;

procedure TDM_Stock.TotalMovimiento(refListaPrecios: integer; var TotalCargado,
  TotalListaPrecio: double);
var
  marca: TBookmark;
  valorLista, valorFinal: double;
begin
  TotalCargado:= 0;
  TotalListaPrecio:= 0;
  With MovimientosStockDetalles do
  begin
    marca:= GetBookmark;
    First;
    While Not EOF do
    begin
      valorLista:= ((DM_Productos.precioProducto(MovimientosStockDetallesproducto_id.AsString
                                 ,refListaPrecios)) * MovimientosStockDetallescantidad.AsFloat );
      valorFinal:= MovimientosStockDetallesprecioTotal.AsFloat;


      if MovimientosStockDetallesmovimiento.AsString = MOV_EGRESO then
      begin
        TotalListaPrecio:= TotalListaPrecio - valorLista;
        TotalCargado:= TotalCargado - valorFinal;
      end
      else
      begin
        TotalListaPrecio:= TotalListaPrecio + valorLista;
        TotalCargado:= TotalCargado + valorFinal;
      end;

      Next;
    end;
    GotoBookmark(marca);
    FreeBookmark(marca);
  end;

end;

procedure TDM_Stock.RecalcularStockPorMovimiento;
begin
  with MovimientosStockDetalles do
  begin
    First;
    While Not Eof do
    begin
      RecalcularStockProducto (MovimientosStockDetallesproducto_id.AsString);
      Next;
    end;
  end;
end;

procedure TDM_Stock.GrabarMovimientoStock;
begin
  DM_General.GrabarDatos(SELMovimientosStock, INSMovimientosStock, UPDMovimientosStock, MovimientosStock, 'id');
  DM_General.GrabarDatos(SELMovimientosStockDetalles, INSMovimientosStockDetalles, UPDMovimientosStockDetalles, MovimientosStockDetalles, 'id');
end;

end.

