unit dmfacturas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral;

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
    qSELCabecera: TZQuery;
    qSELCabeceraCAE: TStringField;
    qSELCabeceraCONDICIONIVA: TStringField;
    qSELCabeceraCUIT: TFloatField;
    qSELCabeceraDOMICILIO: TStringField;
    qSELCabeceraEMAIL: TStringField;
    qSELCabeceraFACTURAELECTRONICA_ID: TStringField;
    qSELCabeceraFEMISION: TStringField;
    qSELCabeceraNRO: TFloatField;
    qSELCabeceraPTOVTA: TLongintField;
    qSELCabeceraRAZONSOCIAL: TStringField;
    qSELCabeceraSUBTOTAL: TFloatField;
    qSELCabeceraTOTAL: TFloatField;
    qSELCabeceraVTOCAE: TStringField;
    qSELDetalles: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { private declarations }
  public
    procedure LevantarFacturaPorID_FE (refFacturaElectronica: GUID_ID);
  end;

var
  DM_Facturas: TDM_Facturas;

implementation

{$R *.lfm}

{ TDM_Facturas }

procedure TDM_Facturas.DataModuleCreate(Sender: TObject);
begin

end;

procedure TDM_Facturas.LevantarFacturaPorID_FE(refFacturaElectronica: GUID_ID);
begin
   refFacturaElectronica:= '{4E7D1AA2-D186-4721-A724-639D28E2C993}';

   DM_General.ReiniciarTabla(Cabecera);
   with qSELCabecera do
   begin
     if active then close;
     ParamByName('id').asString:= refFacturaElectronica;
     Open;
     Cabecera.LoadFromDataSet(qSELCabecera, 0, lmAppend);
     Close;
   end;

end;

end.

