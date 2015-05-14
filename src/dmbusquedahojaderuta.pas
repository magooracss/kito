unit dmbusquedahojaderuta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;

type

  { TDM_BuscarHdR }

  TDM_BuscarHdR = class(TDataModule)
    qBusNroPedido: TZQuery;
    qBusClienteDATO: TStringField;
    qBusClienteDATO1: TStringField;
    qBusFechaHdR: TZQuery;
    qBusNroHdRFECHA3: TDateField;
    qBusNroHdRFECHA4: TDateField;
    qBusNroHdRID3: TStringField;
    qBusNroHdRID4: TStringField;
    qBusNroHdRNROHDR3: TLongintField;
    qBusNroHdRNROHDR4: TLongintField;
    qBusNroHdRTRANSPORTISTA3: TStringField;
    qBusNroHdRTRANSPORTISTA4: TStringField;
    qBusTransp: TZQuery;
    qBusNroHdRFECHA: TDateField;
    qBusNroHdRFECHA1: TDateField;
    qBusNroHdRFECHA2: TDateField;
    qBusNroHdRID: TStringField;
    qBusNroHdRID1: TStringField;
    qBusNroHdRID2: TStringField;
    qBusNroHdRNROHDR: TLongintField;
    qBusNroHdRNROHDR1: TLongintField;
    qBusNroHdRNROHDR2: TLongintField;
    qBusNroHdRTRANSPORTISTA: TStringField;
    qBusNroHdRTRANSPORTISTA1: TStringField;
    qBusNroHdRTRANSPORTISTA2: TStringField;
    qBusCliente: TZQuery;
    Resultados: TRxMemoryData;
    qBusNroHdR: TZQuery;
    ResultadosDato: TStringField;
    ResultadosFecha: TDateTimeField;
    Resultadosid: TStringField;
    ResultadosNroHdR: TLongintField;
    ResultadosTransportista: TStringField;
  private
    { private declarations }
  public
    procedure BuscarNroHdR (nro: integer);
    procedure BuscarFechaHdR(fecha: TDate);
    procedure BuscarTransportista (transpID: GUID_ID);
    procedure BuscarCliente (clienteID: GUID_ID);
    procedure BuscarNroPedido (nroPedido: Integer);
  end;

var
  DM_BuscarHdR: TDM_BuscarHdR;

implementation
{$R *.lfm}

{ TDM_BuscarHdR }

procedure TDM_BuscarHdR.BuscarNroHdR(nro: integer);
begin
  DM_General.ReiniciarTabla(Resultados);
  with qBusNroHdR do
  begin
    if active then close;
    ParamByName('parametro').asInteger:= nro;
    Open;
    Resultados.LoadFromDataSet(qBusNroHdR, 0, lmAppend);
    close;
  end;
end;

procedure TDM_BuscarHdR.BuscarFechaHdR(fecha: TDate);
begin
  DM_General.ReiniciarTabla(Resultados);
  with qBusFechaHdR do
  begin
    if active then close;
    ParamByName('parametro').AsDate:= fecha;
    Open;
    Resultados.LoadFromDataSet(qBusFechaHdR, 0, lmAppend);
    close;
  end;
end;

procedure TDM_BuscarHdR.BuscarTransportista(transpID: GUID_ID);
begin
  DM_General.ReiniciarTabla(Resultados);
  with qBusTransp do
  begin
    if active then close;
    ParamByName('parametro').AsString:= transpID;
    Open;
    Resultados.LoadFromDataSet(qBusTransp, 0, lmAppend);
    close;
  end;
end;

procedure TDM_BuscarHdR.BuscarCliente(clienteID: GUID_ID);
begin
  DM_General.ReiniciarTabla(Resultados);
  with qBusCliente do
  begin
    if active then close;
    ParamByName('parametro').AsString:= clienteID;
    Open;
    Resultados.LoadFromDataSet(qBusCliente, 0, lmAppend);
    close;
  end;
end;

procedure TDM_BuscarHdR.BuscarNroPedido(nroPedido: Integer);
begin
  DM_General.ReiniciarTabla(Resultados);
  with qBusNroPedido do
  begin
    if active then close;
    ParamByName('parametro').AsInteger:= nroPedido;
    Open;
    Resultados.LoadFromDataSet(qBusNroPedido, 0, lmAppend);
    close;
  end;
end;

end.

