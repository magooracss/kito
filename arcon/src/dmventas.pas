unit dmventas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, StrHolder, LR_Class, LR_DBSet,
  LR_BarC, LR_Shape, LR_RRect, ZDataset, dmgeneral;

const
  CALCULAR_CONCEPTO = -1; //La uso cuando hay múltiples impuestos o alícuotas para un concepto y hay que calcularlos

type

  { TDM_Ventas }

  TDM_Ventas = class(TDataModule)
    ComproVtabProducto: TLongintField;
    ComproVtabServicio: TLongintField;
    ComproVtabVisible: TLongintField;
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
    ComproVtafactura_id: TStringField;
    ComproVtafecha: TDateTimeField;
    ComproVtaformaPago_id: TLongintField;
    ComproVtaid: TStringField;
    ComproVtaImpuestosbVisible: TLongintField;
    ComproVtaImpuestoscomprobanteVentaConcepto_id: TStringField;
    ComproVtaImpuestosid: TStringField;
    ComproVtaImpuestosimpuesto_id: TLongintField;
    ComproVtaImpuestosmonto: TFloatField;
    ComproVtaIVAVista: TRxMemoryData;
    ComproVtaIVAalicuota_id: TLongintField;
    ComproVtaIVABaseImponible: TFloatField;
    ComproVtaIVAbVisible: TLongintField;
    ComproVtaIVAcomprobanteVentaConcepto_id: TStringField;
    ComproVtaIVAid: TStringField;
    ComproVtaIVAlxIVA: TStringField;
    ComproVtaIVAmonto: TFloatField;
    ComproVtaIVAVistaalicuota_id: TLongintField;
    ComproVtaIVAVistaBaseImponible: TFloatField;
    ComproVtaIVAVistabVisible: TLongintField;
    ComproVtaIVAVistacomprobanteVentaConcepto_id: TStringField;
    ComproVtaIVAVistaid: TStringField;
    ComproVtaIVAVistalxIVA: TStringField;
    ComproVtaIVAVistamonto: TFloatField;
    ComproVtanetoGravado: TFloatField;
    ComproVtanetoNoGravado: TFloatField;
    ComproVtanroComprobante: TLongintField;
    ComproVtaperiodoFacturadoFin: TDateTimeField;
    ComproVtaperiodoFacturadoIni: TDateTimeField;
    ComproVtapuntoVenta: TLongintField;
    ComproVtatipoComprobante_id: TLongintField;
    ComproVtavtoPago: TDateTimeField;
    INSComproVta: TZQuery;
    INSComproVtaConceptos: TZQuery;
    INSComproVtaIVA: TZQuery;
    INSComproVtaImpuestos: TZQuery;
    PedidosfToma: TDateTimeField;
    Pedidosid: TStringField;
    PedidosNumero: TLongintField;
    PedidosTotalPedido: TFloatField;
    qAlicuotaIVAIdCODIGOAFIP: TFloatField;
    qAlicuotaIVAIdCODIGOFE: TLongintField;
    qAlicuotasIVA: TZQuery;
    qAlicuotaIVAIdBVISIBLE1: TSmallintField;
    qAlicuotaIVAIdID1: TLongintField;
    qAlicuotaIVAIdNOMBRE1: TStringField;
    qAlicuotaIVAIdPORCENTAJE1: TFloatField;
    qComproVtaIVAPorCptoALICUOTA_ID: TLongintField;
    qComproVtaIVAPorCptoBASEIMPONIBLE: TFloatField;
    qComproVtaIVAPorCptoBVISIBLE: TSmallintField;
    qComproVtaIVAPorCptoCOMPROBANTEVENTACONCEPTO_ID: TStringField;
    qComproVtaIVAPorCptoID: TStringField;
    qComproVtaIVAPorCptoMONTO: TFloatField;
    qCompVtaConceptosPorVtaID: TStringField;
    qConceptos: TZQuery;
    qAlicuotaIVAIdBVISIBLE: TSmallintField;
    qAlicuotaIVAIdID: TLongintField;
    qAlicuotaIVAIdNOMBRE: TStringField;
    qAlicuotaIVAIdPORCENTAJE: TFloatField;
    qConceptosBEXENTO: TSmallintField;
    qConceptosBNOGRAVADO: TSmallintField;
    qConceptosBVISIBLE: TSmallintField;
    qConceptosID: TLongintField;
    qConceptosNOMBRE: TStringField;
    qConceptosPLANDECUENTAS_ID: TLongintField;
    qTiposComprobantesVentasTIPOFACTURA: TLongintField;
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
    SELComproVta: TZQuery;
    SELComproVtaBPRODUCTO: TSmallintField;
    SELComproVtaBSERVICIO: TSmallintField;
    SELComproVtaBVISIBLE: TSmallintField;
    SELComproVtaCLIENTE_ID: TStringField;
    SELComproVtaConceptos: TZQuery;
    qCompVtaConceptosPorVta: TZQuery;
    SELComproVtaConceptosBVISIBLE1: TSmallintField;
    SELComproVtaConceptosCANTIDAD1: TFloatField;
    SELComproVtaConceptosCOMPROBANTEVENTA_ID1: TStringField;
    SELComproVtaConceptosCONCEPTO_ID1: TLongintField;
    SELComproVtaConceptosDETALLE1: TStringField;
    SELComproVtaConceptosEXENTO1: TFloatField;
    SELComproVtaConceptosGRAVADO1: TFloatField;
    SELComproVtaConceptosNOGRAVADO1: TFloatField;
    SELComproVtaConceptosORDEN1: TLongintField;
    SELComproVtaConceptosPRODUCTO_ID1: TStringField;
    SELComproVtaEXENTO: TFloatField;
    SELComproVtaFACTURA_ID: TStringField;
    SELComproVtaFECHA: TDateField;
    SELComproVtaFORMAPAGO_ID: TLongintField;
    SELComproVtaID: TStringField;
    qComproVtaImpuestosPorCpto: TZQuery;
    SELComproVtaImpuestosBVISIBLE: TSmallintField;
    SELComproVtaImpuestosBVISIBLE1: TSmallintField;
    SELComproVtaImpuestosCOMPROBANTEVENTACONCEPTO_ID: TStringField;
    SELComproVtaImpuestosCOMPROBANTEVENTACONCEPTO_ID1: TStringField;
    SELComproVtaImpuestosID: TStringField;
    SELComproVtaImpuestosID1: TStringField;
    SELComproVtaImpuestosIMPUESTO_ID: TLongintField;
    SELComproVtaImpuestosIMPUESTO_ID1: TLongintField;
    SELComproVtaImpuestosMONTO: TFloatField;
    SELComproVtaImpuestosMONTO1: TFloatField;
    SELComproVtaIVA: TZQuery;
    SELComproVtaConceptosBVISIBLE: TSmallintField;
    SELComproVtaConceptosCANTIDAD: TFloatField;
    SELComproVtaConceptosCOMPROBANTEVENTA_ID: TStringField;
    SELComproVtaConceptosCONCEPTO_ID: TLongintField;
    SELComproVtaConceptosDETALLE: TStringField;
    SELComproVtaConceptosEXENTO: TFloatField;
    SELComproVtaConceptosGRAVADO: TFloatField;
    SELComproVtaConceptosID: TStringField;
    SELComproVtaConceptosNOGRAVADO: TFloatField;
    SELComproVtaConceptosORDEN: TLongintField;
    SELComproVtaConceptosPRODUCTO_ID: TStringField;
    SELComproVtaImpuestos: TZQuery;
    qComproVtaIVAPorCpto: TZQuery;
    SELComproVtaIVAALICUOTA_ID: TLongintField;
    SELComproVtaIVABASEIMPONIBLE: TFloatField;
    SELComproVtaIVABVISIBLE: TSmallintField;
    SELComproVtaIVACOMPROBANTEVENTACONCEPTO_ID: TStringField;
    SELComproVtaIVAID: TStringField;
    SELComproVtaIVAMONTO: TFloatField;
    ListaPedidos: TStrHolder;
    SELComproVtaNETOGRAVADO: TFloatField;
    SELComproVtaNETONOGRAVADO: TFloatField;
    SELComproVtaNROCOMPROBANTE: TLongintField;
    SELComproVtaPERIODOFACTURADOFIN: TDateField;
    SELComproVtaPERIODOFACTURADOINI: TDateField;
    SELComproVtaPUNTOVENTA: TLongintField;
    SELComproVtaTIPOCOMPROBANTE_ID: TLongintField;
    SELComproVtaVTOPAGO: TDateField;
    UPDComproVta: TZQuery;
    UPDComproVtaConceptos: TZQuery;
    UPDComproVtaIVA: TZQuery;
    UPDComproVtaImpuestos: TZQuery;
    procedure ComproVtaAfterInsert(DataSet: TDataSet);
    procedure ComproVtaConceptosAfterInsert(DataSet: TDataSet);
    procedure ComproVtaImpuestosAfterInsert(DataSet: TDataSet);
    procedure ComproVtaIVAAfterInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    _totalGravado
   ,_totalNoGravado
   ,_totalExento: double;
   function getTotalIVA: Double;

  public
    property TotalGravado: Double read _totalGravado;
    property TotalNoGravado: Double read _totalNoGravado;
    property TotalExento: Double read _totalExento;
    property TotalIVA: Double read getTotalIVA;

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

    procedure ModificarPosicionDetalle (pasos: integer);
    procedure RenumerarPosicionesDetalle;

    procedure CalcularTotales;

    procedure AjustarComprobante (refTipoComprobante, refFormaPago: integer
                                  ; montoGravado, montoNoGravado, montoExento: Double
                                  ; refCliente: GUID_ID);

    procedure LevantarVenta (refVenta: GUID_ID);
    procedure LevantarAgregandoIvaImpuestosComprobante (refComprobante: GUID_ID);
    procedure Grabar;

    procedure ObtenerTiposComprobantes (refTipo: integer);
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
  , dmfacturaelectronica
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
  ComproVtanroComprobante.AsInteger:= -1;
  ComproVtapuntoVenta.AsInteger:= StrToIntDef(LeerDato(SECCION_APP, CFG_PTO_VTA), 1);
  ComproVtabServicio.asInteger:= StrToIntDef(LeerDato(SECCION_APP, CFG_ES_SERVICIO), 1);
  ComproVtabProducto.asInteger:= StrToIntDef(LeerDato(SECCION_APP, CFG_ES_PRODUCTO), 1);
  ComproVtaperiodoFacturadoIni.asDateTime:=  EncodeDate(y, m, 1);
  ComproVtaperiodoFacturadoFin.asDateTime:=  Now;
  ComproVtavtoPago.AsDateTime:= EncodeDate(y,m,DaysInAMonth(y,m));
  ComproVtafactura_id.AsString:= GUIDNULO;
  ComproVtabVisible.AsInteger:= 1;
end;

procedure TDM_Ventas.ComproVtaConceptosAfterInsert(DataSet: TDataSet);
begin
  ComproVtaConceptosid.AsString:= DM_General.CrearGUID;
  ComproVtaConceptoscomprobanteVenta_id.asString:= ComproVtaid.AsString;
  ComproVtaConceptosorden.asInteger:= MaxInt;
  ComproVtaConceptoscantidad.AsFloat:= 1;
  ComproVtaConceptosconcepto_id.AsInteger:= 0;
  ComproVtaConceptosdetalle.AsString:= '-';
  ComproVtaConceptosgravado.AsFloat:= 0;
  ComproVtaConceptosnoGravado.AsFloat:= 0;
  ComproVtaConceptosexento.AsFloat:= 0;
  ComproVtaConceptosproducto_id.AsString:= GUIDNULO;
  ComproVtaConceptosbVisible.AsInteger:= 1;
end;

procedure TDM_Ventas.ComproVtaIVAAfterInsert(DataSet: TDataSet);
begin
  ComproVtaIVAid.AsString:= DM_General.CrearGUID;
  ComproVtaIVAcomprobanteVentaConcepto_id.AsString:= ComproVtaConceptosid.AsString;
  ComproVtaIVAalicuota_id.AsInteger:= StrToIntDef(LeerDato(SECCION_APP, CFGD_IVA_ID), 0);
  ComproVtaIVAmonto.AsFloat:= 0;
  ComproVtaIVAbVisible.AsInteger:= 1;
end;

procedure TDM_Ventas.ComproVtaImpuestosAfterInsert(DataSet: TDataSet);
begin
  ComproVtaImpuestosid.AsString:= DM_General.CrearGUID;
  ComproVtaImpuestoscomprobanteVentaConcepto_id.AsString:= ComproVtaConceptosid.AsString;
  ComproVtaImpuestosimpuesto_id.AsInteger:= 0;
  ComproVtaImpuestosmonto.AsFloat:= 0;
  ComproVtaImpuestosbVisible.AsInteger:= 1;
end;

procedure TDM_Ventas.DataModuleCreate(Sender: TObject);
begin
  DM_Precios := TDM_Precios.Create(self);

end;

procedure TDM_Ventas.DataModuleDestroy(Sender: TObject);
begin
  DM_Precios.Free;
end;

function TDM_Ventas.getTotalIVA: Double;
var
  accum: Double;
begin
  accum:= 0;
  with ComproVtaIVA do
  begin
    DisableControls;
    First;
    While Not EOF do
    begin
      accum:= accum + ComproVtaIVAmonto.AsFloat;
      Next;
    end;
    EnableControls;
  end;
  Result:= accum;
end;

procedure TDM_Ventas.NuevoComprobante;
begin
  DM_General.ReiniciarTabla(ComproVta);
  DM_General.ReiniciarTabla(ComproVtaConceptos);
  DM_General.ReiniciarTabla(ComproVtaIVA);
  DM_General.ReiniciarTabla(ComproVtaImpuestos);

  { TODO : Arreglar esta tabla, que esta para zafar la forma de mostar grilla de iva nomas }
  DM_General.ReiniciarTabla(ComproVtaIVAVista);

  _totalExento:= 0;
  _totalGravado:= 0;
  _totalNoGravado:= 0;
  ListaPedidos.Strings.Clear;
  ComproVta.Insert;
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

   ListaPedidos.Strings.Add(Pedidosid.AsString); //Llevo un control de los pedidos manejados para poder vincularle la factura

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
  nombre: string;
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
    nombre:= qAlicuotaIVAIdNOMBRE.asString;
    close;
  end;

  with ComproVtaIVAVista do
  begin
    if Locate('alicuota_id', refAlicuotaIVA, []) then
    begin
      Edit;
      ComproVtaIVAVistamonto.AsFloat:= ComproVtaIVAVistamonto.AsFloat + ivaCalculado;
      ComproVtaIVAVistaBaseImponible.AsFloat:= ComproVtaIVAVistaBaseImponible.AsFloat + monto;
    end
    else
    begin
      Insert;
      ComproVtaIVAVistacomprobanteVentaConcepto_id.AsString:= refComprobanteConcepto;
      ComproVtaIVAVistaalicuota_id.AsInteger:= refAlicuotaIVA;
      ComproVtaIVAVistamonto.AsFloat:= ivaCalculado;
      ComproVtaIVAVistaBaseImponible.AsFloat:= monto;
      ComproVtaIVAVistalxIVA.asString:= nombre;
    end;
    Post;
  end;

  ComproVtaIVA.Insert;
  ComproVtaIVAcomprobanteVentaConcepto_id.AsString:= refComprobanteConcepto;
  ComproVtaIVAalicuota_id.AsInteger:= refAlicuotaIVA;
  ComproVtaIVAmonto.AsFloat:= ivaCalculado;
  ComproVtaIVABaseImponible.AsFloat:= monto;
  ComproVtaIVAlxIVA.asString:= nombre;
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


procedure TDM_Ventas.CalcularTotales;
var
  marca: TBookmark;
begin
  ComproVtaConceptos.DisableControls;
  marca:= ComproVtaConceptos.GetBookmark;

  _totalExento:= 0;
  _totalGravado:= 0;
  _totalNoGravado:= 0;

  With ComproVtaConceptos do
  begin
    First;
    While Not EOF do
    begin
      _totalExento:= _totalExento + ComproVtaConceptosexento.AsFloat;
      _totalGravado:= _totalGravado + ComproVtaConceptosgravado.AsFloat;
      _totalNoGravado:= _totalNoGravado + ComproVtanetoNoGravado.AsFloat;
      Next;
    end;
  end;
  ComproVtaConceptos.GotoBookmark(marca);
  ComproVtaConceptos.FreeBookmark(marca);

  ComproVtaConceptos.EnableControls;
end;

procedure TDM_Ventas.AjustarComprobante(refTipoComprobante,
  refFormaPago: integer; montoGravado, montoNoGravado, montoExento: Double;
  refCliente: GUID_ID);
begin
  ComproVta.Edit;
  ComproVtatipoComprobante_id.AsInteger:= refTipoComprobante;
  ComproVtaformaPago_id.AsInteger:= refFormaPago;
  ComproVtanetoGravado.asFloat:= montoGravado;
  ComproVtanetoNoGravado.AsFloat:= montoNoGravado;
  ComproVtaexento.AsFloat:= montoExento;
  ComproVtacliente_id.AsString:= refCliente;
  ComproVta.Post;
end;

procedure TDM_Ventas.LevantarVenta(refVenta: GUID_ID);
begin
  DM_General.ReiniciarTabla(ComproVta);
  DM_General.ReiniciarTabla(ComproVtaConceptos);
  DM_General.ReiniciarTabla(ComproVtaIVA);
  DM_General.ReiniciarTabla(ComproVtaImpuestos);

  with SELComproVta do
  begin
    if active then close;
    ParamByName('id').asString:= refVenta;
    Open;
    ComproVta.LoadFromDataSet(SELComproVta, 0, lmAppend);
    Close;
  end;

  with qCompVtaConceptosPorVta do
  begin
    if active then close;
    ParamByName('comprobanteVenta_id').asString:= refVenta;
    Open;
    ComproVtaConceptos.LoadFromDataSet(qCompVtaConceptosPorVta, 0, lmAppend);
    Close;
  end;

  with ComproVtaConceptos do
  begin
   if RecordCount > 0 then
   begin
     First;
     while NOT EOF do
     begin
       LevantarAgregandoIvaImpuestosComprobante(ComproVtaConceptosid.AsString);
       Next;
     end;
   end;

  end;

end;

procedure TDM_Ventas.LevantarAgregandoIvaImpuestosComprobante(refComprobante: GUID_ID);
begin
  with qComproVtaIVAPorCpto do
  begin
    if active then close;
    ParamByName('ComprobanteVentaConcepto_id').AsString:= refComprobante;
    Open;
    While Not EOF do
    begin
      AgregarAlicuotaIva(refComprobante
                        , qComproVtaIVAPorCptoALICUOTA_ID.AsInteger
                        , qComproVtaIVAPorCptoBASEIMPONIBLE.AsFloat);
      Next;
    end;
    close;
  end;

  with qComproVtaImpuestosPorCpto do
  begin
    if active then close;
    ParamByName('ComprobanteVentaConcepto_id').AsString:= refComprobante;
    Open;
    ComproVtaImpuestos.LoadFromDataSet(qComproVtaImpuestosPorCpto, 0, lmAppend);
    close;
  end;

end;

procedure TDM_Ventas.Grabar;
var
  idx: integer;
  cadena:string;
begin

    //Vinculo los pedidos con el comprobante
    for idx:= 0 to ListaPedidos.Strings.Count -1 do
    begin
      DM_Pedidos.PedidosDetalles.DisableControls;
      cadena:= ListaPedidos.Strings[idx];
//      DM_Pedidos.VincularFactura(cadena,ComproVtaid.asString, ComproVtafecha.AsDateTime);
      DM_Pedidos.LevantarPedido(cadena);
      DM_Pedidos.CambiarEstado(EST_FACTURADO, Now, 'Comprobante ID: ' + ComproVtaid.AsString);
      DM_Pedidos.Grabar;
      DM_Pedidos.PedidosDetalles.EnableControls;
    end;

    DM_General.cnxBase.StartTransaction;
    try

    DM_General.GrabarDatos(SELComproVta, INSComproVta, UPDComproVta, ComproVta, 'id');
    DM_General.GrabarDatos(SELComproVtaConceptos, INSComproVtaConceptos, UPDComproVtaConceptos, ComproVtaConceptos, 'id');
    DM_General.GrabarDatos(SELComproVtaIVA, INSComproVtaIVA, UPDComproVtaIVA, ComproVtaIVA, 'id');
    DM_General.GrabarDatos(SELComproVtaImpuestos, INSComproVtaImpuestos, UPDComproVtaImpuestos, ComproVtaImpuestos, 'id');
    DM_General.cnxBase.Commit;
  except
    DM_General.cnxBase.Rollback;
  end;

end;

procedure TDM_Ventas.ObtenerTiposComprobantes(refTipo: integer);
begin
  with qTiposComprobantesVentas do
  begin
   if active then close;
   ParamByName('tipoFactura').asInteger:= refTipo;
   Open;
  end;
end;


(*******************************************************************************
*** MODIFICAR POSICIONES EN EL DETALLE
********************************************************************************)

procedure TDM_Ventas.ModificarPosicionDetalle(pasos: integer);
var
  tmp: integer;
  marca: TBookmark;
begin
  with ComproVtaConceptos do
  begin
    marca:= GetBookmark;
    Edit;
    ComproVtaConceptosorden.AsInteger:= ComproVtaConceptosorden.AsInteger + pasos;
    Post;
    if pasos > 0 then
    begin //Avanzo
      next;
      next;
      While Not eof do
      begin
        Edit;
        ComproVtaConceptosorden.AsInteger:= ComproVtaConceptosorden.AsInteger + 1;
        Post;
        Next;
      end;
    end
    else //Retrocedo
    begin
      Prior;
      Prior;
      While Not bof do
      begin
        Edit;
        ComproVtaConceptosorden.AsInteger:= ComproVtaConceptosorden.AsInteger - 1;
        Post;
        Prior;
      end;
    end;
    GotoBookmark(marca);
    FreeBookmark(marca);
  end;
  ComproVtaConceptos.SortOnFields ('Orden');
  RenumerarPosicionesDetalle;
end;
procedure TDM_Ventas.RenumerarPosicionesDetalle;
var
  marca: TBookmark;
  idx: integer;
begin
  with ComproVtaConceptos do
  begin
    marca:= GetBookmark;
    try
      First;
      idx:= 0;
      While Not Eof do
      begin
        Edit;
        ComproVtaConceptosorden.AsInteger:= idx;
        Inc(idx);
        Post;
        Next;
      end;
      GotoBookmark(marca);
    finally
      FreeBookmark(marca);
    end;
  end;
end;




end.

