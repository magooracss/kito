unit dmcompensaciones;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral;

type

  { TDM_Compensaciones }

  TDM_Compensaciones = class(TDataModule)
    CompensacionesbVisible: TLongintField;
    Compensacionescompra_id: TStringField;
    CompensacionesfCompensacion: TDateField;
    Compensacionesid: TStringField;
    Compensacionesmonto: TFloatField;
    CompensacionesordenDePago_id: TStringField;
    DELCompensacion: TZQuery;
    INSCompensacion: TZQuery;
    Compensaciones: TRxMemoryData;
    SELCompensaciones: TZQuery;
    SELCompensacionesBVISIBLE: TSmallintField;
    SELCompensacionesCOMPRA_ID: TStringField;
    SELCompensacionesFCOMPENSACION: TDateField;
    SELCompensacionesID: TStringField;
    SELCompensacionesMONTO: TFloatField;
    SELCompensacionesORDENDEPAGO_ID: TStringField;
    UPDCompensacion: TZQuery;
    procedure CompensacionesAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure Nueva (refOP: GUID_ID; monto: Double);
    procedure Grabar;
  end;

var
  DM_Compensaciones: TDM_Compensaciones;

implementation

{$R *.lfm}

{ TDM_Compensaciones }

procedure TDM_Compensaciones.CompensacionesAfterInsert(DataSet: TDataSet);
begin
  Compensacionesid.AsString:= DM_General.CrearGUID;
  CompensacionesordenDePago_id.AsString:= GUIDNULO;
  Compensacionesmonto.AsFloat:= 0;
  Compensacionescompra_id.AsString:= GUIDNULO;
  CompensacionesfCompensacion.AsDateTime:= 0;
  CompensacionesbVisible.AsInteger:= 1;
end;

procedure TDM_Compensaciones.Nueva(refOP: GUID_ID; monto: Double);
begin
  with Compensaciones do
  begin
    if Not Active then Open;

    Insert;
    CompensacionesordenDePago_id.AsString:= refOP;
    Compensacionesmonto.AsFloat:= monto;
    Post;
  end;
end;

procedure TDM_Compensaciones.Grabar;
begin
  DM_General.GrabarDatos(SELCompensaciones, INSCompensacion, UPDCompensacion, Compensaciones, 'id');
end;

end.

