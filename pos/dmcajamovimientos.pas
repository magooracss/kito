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

  MAX_FormaPago = 50;
type

  { TDM_CajaMovimentos }
  rec_FormaPago = RECORD
    idFormaPago: Integer;
    formaPago: string;
    monto: double;
  end;

  TDM_CajaMovimentos = class(TDataModule)
    CajaMovimientos: TRxMemoryData;
    CajaMovimientosbVisible: TLongintField;
    CajaMovimientosdetalle: TStringField;
    CajaMovimientosfecha: TDateField;
    CajaMovimientosformaPago_id: TLongintField;
    CajaMovimientosid: TStringField;
    CajaMovimientoslxformaPago: TStringField;
    CajaMovimientosmonto: TFloatField;
    CajaMovimientosreferencia_id: TStringField;
    CajaMovimientostipo: TLongintField;
    DELCajaMov: TZQuery;
    INSCajaMov: TZQuery;
    qFormasDePagoBEDIT: TSmallintField;
    qFormasDePagoBVISIBLE: TSmallintField;
    qFormasDePagoFORMAPAGO: TStringField;
    qFormasDePagoID: TLongintField;
    qMovFechasBVISIBLE: TSmallintField;
    qMovFechasDETALLE: TStringField;
    qMovFechasFECHA: TDateField;
    qMovFechasFORMAPAGO_ID: TLongintField;
    qMovFechasID: TStringField;
    qMovFechasLXFORMAPAGO: TStringField;
    qMovFechasMONTO: TFloatField;
    qMovFechasREFERENCIA_ID: TStringField;
    qMovFechasTIPO: TSmallintField;
    SELCajaMov: TZQuery;
    qMovFechas: TZQuery;
    SELCajaMovBVISIBLE: TSmallintField;
    SELCajaMovDETALLE: TStringField;
    SELCajaMovFECHA: TDateField;
    SELCajaMovFORMAPAGO_ID: TLongintField;
    SELCajaMovID: TStringField;
    SELCajaMovLXFORMAPAGO: TStringField;
    SELCajaMovMONTO: TFloatField;
    SELCajaMovREFERENCIA_ID: TStringField;
    SELCajaMovTIPO: TSmallintField;
    UPDCajaMov: TZQuery;
    qFormasDePago: TZQuery;
    procedure CajaMovimientosAfterInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private


    procedure Initialise;
  public
    LenResumenFormaPago: integer;
    ResumenFormaPago: ARRAY [0..MAX_FormaPago] of rec_FormaPago;



    procedure New;
    procedure Edit (ref: GUID_ID);
    procedure Delete (ref: GUID_ID);
    procedure Add (fecha: TDate; tipo: integer; detalle: string;
                  monto: double; referencia_id: GUID_ID; formaPago_id: integer);
    procedure Save;
    procedure LoadMovFechas(fechaIni, fechaFin: TDate);

    procedure CargarResumenFormaPago;

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
  CajaMovimientostipo.AsInteger:= 0;
  CajaMovimientosdetalle.AsString:= EmptyStr;
  CajaMovimientosmonto.AsFloat:= 0;
  CajaMovimientosreferencia_id.AsString:= GUIDNULO;
  CajaMovimientosformaPago_id.AsInteger:= 0;
  CajaMovimientoslxformaPago.AsString:= EmptyStr;
  CajaMovimientosbVisible.AsInteger:= 1;
end;

procedure TDM_CajaMovimentos.DataModuleCreate(Sender: TObject);
begin
  Initialise;

  if qFormasDePago.Active then qFormasDePago.Close;
  qFormasDePago.Open;
end;

procedure TDM_CajaMovimentos.CargarResumenFormaPago;
begin
  LenResumenFormaPago:= 0;
  with CajaMovimientos do
  begin
    if ((Active) and (RecordCount > 0)) then
    begin
      SortOnFields('formaPago_id');
      First;
      ResumenFormaPago[LenResumenFormaPago].idFormaPago:= -999;
      while not EOF do
      begin
        if (CajaMovimientosformaPago_id.AsInteger =
            ResumenFormaPago[LenResumenFormaPago].idFormaPago) then

        begin
          case CajaMovimientostipo.AsInteger of
               MOV_INGRESO
               , MOV_SALDO : ResumenFormaPago[LenResumenFormaPago].monto:= ResumenFormaPago[LenResumenFormaPago].monto
                                                                                + CajaMovimientosmonto.AsFloat;
               MOV_EGRESO:  ResumenFormaPago[LenResumenFormaPago].monto:= ResumenFormaPago[LenResumenFormaPago].monto                                                                          - CajaMovimientosmonto.AsFloat;
          end;
        end
        else
        begin
          Inc(LenResumenFormaPago);
          ResumenFormaPago[LenResumenFormaPago].idFormaPago:= CajaMovimientosformaPago_id.AsInteger;
          ResumenFormaPago[LenResumenFormaPago].formaPago:= CajaMovimientoslxformaPago.AsString;
          case CajaMovimientostipo.AsInteger of
               MOV_INGRESO
               , MOV_SALDO: ResumenFormaPago[LenResumenFormaPago].monto:= CajaMovimientosmonto.AsFloat;
               MOV_EGRESO:  ResumenFormaPago[LenResumenFormaPago].monto:= CajaMovimientosmonto.AsFloat * -1;
          end;
        end;
        Next;
      end;
     SortOnFields('fecha');
    end;
  end;
end;

procedure TDM_CajaMovimentos.Initialise;
begin
  LenResumenFormaPago:= 0;
end;

procedure TDM_CajaMovimentos.New;
begin
  DM_General.ReiniciarTabla(CajaMovimientos);
  CajaMovimientos.Insert;
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

procedure TDM_CajaMovimentos.Add(fecha: TDate; tipo: integer; detalle: string;
  monto: double; referencia_id: GUID_ID; formaPago_id: integer);
begin
  with CajaMovimientos do
  begin
    if NOT (State in dsWriteModes) then
      Insert;
    CajaMovimientosfecha.AsDateTime:= fecha;
    CajaMovimientostipo.AsInteger:= tipo;
    CajaMovimientosdetalle.AsString:=TRIM(detalle);
    CajaMovimientosmonto.AsFloat:= monto;
    CajaMovimientosreferencia_id.AsString:= referencia_id;
    CajaMovimientosformaPago_id.AsInteger:= formaPago_id;
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

