unit dmcambios;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral;

const
  MOT_CAMBIO_NORMAL = 1;

type

  { TDM_Cambios }

  TDM_Cambios = class(TDataModule)
    DELPosCambios: TZQuery;
    INSPosCambios: TZQuery;
    PosCambios: TRxMemoryData;
    PosCambiosbVisible: TLongintField;
    PosCambiosid: TStringField;
    PosCambioslxCantidad: TFloatField;
    PosCambioslxColor: TStringField;
    PosCambioslxProducto: TStringField;
    PosCambioslxTalle: TStringField;
    PosCambioslxTotal: TFloatField;
    PosCambiosmotivoCambio_id: TLongintField;
    PosCambiosnew_venta: TStringField;
    PosCambiosold_prod: TStringField;
    PosCambiosold_venta: TStringField;
    SELPosCambios: TZQuery;
    SELPosCambiosBVISIBLE: TSmallintField;
    SELPosCambiosID: TStringField;
    SELPosCambiosMOTIVOCAMBIO_ID: TLongintField;
    SELPosCambiosNEW_VENTA: TStringField;
    SELPosCambiosOLD_PROD: TStringField;
    SELPosCambiosOLD_VENTA: TStringField;
    UPDPosCambios: TZQuery;
    procedure PosCambiosAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure New;
    procedure DelCambio (refCambio: GUID_ID);
  end;

var
  DM_Cambios: TDM_Cambios;

implementation

{$R *.lfm}

{ TDM_Cambios }

procedure TDM_Cambios.PosCambiosAfterInsert(DataSet: TDataSet);
begin
  PosCambiosid.AsString:= DM_General.CrearGUID;
  PosCambiosold_venta.AsString:= GUIDNULO;
  PosCambiosold_prod.AsString:= GUIDNULO;
  PosCambiosnew_venta.AsString:= GUIDNULO;
  PosCambiosmotivoCambio_id.AsInteger:= MOT_CAMBIO_NORMAL;
  PosCambiosbVisible.AsInteger:= 1;
end;

procedure TDM_Cambios.New;
begin
  DM_General.ReiniciarTabla(PosCambios);
  PosCambios.Insert;
end;

procedure TDM_Cambios.DelCambio(refCambio: GUID_ID);
begin
  DELPosCambios.ParamByName('id').AsString:= refCambio;
  DELPosCambios.ExecSQL;
end;

end.

