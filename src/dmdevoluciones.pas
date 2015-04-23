unit dmdevoluciones;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;

const
  FORMULARIO_DEVOLUCION = 'frmDevolucion.lrf';

type

  { TDM_Devoluciones }

  TDM_Devoluciones = class(TDataModule)
    DELDevoluciones: TZQuery;
    DELDevDetalles: TZQuery;
    Devoluciones: TRxMemoryData;
    DevolucionesbVisible: TLongintField;
    Devolucionescliente_id: TStringField;
    DevolucionesDetalles: TRxMemoryData;
    DevolucionesDetallesbVisible: TLongintField;
    DevolucionesDetallesdescartado: TFloatField;
    DevolucionesDetallesdevolucion_id: TStringField;
    DevolucionesDetallesdevuelto: TFloatField;
    DevolucionesDetallesid: TStringField;
    DevolucionesDetalleslxCantidad: TFloatField;
    DevolucionesDetalleslxCodigo: TStringField;
    DevolucionesDetalleslxProducto: TStringField;
    DevolucionesDetallesNota: TStringField;
    DevolucionesDetallesproducto_id: TStringField;
    DevolucionesFecha: TDateTimeField;
    Devolucionesid: TStringField;
    DevolucionesNotas: TStringField;
    Devolucionesnumero: TLongintField;
    Devolucionespedido_id: TStringField;
    INSDevoluciones: TZQuery;
    INSDevDetalles: TZQuery;
    qDevolucionPorPedidoBVISIBLE: TSmallintField;
    qDevolucionPorPedidoCLIENTE_ID: TStringField;
    qDevolucionPorPedidoFECHA: TDateField;
    qDevolucionPorPedidoID: TStringField;
    qDevolucionPorPedidoNOTAS: TStringField;
    qDevolucionPorPedidoNUMERO: TLongintField;
    qDevolucionPorPedidoPEDIDO_ID: TStringField;
    SELDevDetallesBVISIBLE: TSmallintField;
    SELDevDetallesDESCARTADO: TFloatField;
    SELDevDetallesDEVOLUCION_ID: TStringField;
    SELDevDetallesDEVUELTO: TFloatField;
    SELDevDetallesID: TStringField;
    SELDevDetallesNOTA: TStringField;
    SELDevDetallesPRODUCTO_ID: TStringField;
    SELDevoluciones: TZQuery;
    SELDevDetalles: TZQuery;
    qDevolucionPorPedido: TZQuery;
    SELDevolucionesBVISIBLE: TSmallintField;
    SELDevolucionesCLIENTE_ID: TStringField;
    SELDevolucionesFECHA: TDateField;
    SELDevolucionesID: TStringField;
    SELDevolucionesNOTAS: TStringField;
    SELDevolucionesNUMERO: TLongintField;
    SELDevolucionesPEDIDO_ID: TStringField;
    UPDDevoluciones: TZQuery;
    UPDDevDetalles: TZQuery;
    procedure DevolucionesAfterInsert(DataSet: TDataSet);
    procedure DevolucionesDetallesAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure cargarPedidoDevolucion (refPedido: GUID_ID);
    function ValidarCantidades: boolean;
    function PedidoConDevolucionCargada (refPedido: GUID_ID): boolean;

    procedure LevantarDevolucion (refDevolucion: GUID_ID);

    procedure Grabar;
    procedure AjustarStock;

    procedure ImprimirDevolucion (refDevolucion: GUID_ID);
  end;

var
  DM_Devoluciones: TDM_Devoluciones;

implementation
{$R *.lfm}
uses
  dmpedidos
  ,dmstock
  ;

{ TDM_Devoluciones }

procedure TDM_Devoluciones.DevolucionesAfterInsert(DataSet: TDataSet);
begin
  Devolucionesid.AsString:= DM_General.CrearGUID;
  Devolucionesnumero.AsInteger:= -1;
  DevolucionesFecha.AsDateTime:= Now;
  Devolucionescliente_id.AsString:= GUIDNULO;
  Devolucionespedido_id.AsString:= GUIDNULO;
  DevolucionesNotas.AsString:= ' ';
  DevolucionesbVisible.AsInteger:= 1;
end;

procedure TDM_Devoluciones.DevolucionesDetallesAfterInsert(DataSet: TDataSet);
begin
  DevolucionesDetallesid.AsString:= DM_General.CrearGUID;
  DevolucionesDetallesdevolucion_id.AsString:= Devolucionesid.AsString;
  DevolucionesDetallesproducto_id.AsString:= GUIDNULO;
  DevolucionesDetallesdevuelto.AsFloat:= 0;
  DevolucionesDetallesdescartado.AsFloat:= 0;
  DevolucionesDetallesNota.AsString:= ' ';
  DevolucionesDetallesbVisible.AsInteger:= 1;
end;

procedure TDM_Devoluciones.cargarPedidoDevolucion(refPedido: GUID_ID);
begin
   DM_Pedidos.LevantarPedido(refPedido);
   DM_General.ReiniciarTabla(Devoluciones);
   DM_General.ReiniciarTabla(DevolucionesDetalles);

   Devoluciones.Insert;
   Devolucionespedido_id.AsString:= refPedido;
   Devolucionescliente_id.AsString:= DM_Pedidos.Pedidoscliente_id.AsString;
   Devoluciones.Post;

   DM_Pedidos.PedidosDetalles.First;
   While NOT DM_Pedidos.PedidosDetalles.EOF do
   begin
     DevolucionesDetalles.Insert;
     DevolucionesDetallesproducto_id.AsString:= DM_Pedidos.PedidosDetallesproducto_id.AsString;
     DevolucionesDetalleslxCantidad.asFloat:= DM_Pedidos.PedidosDetallescantidad.AsFloat;
     DevolucionesDetalleslxCodigo.asString:= DM_Pedidos.PedidosDetalleslxCodigo.AsString;
     DevolucionesDetalleslxProducto.asString:= DM_Pedidos.PedidosDetalleslxProducto.AsString;
     DevolucionesDetalles.Post;

     DM_Pedidos.PedidosDetalles.Next;
   end;
end;

function TDM_Devoluciones.ValidarCantidades: boolean;
var
  resultado: boolean;
begin
  resultado:= true;
  with DevolucionesDetalles do
  begin
    DisableControls;
    First;
    While ((Not EOF)and (resultado)) do
    begin
      if (DevolucionesDetalleslxCantidad.AsFloat <
         (DevolucionesDetallesdevuelto.AsFloat + DevolucionesDetallesdescartado.AsFloat)
         ) then
         resultado:= false;
      Next;
    end;
    EnableControls;
  end;
  Result:= resultado;
end;

function TDM_Devoluciones.PedidoConDevolucionCargada(refPedido: GUID_ID
  ): boolean;
begin
  with qDevolucionPorPedido do
  begin
    if active then close;
    ParamByName('pedido_id').AsString:= refPedido;
    Open;
    Result:= (RecordCount > 0);
    Close;
  end;
end;

procedure TDM_Devoluciones.Grabar;
begin
  DM_General.GrabarDatos(SELDevoluciones, INSDevoluciones, UPDDevoluciones, Devoluciones, 'id');
  DM_General.GrabarDatos(SELDevDetalles, INSDevDetalles, UPDDevDetalles, DevolucionesDetalles, 'id');
end;

procedure TDM_Devoluciones.AjustarStock;
begin
  with DevolucionesDetalles do
  begin
    DisableControls;
    First;
    DM_Stock.NuevoMovimientoStock;
    DM_Stock.MovimientosStockremito.asString := 'DEVOLUCION';
    DM_Stock.MovimientosStock.Post;
    While (Not EOF) do
    begin
      if (DevolucionesDetallesdevuelto.AsFloat > 0) then
      begin
        DM_Stock.CargarMovimiento(DevolucionesDetallesproducto_id.AsString
                                  , DevolucionesDetallesdevuelto.AsFloat
                                  , 0
                                  , 0
                                  , MOV_INGRESO
                                  , nuevo
                                 );
      end
      else
        DevolucionesDetalles.Delete;

      Next;
    end;
    DM_Stock.GrabarMovimientoStock;
    DM_Stock.RecalcularStockPorMovimiento;
    EnableControls;
  end;
end;

procedure TDM_Devoluciones.LevantarDevolucion(refDevolucion: GUID_ID);
begin
  DM_General.ReiniciarTabla(Devoluciones);
  DM_General.ReiniciarTabla(DevolucionesDetalles);

  With SELDevoluciones do
  begin
    if active then close;
    ParamByName('id').asString:= refDevolucion;
    Open;
    Devoluciones.LoadFromDataSet(SELDevoluciones, 0, lmAppend);
    Close;
  end;
  { TODO : Falta terminar de levantar los detalles de la devolucion }
end;


procedure TDM_Devoluciones.ImprimirDevolucion(refDevolucion: GUID_ID);
begin
  LevantarDevolucion(refDevolucion);
  DM_General.LevantarReporte(FORMULARIO_DEVOLUCION, Devoluciones);
  DM_General.EjecutarReporte;
end;



end.

