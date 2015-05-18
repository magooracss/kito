unit dmhojaderutapresentacion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  , dmgeneral;
const
  HdR_TODOS_LOS_ESTADOS = 3;
type

  { TDM_HdRPresentacion }

  TDM_HdRPresentacion = class(TDataModule)
    Presentacion: TRxMemoryData;
    PresentacionEstado: TStringField;
    Presentacionfecha: TDateTimeField;
    PresentacionfPresentada: TDateTimeField;
    Presentacionid: TStringField;
    Presentacionmarca: TBooleanField;
    PresentacionNumero: TLongintField;
    qBuscar: TZQuery;
    qBuscarESTADO: TStringField;
    qBuscarFECHA: TDateField;
    qBuscarFPRESENTADA: TDateField;
    qBuscarID: TStringField;
    qBuscarNUMERO: TLongintField;
    procedure PresentacionAfterInsert(DataSet: TDataSet);
  private
    procedure CabeceraSQL (consulta: TZQuery);
    procedure ConsultaATabla;
  public
    procedure BuscarEstado (refEstado: integer);
    procedure BuscarFechaEstado (laFecha: TDate; refEstado: integer);
    procedure BuscarHdR (refHojaDeRuta: GUID_ID );
  end;

var
  DM_HdRPresentacion: TDM_HdRPresentacion;

implementation

{$R *.lfm}

{ TDM_HdRPresentacion }

procedure TDM_HdRPresentacion.PresentacionAfterInsert(DataSet: TDataSet);
begin
  Presentacionmarca.AsBoolean:= False;
end;

procedure TDM_HdRPresentacion.CabeceraSQL(consulta: TZQuery);
begin
  With consulta do
  begin
    SQL.Clear;
    SQL.Add('select  H.ID, H.FECHA, H.NUMERO , case ');
    SQL.Add('    when H.ESTADO = 1 THEN ''REALIZADA'' ');
    SQL.Add('    when H.ESTADO = 2 THEN ''PRESENTADA'' ');
    SQL.Add('end as Estado, H.FPRESENTADA');
    SQL.Add('from HOJASDERUTA H');
    SQL.Add('where (H.BVISIBLE = 1)');
  end;
end;

procedure TDM_HdRPresentacion.ConsultaATabla;
begin
  DM_General.ReiniciarTabla(Presentacion);
  qBuscar.Open;
  Presentacion.LoadFromDataSet(qBuscar, 0 , lmAppend);
  qBuscar.Close;
end;

procedure TDM_HdRPresentacion.BuscarEstado(refEstado: integer);
begin
  CabeceraSQL (qBuscar);
  if refEstado < HdR_TODOS_LOS_ESTADOS then
    qBuscar.SQL.Add(' and (H.Estado = '+ IntToStr (refEstado) +')');
  ConsultaATabla;
end;

procedure TDM_HdRPresentacion.BuscarFechaEstado(laFecha: TDate;
  refEstado: integer);
begin
  CabeceraSQL (qBuscar);
  qBuscar.SQL.Add(' and (H.fecha = '''+ DateToStr (laFecha) +''')');
  if refEstado < HdR_TODOS_LOS_ESTADOS then
    qBuscar.SQL.Add(' and (H.Estado = '+ IntToStr (refEstado) +')');

  ConsultaATabla;
end;

procedure TDM_HdRPresentacion.BuscarHdR(refHojaDeRuta: GUID_ID);
begin
  CabeceraSQL (qBuscar);
  qBuscar.SQL.Add(' and (H.id = '''+refHojaDeRuta +''')');
  ConsultaATabla;
end;

end.

