unit dmhojaderuta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds;

type

  { TDM_HojaDeRuta }

  TDM_HojaDeRuta = class(TDataModule)
    HojaDeRuta: TRxMemoryData;
    HojaDeRutabAnulada: TLongintField;
    HojaDeRutabVisible: TLongintField;
    HojaDeRutaDetallesbCobroDestino: TLongintField;
    HojaDeRutaDetallesbEntregaCompleto: TLongintField;
    HojaDeRutaDetallesbNoEntregado: TLongintField;
    HojaDeRutaDetallesbultos: TLongintField;
    HojaDeRutaDetallesbVisible: TLongintField;
    HojaDeRutaDetallesclienteDireccion_id: TStringField;
    HojaDeRutaDetallesdevolucion_id: TStringField;
    HojaDeRutaDetalleshojaDeRuta_id: TStringField;
    HojaDeRutaDetallesid: TStringField;
    HojaDeRutaDetallesmontoCobrado: TFloatField;
    HojaDeRutaDetallesmontoCobrar: TFloatField;
    HojaDeRutaDetallesmotivoNoEntrega_id: TLongintField;
    HojaDeRutaDetallesnota: TStringField;
    HojaDeRutaDetallesnroOrdena: TLongintField;
    HojaDeRutaDetallespedido_id: TStringField;
    HojaDeRutafAnulada: TDateTimeField;
    HojaDeRutaFecha: TDateTimeField;
    HojaDeRutaid: TStringField;
    HojaDeRutanumero: TLongintField;
    HojaDeRutatransportista_id: TStringField;
    HojaDeRutaDetalles: TRxMemoryData;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DM_HojaDeRuta: TDM_HojaDeRuta;

implementation

{$R *.lfm}

end.

