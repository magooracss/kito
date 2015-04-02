unit dmproductos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset, db
  ,dmgeneral
  ;

type

  { TDM_Productos }

  TDM_Productos = class(TDataModule)
    Productos: TRxMemoryData;
    ProductosbVisible: TLongintField;
    ProductoscantTotalizar: TFloatField;
    Productoscategoria_id: TLongintField;
    ProductoscodBarras: TStringField;
    Productoscodigo: TStringField;
    Productosid: TStringField;
    Productosmarca_id: TLongintField;
    Productosminimo: TFloatField;
    Productosnombre: TStringField;
    Productosunidad_id: TLongintField;
    SELProductos: TZQuery;
    SELProductosBVISIBLE: TSmallintField;
    SELProductosCANTTOTALIZAR: TFloatField;
    SELProductosCATEGORIA_ID: TLongintField;
    SELProductosCODBARRAS: TStringField;
    SELProductosCODIGO: TStringField;
    SELProductosID: TStringField;
    SELProductosMARCA_ID: TLongintField;
    SELProductosMINIMO: TFloatField;
    SELProductosNOMBRE: TStringField;
    SELProductosUNIDAD_ID: TLongintField;
    INSProductos: TZQuery;
    UPDProductos: TZQuery;
    procedure ProductosAfterInsert(DataSet: TDataSet);
  private
    _idProducto: GUID_ID;
  public
    property idProducto: GUID_ID read _idProducto write _idProducto;
  end;

var
  DM_Productos: TDM_Productos;

implementation

{$R *.lfm}

{ TDM_Productos }

procedure TDM_Productos.ProductosAfterInsert(DataSet: TDataSet);
begin
  _idProducto:= DM_General.CrearGUID;

  Productosid.AsString:= _idProducto;
  Productosmarca_id.AsInteger:= 0;
  Productoscodigo.AsString:= EmptyStr;
  Productoscategoria_id.AsInteger:= 0;
  Productosnombre.AsString:= EmptyStr;
  Productosminimo.AsFloat:= 0;
  Productosunidad_id.asInteger:= 0;
  ProductoscantTotalizar.AsFloat:= 0;
  ProductoscodBarras.asString:= EmptyStr;
  ProductosbVisible.asInteger:= 1;
end;

end.

