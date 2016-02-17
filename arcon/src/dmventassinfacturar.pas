unit dmventasSinFacturar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset, dmgeneral;

const
  TIPO_VENTA_SF = 'V';
  TIPO_SIN_CAE = 'C';

type

  { TDM_VentasSinFacturar }

  TDM_VentasSinFacturar = class(TDataModule)
    Comprobantes: TRxMemoryData;
    Comprobantesexento: TFloatField;
    Comprobantesfactura_id: TStringField;
    ComprobantesFecha: TDateField;
    Comprobantesgravado: TFloatField;
    Comprobantesid: TStringField;
    ComprobantesMontoTotal: TFloatField;
    ComprobantesnoGravado: TFloatField;
    ComprobantesRazonSocial: TStringField;
    ComprobantesTIPO: TStringField;
    ComprobantesTipoComprobante: TStringField;
    qLevantarDatos: TZQuery;
    qLevantarDatosEXENTO: TFloatField;
    qLevantarDatosFACTURA_ID: TStringField;
    qLevantarDatosFECHA: TDateField;
    qLevantarDatosGRAVADO: TFloatField;
    qLevantarDatosID: TStringField;
    qLevantarDatosMONTOTOTAL: TFloatField;
    qLevantarDatosNOGRAVADO: TFloatField;
    qLevantarDatosRAZONSOCIAL: TStringField;
    qLevantarDatosTIPO: TStringField;
    qLevantarDatosTIPOCOMPROBANTE: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    _clienteID: GUID_ID;
    _sinCAE: boolean;
    _sinFacturar: boolean;

    procedure obtenerVentasSinFacturar (fechaIni, fechaFin: TDate);
    procedure obtenerVentasSinCAE (fechaIni, fechaFin: TDate);
  public
     property clienteID: GUID_ID write _clienteID;
     property sinFacturar: boolean write _sinFacturar;
     property sinCAE: boolean write _sinCAE;

     procedure ObtenerVentas (fechaIni, fechaFin: TDate);
  end;

var
  DM_VentasSinFacturar: TDM_VentasSinFacturar;

implementation

{$R *.lfm}

{ TDM_VentasSinFacturar }

procedure TDM_VentasSinFacturar.DataModuleCreate(Sender: TObject);
begin
  _clienteID:= GUIDNULO;
  _sinFacturar:= False;
  _sinCAE:= False;
end;

procedure TDM_VentasSinFacturar.obtenerVentasSinFacturar(fechaIni,
  fechaFin: TDate);
begin
  with qLevantarDatos do
  begin
    if active then close;
    SQL.Clear;

    SQL.Add(' select  CV.ID ');
    SQL.Add('       , CV.FECHA  ');
    SQL.Add('       , E.RAZONSOCIAL ');
    SQL.Add('       , TCV.COMPROBANTEVENTA as TipoComprobante ');
    SQL.Add('       , CV.NETOGRAVADO as Gravado ');
    SQL.Add('       , CV.NETONOGRAVADO as NoGravado ');
    SQL.Add('       , CV.EXENTO ');
    SQL.Add('       , (CV.NETOGRAVADO + CV.NETONOGRAVADO + CV.EXENTO) as MontoTotal ');
    SQL.Add('       , CV.FACTURA_ID ');
    SQL.Add('       , ''' + TIPO_VENTA_SF + ''' as Tipo' );
    SQL.Add(' from COMPROBANTESVENTA CV ');
    SQL.Add('       left join TIPOSCOMPROBANTESVENTAS TCV ON CV.TIPOCOMPROBANTE_ID = TCV.ID ');
    SQL.Add('       left join CLIENTES C ON CV.CLIENTE_ID = C.ID ');
    SQL.Add('       left join EMPRESAS E ON E.ID = C.EMPRESA_ID ');
    SQL.Add(' where (cv.BVISIBLE = 1) ');
    SQL.Add('        and (FACTURA_ID = ''{00000000-0000-0000-0000-000000000000}'' ) ');
    SQL.Add('        and (CV.FECHA >= '''+ FormatDateTime('MM-DD-YYYY', fechaIni) +''') ');
    SQL.Add('        and (CV.FECHA <= '''+ FormatDateTime('MM-DD-YYYY', fechaFin) +''') ');

    if ((_clienteID <> GUIDNULO) and (_clienteID <> EmptyStr)) then
         SQL.Add('        and (CV.CLIENTE_ID = '''+ _clienteID+ ''') ');

    Open;
    Comprobantes.LoadFromDataSet(qLevantarDatos, 0, lmAppend);
   // Close;
  end;
end;

procedure TDM_VentasSinFacturar.obtenerVentasSinCAE(fechaIni, fechaFin: TDate);
begin
  with qLevantarDatos do
  begin
    if active then close;
    SQL.Clear;

    SQL.Add(' select  CP.ID ');
    SQL.Add('       , CV.FECHA  ');
    SQL.Add('       , E.RAZONSOCIAL ');
    SQL.Add('       , TCV.COMPROBANTEVENTA as TipoComprobante ');
    SQL.Add('       , CV.NETOGRAVADO as Gravado ');
    SQL.Add('       , CV.NETONOGRAVADO as NoGravado ');
    SQL.Add('       , CV.EXENTO ');
    SQL.Add('       , (CV.NETOGRAVADO + CV.NETONOGRAVADO + CV.EXENTO) as MontoTotal ');
    SQL.Add('       , CV.FACTURA_ID ');
    SQL.Add('       , ''' + TIPO_VENTA_SF + ''' as Tipo' );
    SQL.Add(' from  FE_Comprobantes CP' );
    SQL.Add('       INNER join COMPROBANTESVENTA CV  ON CV.factura_id = CP.id');
    SQL.Add('       left join TIPOSCOMPROBANTESVENTAS TCV ON CV.TIPOCOMPROBANTE_ID = TCV.ID ');
    SQL.Add('       left join CLIENTES C ON CV.CLIENTE_ID = C.ID ');
    SQL.Add('       left join EMPRESAS E ON E.ID = C.EMPRESA_ID ');
    SQL.Add(' where (cv.BVISIBLE = 1) ');
    SQL.Add('        and (CP.ULTResultado <> ''A'') ');
    SQL.Add('        and (CV.FECHA >= '''+ FormatDateTime('MM-DD-YYYY', fechaIni) +''') ');
    SQL.Add('        and (CV.FECHA <= '''+ FormatDateTime('MM-DD-YYYY', fechaFin) +''') ');

    if (_clienteID <> GUIDNULO) then
         SQL.Add('        and (CV.CLIENTE_ID = '''+ _clienteID+ ''') ');

    Open;
    Comprobantes.LoadFromDataSet(qLevantarDatos, 0, lmAppend);
    Close;
  end;

end;

procedure TDM_VentasSinFacturar.ObtenerVentas(fechaIni, fechaFin: TDate);
begin
  DM_General.ReiniciarTabla(Comprobantes);

  if _sinFacturar then
   ObtenerVentasSinFacturar (fechaIni, fechaFin);

  if _sinCAE then
   ObtenerVentasSinCAE (fechaIni, fechaFin);
end;

end.

