unit dmbusquedamovstock;
{$mode objfpc}{$H+}
interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;

type

  { TDM_BusquedaMovStock }

  TDM_BusquedaMovStock = class(TDataModule)
    qBusFechaFECHA: TDateField;
    qBusFechaID: TStringField;
    qBusFechaNUMERO: TLongintField;
    qBusFechaPROVEEDOR: TStringField;
    qBusFechaREMITO: TStringField;
    qBusProveedor: TZQuery;
    qBusFecha: TZQuery;
    qBusNro: TZQuery;
    qBusNroFECHA: TDateField;
    qBusNroID: TStringField;
    qBusNroNUMERO: TLongintField;
    qBusNroPROVEEDOR: TStringField;
    qBusNroREMITO: TStringField;
    qBusProveedorFECHA: TDateField;
    qBusProveedorID: TStringField;
    qBusProveedorNUMERO: TLongintField;
    qBusProveedorPROVEEDOR: TStringField;
    qBusProveedorREMITO: TStringField;
    Resultados: TRxMemoryData;
    Resultadosfecha: TDateTimeField;
    Resultadosid: TStringField;
    ResultadosNumero: TLongintField;
    Resultadosproveedor: TStringField;
    ResultadosRemito: TStringField;
  private
    procedure CargarResultados (var elQuery: TZQuery);
  public
    procedure BuscarPorNumero(nro: integer);
    procedure BuscarPorFecha(fecha: TDate);
    procedure BuscarPorProveedor(refProveedor: GUID_ID);
  end;

var
  DM_BusquedaMovStock: TDM_BusquedaMovStock;

implementation

{$R *.lfm}

{ TDM_BusquedaMovStock }

procedure TDM_BusquedaMovStock.CargarResultados(var elQuery: TZQuery);
begin
  DM_General.ReiniciarTabla(Resultados);
  Resultados.LoadFromDataSet(elQuery, 0 , lmAppend);
  elQuery.Close;
end;

procedure TDM_BusquedaMovStock.BuscarPorNumero(nro: integer);
begin
  with qBusNro do
  begin
    if active then close;
    ParamByName('parametro').asInteger:= nro;
    Open;
    CargarResultados(qBusNro);
  end;
end;

procedure TDM_BusquedaMovStock.BuscarPorFecha(fecha: TDate);
begin
  with qBusFecha do
  begin
   if active then close;
   ParamByName('parametro').AsDate:= fecha;
   Open;
   CargarResultados(qBusFecha);
  end;
 end;

procedure TDM_BusquedaMovStock.BuscarPorProveedor(refProveedor: GUID_ID);
begin
  with qBusProveedor do
  begin
   if active then close;
   ParamByName('parametro').AsString:= refProveedor;
   Open;
   CargarResultados(qBusProveedor);
  end;
end;

end.

