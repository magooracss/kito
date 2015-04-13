unit dmbusquedapedidos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;

type

  { TDM_BusquedaPedidos }

  TDM_BusquedaPedidos = class(TDataModule)
    qBusCliente: TZQuery;
    qBusClienteCLIENTE: TStringField;
    qBusClienteESTADO: TStringField;
    qBusClienteFTOMA: TDateField;
    qBusClienteID: TStringField;
    qBusClienteNUMERO: TLongintField;
    qBusClienteTOTALPEDIDO: TFloatField;
    qBusFechaToma: TZQuery;
    qBusFechaTomaCLIENTE: TStringField;
    qBusFechaTomaESTADO: TStringField;
    qBusFechaTomaFTOMA: TDateField;
    qBusFechaTomaID: TStringField;
    qBusFechaTomaNUMERO: TLongintField;
    qBusFechaTomaTOTALPEDIDO: TFloatField;
    qBusNroCLIENTE: TStringField;
    qBusNroESTADO: TStringField;
    qBusNroFTOMA: TDateField;
    qBusNroID: TStringField;
    qBusNroNUMERO: TLongintField;
    qBusNroTOTALPEDIDO: TFloatField;
    Resultados: TRxMemoryData;
    qBusNro: TZQuery;
    ResultadosCliente: TStringField;
    ResultadosEstado: TStringField;
    ResultadosfToma: TDateTimeField;
    Resultadosid: TStringField;
    ResultadosNumero: TLongintField;
    ResultadosTotalPedido: TFloatField;
  private
    procedure CargarResultados (var elQuery: TZQuery);
  public
    procedure BuscarPorNumero(nroPedido: integer);
    procedure BuscarPorFToma(fechaPedido: TDate);
    procedure BuscarPorCliente(refCliente: GUID_ID);

  end;

var
  DM_BusquedaPedidos: TDM_BusquedaPedidos;

implementation

{$R *.lfm}

{ TDM_BusquedaPedidos }

procedure TDM_BusquedaPedidos.CargarResultados(var elQuery: TZQuery);
begin
  DM_General.ReiniciarTabla(Resultados);
  Resultados.LoadFromDataSet(elQuery, 0 , lmAppend);
  elQuery.Close;
end;

procedure TDM_BusquedaPedidos.BuscarPorNumero(nroPedido: integer);
begin
  with qBusNro do
  begin
    if active then close;
    ParamByName('parametro').asInteger:= nroPedido;
    Open;
    CargarResultados(qBusNro);
  end;
end;

procedure TDM_BusquedaPedidos.BuscarPorFToma(fechaPedido: TDate);
begin
  with qBusFechaToma do
  begin
   if active then close;
   ParamByName('parametro').AsDate:= fechaPedido;
   Open;
   CargarResultados(qBusFechaToma);
 end;

end;

procedure TDM_BusquedaPedidos.BuscarPorCliente(refCliente: GUID_ID);
begin
  with qBusCliente do
  begin
   if active then close;
   ParamByName('parametro').AsString:= refCliente;
   Open;
   CargarResultados(qBusCliente);
  end;
end;

end.

