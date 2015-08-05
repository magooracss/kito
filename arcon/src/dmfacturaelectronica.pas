unit dmfacturaelectronica;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  , dmgeneral
  , dmventas
  ;

type

  { TDM_FacturaElectronica }

  TDM_FacturaElectronica = class(TDataModule)
    fe_agregarIVAbaseImp: TFloatField;
    fe_agregarIVAcomprobante_id: TStringField;
    fe_agregarIVAid: TStringField;
    fe_agregarIVAimporte: TFloatField;
    fe_agregarIVAtipoIVA: TLongintField;
    fe_comprobantes: TRxMemoryData;
    fe_comprobantesCAE: TStringField;
    fe_comprobantescbtDesde: TFloatField;
    fe_comprobantescbtFecha: TStringField;
    fe_comprobantescbtHasta: TFloatField;
    fe_comprobantesconcepto: TLongintField;
    fe_comprobantesdocnro: TFloatField;
    fe_comprobantesdoctipo: TLongintField;
    fe_comprobantesestadoFE: TLongintField;
    fe_comprobantesfechaServDesde: TStringField;
    fe_comprobantesfechaServHasta: TStringField;
    fe_comprobantesfechaVtoPago: TStringField;
    fe_comprobantesid: TStringField;
    fe_comprobantesimpNeto: TFloatField;
    fe_comprobantesimpOpEx: TFloatField;
    fe_comprobantesimpTotal: TFloatField;
    fe_comprobantesimpTotalConc: TFloatField;
    fe_comprobantesmonCotiz: TFloatField;
    fe_comprobantesmonedaID: TStringField;
    fe_comprobantesptoVta: TLongintField;
    fe_comprobantestipoCompr: TLongintField;
    fe_comprobantesultReproceso: TStringField;
    fe_comprobantesultResultado: TStringField;
    fe_comprobantesvtoCAE: TStringField;
    fe_agregarIVA: TRxMemoryData;
    INSfe_comprobantes: TZQuery;
    INSfe_agregarIVA: TZQuery;
    qAlicuotasIVABVISIBLE: TSmallintField;
    qAlicuotasIVACODIGOAFIP: TFloatField;
    qAlicuotasIVACODIGOFE: TLongintField;
    qAlicuotasIVAID: TLongintField;
    qAlicuotasIVANOMBRE: TStringField;
    qAlicuotasIVAPORCENTAJE: TFloatField;
    qTiposComprVentasID: TZQuery;
    qAlicuotasIVA: TZQuery;
    qTiposComprVentasIDBVISIBLE: TSmallintField;
    qTiposComprVentasIDCODIGO: TStringField;
    qTiposComprVentasIDCOMPROBANTEVENTA: TStringField;
    qTiposComprVentasIDID: TLongintField;
    SELfe_agregarIVABASEIMP: TFloatField;
    SELfe_agregarIVACOMPROBANTE_ID: TStringField;
    SELfe_agregarIVAID: TStringField;
    SELfe_agregarIVAIMPORTE: TFloatField;
    SELfe_agregarIVATIPOIVA: TLongintField;
    SELfe_comprobantes: TZQuery;
    SELfe_agregarIVA: TZQuery;
    SELfe_comprobantesCAE: TStringField;
    SELfe_comprobantesCBTEDESDE: TFloatField;
    SELfe_comprobantesCBTFECHA: TStringField;
    SELfe_comprobantesCBTHASTA: TFloatField;
    SELfe_comprobantesCONCEPTO: TLongintField;
    SELfe_comprobantesDOCNRO: TFloatField;
    SELfe_comprobantesDOCTIPO: TLongintField;
    SELfe_comprobantesESTADOFE: TLongintField;
    SELfe_comprobantesFECHASERVDESDE: TStringField;
    SELfe_comprobantesFECHASERVHASTA: TStringField;
    SELfe_comprobantesFECHAVTOPAGO: TStringField;
    SELfe_comprobantesID: TStringField;
    SELfe_comprobantesIMPNETO: TFloatField;
    SELfe_comprobantesIMPOPEX: TFloatField;
    SELfe_comprobantesIMPTOTAL: TFloatField;
    SELfe_comprobantesIMPTOTALCONC: TFloatField;
    SELfe_comprobantesMONCOTIZ: TFloatField;
    SELfe_comprobantesMONEDAID: TStringField;
    SELfe_comprobantesPTOVTA: TLongintField;
    SELfe_comprobantesTIPOCOMPR: TLongintField;
    SELfe_comprobantesULTREPROCESO: TStringField;
    SELfe_comprobantesULTRESULTADO: TStringField;
    SELfe_comprobantesVTOCAE: TStringField;
    UPDfe_comprobantes: TZQuery;
    UPDfe_agregarIVA: TZQuery;
    procedure fe_agregarIVAAfterInsert(DataSet: TDataSet);
    procedure fe_comprobantesAfterInsert(DataSet: TDataSet);
  private
    function obtenerConceptoVta: integer;
    function obtenerTipoComprobante (elId: integer): integer;
    function convertirID_IVA (ref: integer): integer;
  public
    procedure FacturarVenta (refVenta:GUID_ID );
    procedure Grabar;

  end;

var
  DM_FacturaElectronica: TDM_FacturaElectronica;

implementation
uses
   SD_Configuracion
  , dmclientes
  ;

const
 FORMATO_FECHA = 'yyyymmdd';

{$R *.lfm}

{ TDM_FacturaElectronica }

procedure TDM_FacturaElectronica.fe_comprobantesAfterInsert(DataSet: TDataSet);
var
  fechaDefault: string;
begin
  fechaDefault:= FormatDateTime(FORMATO_FECHA, now);
  with DataSet do
  begin
    fe_comprobantesid.AsString:= DM_General.CrearGUID;
    fe_comprobantesconcepto.asInteger:= 4; // 4 = OTRO CONCEPTO
    fe_comprobantesdoctipo.AsInteger:= 80; //80 = CUIT
    fe_comprobantesdocnro.AsFloat:= 0;
    fe_comprobantescbtDesde.AsFloat:= 0;
    fe_comprobantescbtHasta.AsFloat:= 0;
    fe_comprobantescbtFecha.AsString:= fechaDefault;
    fe_comprobantesimpTotal.AsFloat:= 0;
    fe_comprobantesimpTotalConc.AsFloat:= 0;
    fe_comprobantesimpNeto.AsFloat:= 0;
    fe_comprobantesimpOpEx.AsFloat:= 0;
    fe_comprobantesfechaServDesde.AsString:= fechaDefault;
    fe_comprobantesfechaServHasta.AsString:= fechaDefault;
    fe_comprobantesfechaVtoPago.AsString:= fechaDefault;
    fe_comprobantesmonedaID.AsString:= 'PES'; // PES = PESO ARGENTINO
    fe_comprobantesmonCotiz.AsFloat:= 1; // Cotizacion 1 a 1
    fe_comprobantesestadoFE.AsInteger:= 0; // 0 = Estado Desconocido
    fe_comprobantesptoVta.AsInteger:= StrToIntDef (LeerDato(SECCION_APP, CFG_PTO_VTA),0);
    fe_comprobantestipoCompr.AsInteger:= 1;  //1 = Facturas A
    fe_comprobantesCAE.AsString:= EmptyStr;
    fe_comprobantesvtoCAE.asString:= fechaDefault;
    fe_comprobantesultResultado.asInteger:= 0;
    fe_comprobantesultReproceso.AsInteger:= 0;
  end;
end;

function TDM_FacturaElectronica.obtenerConceptoVta: integer;
var
  resultado: integer;
begin
  resultado:= 0;
  if DM_Ventas.ComproVtabProducto.AsInteger = 1 then
   resultado:= 1; //Es Producto
  if DM_Ventas.ComproVtabServicio.asInteger = 1 then
   resultado:= resultado + 2;  // 2 = Solo Servicio, 3 servicio+producto
  if resultado = 0 then
   resultado:= 4; //Otros
  Result:= resultado;
end;

function TDM_FacturaElectronica.obtenerTipoComprobante (elId: integer): integer;
var
  resultado: integer;
begin
  resultado:= 0;
  with qTiposComprVentasID do
  begin
    if active then close;
    ParamByName('id').asInteger:= elId;
    Open;
    if RecordCount > 0 then
     resultado:= StrToIntDef(qTiposComprVentasIDCODIGO.AsString, 0);
  end;
  Result:= resultado;
end;

function TDM_FacturaElectronica.convertirID_IVA(ref: integer): integer;
begin
  result:= 0;
  with qAlicuotasIVA do
  begin
    if active then close;
    ParamByName('id').AsInteger:= ref;
    Open;
    if RecordCount > 0 then
     Result:= qAlicuotasIVACODIGOFE.AsInteger;
    close;
  end;
end;

procedure TDM_FacturaElectronica.fe_agregarIVAAfterInsert(DataSet: TDataSet);
begin
  with DataSet do
  begin
    fe_agregarIVAid.AsString:= DM_General.CrearGUID;
    fe_agregarIVAcomprobante_id.AsString:= fe_comprobantesid.AsString;
    fe_agregarIVAtipoIVA.AsInteger:= 5; //5 = 21%
    fe_agregarIVAbaseImp.AsFloat:= 0;
    fe_agregarIVAimporte.AsFloat:= 0;
  end;
end;

procedure TDM_FacturaElectronica.FacturarVenta(refVenta: GUID_ID);
var
  c, acumuladorIVA: double;
  cs: string;
begin
  DM_Ventas.LevantarVenta(refVenta);

  DM_General.ReiniciarTabla(fe_agregarIVA);
  DM_General.ReiniciarTabla(fe_comprobantes);


  acumuladorIVA:= 0;

  fe_comprobantes.Insert;

  with DM_Ventas, ComproVtaIVA do
  begin
      if RecordCount > 0 then
      begin
        First;
        While not EOF do
        begin
          fe_agregarIVA.Insert;
          fe_agregarIVAcomprobante_id.AsString:= fe_comprobantesid.AsString;
          fe_agregarIVAtipoIVA.AsInteger:= ConvertirID_IVA(ComproVtaIVAalicuota_id.AsInteger);
          fe_agregarIVAbaseImp.AsFloat:= ComproVtaIVABaseImponible.AsFloat;
          fe_agregarIVAimporte.AsFloat:= ComproVtaIVAmonto.AsFloat;
          acumuladorIVA:= acumuladorIVA + ComproVtaIVAmonto.AsFloat;
          fe_agregarIVA.Post;
          Next;
        end;
      end;
  end;



  with fe_comprobantes do
  begin
    fe_comprobantesconcepto.asInteger:= ObtenerConceptoVta;
    fe_comprobantesdoctipo.AsInteger:= 80;

    DM_Clientes.Editar(DM_Ventas.ComproVtacliente_id.AsString);
    cs:=DM_Clientes.Cuit;
    c:= StrToFloatDef(cs, 0);
    fe_comprobantesdocnro.AsFloat:= c;
    c:= 0;
    c:=fe_comprobantesdocnro.AsFloat;

    fe_comprobantesimpTotal.AsFloat:= DM_Ventas.ComproVtanetoGravado.AsFloat
                                    + DM_Ventas.ComproVtanetoNoGravado.AsFloat
                                    + DM_Ventas.ComproVtaexento.asFloat
                                    + acumuladorIVA;
    fe_comprobantesimpTotalConc.AsFloat:= DM_Ventas.ComproVtanetoNoGravado.AsFloat;
    fe_comprobantesimpNeto.AsFloat:= DM_Ventas.ComproVtanetoGravado.AsFloat;
    fe_comprobantesimpOpEx.AsFloat:= DM_Ventas.ComproVtaexento.asFloat;
    fe_comprobantesfechaServDesde.asString:= FormatDateTime(FORMATO_FECHA, DM_Ventas.ComproVtaperiodoFacturadoIni.AsDateTime);
    fe_comprobantesfechaServHasta.asString:= FormatDateTime(FORMATO_FECHA, DM_Ventas.ComproVtaperiodoFacturadoFin.AsDateTime);
    fe_comprobantesfechaVtoPago.AsString:= FormatDateTime(FORMATO_FECHA, DM_Ventas.ComproVtavtoPago.AsDateTime);
    fe_comprobantesmonedaID.AsString:= 'PES';
    fe_comprobantesmonCotiz.AsFloat:= 1;
    fe_comprobantesestadoFE.AsInteger:= 0;
    fe_comprobantesptoVta.AsInteger:= DM_Ventas.ComproVtapuntoVenta.AsInteger;
    fe_comprobantestipoCompr.AsInteger:= ObtenerTipoComprobante (DM_Ventas.ComproVtatipoComprobante_id.AsInteger);
    Post;
  end;


  Grabar;
end;

procedure TDM_FacturaElectronica.Grabar;
begin
  DM_General.cnxBase.StartTransaction;
  try
    DM_General.GrabarDatos(SELfe_comprobantes, INSfe_comprobantes, UPDfe_comprobantes, fe_comprobantes, 'id');
    DM_General.GrabarDatos(SELfe_agregarIVA, INSfe_agregarIVA, UPDfe_agregarIVA, fe_agregarIVA, 'id');
    DM_General.cnxBase.Commit;
except
  DM_General.cnxBase.Rollback;
end;

end;

end.

