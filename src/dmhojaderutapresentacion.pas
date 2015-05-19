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
    Presentacionfecha: TDateTimeField;
    PresentacionfPresentada: TDateTimeField;
    Presentacionid: TStringField;
    PresentacionlxEstado: TStringField;
    Presentacionmarca: TBooleanField;
    PresentacionNumero: TLongintField;
    qBuscar: TZQuery;
    qBuscarFECHA: TDateField;
    qBuscarFPRESENTADA: TDateField;
    qBuscarID: TStringField;
    qBuscarLXESTADO: TStringField;
    qBuscarNUMERO: TLongintField;
    procedure PresentacionAfterInsert(DataSet: TDataSet);
  private
    procedure CabeceraSQL (consulta: TZQuery);
    procedure ConsultaATabla;
    function getIdSeleccion: GUID_ID;
  public
    property idSeleccion: GUID_ID read getIdSeleccion;

    procedure BuscarEstado (refEstado: integer);
    procedure BuscarFechaEstado (laFecha: TDate; refEstado: integer);
    procedure BuscarHdR (refHojaDeRuta: GUID_ID );

    procedure CambiarMarca;
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
    SQL.Add('end as lxEstado, H.FPRESENTADA');
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

function TDM_HdRPresentacion.getIdSeleccion: GUID_ID;
begin
  with Presentacion do
  begin
    if ((active) and (RecordCount > 0)) then
     Result:= Presentacionid.AsString
    else
      Result:= GUIDNULO;
  end;
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
  qBuscar.SQL.Add(' and (H.fecha = CAST('''+ FormatDateTime ('MM-DD-YYYY',laFecha) +''' as date))');
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

procedure TDM_HdRPresentacion.CambiarMarca;
begin
  with Presentacion do
  begin
    if ((Active) and (RecordCount > 0)) then
    begin
      Edit;
      Presentacionmarca.AsBoolean:= NOT Presentacionmarca.AsBoolean;
      Post;
    end;
  end;
end;

end.

