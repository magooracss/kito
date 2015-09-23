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
    CabeceraComprobanteVentaID: TStringField;
    CabeceracondicionIVA: TStringField;
    CabeceraCUIT: TLargeintField;
    CabeceraDomicilio: TStringField;
    Cabeceraemail: TStringField;
    CabecerafacturaElectronica_id: TStringField;
    CabeceraFEmision: TStringField;
    CabeceraIVA: TFloatField;
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
    frRoundRectObject1: TfrRoundRectObject;
    frShapeObject1: TfrShapeObject;
    qSELCabecera: TZQuery;
    qSELCabeceraCAE: TStringField;
    qSELCabeceraCOMPROBANTEVENTAID: TStringField;
    qSELCabeceraCONDICIONIVA: TStringField;
    qSELCabeceraCUIT: TFloatField;
    qSELCabeceraDOMICILIO: TStringField;
    qSELCabeceraEMAIL: TStringField;
    qSELCabeceraFACTURAELECTRONICA_ID: TStringField;
    qSELCabeceraFEMISION: TStringField;
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
begin

  LevantarFacturaPorID_FE(refFacturaElectronica);

  with elReporte do
  begin
    ruta:= LeerDato (SECCION_FI ,FI_FACTURA) ;
    LoadFromFile(ruta);
    frDataset.DataSet:= Cabecera;
  end;

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

end.

