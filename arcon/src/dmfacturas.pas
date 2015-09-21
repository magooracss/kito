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
    Detallescodigo: TStringField;
    Detallesdescripcion: TStringField;
    DetallesfacturaElectronica_id: TStringField;
    DetallesIVA: TFloatField;
    DetallesprecioTotal: TFloatField;
    DetallesprecioUnitario: TFloatField;
    elReporte: TfrReport;
    frBarCodeObject1: TfrBarCodeObject;
    frDataset: TfrDBDataSet;
    frRoundRectObject1: TfrRoundRectObject;
    frShapeObject1: TfrShapeObject;
    qSELCabecera: TZQuery;
    qSELCabeceraCAE: TStringField;
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
    qSELDetallesCANTIDAD: TFloatField;
    qSELDetallesCODIGO: TStringField;
    qSELDetallesDETALLE: TStringField;
    qSELDetallesEXENTO: TFloatField;
    qSELDetallesGRAVADO: TFloatField;
    qSELDetallesNOGRAVADO: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
  private
    factNro, factFecha: string;
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

   end;

   AjusteVisualDeCampos;

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
end;

end.

