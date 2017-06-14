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
    PreciosalicuotaIVA_id: TLongintField;
    PreciosbOferta: TLongintField;
    PreciosbVisible: TLongintField;
    Preciosid: TStringField;
    Preciosiva: TFloatField;
    PrecioslistaPrecio_id: TLongintField;
    PrecioslxListaPrecio: TStringField;
    Preciosmonto: TFloatField;
    PreciosOfertaFin: TDateTimeField;
    PreciosOfertaIni: TDateTimeField;
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
    qTalleDisponibleDEL: TZQuery;
    qColorDisponibleINS: TZQuery;
    qColorDisponibleDEL: TZQuery;
    qTalleDisponibleINS: TZQuery;
    qTallesDisponibles: TZQuery;
    qColoresDisponiblesBVISIBLE: TSmallintField;
    qColoresDisponiblesBVISIBLE1: TSmallintField;
    qColoresDisponiblesBVISIBLE2: TSmallintField;
    qColoresDisponiblesBVISIBLE4: TSmallintField;
    qColoresDisponiblesBVISIBLE5: TSmallintField;
    qColoresDisponiblesCOLOR: TStringField;
    qColoresDisponiblesCOLOR1: TStringField;
    qColoresDisponiblesCOLOR2: TStringField;
    qColoresDisponiblesCOLOR4: TStringField;
    qColoresDisponiblesCOLOR5: TStringField;
    qColoresDisponiblesCOLOR_ID: TLongintField;
    qColoresDisponiblesCOLOR_ID1: TLongintField;
    qColoresDisponiblesCOLOR_ID2: TLongintField;
    qColoresDisponiblesCOLOR_ID4: TLongintField;
    qColoresDisponiblesCOLOR_ID5: TLongintField;
    qColoresDisponiblesID: TStringField;
    qColoresDisponiblesID1: TStringField;
    qColoresDisponiblesID2: TStringField;
    qColoresDisponiblesID4: TStringField;
    qColoresDisponiblesID5: TStringField;
    qColoresDisponiblesPRODUCTO_ID: TStringField;
    qColoresDisponiblesPRODUCTO_ID1: TStringField;
    qColoresDisponiblesPRODUCTO_ID2: TStringField;
    qColoresDisponiblesPRODUCTO_ID4: TStringField;
    qColoresDisponiblesPRODUCTO_ID5: TStringField;
    qGrillaPrincipal: TZQuery;
    qGrillaPrincipalCATEGORIA: TStringField;
    qGrillaPrincipalCODIGO: TStringField;
    qGrillaPrincipalDISPONIBLE: TFloatField;
    qGrillaPrincipalIDPRODUCTO: TStringField;
    qGrillaPrincipalMARCA: TStringField;
    qGrillaPrincipalMINIMO: TFloatField;
    qGrillaPrincipalNOMBRE: TStringField;
    qListaPreciosIDBVISIBLE: TSmallintField;
    qListaPreciosIDID: TLongintField;
    qListaPreciosIDLISTAPRECIO: TStringField;
    qListasPrecios: TZQuery;
    qListaPreciosID: TZQuery;
    qColoresDisponibles: TZQuery;
    qPrecioProductoALICUOTAIVA_ID: TLongintField;
    qPrecioProductoBOFERTA: TSmallintField;
    qPrecioProductoBVISIBLE: TSmallintField;
    qPrecioProductoID: TStringField;
    qPrecioProductoIVA: TFloatField;
    qPrecioProductoLISTAPRECIO_ID: TLongintField;
    qPrecioProductoLXLISTAPRECIO: TStringField;
    qPrecioProductoMONTO: TFloatField;
    qPrecioProductoOFERTAFIN: TDateField;
    qPrecioProductoOFERTAINI: TDateField;
    qPrecioProductoPRODUCTO_ID: TStringField;
    qPreciosProducto: TZQuery;
    qListasPreciosBVISIBLE: TSmallintField;
    qListasPreciosID: TLongintField;
    qListasPreciosLISTAPRECIO: TStringField;
    qPrecioProducto: TZQuery;
    qPreciosProductoALICUOTAIVA_ID: TLongintField;
    qPreciosProductoBOFERTA: TSmallintField;
    qPreciosProductoBVISIBLE: TSmallintField;
    qPreciosProductoID: TStringField;
    qPreciosProductoIVA: TFloatField;
    qPreciosProductoLISTAPRECIO_ID: TLongintField;
    qPreciosProductoLXLISTAPRECIO: TStringField;
    qPreciosProductoMONTO: TFloatField;
    qPreciosProductoOFERTAFIN: TDateField;
    qPreciosProductoOFERTAINI: TDateField;
    qPreciosProductoPRODUCTO_ID: TStringField;
    qTallesDisponiblesBVISIBLE: TSmallintField;
    qTallesDisponiblesID: TStringField;
    qTallesDisponiblesPRODUCTO_ID: TStringField;
    qTallesDisponiblesTALLE: TStringField;
    qTallesDisponiblesTALLE_ID: TLongintField;
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
    SELPreciosALICUOTAIVA_ID: TLongintField;
    SELPreciosBOFERTA: TSmallintField;
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
    SELPreciosOFERTAFIN: TDateField;
    SELPreciosOFERTAINI: TDateField;
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
    procedure DataModuleCreate(Sender: TObject);
    procedure PreciosAfterInsert(DataSet: TDataSet);
    procedure ProductosAfterInsert(DataSet: TDataSet);
  private
    _idProducto: GUID_ID;
    procedure prepararSQLFiltro;
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
    procedure modificarValorPrecio (refPrecio: GUID_ID; valor: double);
    procedure BorrarPrecio (refPrecio: GUID_ID);
    procedure GrabarPrecios;


    procedure AgregarColorDisponible (refColor: integer);
    procedure QuitarColorDisponible (refColor: integer);
    procedure LevantarColores;

    procedure AgregarTalleDisponible (refTalle: integer);
    procedure QuitarTalleDisponible (refTalle: integer);
    procedure LevantarTalles;


    function NombreListaPrecios (idLista: integer): string;
    function precioProducto (refProducto: GUID_ID; refListaPrecio: integer): Double;

    procedure FiltradoGrillaCodigo (codigoProducto: string);
    procedure FiltradoGrillaNombre (nombreProducto: string);
    procedure FiltradoGrillaNulo;

  end;

var
  DM_Productos: TDM_Productos;

implementation
{$R *.lfm}
uses
  SD_Configuracion
  ;

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
  PreciosbOferta.AsInteger:= 0;
  PreciosOfertaIni.AsDateTime:= Now;
  PreciosOfertaFin.AsDateTime:= Now;
  PreciosalicuotaIVA_id.asInteger:=  StrToIntDef(LeerDato(SECCION_APP,CFGD_IVA_ID), 3);
  EscribirDato(SECCION_APP, CFGD_IVA_ID, IntToStr(PreciosalicuotaIVA_id.asInteger)); //Por si el valor no esta en el cfg;
end;

procedure TDM_Productos.DataModuleCreate(Sender: TObject);
begin

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
  DM_General.ReiniciarTabla(Precios);
  Productos.Insert;
end;

procedure TDM_Productos.Editar(refProducto: GUID_ID);
begin
  _idProducto:= refProducto;
  DM_General.ReiniciarTabla(Productos);

  if SELProductos.Active then SELProductos.Close;
  SELProductos.ParamByName('id').AsString:= refProducto;
  SELProductos.Open;

  Productos.LoadFromDataSet(SELProductos, 0, lmAppend);
  SELProductos.Close;

  LevantarPreciosProducto;
  LevantarColores;
  LevantarTalles;

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

procedure TDM_Productos.modificarValorPrecio(refPrecio: GUID_ID; valor: double);
begin
  DM_General.ReiniciarTabla(Precios);
  EditarPrecio(refPrecio);
  Precios.Edit;
  Preciosmonto.AsFloat:=valor;
  Precios.Post;
  GrabarPrecios;
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

(*******************************************************************************
*** FILTRADO PARA GRILLA PRINCIPAL
*******************************************************************************)

procedure TDM_Productos.prepararSQLFiltro;
var
  elSELECT
  ,elFROM
  ,elWHERE:string;
begin
  elSELECT:= ' SELECT P.id as idProducto,C.CATEGORIA,M.MARCA,P.Codigo '
           + ' , P.Nombre, S.DISPONIBLE, P.Minimo ';
  elFROM:= ' FROM Productos P '
         + ' LEFT JOIN CATEGORIAS C ON C.ID = P.CATEGORIA_ID '
         + ' LEFT JOIN MARCAS M on M.ID = P.MARCA_ID '
         + ' LEFT JOIN STOCK S on S.PRODUCTO_ID = P.ID ';
  elWHERE:=' WHERE (P.bVisible = 1) ';

  with qGrillaPrincipal do
  begin
    if active then close;
    sql.Clear;
    sql.Add(elSELECT);
    sql.Add(elFROM);
    sql.Add(elWHERE);
  end;
end;


procedure TDM_Productos.FiltradoGrillaCodigo(codigoProducto: string);
begin
  prepararSQLFiltro;
  qGrillaPrincipal.SQL.Add(' AND (UPPER(P.Codigo) LIKE ''%'+UpperCase(codigoProducto)+'%'')');
  qGrillaPrincipal.Open;
end;

procedure TDM_Productos.FiltradoGrillaNombre(nombreProducto: string);
begin
  prepararSQLFiltro;
  qGrillaPrincipal.SQL.Add(' AND (UPPER(P.Nombre) LIKE ''%'+UpperCase(nombreProducto)+'%'')');
  qGrillaPrincipal.Open;
end;

procedure TDM_Productos.FiltradoGrillaNulo;
begin
  prepararSQLFiltro;
  qGrillaPrincipal.Open;
end;

(*******************************************************************************
*** COLORES
*******************************************************************************)

procedure TDM_Productos.AgregarColorDisponible(refColor: integer);
begin
  with qColorDisponibleINS do
  begin
    ParamByName('id').AsString:= DM_General.CrearGUID;
    ParamByName('producto_id').AsString:= Productosid.AsString;
    ParamByName('color_id').AsInteger:= refColor;
    ParamByName('bVisible').AsInteger:= 1;
    ExecSQL;
  end;
end;

procedure TDM_Productos.QuitarColorDisponible(refColor: integer);
begin
  with qColorDisponibleDEL do
  begin
    ParamByName('producto_id').AsString:= Productosid.AsString;
    ParamByName('color_id').AsInteger:= refColor;
    ExecSQL;
  end;
end;

procedure TDM_Productos.LevantarColores;
begin
  with qColoresDisponibles do
  begin
    if active then close;
    ParamByName('producto_id').asString:= Productosid.AsString;
    Open;
  end;
end;

(*******************************************************************************
*** TALLES
*******************************************************************************)

procedure TDM_Productos.AgregarTalleDisponible(refTalle: integer);
begin
  with qTalleDisponibleINS do
  begin
    ParamByName('id').AsString:= DM_General.CrearGUID;
    ParamByName('producto_id').AsString:= Productosid.AsString;
    ParamByName('talle_id').AsInteger:= refTalle;
    ParamByName('bVisible').AsInteger:= 1;
    ExecSQL;
  end;
end;

procedure TDM_Productos.QuitarTalleDisponible(refTalle: integer);
begin
  with qTalleDisponibleDEL do
  begin
    ParamByName('producto_id').AsString:= Productosid.AsString;
    ParamByName('talle_id').AsInteger:= refTalle;
    ExecSQL;
  end;
end;

procedure TDM_Productos.LevantarTalles;
begin
  with qTallesDisponibles do
  begin
    if active then close;
    ParamByName('producto_id').asString:= Productosid.AsString;
    Open;
  end;
end;

end.

