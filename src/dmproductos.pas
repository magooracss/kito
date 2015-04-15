unit dmproductos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset, db
  ,dmgeneral, StdCtrls
  ;

const
  BUS_NOMBRE = 0;
  BUS_CATEGORIA = 1;
  BUS_MARCA = 2;
  BUS_CODIGO = 3;
  BUS_CODBARRAS = 4;

type

  { TDM_Productos }

  TDM_Productos = class(TDataModule)
    DELPrecios: TZQuery;
    INSPrecios: TZQuery;
    Precios: TRxMemoryData;
    PreciosbVisible: TLongintField;
    Preciosid: TStringField;
    Preciosiva: TFloatField;
    PrecioslistaPrecio_id: TLongintField;
    PrecioslxListaPrecio: TStringField;
    Preciosmonto: TFloatField;
    Preciosproducto_id: TStringField;
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
    qBuscarProductosBVISIBLE: TSmallintField;
    qBuscarProductosCANTTOTALIZAR: TFloatField;
    qBuscarProductosCATEGORIA: TStringField;
    qBuscarProductosCATEGORIA_ID: TLongintField;
    qBuscarProductosCODBARRAS: TStringField;
    qBuscarProductosCODIGO: TStringField;
    qBuscarProductosID: TStringField;
    qBuscarProductosMARCA: TStringField;
    qBuscarProductosMARCA_ID: TLongintField;
    qBuscarProductosMINIMO: TFloatField;
    qBuscarProductosNOMBRE: TStringField;
    qBuscarProductosUNIDAD_ID: TLongintField;
    qCategorias: TZQuery;
    qCategoriasBVISIBLE: TSmallintField;
    qCategoriasCATEGORIA: TStringField;
    qCategoriasID: TLongintField;
    qListaPreciosIDBVISIBLE: TSmallintField;
    qListaPreciosIDID: TLongintField;
    qListaPreciosIDLISTAPRECIO: TStringField;
    qListasPrecios: TZQuery;
    qListaPreciosID: TZQuery;
    qPrecioProductoBVISIBLE: TSmallintField;
    qPrecioProductoID: TStringField;
    qPrecioProductoIVA: TFloatField;
    qPrecioProductoLISTAPRECIO_ID: TLongintField;
    qPrecioProductoLXLISTAPRECIO: TStringField;
    qPrecioProductoMONTO: TFloatField;
    qPrecioProductoPRODUCTO_ID: TStringField;
    qPreciosProducto: TZQuery;
    qListasPreciosBVISIBLE: TSmallintField;
    qListasPreciosID: TLongintField;
    qListasPreciosLISTAPRECIO: TStringField;
    qPrecioProducto: TZQuery;
    qPreciosProductoBVISIBLE: TSmallintField;
    qPreciosProductoID: TStringField;
    qPreciosProductoIVA: TFloatField;
    qPreciosProductoLISTAPRECIO_ID: TLongintField;
    qPreciosProductoLXLISTAPRECIO: TStringField;
    qPreciosProductoMONTO: TFloatField;
    qPreciosProductoPRODUCTO_ID: TStringField;
    qUnidades: TZQuery;
    qMarcasBVISIBLE: TSmallintField;
    qMarcasID: TLongintField;
    qMarcasMARCA: TStringField;
    qUnidadesBVISIBLE: TSmallintField;
    qUnidadesFACTOR: TFloatField;
    qUnidadesID: TLongintField;
    qUnidadesTOTALIZA: TStringField;
    qUnidadesUNIDAD: TStringField;
    SELPrecios: TZQuery;
    SELPreciosBVISIBLE: TSmallintField;
    SELPreciosBVISIBLE1: TSmallintField;
    SELPreciosID: TStringField;
    SELPreciosID1: TStringField;
    SELPreciosIVA: TFloatField;
    SELPreciosIVA1: TFloatField;
    SELPreciosLISTAPRECIO_ID: TLongintField;
    SELPreciosLISTAPRECIO_ID1: TLongintField;
    SELPreciosMONTO: TFloatField;
    SELPreciosMONTO1: TFloatField;
    SELPreciosPRODUCTO_ID: TStringField;
    SELPreciosPRODUCTO_ID1: TStringField;
    SELProductos: TZQuery;
    qMarcas: TZQuery;
    qBuscarProductos: TZQuery;
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
    UPDPrecios: TZQuery;
    UPDProductos: TZQuery;
    DELProductos: TZQuery;
    procedure PreciosAfterInsert(DataSet: TDataSet);
    procedure ProductosAfterInsert(DataSet: TDataSet);
  private
    _idProducto: GUID_ID;
  public
    property idProducto: GUID_ID read _idProducto write _idProducto;

    procedure ActualizarRefsCb(refMarca, refCategoria, refUnidad: integer);
    procedure Nuevo;
    procedure Editar (refProducto: GUID_ID);
    procedure Grabar;
    procedure Borrar;

    procedure BuscarProducto(dato: string; criterio: integer);

    procedure LevantarPreciosProducto;

    procedure ActualizarRefsCbPrecios (refListaPrecio: integer);
    procedure NuevoPrecio (iva: Double);
    procedure EditarPrecio (refPrecio: GUID_ID);
    procedure BorrarPrecio (refPrecio: GUID_ID);
    procedure GrabarPrecios;

    function NombreListaPrecios (idLista: integer): string;
    function precioProducto (refProducto: GUID_ID; refListaPrecio: integer): Double;

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

procedure TDM_Productos.LevantarPreciosProducto;
begin
  if Productos.Active then
  begin
    DM_General.ReiniciarTabla(Precios);
    with qPreciosProducto do
    begin
      if active then close;
      ParamByName('refProducto').asString:= Productosid.AsString;
      Open;
      Precios.LoadFromDataSet(qPreciosProducto, 0, lmAppend);
      close;
    end;
  end;
end;

procedure TDM_Productos.PreciosAfterInsert(DataSet: TDataSet);
begin
  Preciosid.AsString:= DM_General.CrearGUID;
  Preciosproducto_id.AsString:= Productosid.AsString;
  Preciosmonto.AsFloat:= 0;
  PrecioslistaPrecio_id.AsInteger:= 0;
  PreciosbVisible.AsInteger:= 1;
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

  LevantarPreciosProducto;

  Productos.Edit;
end;

procedure TDM_Productos.Grabar;
begin
  DM_General.GrabarDatos(SELProductos, INSProductos, UPDProductos, Productos, 'id');
end;

procedure TDM_Productos.Borrar;
begin
  With DELProductos do
  begin
    ParamByName('id').AsString:= _idProducto;
    ExecSQL;
  end;
end;


procedure TDM_Productos.BuscarProducto(dato: string; criterio: integer);
var
  qSEL, qFROM, qWHERE, qORDER: string;
begin
  qSEL:= '  SELECT P.*, M.Marca,C.Categoria ';
  qFROM:= ' FROM Productos P '
            + ' LEFT JOIN marcas M ON M.id = P.marca_id '
            + ' LEFT JOIN categorias C ON C.id = P.categoria_id ';

  qWHERE:= ' WHERE (P.bVisible = 1) ';

  with qBuscarProductos do
  begin
    if active then close;
    SQL.Clear;
    SQL.Add(qSEL);
    case criterio of
      BUS_NOMBRE:
        begin
          qWHERE:= qWHERE + ' AND (UPPER(P.Nombre) LIKE ''%'+UpperCase(Trim(dato))+'%'')';
          qORDER:= ' ORDER BY P.Nombre ';
        end;
      BUS_CATEGORIA:
        begin
          qFROM:= ' FROM Productos P '
                 + ' LEFT JOIN marcas M ON M.id = P.marca_id '
                 + ' INNER JOIN categorias C ON C.id = P.categoria_id ';
          qWHERE:= qWHERE
                  + ' AND (UPPER(C.categoria) LIKE ''%'+UpperCase(Trim(dato))+'%'')'
                  + ' AND (C.bVisible = 1) '
                  ;
          qORDER:= ' ORDER BY C.Categoria, P.Nombre ';
        end;
       BUS_MARCA:
         begin
           qFROM:= ' FROM Productos P '
                  + ' INNER JOIN marcas M ON M.id = P.marca_id '
                  + ' LEFT JOIN categorias C ON C.id = P.categoria_id ';
           qWHERE:= qWHERE
                   + ' AND (UPPER(M.marca) LIKE ''%'+UpperCase(Trim(dato))+'%'')'
                   + ' AND (M.bVisible = 1) ';
           qORDER:= ' ORDER BY M.Marca, P.Nombre ';
         end;
       BUS_CODIGO:
         begin
           qWHERE:= qWHERE + ' AND (UPPER(P.Codigo) LIKE '''+UpperCase(Trim(dato))+'%'')';
           qORDER:= ' ORDER BY P.Codigo, P.Nombre ';
         end;
       BUS_CODBARRAS:
         begin
           qWHERE:= qWHERE + ' AND (UPPER(P.CodBarras) LIKE '''+UpperCase(Trim(dato))+''')';
           qORDER:= ' ORDER BY P.CodBarras, P.Nombre ';
         end;
    end;
    sql.Add(qFROM);
    sql.Add(qWHERE);
    sql.Add(qORDER);
    Open;
  end;


end;

(*******************************************************************************
*** PRECIOS
********************************************************************************)
procedure TDM_Productos.ActualizarRefsCbPrecios(refListaPrecio: integer);
begin
  Precios.Edit;
  PrecioslistaPrecio_id.AsInteger:= refListaPrecio;
  Precios.Post;
end;


procedure TDM_Productos.NuevoPrecio(iva: Double);
begin
  DM_General.ReiniciarTabla(Precios);
  with Precios do
  begin
    Insert;
    Preciosiva.asFloat:= iva;
    Post;
  end;
end;

procedure TDM_Productos.EditarPrecio(refPrecio: GUID_ID);
begin
  DM_General.ReiniciarTabla(Precios);

  if SELPrecios.Active then SELPrecios.Close;
  SELPrecios.ParamByName('id').asString:= refPrecio;
  SELPrecios.Open;

  Precios.LoadFromDataSet(SELPrecios, 0, lmAppend);
end;

procedure TDM_Productos.BorrarPrecio(refPrecio: GUID_ID);
begin
  DELPrecios.ParamByName('id').asString:= refPrecio;
  DELPrecios.ExecSQL;
end;

procedure TDM_Productos.GrabarPrecios;
begin
   DM_General.GrabarDatos(SELPrecios, INSPrecios, UPDPrecios, Precios, 'id');
end;

function TDM_Productos.NombreListaPrecios(idLista: integer): string;
begin
  with qListaPreciosID do
  begin
    if active then close;
    ParamByName('id').AsInteger:= idLista;
    Open;
    if RecordCount > 0 then
     Result := qListaPreciosIDLISTAPRECIO.AsString
    else
     Result:= EmptyStr;
  end;
end;

function TDM_Productos.precioProducto(refProducto: GUID_ID;
  refListaPrecio: integer): Double;
begin
  with qPrecioProducto do
  begin
    if active then close;
    ParamByName('refProducto').AsString:= refProducto;
    ParamByName('refListaPrecio').AsInteger:= refListaPrecio;
    Open;
    if (RecordCount > 0) then
     Result:= qPrecioProductoMONTO.AsFloat
    else
     Result:= 0;
    Close;
  end;
end;

end.

