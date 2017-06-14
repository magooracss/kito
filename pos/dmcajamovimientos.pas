unit dmcajamovimientos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;

const
  MOV_INGRESO = 1;
  MOV_EGRESO = 2;
  MOV_SALDO = 3;

type

  { TDM_CajaMovimentos }

  TDM_CajaMovimentos = class(TDataModule)
    CajaMovimientos: TRxMemoryData;
    CajaMovimientosbVisible: TLongintField;
    CajaMovimientosdetalle: TStringField;
    CajaMovimientosfecha: TDateField;
    CajaMovimientosid: TStringField;
    CajaMovimientosmarca: TFloatField;
    CajaMovimientosmonto: TFloatField;
    CajaMovimientosreferencia_id: TStringField;
    CajaMovimientostipo: TLongintField;
    DELCajaMov: TZQuery;
    INSCajaMov: TZQuery;
    qMovFechasBVISIBLE: TSmallintField;
    qMovFechasDETALLE: TStringField;
    qMovFechasFECHA: TDateField;
    qMovFechasID: TStringField;
    qMovFechasMARCA: TDateTimeField;
    qMovFechasMONTO: TFloatField;
    qMovFechasREFERENCIA_ID: TStringField;
    qMovFechasTIPO: TSmallintField;
    SELCajaMov: TZQuery;
    qMovFechas: TZQuery;
    SELCajaMovBVISIBLE: TSmallintField;
    SELCajaMovDETALLE: TStringField;
    SELCajaMovFECHA: TDateField;
    SELCajaMovID: TStringField;
    SELCajaMovMARCA: TDateTimeField;
    SELCajaMovMONTO: TFloatField;
    SELCajaMovREFERENCIA_ID: TStringField;
    SELCajaMovTIPO: TSmallintField;
    UPDCajaMov: TZQuery;
    procedure CajaMovimientosAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure Edit (ref: GUID_ID);
    procedure Delete (ref: GUID_ID);
    procedure Add (fecha: TDate; tipo: integer; detalle: string;
                  monto: double; referencia_id: GUID_ID);
    procedure Save;
    procedure LoadMovFechas(fechaIni, fechaFin: TDate);
  end;

var
  DM_CajaMovimentos: TDM_CajaMovimentos;

implementation

{$R *.lfm}

{ TDM_CajaMovimentos }

procedure TDM_CajaMovimentos.CajaMovimientosAfterInsert(DataSet: TDataSet);
begin
  CajaMovimientosid.AsString:= DM_General.CrearGUID;
  CajaMovimientosfecha.AsDateTime:= now;
  CajaMovimientosmarca.AsFloat:= Now;
  CajaMovimientostipo.AsInteger:= 0;
  CajaMovimientosdetalle.AsString:= EmptyStr;
  CajaMovimientosmonto.AsFloat:= 0;
  CajaMovimientosreferencia_id.AsString:= GUIDNULO;
  CajaMovimientosbVisible.AsInteger:= 1;
end;

procedure TDM_CajaMovimentos.Edit(ref: GUID_ID);
begin
  DM_General.ReiniciarTabla(CajaMovimientos);
  with SELCajaMov do
  Begin
    if active then close;
    ParamByName('id').AsString:= ref;
    Open;
    CajaMovimientos.LoadFromDataSet(SELCajaMov, 0, lmAppend);
    Close;
  end;
  CajaMovimientos.Edit;
end;

procedure TDM_CajaMovimentos.Delete(ref: GUID_ID);
begin
  DELCajaMov.ParamByName('id').AsString:= ref;
  DELCajaMov.ExecSQL;
end;

procedure TDM_CajaMovimentos.Add(fecha: TDate;  tipo: integer;
  detalle: string; monto: double; referencia_id: GUID_ID);
begin
  with CajaMovimientos do
  begin
    Insert;
    CajaMovimientosfecha.AsDateTime:= fecha;
    CajaMovimientostipo.AsInteger:= tipo;
    CajaMovimientosdetalle.AsString:=TRIM(detalle);
    CajaMovimientosmonto.AsFloat:= monto;
    CajaMovimientosreferencia_id.AsString:= referencia_id;
    Post;
  end;
end;

procedure TDM_CajaMovimentos.Save;
begin
  DM_General.GrabarDatos(SELCajaMov, INSCajaMov, UPDCajaMov, CajaMovimientos, 'id');
end;

procedure TDM_CajaMovimentos.LoadMovFechas(fechaIni, fechaFin: TDate);
begin
  DM_General.ReiniciarTabla(CajaMovimientos);
  with qMovFechas do
  begin
    if active then close;
    ParamByName('fechaIni').AsDate:= fechaIni;
    ParamByName('fechaFin').AsDate:= fechaFin;
    Open;
    CajaMovimientos.LoadFromDataSet(qMovFechas, 0, lmAppend);
    Close;
  end;
end;

end.

