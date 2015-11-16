unit dmfacturas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, LR_BarC, LR_RRect, LR_DBSet,
  LR_Class, LR_Shape, ZDataset, dmgeneral;

type

  { TDM_Facturas }

  TDM_Facturas = class(TDataModule)
    Cabecera: TRxMemoryData;
    CabeceraCAE: TLargeintField;
    Cabeceracodigo: TStringField;
    CabeceraComprobanteVenta: TStringField;
    CabeceraComprobanteVentaID: TStringField;
    CabeceracondicionIVA: TStringField;
    CabeceraCUIT: TLargeintField;
    CabeceraDomicilio: TStringField;
    Cabeceraemail: TStringField;
    CabecerafacturaElectronica_id: TStringField;
    CabeceraFEmision: TStringField;
    CabeceraIVA: TFloatField;
    Cabeceraletra: TStringField;
    CabeceraNro: TLongintField;
    CabeceraOtrosTributos: TFloatField;
    CabeceraPtoVenta: TLongintField;
    CabeceraRazonSocial: TStringField;
    CabeceraRemito: TStringField;
    CabeceraSubTotal: TFloatField;
    CabeceraTotal: TFloatField;
    CabeceravtoCAE: TStringField;
    Detalles: TRxMemoryData;
    DetallesbaseImponible: TFloatField;
    Detallescantidad: TFloatField;
    Detallescodigo: TStringField;
    Detallesdetalle: TStringField;
    Detallesexento: TFloatField;
    Detallesgravado: TFloatField;
    Detallesid: TStringField;
    DetallesmontoIVA: TFloatField;
    DetallesnoGravado: TFloatField;
    DetallesPrecioRenglon: TFloatField;
    DetallesprecioTotal: TFloatField;
    DetallestipoIva: TStringField;
    elReporte: TfrReport;
    frBarCodeObject1: TfrBarCodeObject;
    frDataset: TfrDBDataSet;
    frDataset1: TfrDBDataSet;
    frRoundRectObject1: TfrRoundRectObject;
    frShapeObject1: TfrShapeObject;
    qBusCAE: TZQuery;
    qBusCAECAE: TStringField;
    qBusCAECLIENTE: TStringField;
    qBusCAEFECHACOMPROBANTE: TDateField;
    qBusCAEFECHAFACTURA: TStringField;
    qBusCAEIDCOMPROBANTE: TStringField;
    qBusCAEID_FE: TStringField;
    qBusCAEMONTO: TFloatField;
    qBusCAENROFACTURA: TFloatField;
    qBusCAENROINTERNO: TLongintField;
    qBusCAEPTOVENTA: TLongintField;
    qBusCAETIPOCOMPROBANTE: TStringField;
    qBusFechaVenta: TZQuery;
    qBusClienteCAE1: TStringField;
    qBusClienteCLIENTE1: TStringField;
    qBusClienteFECHACOMPROBANTE1: TDateField;
    qBusClienteFECHAFACTURA1: TStringField;
    qBusClienteIDCOMPROBANTE1: TStringField;
    qBusClienteID_FE1: TStringField;
    qBusClienteMONTO1: TFloatField;
    qBusClienteNROFACTURA1: TFloatField;
    qBusClienteNROINTERNO1: TLongintField;
    qBusClientePTOVENTA1: TLongintField;
    qBusClienteTIPOCOMPROBANTE1: TStringField;
    qBusMonto: TZQuery;
    qBusClienteCAE: TStringField;
    qBusClienteCLIENTE: TStringField;
    qBusClienteFECHACOMPROBANTE: TDateField;
    qBusClienteFECHAFACTURA: TStringField;
    qBusClienteIDCOMPROBANTE: TStringField;
    qBusClienteID_FE: TStringField;
    qBusClienteMONTO: TFloatField;
    qBusClienteNROFACTURA: TFloatField;
    qBusClienteNROINTERNO: TLongintField;
    qBusClientePTOVENTA: TLongintField;
    qBusClienteTIPOCOMPROBANTE: TStringField;
    qBusFechaAFipCAE: TStringField;
    qBusFechaAFipCLIENTE: TStringField;
    qBusFechaAFipFECHACOMPROBANTE: TDateField;
    qBusFechaAFipFECHAFACTURA: TStringField;
    qBusFechaAFipIDCOMPROBANTE: TStringField;
    qBusFechaAFipID_FE: TStringField;
    qBusFechaAFipMONTO: TFloatField;
    qBusFechaAFipNROFACTURA: TFloatField;
    qBusFechaAFipNROINTERNO: TLongintField;
    qBusFechaAFipPTOVENTA: TLongintField;
    qBusFechaAFipTIPOCOMPROBANTE: TStringField;
    qBusMontoCAE: TStringField;
    qBusMontoCAE1: TStringField;
    qBusMontoCLIENTE: TStringField;
    qBusMontoCLIENTE1: TStringField;
    qBusMontoFECHACOMPROBANTE: TDateField;
    qBusMontoFECHACOMPROBANTE1: TDateField;
    qBusMontoFECHAFACTURA: TStringField;
    qBusMontoFECHAFACTURA1: TStringField;
    qBusMontoIDCOMPROBANTE: TStringField;
    qBusMontoIDCOMPROBANTE1: TStringField;
    qBusMontoID_FE: TStringField;
    qBusMontoID_FE1: TStringField;
    qBusMontoMONTO: TFloatField;
    qBusMontoMONTO1: TFloatField;
    qBusMontoNROFACTURA: TFloatField;
    qBusMontoNROFACTURA1: TFloatField;
    qBusMontoNROINTERNO: TLongintField;
    qBusMontoNROINTERNO1: TLongintField;
    qBusMontoPTOVENTA: TLongintField;
    qBusMontoPTOVENTA1: TLongintField;
    qBusMontoTIPOCOMPROBANTE: TStringField;
    qBusMontoTIPOCOMPROBANTE1: TStringField;
    qBusNroInterno: TZQuery;
    qBusCliente: TZQuery;
    qBusNroInternoCAE: TStringField;
    qBusNroInternoCLIENTE: TStringField;
    qBusNroInternoFECHACOMPROBANTE: TDateField;
    qBusNroInternoFECHAFACTURA: TStringField;
    qBusNroInternoIDCOMPROBANTE: TStringField;
    qBusNroInternoID_FE: TStringField;
    qBusNroInternoMONTO: TFloatField;
    qBusNroInternoNROFACTURA: TFloatField;
    qBusNroInternoNROINTERNO: TLongintField;
    qBusNroInternoPTOVENTA: TLongintField;
    qBusNroInternoTIPOCOMPROBANTE: TStringField;
    qBusTipoComprobante: TZQuery;
    qBusNroFactCAE: TStringField;
    qBusNroFactCLIENTE: TStringField;
    qBusNroFactFECHACOMPROBANTE: TDateField;
    qBusNroFactFECHAFACTURA: TStringField;
    qBusNroFactIDCOMPROBANTE: TStringField;
    qBusNroFactID_FE: TStringField;
    qBusNroFactMONTO: TFloatField;
    qBusNroFactNROFACTURA: TFloatField;
    qBusNroFactNROINTERNO: TLongintField;
    qBusNroFactPTOVENTA: TLongintField;
    qBusNroFactTIPOCOMPROBANTE: TStringField;
    qBusFechaAFip: TZQuery;
    qBusTipoComprobanteCAE: TStringField;
    qBusTipoComprobanteCLIENTE: TStringField;
    qBusTipoComprobanteFECHACOMPROBANTE: TDateField;
    qBusTipoComprobanteFECHAFACTURA: TStringField;
    qBusTipoComprobanteIDCOMPROBANTE: TStringField;
    qBusTipoComprobanteID_FE: TStringField;
    qBusTipoComprobanteMONTO: TFloatField;
    qBusTipoComprobanteNROFACTURA: TFloatField;
    qBusTipoComprobanteNROINTERNO: TLongintField;
    qBusTipoComprobantePTOVENTA: TLongintField;
    qBusTipoComprobanteTIPOCOMPROBANTE: TStringField;
    qSELCabecera: TZQuery;
    qSELCabeceraCAE: TStringField;
    qSELCabeceraCODIGO: TStringField;
    qSELCabeceraCOMPROBANTEVENTA: TStringField;
    qSELCabeceraCOMPROBANTEVENTAID: TStringField;
    qSELCabeceraCONDICIONIVA: TStringField;
    qSELCabeceraCUIT: TFloatField;
    qSELCabeceraDOMICILIO: TStringField;
    qSELCabeceraEMAIL: TStringField;
    qSELCabeceraFACTURAELECTRONICA_ID: TStringField;
    qSELCabeceraFEMISION: TStringField;
    qSELCabeceraLETRA: TStringField;
    qSELCabeceraNRO: TFloatField;
    qSELCabeceraPTOVENTA: TLongintField;
    qSELCabeceraRAZONSOCIAL: TStringField;
    qSELCabeceraSUBTOTAL: TFloatField;
    qSELCabeceraTOTAL: TFloatField;
    qSELCabeceraVTOCAE: TStringField;
    qSELDetalles: TZQuery;
    qSELDetallesID: TStringField;
    qSELIVA: TZQuery;
    qSELDetallesCANTIDAD: TFloatField;
    qSELDetallesCODIGO: TStringField;
    qSELDetallesDETALLE: TStringField;
    qSELDetallesEXENTO: TFloatField;
    qSELDetallesGRAVADO: TFloatField;
    qSELDetallesNOGRAVADO: TFloatField;
    qSELIVABASEIMPONIBLE: TFloatField;
    qSELIVAIVA: TFloatField;
    qSELIVANOMBRE: TStringField;
    qSELIVAPORCENTAJE: TFloatField;
    qTiposComprVentas: TZQuery;
    qTiposComprVentasBVISIBLE: TSmallintField;
    qTiposComprVentasCODIGO: TStringField;
    qTiposComprVentasCOMPROBANTEVENTA: TStringField;
    qTiposComprVentasID: TLongintField;
    Resultados: TRxMemoryData;
    ResultadosCAE: TStringField;
    ResultadosCliente: TStringField;
    ResultadosfechaComprobante: TDateField;
    ResultadosfechaFactura: TStringField;
    ResultadosidComprobante: TStringField;
    Resultadosid_FE: TStringField;
    ResultadosMonto: TFloatField;
    ResultadosNroFactura: TLongintField;
    ResultadosNroInterno: TLongintField;
    ResultadosPtoVenta: TLongintField;
    ResultadosTipoComprobante: TStringField;
    qBusNroFact: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    factNro, factFecha: string;
     iva2_5
    ,iva5
    ,iva10_5
    ,iva21
    ,iva27: double;
    procedure AjusteVisualDeCampos;
    function AjustarFecha(laFecha: string): string;
  public
    procedure LevantarFacturaPorID_FE (refFacturaElectronica: GUID_ID);
    procedure ImprimirFactura (refFacturaElectronica: GUID_ID);

    procedure BuscarNroComprobante(ptoVenta, Comprobante: integer);
    procedure BuscarTiposComprobante(refTipoComprobante: integer);
    procedure BuscarFechaAFIP(laFecha: TDate);
    procedure BuscarCAE(elCAE: String);
    procedure BuscarNroInterno(elNroInterno: integer);
    procedure BuscarCliente (refCliente: GUID_ID);
    procedure BuscarMonto (elMonto: Double);
    procedure BuscarFechaVenta(laFecha: TDate);
  end;

var
  DM_Facturas: TDM_Facturas;

implementation
{$R *.lfm}
uses
  SD_Configuracion
, strutils
  ;


{ TDM_Facturas }
procedure TDM_Facturas.DataModuleCreate(Sender: TObject);
begin

end;

function TDM_Facturas.AjustarFecha(laFecha: string): string;
var
  d,m,a: string;
begin
  if (Length(laFecha) >= 8) then
  begin
    a:= Copy(laFecha,1,4);
    m:= Copy(laFecha,5,2);
    d:= Copy(laFecha,7,2);
    Result:= d + '/' + m + '/' + a;
  end
  else
   Result:= laFecha;
end;


procedure TDM_Facturas.AjusteVisualDeCampos;
begin
  with Cabecera do
  begin
    First;
    Edit;
    factNro:= AddChar('0',IntToStr(CabeceraPtoVenta.AsInteger), 4)
              + ' - '
              + AddChar('0',IntToStr(CabeceraNro.AsInteger), 8);
    factFecha:= AjustarFecha(CabeceraFEmision.AsString);
    Post;
  end;
end;


procedure TDM_Facturas.LevantarFacturaPorID_FE(refFacturaElectronica: GUID_ID);
begin
   DM_General.ReiniciarTabla(Cabecera);
   DM_General.ReiniciarTabla(Detalles);

   Cabecera.DisableControls;
   Detalles.DisableControls;

   iva2_5:= 0;
   iva5:= 0;
   iva10_5:= 0;
   iva21:= 0;
   iva27:= 0;

   with qSELCabecera do
   begin
     if active then close;
     ParamByName('id').asString:= refFacturaElectronica;
     Open;
     Cabecera.LoadFromDataSet(qSELCabecera, 0, lmAppend);
     Close;
   end;


   with qSELDetalles do
   begin
     if active then close;
     ParamByName('ComprobanteID').asString:= CabeceraComprobanteVentaID.AsString;
     Open;
     Detalles.LoadFromDataSet(qSELDetalles, 0, lmAppend);
     Close;
   end;

   with Detalles do
   begin
     if RecordCount > 0 then
     begin
       First;

       While Not EOF do
       begin
         qSELIVA.Close;
         qSELIVA.ParamByName('comprobanteVentaConceptoID').asString:= Detallesid.AsString;
         qSELIVA.Open;

         if qSELIVA.RecordCount > 0 then
         begin
           Edit;
           DetallesbaseImponible.AsFloat:= qSELIVABASEIMPONIBLE.AsFloat;
           DetallesmontoIVA.AsFloat:= qSELIVAIVA.AsFloat;
           DetallestipoIva.AsString:= qSELIVANOMBRE.AsString;
           DetallesPrecioRenglon.AsFloat:= Detallesgravado.AsFloat
                                         + DetallesnoGravado.AsFloat
                                         + Detallesexento.AsFloat
                                         ;
           DetallesprecioTotal.asFloat:= Detallesgravado.AsFloat
                                       + DetallesnoGravado.AsFloat
                                       + Detallesexento.AsFloat
                                       + qSELIVAIVA.asFloat
                                       ;

            if (qSELIVAPORCENTAJE.AsFloat = 2.5) then
              iva2_5:= iva2_5 + qSELIVAIVA.AsFloat
            else
              if (qSELIVAPORCENTAJE.AsFloat = 5) then
                iva5:= iva5 + qSELIVAIVA.AsFloat
              else
                if (qSELIVAPORCENTAJE.AsFloat = 10.5) then
                  iva10_5:= iva10_5 + qSELIVAIVA.AsFloat
                else
                  if (qSELIVAPORCENTAJE.AsFloat = 21) then
                    iva21:= iva21 + qSELIVAIVA.AsFloat
                  else
                    if (qSELIVAPORCENTAJE.AsFloat <> 0) then
                      iva27:= iva27 + qSELIVAIVA.AsFloat;
           Post;
         end;

         Next;
       end;
     end;
   end;

   AjusteVisualDeCampos;

   Cabecera.EnableControls;
   Detalles.EnableControls;

end;


(*******************************************************************************
*** IMPRESION DE FACTURAS
*******************************************************************************)

procedure TDM_Facturas.ImprimirFactura(refFacturaElectronica: GUID_ID);
var
  ruta: string;
  letra, tipoComprobante: string;
begin

  LevantarFacturaPorID_FE(refFacturaElectronica);

  with elReporte do
  begin
    ruta:= LeerDato (SECCION_FI ,FI_FACTURA) ;
    LoadFromFile(ruta);
    frDataset.DataSet:= Cabecera;
  end;

  letra:= EmptyStr;
  tipoComprobante:= EmptyStr;
  frVariables ['RAZON_SOCIAL']:= LeerDato (SECCION_FI ,FI_RAZON_SOCIAL);
  frVariables ['DOMICILIO']:= LeerDato (SECCION_FI ,FI_DOMICILIO);
  frVariables ['CONDICION_IVA']:= LeerDato (SECCION_FI ,FI_CONDICION_IVA);
  frVariables ['CUIT']:= LeerDato (SECCION_FI ,FI_CUIT);
  frVariables ['INGRESOS_BRUTOS']:= LeerDato (SECCION_FI ,FI_IB);
  frVariables ['INICIO_ACTIVIDADES']:= LeerDato (SECCION_FI ,FI_INIACT);
  frVariables ['FacturaNro']:= factNro;
  frVariables ['FacturaFecha']:= factFecha;
  frVariables ['IVA2_5']:= FormatFloat('##########0.00', iva2_5);
  frVariables ['IVA5']:= FormatFloat('##########0.00', iva5);
  frVariables ['IVA10_5']:= FormatFloat('##########0.00', iva10_5);
  frVariables ['IVA21']:= FormatFloat('##########0.00', iva21);
  frVariables ['IVA27']:= FormatFloat('##########0.00', iva27);
  frVariables ['IVATOTAL']:= FormatFloat('##########0.00', iva2_5+iva5+iva10_5+iva21+iva27);

end;


(*******************************************************************************
*** BÙSQUEDA DE FACTURAS
*******************************************************************************)

procedure TDM_Facturas.BuscarNroComprobante(ptoVenta, Comprobante: integer);
begin
  DM_General.ReiniciarTabla(Resultados);
  if qBusNroFact.Active then qBusNroFact.Close;

  qBusNroFact.ParamByName('ptoVta').asInteger:= ptoVenta;
  qBusNroFact.ParamByName('NroFactura').asInteger:= Comprobante;
  qBusNroFact.Open;

  Resultados.LoadFromDataSet(qBusNroFact, 0, lmAppend);

  qBusNroFact.Close;
end;

procedure TDM_Facturas.BuscarTiposComprobante(refTipoComprobante: integer);
begin
  DM_General.ReiniciarTabla(Resultados);
  if qBusTipoComprobante.Active then qBusTipoComprobante.Close;

  qBusTipoComprobante.ParamByName('tipoComprobante').asInteger:= refTipoComprobante;
  qBusTipoComprobante.Open;

  Resultados.LoadFromDataSet(qBusTipoComprobante, 0, lmAppend);

  qBusTipoComprobante.Close;
end;

procedure TDM_Facturas.BuscarFechaAFIP(laFecha: TDate);
var
  fechaAfip: string;
  y,m,d: word;
begin
  DM_General.ReiniciarTabla(Resultados);

  DecodeDate(laFecha,y,m,d);
  fechaAfip:= IntToStr(y)
             + AddChar('0',IntToStr(m), 2)
             + AddChar('0',IntToStr(d), 2);

  if qBusFechaAFip.Active then qBusFechaAFip.Close;

  qBusFechaAFip.ParamByName('fechaAfip').AsString:= fechaAFIP;
  qBusFechaAFip.Open;

  Resultados.LoadFromDataSet(qBusFechaAFip, 0, lmAppend);

  qBusFechaAFip.Close;
end;

procedure TDM_Facturas.BuscarCAE(elCAE: String);
begin
  DM_General.ReiniciarTabla(Resultados);
  if qBusCAE.Active then qBusCAE.Close;

  qBusCAE.ParamByName('CAE').AsString:= elCAE;
  qBusCAE.Open;

  Resultados.LoadFromDataSet(qBusCAE, 0, lmAppend);

  qBusCAE.Close;
end;

procedure TDM_Facturas.BuscarNroInterno(elNroInterno: integer);
begin
  DM_General.ReiniciarTabla(Resultados);
  if qBusNroInterno.Active then qBusNroInterno.Close;

  qBusNroInterno.ParamByName('nroInterno').AsInteger:= elNroInterno;
  qBusNroInterno.Open;

  Resultados.LoadFromDataSet(qBusNroInterno, 0, lmAppend);

  qBusNroInterno.Close;

end;

procedure TDM_Facturas.BuscarCliente(refCliente: GUID_ID);
begin
  DM_General.ReiniciarTabla(Resultados);
  if qBusCliente.Active then qBusCliente.Close;

  qBusCliente.ParamByName('refCliente').AsString:= refCliente;
  qBusCliente.Open;

  Resultados.LoadFromDataSet(qBusCliente, 0, lmAppend);

  qBusCliente.Close;
end;

procedure TDM_Facturas.BuscarMonto(elMonto: Double);
begin
  DM_General.ReiniciarTabla(Resultados);
  if qBusMonto.Active then qBusMonto.Close;

  qBusMonto.ParamByName('monto').AsFloat:= elMonto;
  qBusMonto.Open;

  Resultados.LoadFromDataSet(qBusMonto, 0, lmAppend);

  qBusMonto.Close;
end;

procedure TDM_Facturas.BuscarFechaVenta(laFecha: TDate);
begin
  DM_General.ReiniciarTabla(Resultados);
  if qBusFechaVenta.Active then qBusFechaVenta.Close;

  qBusFechaVenta.ParamByName('fechaVenta').AsDate:= laFecha;
  qBusFechaVenta.Open;

  Resultados.LoadFromDataSet(qBusFechaVenta, 0, lmAppend);

  qBusFechaVenta.Close;
end;

end.

