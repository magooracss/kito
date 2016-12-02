unit dmbusquedarecibosinternos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral;

type

  { TDM_BusquedaRecibosInternos }

  TDM_BusquedaRecibosInternos = class(TDataModule)
    qBusClienteCLIENTE: TStringField;
    qBusClienteFECHARECIBO: TDateField;
    qBusClienteIDRECIBO: TStringField;
    qBusClienteMONTO: TFloatField;
    qBusClienteNUMERORECIBO: TLongintField;
    qBusFechaCLIENTE: TStringField;
    qBusFechaFECHARECIBO: TDateField;
    qBusFechaIDRECIBO: TStringField;
    qBusFechaMONTO: TFloatField;
    qBusFechaNUMERORECIBO: TLongintField;
    qBusNumeroCLIENTE: TStringField;
    qBusNumeroFECHARECIBO: TDateField;
    qBusNumeroIDRECIBO: TStringField;
    qBusNumeroMONTO: TFloatField;
    qBusNumeroNUMERORECIBO: TLongintField;
    Resultados: TRxMemoryData;
    ResultadosCliente: TStringField;
    ResultadosFechaRecibo: TDateTimeField;
    ResultadosidRecibo: TStringField;
    ResultadosMonto: TFloatField;
    ResultadosNumeroRecibo: TLongintField;
    qBusNumero: TZQuery;
    qBusFecha: TZQuery;
    qBusCliente: TZQuery;
  private
    { private declarations }
  public
    procedure BusNumero (nro: integer);
    procedure BusFecha (laFecha: TDate);
    procedure BusCliente(refCliente: GUID_ID);
  end;

var
  DM_BusquedaRecibosInternos: TDM_BusquedaRecibosInternos;

implementation

{$R *.lfm}

{ TDM_BusquedaRecibosInternos }

procedure TDM_BusquedaRecibosInternos.BusNumero(nro: integer);
begin
  DM_General.ReiniciarTabla(Resultados);
  with qBusNumero do
  begin
    if active then close;
    ParamByName('parametro').asInteger:= nro;
    Open;
    Resultados.LoadFromDataSet(qBusNumero, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_BusquedaRecibosInternos.BusFecha(laFecha: TDate);
begin
  DM_General.ReiniciarTabla(Resultados);
  with qBusFecha do
  begin
    if active then close;
    ParamByName('parametro').AsDateTime:= laFecha;
    Open;
    Resultados.LoadFromDataSet(qBusFecha, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_BusquedaRecibosInternos.BusCliente(refCliente: GUID_ID);
begin
  DM_General.ReiniciarTabla(Resultados);
  with qBusCliente do
  begin
    if active then close;
    ParamByName('parametro').AsString:= refCliente;
    Open;
    Resultados.LoadFromDataSet(qBusCliente, 0, lmAppend);
    Close;
  end;
end;

end.

