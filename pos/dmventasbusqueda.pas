unit dmventasbusqueda;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset, dmgeneral;

type

  { TDM_VentasBusqueda }

  TDM_VentasBusqueda = class(TDataModule)
    qBusquedaCLIENTE: TStringField;
    qBusquedaFECHA: TDateField;
    qBusquedaMONTO: TFloatField;
    qBusquedaNRO: TLongintField;
    qBusquedaVENTA_ID: TStringField;
    Resultados: TRxMemoryData;
    ResultadosCliente: TStringField;
    Resultadosfecha: TDateField;
    Resultadosmonto: TFloatField;
    ResultadosNro: TLongintField;
    Resultadosventa_id: TStringField;
    qBusqueda: TZQuery;
  private
    function getVentaID: GUID_ID;
    procedure SQLBase;
    procedure SQLEjecutar;
  public
    property ventaSeleccionada: GUID_ID read getVentaID;
    procedure BusNroVenta (ref: integer);
    procedure BusfechasVenta (fIni, fFin: TDate);
    procedure BusProducto (ref: GUID_ID);
    procedure BusCliente (ref: GUID_ID);
  end;

var
  DM_VentasBusqueda: TDM_VentasBusqueda;

implementation

{$R *.lfm}

{ TDM_VentasBusqueda }

function TDM_VentasBusqueda.getVentaID: GUID_ID;
begin
  if ((qBusqueda.Active) and (qBusqueda.RecordCount > 0)) then
  begin
    Result:= qBusquedaVENTA_ID.AsString;
  end
  else
   Result:= GUIDNULO;
end;

procedure TDM_VentasBusqueda.SQLBase;
begin
  with qBusqueda do
  begin
    if active then close;

    SQL.Clear;

    SQL.Add('select V.ID as venta_id, V.NUMERO as NRO, V.FECHA');
    SQL.Add(' , E.RAZONSOCIAL as cliente, V.TOTAL as Monto');
    SQL.Add('from POSVENTAS V  ');
    SQL.Add('    left join CLIENTES C on V.CLIENTE_ID = C.ID ');
    SQL.Add('    left join EMPRESAS E on C.EMPRESA_ID = E.ID ');
    SQL.Add(' where (V.BVISIBLE = 1) and (V.BANULADA <> 1) ');
  end;
end;

procedure TDM_VentasBusqueda.SQLEjecutar;
begin
  DM_General.ReiniciarTabla(Resultados);
  qBusqueda.Open;
  Resultados.LoadFromDataSet(qBusqueda, 0, lmAppend);
  qBusqueda.Close;
end;

procedure TDM_VentasBusqueda.BusNroVenta(ref: integer);
begin
  SQLBase;
  qBusqueda.SQL.Add(' and (V.Numero = '+ IntToStr(ref) + ')');
  SQLEjecutar;
end;

procedure TDM_VentasBusqueda.BusfechasVenta(fIni, fFin: TDate);
begin
  SQLBase;
  qBusqueda.SQL.Add(' and (V.Fecha >= '''+ DM_General.FormatearFecha(fIni) + ''')');
  qBusqueda.SQL.Add(' and (V.Fecha <= '''+ DM_General.FormatearFecha(fFin) + ''')');
  SQLEjecutar;
end;

procedure TDM_VentasBusqueda.BusProducto(ref: GUID_ID);
begin
  with qBusqueda  do
  begin
    if active then close;
    SQL.Clear;
    SQL.Add('select V.ID as venta_id, V.NUMERO as NRO, V.FECHA');
    SQL.Add(' , E.RAZONSOCIAL as cliente, V.TOTAL as Monto');
    SQL.Add('from POSVENTAS V  ');
    SQL.Add('    left join CLIENTES C on V.CLIENTE_ID = C.ID ');
    SQL.Add('    left join EMPRESAS E on C.EMPRESA_ID = E.ID ');
    SQL.Add('    inner join POSVENTAITEMS VI on Vi.VENTA_ID = V.ID ');
    SQL.Add('    inner join POSPRODUCTOSSTOCK PS on PS.ID = VI.PRODUCTOSTOCK_ID ');
    SQL.Add(' where (V.BVISIBLE = 1) and (V.BANULADA <> 1) ');
    SQL.Add('    and (PS.PRODUCTO_ID = ''' +ref+ ''')');
  end;
  SQLEjecutar;
end;

procedure TDM_VentasBusqueda.BusCliente(ref: GUID_ID);
begin
  SQLBase;
  qBusqueda.SQL.Add(' and (V.Cliente_id = '''+ref+ ''')');
  SQLEjecutar;
end;

end.

