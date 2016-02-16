unit dmventasSinFacturar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, dmgeneral;

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
    ComprobantesTipoComprobante: TStringField;
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
  clienteID:= GUIDNULO;
  sinFacturar:= False;
  sinCAE:= False;
end;

procedure TDM_VentasSinFacturar.obtenerVentasSinFacturar(fechaIni,
  fechaFin: TDate);
begin

end;

procedure TDM_VentasSinFacturar.obtenerVentasSinCAE(fechaIni, fechaFin: TDate);
begin

end;

procedure TDM_VentasSinFacturar.ObtenerVentas(fechaIni, fechaFin: TDate);
begin
  if sinFacturar then
   ObtenerVentasSinFacturar (fechaIni, fechaFin);
  if sinCAE then
   ObtenerVentasSinCAE (fechaIni, fechaFin);
end;

end.

