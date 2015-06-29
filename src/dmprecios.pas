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
    PreciosbVisible: TLongintField;
    Preciosid: TStringField;
    Preciosiva: TFloatField;
    PrecioslistaPrecio_id: TLongintField;
    Preciosmonto: TFloatField;
    Preciosproducto_id: TLongintField;
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
    procedure PreciosAfterInsert(DataSet: TDataSet);
  private
    _idPrecio: GUID_ID;
  public
    property idPrecio: GUID_ID read _idPrecio write _idPrecio;
  end;

var
  DM_Precios: TDM_Precios;

implementation
{$R *.lfm}

{ TDM_Precios }

procedure TDM_Precios.PreciosAfterInsert(DataSet: TDataSet);
begin
  _idPrecio:= DM_General.CrearGUID;
  Preciosid.AsString:= _idPrecio;
end;

end.

