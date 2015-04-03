unit dmproductos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset, db
  ,dmgeneral, StdCtrls
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
    qCategorias: TZQuery;
    qCategoriasBVISIBLE: TSmallintField;
    qCategoriasCATEGORIA: TStringField;
    qCategoriasID: TLongintField;
    qUnidades: TZQuery;
    qMarcasBVISIBLE: TSmallintField;
    qMarcasID: TLongintField;
    qMarcasMARCA: TStringField;
    qUnidadesBVISIBLE: TSmallintField;
    qUnidadesFACTOR: TFloatField;
    qUnidadesID: TLongintField;
    qUnidadesTOTALIZA: TStringField;
    qUnidadesUNIDAD: TStringField;
    SELProductos: TZQuery;
    qMarcas: TZQuery;
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

    procedure ActualizarRefsCb(refMarca, refCategoria, refUnidad: integer);
    procedure Nuevo;
    procedure Editar (refProducto: GUID_ID);
    procedure Grabar;

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

procedure TDM_Productos.ActualizarRefsCb(refMarca, refCategoria,
  refUnidad: integer);
begin
  Productos.Edit;
  Productosmarca_id.AsInteger:= refMarca;
  Productoscategoria_id.AsInteger:= refCategoria;
  Productosunidad_id.AsInteger:= refUnidad;
  Productos.Post;
end;

procedure TDM_Productos.Nuevo;
begin
  DM_General.ReiniciarTabla(Productos);
  Productos.Insert;
end;

procedure TDM_Productos.Editar(refProducto: GUID_ID);
begin
  DM_General.ReiniciarTabla(Productos);

  if SELProductos.Active then SELProductos.Close;
  SELProductos.ParamByName('id').AsString:= refProducto;
  SELProductos.Open;

  Productos.LoadFromDataSet(SELProductos, 0, lmAppend);
  SELProductos.Close;

  Productos.Edit;
end;

procedure TDM_Productos.Grabar;
begin
  DM_General.GrabarDatos(SELProductos, INSProductos, UPDProductos, Productos, 'id');
end;

end.

