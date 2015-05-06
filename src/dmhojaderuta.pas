unit dmhojaderuta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;

type

  { TDM_HojaDeRuta }

  TDM_HojaDeRuta = class(TDataModule)
    HojaDeRuta: TRxMemoryData;
    HojaDeRutabAnulada: TLongintField;
    HojaDeRutabVisible: TLongintField;
    HojaDeRutaDetallesbCobroDestino: TLongintField;
    HojaDeRutaDetallesbEntregaCompleto: TLongintField;
    HojaDeRutaDetallesbNoEntregado: TLongintField;
    HojaDeRutaDetallesbultos: TLongintField;
    HojaDeRutaDetallesbVisible: TLongintField;
    HojaDeRutaDetallesclienteDireccion_id: TStringField;
    HojaDeRutaDetallesdevolucion_id: TStringField;
    HojaDeRutaDetalleshojaDeRuta_id: TStringField;
    HojaDeRutaDetallesid: TStringField;
    HojaDeRutaDetalleslxCliente: TStringField;
    HojaDeRutaDetalleslxClienteDir: TStringField;
    HojaDeRutaDetalleslxPedidoNro: TLongintField;
    HojaDeRutaDetallesmontoCobrado: TFloatField;
    HojaDeRutaDetallesmontoCobrar: TFloatField;
    HojaDeRutaDetallesmotivoNoEntrega_id: TLongintField;
    HojaDeRutaDetallesnota: TStringField;
    HojaDeRutaDetallesnroOrdena: TLongintField;
    HojaDeRutaDetallespedido_id: TStringField;
    HojaDeRutafAnulada: TDateTimeField;
    HojaDeRutaFecha: TDateTimeField;
    HojaDeRutaid: TStringField;
    HojaDeRutanumero: TLongintField;
    HojaDeRutatransportista_id: TStringField;
    HojaDeRutaDetalles: TRxMemoryData;
    INSHdR: TZQuery;
    INSHdRDet: TZQuery;
    SELHdR: TZQuery;
    SELHdRDet: TZQuery;
    SELHdRBANULADA: TSmallintField;
    SELHdRBVISIBLE: TSmallintField;
    SELHdRDetBCOBRODESTINO: TSmallintField;
    SELHdRDetBENTREGACOMPLETO: TSmallintField;
    SELHdRDetBNOENTREGADO: TSmallintField;
    SELHdRDetBULTOS: TLongintField;
    SELHdRDetBVISIBLE: TSmallintField;
    SELHdRDetCLIENTEDIRECCION_ID: TStringField;
    SELHdRDetDEVOLUCION_ID: TStringField;
    SELHdRDetHOJADERUTA_ID: TStringField;
    SELHdRDetID: TStringField;
    SELHdRDetMONTOCOBRADO: TFloatField;
    SELHdRDetMONTOCOBRAR: TFloatField;
    SELHdRDetMOTIVONOENTREGA_ID: TLongintField;
    SELHdRDetNOTA: TStringField;
    SELHdRDetNROORDENA: TLongintField;
    SELHdRDetPEDIDO_ID: TStringField;
    SELHdRFANULADA: TDateField;
    SELHdRFECHA: TDateField;
    SELHdRID: TStringField;
    SELHdRNUMERO: TLongintField;
    SELHdRTRANSPORTISTA_ID: TStringField;
    UPDHdR: TZQuery;
    UPDHdRDet: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure HojaDeRutaAfterInsert(DataSet: TDataSet);
    procedure HojaDeRutaDetallesAfterInsert(DataSet: TDataSet);
  private
    bArtSonBultos: Boolean;
  public
    procedure Nuevo;
    procedure Editar (refHojaDeRuta: GUID_ID);
    procedure Grabar;

  end;

var
  DM_HojaDeRuta: TDM_HojaDeRuta;

implementation
{$R *.lfm}
uses
  SD_Configuracion
  ;

{ TDM_HojaDeRuta }

procedure TDM_HojaDeRuta.DataModuleCreate(Sender: TObject);
begin
  bArtSonBultos:= StrToBoolDef(LeerDato(SECCION_APP, ART_BULTOS), true);
end;

procedure TDM_HojaDeRuta.DataModuleDestroy(Sender: TObject);
begin
  EscribirDato(SECCION_APP, ART_BULTOS, BoolToStr(bArtSonBultos));
end;

procedure TDM_HojaDeRuta.HojaDeRutaAfterInsert(DataSet: TDataSet);
begin
  HojaDeRutaid.AsString:= DM_General.CrearGUID;
  HojaDeRutanumero.AsInteger:= -1;
  HojaDeRutatransportista_id.AsString:= GUIDNULO;
  HojaDeRutaFecha.AsDateTime:= Now;
  HojaDeRutabAnulada.AsInteger:= 0;
  HojaDeRutafAnulada.AsDateTime:= 0;
  HojaDeRutabVisible.asInteger:= 1;
end;

procedure TDM_HojaDeRuta.HojaDeRutaDetallesAfterInsert(DataSet: TDataSet);
begin
  HojaDeRutaDetallesid.AsString:= DM_General.CrearGUID;
  HojaDeRutaDetalleshojaDeRuta_id.AsString:= HojaDeRutaid.AsString;
  HojaDeRutaDetallesnroOrdena.AsInteger:= MaxInt;
  HojaDeRutaDetallespedido_id.AsString:= GUIDNULO;
  HojaDeRutaDetallesclienteDireccion_id.AsString:= GUIDNULO;
  HojaDeRutaDetallesbultos.AsInteger:= 0;
  HojaDeRutaDetallesbCobroDestino.AsInteger:= 0;
  HojaDeRutaDetallesmontoCobrar.AsFloat:= 0;
  HojaDeRutaDetallesnota.AsString:= '-';
  HojaDeRutaDetallesbEntregaCompleto.AsInteger:= 0;
  HojaDeRutaDetallesmontoCobrado.AsFloat:= 0;
  HojaDeRutaDetallesdevolucion_id.AsString:= GUIDNULO;
  HojaDeRutaDetallesbNoEntregado.AsInteger:= 0;
  HojaDeRutaDetallesmotivoNoEntrega_id.AsInteger:= 0;
  HojaDeRutaDetallesbVisible.AsInteger:= 1;
  HojaDeRutaDetalleslxPedidoNro.AsInteger:= 0;
  HojaDeRutaDetalleslxCliente.asString:= EmptyStr;
  HojaDeRutaDetalleslxClienteDir.AsString:= EmptyStr;
end;

procedure TDM_HojaDeRuta.Nuevo;
begin
  DM_General.ReiniciarTabla(HojaDeRuta);
  DM_General.ReiniciarTabla(HojaDeRutaDetalles);
  HojaDeRuta.Insert;
end;

procedure TDM_HojaDeRuta.Editar(refHojaDeRuta: GUID_ID);
begin

end;

procedure TDM_HojaDeRuta.Grabar;
begin
  DM_General.GrabarDatos(SELHdR, INSHdR, UPDHdR, HojaDeRuta, 'id');
  DM_General.GrabarDatos(SELHdRDet, INSHdRDet, UPDHdRDet, HojaDeRutaDetalles, 'id');
end;

end.

