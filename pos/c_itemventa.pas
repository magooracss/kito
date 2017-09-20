unit c_itemventa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, dmgeneral;

type

  { TItemVenta }

  TItemVenta = Class
    private
      _producto: string;
      _productoID: GUID_ID;
      _stockID: GUID_ID;
      _colorID: GUID_ID;
      _color: string;
      _talle: string;
      _talleID: GUID_ID;
      _cantidad: double;
      _precio: double;
      _listaPrecio: string;
      _listaPrecioID: GUID_ID;
    public
      property productoID: GUID_ID read _productoID write _productoID;
      property producto: string read _producto write _producto;
      property stockID: GUID_ID read _stockID write _stockID;
      property colorID: GUID_ID read _colorID write _colorID;
      property color: string read _color write _color;
      property talle: string read _talle write _talle;
      property talleID: GUID_ID read _talleID write _talleID;
      property cantidad: double read _cantidad write _cantidad;
      property precio: double read _precio write _precio;
      property listaPrecio: string read _listaPrecio write _listaPrecio;
      property listaPrecioID: GUID_ID read _listaPrecioID write _listaPrecioID;

      constructor ItemVenta;

  end;

implementation

{ TItemVenta }

constructor TItemVenta.ItemVenta;
begin
  _productoID:= GUIDNULO;
  _stockID:= GUIDNULO;
  _colorID:= GUIDNULO;
  _color:= EmptyStr;
  _talle:= EmptyStr;
  _talleID:= GUIDNULO;
  _cantidad:= 1;
  _precio:= 0;
  _listaPrecio:= EmptyStr;
  _listaPrecioID:= GUIDNULO;
  _producto:= EmptyStr;
end;

end.

