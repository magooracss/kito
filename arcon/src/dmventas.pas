unit dmventas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  , dmgeneral;

const
  CALCULAR_CONCEPTO = -1; //La uso cuando hay múltiples impuestos o alícuotas para un concepto y hay que calcularlos

type

  { TDM_Ventas }

  TDM_Ventas = class(TDataModule)
    ComproVtabProducto: TLongintField;
    ComproVtabServicio: TLongintField;
    ComproVtabVisible: TLongintField;
    ComproVtacae: TStringField;
    ComproVtacliente_id: TStringField;
    ComproVtaConceptosbVisible: TLongintField;
    ComproVtaConceptoscantidad: TFloatField;
    ComproVtaConceptoscomprobanteVenta_id: TStringField;
    ComproVtaConceptosconcepto_id: TLongintField;
    ComproVtaConceptosdetalle: TStringField;
    ComproVtaConceptosexento: TFloatField;
    ComproVtaConceptosgravado: TFloatField;
    ComproVtaConceptosid: TStringField;
    ComproVtaConceptosnoGravado: TFloatField;
    ComproVtaConceptosorden: TLongintField;
    ComproVtaConceptosproducto_id: TStringField;
    ComproVtaexento: TFloatField;
    ComproVtafecha: TDateTimeField;
    ComproVtaformaPago_id: TLongintField;
    ComproVtaid: TStringField;
    ComproVtaImpuestosbVisible: TLongintField;
    ComproVtaImpuestoscomprobanteVentaConcepto_id: TStringField;
    ComproVtaImpuestosid: TStringField;
    ComproVtaImpuestosimpuesto_id: TLongintField;
    ComproVtaImpuestosmonto: TFloatField;
    ComproVtaIVAalicuota_id: TLongintField;
    ComproVtaIVAbVisible: TLongintField;
    ComproVtaIVAcomprobanteVentaConcepto_id: TStringField;
    ComproVtaIVAid: TStringField;
    ComproVtaIVAmonto: TFloatField;
    ComproVtanetoGravado: TFloatField;
    ComproVtanetoNoGravado: TFloatField;
    ComproVtanroComprobante: TLongintField;
    ComproVtaperiodoFacturadoFin: TDateTimeField;
    ComproVtaperiodoFacturadoIni: TDateTimeField;
    ComproVtapuntoVenta: TLongintField;
    ComproVtatipoComprobante_id: TLongintField;
    ComproVtavtoCae: TDateTimeField;
    ComproVtavtoPago: TDateTimeField;
    PedidosfToma: TDateTimeField;
    Pedidosid: TStringField;
    PedidosNumero: TLongintField;
    PedidosTotalPedido: TFloatField;
    qAlicuotaIVAIdBVISIBLE: TSmallintField;
    qAlicuotaIVAIdID: TLongintField;
    qAlicuotaIVAIdNOMBRE: TStringField;
    qAlicuotaIVAIdPORCENTAJE: TFloatField;
    qUltComprobanteGrabado: TZQuery;
    qFormasPagoBVISIBLE: TSmallintField;
    qFormasPagoFORMADEPAGO: TStringField;
    qFormasPagoID: TLongintField;
    qTiposComprobantesVentas: TZQuery;
    Pedidos: TRxMemoryData;
    ComproVta: TRxMemoryData;
    ComproVtaConceptos: TRxMemoryData;
    ComproVtaIVA: TRxMemoryData;
    ComproVtaImpuestos: TRxMemoryData;
    qAlicuotaIVAId: TZQuery;
    qFormasPago: TZQuery;
    qTiposComprobantesVentasBVISIBLE: TSmallintField;
    qTiposComprobantesVentasCODIGO: TStringField;
    qTiposComprobantesVentasCOMPROBANTEVENTA: TStringField;
    qTiposComprobantesVentasID: TLongintField;
    qUltComprobanteGrabadoBVISIBLE: TSmallintField;
    qUltComprobanteGrabadoCOMPROBANTEVENTA_ID: TLongintField;
    qUltComprobanteGrabadoID: TLongintField;
    qUltComprobanteGrabadoNUMERO: TLongintField;
    qUltComprobanteGrabadoPUNTODEVENTA: TLongintField;
    procedure ComproVtaAfterInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { private declarations }
  public
    procedure NuevoComprobante;
    procedure AgregarPedido (refPedido: GUID_ID);
    procedure AgregarConceptoPedidos;
    procedure AgregarConcepto (cantidad: double; concepto: integer;
      descripcion: string; gravado, noGravado, Exento: double;
      refProducto: GUID_ID; alicuotaIVA: integer);
    procedure AgregarAlicuotaIva (refComprobanteConcepto: GUID_ID;
                                  refAlicuotaIVA: integer ; monto: double);
    function ObtenerNroComprobante (refComprobante, NroPtoVenta: integer): integer;
    procedure ComprobanteEditarNro (elNroComprobante: integer);
  end;

var
  DM_Ventas: TDM_Ventas;

implementation
{$R *.lfm}
uses
  dmpedidos
  ,dmprecios
  ,dateutils
  ,SD_Configuracion
  ;

{ TDM_Ventas }

procedure TDM_Ventas.ComproVtaAfterInsert(DataSet: TDataSet);
var
  y,m,d: word;
begin
  DecodeDate(Now, y, m, d);
  ComproVtaid.AsString:= DM_General.CrearGUID;
  ComproVtafecha.AsDateTime:= Now;
  ComproVtacliente_id.asString:= GUIDNULO;
  ComproVtapuntoVenta.AsInteger:= StrToIntDef(LeerDato(SECCION_APP, CFG_PTO_VTA), 1);
  ComproVtabServicio.asInteger:= StrToIntDef(LeerDato(SECCION_APP, CFG_ES_SERVICIO), 1);
  ComproVtabProducto.asInteger:= StrToIntDef(LeerDato(SECCION_APP, CFG_ES_PRODUCTO), 1);
  ComproVtaperiodoFacturadoIni.asDateTime:=  EncodeDate(y, m, 1);
  ComproVtaperiodoFacturadoFin.asDateTime:=  Now;
  ComproVtavtoPago.AsDateTime:= EncodeDate(y,m,DaysInAMonth(y,m));
end;

procedure TDM_Ventas.DataModuleCreate(Sender: TObject);
begin
  DM_Precios := TDM_Precios.Create(self);
end;

procedure TDM_Ventas.DataModuleDestroy(Sender: TObject);
begin
  DM_Precios.Free;
end;

procedure TDM_Ventas.NuevoComprobante;
begin
  DM_General.ReiniciarTabla(ComproVta);
  DM_General.ReiniciarTabla(ComproVtaConceptos);
  DM_General.ReiniciarTabla(ComproVtaIVA);
  DM_General.ReiniciarTabla(ComproVtaImpuestos);
end;

procedure TDM_Ventas.AgregarPedido(refPedido: GUID_ID);
begin
  DM_Pedidos.LevantarPedido(refPedido);
  Pedidos.LoadFromDataSet(DM_Pedidos.Pedidos, 0, lmAppend);
end;

procedure TDM_Ventas.AgregarConceptoPedidos;
var
  ivaProducto: integer;
begin
  Pedidos.First;
  ivaProducto:= 3; //Por ahora, en caso de duda, el iva es 21%
  While Not Pedidos.EOF do
  begin
    DM_Pedidos.VincularFactura(Pedidosid.AsString
                               , ComproVtaid.AsString
                               , ComproVtafecha.AsDateTime);

  //Vuelco todos los renglones del pedido a la factura/comprobante
   DM_Pedidos.LevantarPedido(Pedidosid.AsString);
   With DM_Pedidos do
   begin
     While NOT PedidosDetalles.EOF do
     begin

       if PedidosDetallesprecio_id.AsString <> GUIDNULO then //Alicuota de iva!
       begin
         DM_Precios.LevantarPrecio(PedidosDetallesprecio_id.AsString);
         ivaProducto:= DM_Precios.PreciosalicuotaIVA_id.AsInteger;
       end;

       AgregarConcepto (PedidosDetallescantidad.AsFloat
                        ,-999999 //Concepto a vincular los productos
                        ,PedidosDetalleslxProducto.AsString
                        ,(PedidosDetallesprecioUnitario.AsFloat * PedidosDetallescantidad.AsFloat )//Precio gravado
                        ,0 //No gravado
                        ,0 //Exento
                        ,PedidosDetallesproducto_id.asString
                        , ivaProducto
                        );
       PedidosDetalles.Next;
     end;
   end;


    Pedidos.Next;
  end;
end;

procedure TDM_Ventas.AgregarConcepto(cantidad: double; concepto: integer;
  descripcion: string; gravado, noGravado, Exento: double;
  refProducto: GUID_ID; alicuotaIVA: integer);
begin
  if ((refProducto <> GUIDNULO)
     and
     (ComproVtaConceptos.Locate('producto_id', refProducto,[loCaseInsensitive]))
     ) then
  begin
    ComproVtaConceptos.Edit;
    ComproVtaConceptoscantidad.AsFloat:= ComproVtaConceptoscantidad.AsFloat + cantidad;
    ComproVtaConceptosgravado.AsFloat:= ComproVtaConceptosgravado.AsFloat + gravado;
    ComproVtaConceptosnoGravado.AsFloat:= ComproVtaConceptosnoGravado.AsFloat + noGravado;
    ComproVtaConceptosexento.AsFloat:= ComproVtaConceptosexento.AsFloat + Exento;
  end
  else
  begin
    ComproVtaConceptos.Insert;
    ComproVtaConceptoscantidad.AsFloat:= cantidad;
    ComproVtaConceptosgravado.AsFloat:= gravado;
    ComproVtaConceptosnoGravado.AsFloat:= noGravado;
    ComproVtaConceptosexento.AsFloat:= Exento;
  end;

  ComproVtaConceptosconcepto_id.AsInteger:= concepto;
  ComproVtaConceptosdetalle.AsString:= descripcion;
  ComproVtaConceptosproducto_id.AsString:= refProducto;
  ComproVtaConceptos.Post;

{ TODO : Aca tengo que calcular la alicuota de iva de nuevo!!!!}
  if alicuotaIVA <> CALCULAR_CONCEPTO then
    AgregarAlicuotaIVA (ComproVtaConceptosid.asString
                       ,alicuotaIVA
                       ,gravado);
end;

procedure TDM_Ventas.AgregarAlicuotaIva(refComprobanteConcepto: GUID_ID;
  refAlicuotaIVA: integer; monto: double);
var
  ivaCalculado: double;
begin

  with qAlicuotaIVAId do
  begin
    if active then close;
    ParamByName('id').AsInteger:= refAlicuotaIVA;
    Open;
    if RecordCount > 0 then
      ivaCalculado:= ((qAlicuotaIVAIdPORCENTAJE.asFloat * monto) /100)
    else
      ivaCalculado:= 0;
    close;
  end;

  ComproVtaIVA.Insert;
  ComproVtaIVAcomprobanteVentaConcepto_id.AsString:= refComprobanteConcepto;
  ComproVtaIVAalicuota_id.AsInteger:= refAlicuotaIVA;
  ComproVtaIVAmonto.AsFloat:= ivaCalculado;
  ComproVtaIVA.Post;
end;

function TDM_Ventas.ObtenerNroComprobante(refComprobante, NroPtoVenta: integer
  ): integer;
begin
   with qUltComprobanteGrabado do
   begin
     if active then close;
     ParamByName('comprobanteVenta_id').asInteger:= refComprobante;
     ParamByName('PuntoDeVenta').asInteger:= NroPtoVenta;
     Open;
     if RecordCount > 0 then
       Result:= (qUltComprobanteGrabadoNUMERO.AsInteger + 1)
     else
       Result:= 0;
     Close;
   end;
end;

procedure TDM_Ventas.ComprobanteEditarNro(elNroComprobante: integer);
begin
  with ComproVta do
  begin
    Edit;
    ComproVtanroComprobante.AsInteger:= elNroComprobante;
    Post;
  end;
end;


end.

