unit dmasientomanual;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral;

type

  { TDM_AsientoManual }

  TDM_AsientoManual = class(TDataModule)
    AsientoManual: TRxMemoryData;
    AsientoManualbVisible: TLongintField;
    AsientoManualDebe: TFloatField;
    AsientoManualDetalle: TStringField;
    AsientoManualempresa_id: TStringField;
    AsientoManualFecha: TDateField;
    AsientoManualHaber: TFloatField;
    AsientoManualid: TStringField;
    qAsientosFechaBVISIBLE: TSmallintField;
    qAsientosFechaDEBE: TFloatField;
    qAsientosFechaDETALLE: TStringField;
    qAsientosFechaEMPRESA_ID: TStringField;
    qAsientosFechaFECHA: TDateField;
    qAsientosFechaHABER: TFloatField;
    qAsientosFechaID: TStringField;
    SELAsiento: TZQuery;
    qAsientosFecha: TZQuery;
    SELAsientoBVISIBLE: TSmallintField;
    SELAsientoDEBE: TFloatField;
    SELAsientoDETALLE: TStringField;
    SELAsientoEMPRESA_ID: TStringField;
    SELAsientoFECHA: TDateField;
    SELAsientoHABER: TFloatField;
    SELAsientoID: TStringField;
    INSAsiento: TZQuery;
    UPDAsiento: TZQuery;
    DELAsiento: TZQuery;
    procedure AsientoManualAfterInsert(DataSet: TDataSet);
  private
    procedure setEmpresa(AValue: GUID_ID);
    { private declarations }
  public
    property EmpresaID: GUID_ID write setEmpresa;

     procedure Nuevo;
     procedure Editar (refID: GUID_ID);


     procedure Borrar;
     procedure Grabar;

     procedure levantarAsientos (refEmpresa: GUID_ID; fIni, fFin: TDate);
  end;

var
  DM_AsientoManual: TDM_AsientoManual;

implementation

{$R *.lfm}

{ TDM_AsientoManual }

procedure TDM_AsientoManual.AsientoManualAfterInsert(DataSet: TDataSet);
begin
  AsientoManualid.AsString:= DM_General.CrearGUID;
  AsientoManualFecha.AsDateTime:= Now;
  AsientoManualempresa_id.AsString:= GUIDNULO;
  AsientoManualDetalle.AsString:= EmptyStr;
  AsientoManualDebe.AsFloat:= 0;
  AsientoManualHaber.AsFloat:= 0;
  AsientoManualbVisible.AsInteger:= 1;
end;

procedure TDM_AsientoManual.setEmpresa(AValue: GUID_ID);
begin
  with AsientoManual do
  begin
    Edit;
    AsientoManualempresa_id.AsString:= AValue;
    Post;
  end;
end;

procedure TDM_AsientoManual.Nuevo;
begin
  DM_General.ReiniciarTabla(AsientoManual);
  AsientoManual.Insert;
end;

procedure TDM_AsientoManual.Editar(refID: GUID_ID);
begin
  DM_General.ReiniciarTabla(AsientoManual);
  with SELAsiento do
  begin
    if active then close;
    ParamByName('id').AsString:= refID;
    Open;
    AsientoManual.LoadFromDataSet(SELAsiento, 0, lmAppend);
    Close;
    AsientoManual.Edit;
  end;
end;

procedure TDM_AsientoManual.Borrar;
begin
  with AsientoManual do
  begin
    if (active and (RecordCount > 0)) then
    begin
      DELAsiento.ParamByName('id').asString:= AsientoManualid.AsString;
      DELAsiento.ExecSQL;
    end;
    AsientoManual.Delete;
  end;
end;

procedure TDM_AsientoManual.Grabar;
begin
  DM_General.GrabarDatos(SELAsiento, INSAsiento, UPDAsiento, AsientoManual, 'id');
end;

procedure TDM_AsientoManual.levantarAsientos(refEmpresa: GUID_ID; fIni,
  fFin: TDate);
begin
  DM_General.ReiniciarTabla(AsientoManual);
  with qAsientosFecha do
  begin
    if active then close;
    ParamByName('empresa_id').asString:= refEmpresa;
    ParamByName('fIni').AsDate:= fIni;
    ParamByName('fFin').AsDate:= fFin;
    Open;
    AsientoManual.LoadFromDataSet(qAsientosFecha, 0, lmAppend);
    Close;
  end;
end;

end.

