unit dmprecios;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;

type

  { TDM_Precios }

  TDM_Precios = class(TDataModule)
    DELPrecios: TZQuery;
    INSPrecios: TZQuery;
    Precios: TRxMemoryData;
    PreciosalicuotaIVA_id: TLongintField;
    PreciosbOferta: TLongintField;
    PreciosbVisible: TLongintField;
    Preciosid: TStringField;
    Preciosiva: TFloatField;
    PrecioslistaPrecio_id: TLongintField;
    Preciosmonto: TFloatField;
    PreciosOfertaFin: TDateTimeField;
    PreciosOfertaIni: TDateTimeField;
    Preciosproducto_id: TStringField;
    qListasPreciosLISTAPRECIO: TStringField;
    SELPrecios: TZQuery;
    qListasPrecios: TZQuery;
    SELPreciosALICUOTAIVA_ID: TLongintField;
    SELPreciosBOFERTA: TSmallintField;
    SELPreciosBVISIBLE: TSmallintField;
    SELPreciosBVISIBLE1: TSmallintField;
    SELPreciosID: TStringField;
    SELPreciosID1: TStringField;
    SELPreciosIVA: TFloatField;
    SELPreciosIVA1: TFloatField;
    SELPreciosLISTAPRECIO_ID: TLongintField;
    SELPreciosLISTAPRECIO_ID1: TLongintField;
    SELPreciosMONTO: TFloatField;
    SELPreciosMONTO1: TFloatField;
    SELPreciosOFERTAFIN: TDateField;
    SELPreciosOFERTAINI: TDateField;
    SELPreciosPRODUCTO_ID: TStringField;
    SELPreciosPRODUCTO_ID1: TStringField;
    UPDPrecios: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure PreciosAfterInsert(DataSet: TDataSet);
  private
    _idPrecio: GUID_ID;
  public
    property idPrecio: GUID_ID read _idPrecio write _idPrecio;
    procedure LevantarPrecio (refPrecio: GUID_ID);

  end;

var
  DM_Precios: TDM_Precios;

implementation
{$R *.lfm}
uses
  SD_Configuracion;

{ TDM_Precios }

procedure TDM_Precios.PreciosAfterInsert(DataSet: TDataSet);
begin
  _idPrecio:= DM_General.CrearGUID;
  Preciosid.AsString:= _idPrecio;
  PreciosbOferta.AsInteger:= 0;
  PreciosOfertaIni.AsDateTime:= 0;
  PreciosOfertaFin.AsDateTime:= 0;
  PreciosalicuotaIVA_id.asInteger:= StrToIntDef(LeerDato(SECCION_APP,CFGD_IVA_ID), 3);
  EscribirDato(SECCION_APP, CFGD_IVA_ID, IntToStr(PreciosalicuotaIVA_id.asInteger)); //Por si el valor no esta en el cfg
end;

procedure TDM_Precios.DataModuleCreate(Sender: TObject);
begin

end;

procedure TDM_Precios.LevantarPrecio(refPrecio: GUID_ID);
begin
  DM_General.ReiniciarTabla(Precios);
  with SELPrecios do
  begin
    if active then close;
    ParamByName('id').AsString:= refPrecio;
    Open;
    Precios.LoadFromDataSet(SELPrecios, 0, lmAppend);
  end;
end;

end.

