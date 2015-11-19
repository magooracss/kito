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
    qCompensacionOPBVISIBLE: TSmallintField;
    qCompensacionOPCOMPRA_ID: TStringField;
    qCompensacionOPFCOMPENSACION: TDateField;
    qCompensacionOPID: TStringField;
    qCompensacionOPMONTO: TFloatField;
    qCompensacionOPORDENDEPAGO_ID: TStringField;
    SELCompensaciones: TZQuery;
    qCompensacionOP: TZQuery;
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
    function MontoCompensacionOP (refOP: GUID_ID): double;
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

function TDM_Compensaciones.MontoCompensacionOP(refOP: GUID_ID): double;
begin
  with qCompensacionOP do
  begin
    if active then close;
    ParamByName('ordenDePago_id').AsString:= refOP;
    Open;
    if (RecordCount > 0) then
      Result:= qCompensacionOPMONTO.AsFloat
    else
      //Valido que no haya compensaciones en memoria
      if ((Compensaciones.Active)
          and (Compensaciones.RecordCount > 0)
          and (CompensacionesordenDePago_id.AsString = refOP)
          ) then
      begin
        Result:= Compensacionesmonto.AsFloat;
      end
      else
        Result:= 0;
  end;
end;

procedure TDM_Compensaciones.Grabar;
begin
  DM_General.GrabarDatos(SELCompensaciones, INSCompensacion, UPDCompensacion, Compensaciones, 'id');
end;

end.

