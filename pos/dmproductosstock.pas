unit dmproductosstock;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;

type

  { TDM_PosProductosStock }

  TDM_PosProductosStock = class(TDataModule)
    MovimientoStockActualizar: TFloatField;
    MovimientoStockbVisible: TLongintField;
    MovimientoStockCantidad: TFloatField;
    MovimientoStockCodigo: TStringField;
    MovimientoStockColor: TStringField;
    MovimientoStockcolor_id: TStringField;
    MovimientoStockid: TStringField;
    MovimientoStockProducto: TStringField;
    MovimientoStockproducto_id: TStringField;
    MovimientoStockTalle: TStringField;
    MovimientoStocktalle_id: TStringField;
    MovimientoStockTipoOperacion: TLongintField;
    ProductosStock: TRxMemoryData;
    MovimientoStock: TRxMemoryData;
    ProductosStockbVisible: TLongintField;
    ProductosStockCantidad: TFloatField;
    ProductosStockColor: TStringField;
    ProductosStockcolor_id: TStringField;
    ProductosStockid: TStringField;
    ProductosStockproducto_id: TStringField;
    ProductosStockTalle: TStringField;
    ProductosStocktalle_id: TStringField;
    qLevantarStock: TZQuery;
    qLevantarStockBVISIBLE: TSmallintField;
    qLevantarStockCANTIDAD: TFloatField;
    qLevantarStockCOLOR: TStringField;
    qLevantarStockCOLOR_ID: TStringField;
    qLevantarStockID: TStringField;
    qLevantarStockPRODUCTO_ID: TStringField;
    qLevantarStockTALLE: TStringField;
    qLevantarStockTALLE_ID: TStringField;
    qStockPorMarcaCODIGO: TStringField;
    qStockPorMarcaCOLOR: TStringField;
    qStockPorMarcaCOLOR_ID: TStringField;
    qStockPorMarcaPRODUCTO: TStringField;
    qStockPorMarcaPRODUCTO_ID: TStringField;
    qStockPorMarcaTALLE: TStringField;
    qStockPorMarcaTALLE_ID: TStringField;
    SELProductosStock: TZQuery;
    INSProductosStock: TZQuery;
    qBuscarProducto: TZQuery;
    SELProductosStockBVISIBLE3: TSmallintField;
    SELProductosStockBVISIBLE4: TSmallintField;
    SELProductosStockCANTIDAD3: TFloatField;
    SELProductosStockCANTIDAD4: TFloatField;
    SELProductosStockCOLOR_ID3: TStringField;
    SELProductosStockCOLOR_ID4: TStringField;
    SELProductosStockID3: TStringField;
    SELProductosStockID4: TStringField;
    SELProductosStockPRODUCTO_ID3: TStringField;
    SELProductosStockPRODUCTO_ID4: TStringField;
    SELProductosStockTALLE_ID3: TStringField;
    SELProductosStockTALLE_ID4: TStringField;
    UPDProductosStock: TZQuery;
    SELProductosStockBVISIBLE: TSmallintField;
    SELProductosStockBVISIBLE1: TSmallintField;
    SELProductosStockBVISIBLE2: TSmallintField;
    SELProductosStockCANTIDAD: TFloatField;
    SELProductosStockCANTIDAD1: TFloatField;
    SELProductosStockCANTIDAD2: TFloatField;
    SELProductosStockCOLOR_ID: TStringField;
    SELProductosStockCOLOR_ID1: TStringField;
    SELProductosStockCOLOR_ID2: TStringField;
    SELProductosStockID: TStringField;
    SELProductosStockID1: TStringField;
    SELProductosStockID2: TStringField;
    SELProductosStockPRODUCTO_ID: TStringField;
    SELProductosStockPRODUCTO_ID1: TStringField;
    SELProductosStockPRODUCTO_ID2: TStringField;
    SELProductosStockTALLE_ID: TStringField;
    SELProductosStockTALLE_ID1: TStringField;
    SELProductosStockTALLE_ID2: TStringField;
    qStockPorMarca: TZQuery;
    procedure MovimientoStockAfterInsert(DataSet: TDataSet);
    procedure ProductosStockAfterInsert(DataSet: TDataSet);
  private
    procedure CargarCantidadesStock;
  public
    procedure AgregarProducto (refProducto, refColor, refTalle: GUID_ID; cantidad: Double);
    procedure QuitarProducto (refProducto, refColor, refTalle: GUID_ID; cantidad: Double);
    function Cantidad (refProducto, refColor, refTalle: GUID_ID):Double;
    procedure Grabar;

    procedure LevantarStockProducto (refProducto: GUID_ID);
    procedure LevantarProducto (refProducto, refColor, refTalle: GUID_ID);
    procedure LevantarStockProductoIdMov (refMovimiento: GUID_ID);

    procedure LevantarMovStockMarca (refMarca: integer);
    procedure AsentarMovimientos (tipoMovimiento: integer);
  end;

var
  DM_PosProductosStock: TDM_PosProductosStock;

implementation

{$R *.lfm}

{ TDM_PosProductosStock }

procedure TDM_PosProductosStock.MovimientoStockAfterInsert(DataSet: TDataSet);
begin
  MovimientoStockid.AsString:= GUIDNULO;
  MovimientoStockproducto_id.AsString:= GUIDNULO;
  MovimientoStockcolor_id.AsString:= GUIDNULO;
  MovimientoStocktalle_id.AsString:= GUIDNULO;
  MovimientoStockCantidad.AsFloat:= 0;
  MovimientoStockbVisible.AsInteger:= 1;
  MovimientoStockProducto.AsString:= EmptyStr;
  MovimientoStockTalle.AsString:= EmptyStr;
  MovimientoStockColor.AsString:= EmptyStr;
  MovimientoStockActualizar.AsFloat:= 0;
  MovimientoStockTipoOperacion.AsInteger:= MOV_INGRESO;
end;

procedure TDM_PosProductosStock.ProductosStockAfterInsert(DataSet: TDataSet);
begin
  ProductosStockid.AsString:= DM_General.CrearGUID;
  ProductosStockproducto_id.AsString:= GUIDNULO;
  ProductosStockcolor_id.AsString:= GUIDNULO;
  ProductosStocktalle_id.AsString:= GUIDNULO;
  ProductosStockCantidad.AsFloat:= 0;
  ProductosStockbVisible.AsInteger:= 1;
end;


procedure TDM_PosProductosStock.LevantarProducto(refProducto, refColor,
  refTalle: GUID_ID);
begin
  DM_General.ReiniciarTabla(ProductosStock);
  with qBuscarProducto do
  begin
    if active then close;
    ParamByName('producto_id').asString:= refProducto;
    ParamByName('color_id').asString:= refColor;
    ParamByName('talle_id').asString:= refTalle;
    Open;
    if RecordCount > 0 then
       ProductosStock.LoadFromDataSet(qBuscarProducto, 0, lmAppend)
    else
    begin
      ProductosStock.Insert;
      ProductosStockproducto_id.AsString:= refProducto;
      ProductosStockcolor_id.AsString:= refColor;
      ProductosStocktalle_id.AsString:= refTalle;
      ProductosStock.Post;
    end;
    Close;
  end;
end;

procedure TDM_PosProductosStock.LevantarStockProductoIdMov(
  refMovimiento: GUID_ID);
begin
  if SELProductosStock.Active then SELProductosStock.Close;

  SELProductosStock.ParamByName('id').AsString:= refMovimiento;
  SELProductosStock.Open;

  ProductosStock.LoadFromDataSet(SELProductosStock, 0, lmAppend);

  SELProductosStock.Close;
end;

procedure TDM_PosProductosStock.CargarCantidadesStock;
begin
  With MovimientoStock do
  begin
    DisableControls;
    if (active and (RecordCount > 0)) then
    begin
      First;
      While not eof do
      begin
        Edit;
        MovimientoStockCantidad.AsFloat:= Cantidad( MovimientoStockproducto_id.AsString
                                                  , MovimientoStockColor_id.AsString
                                                  , MovimientoStockTalle_id.AsString);
        Post;
        Next;
      end;
    end;
    EnableControls;
  end;
end;

procedure TDM_PosProductosStock.AgregarProducto(refProducto, refColor,
  refTalle: GUID_ID; cantidad: Double);
var
  cant: Double;
begin
  LevantarProducto(refProducto, refColor, refTalle);
  with ProductosStock do
  begin
    cant:= 0;
    if RecordCount > 0 then
    begin
     Edit;
     cant:= ProductosStockCantidad.AsFloat + cantidad;
    end
    else
    begin
      Insert;
      cant:= cantidad;
    end;
    ProductosStockCantidad.AsFloat:= cant;
    ProductosStock.Post;
    Grabar;
  end;
end;

procedure TDM_PosProductosStock.QuitarProducto(refProducto, refColor,
  refTalle: GUID_ID; cantidad: Double);
begin
  AgregarProducto(refProducto, refColor, refTalle, (cantidad * -1));
end;

function TDM_PosProductosStock.Cantidad(refProducto, refColor, refTalle: GUID_ID
  ): Double;
begin
  LevantarProducto(refProducto, refColor, refTalle);
  if ProductosStock.RecordCount > 0 then
     Result:= ProductosStockCantidad.AsFloat
  else
     Result:= 0;
end;

procedure TDM_PosProductosStock.Grabar;
begin
  DM_General.GrabarDatos(SELProductosStock, INSProductosStock, UPDProductosStock, ProductosStock, 'id');
end;

procedure TDM_PosProductosStock.LevantarStockProducto(refProducto: GUID_ID);
begin
  DM_General.ReiniciarTabla(ProductosStock);
  with qLevantarStock do
  begin
    if active then close;
    ParamByName('producto_id').asString:= refProducto;
    Open;
    ProductosStock.LoadFromDataSet(qLevantarStock, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_PosProductosStock.LevantarMovStockMarca(refMarca: integer);
begin
   DM_General.ReiniciarTabla(MovimientoStock);
   with qStockPorMarca do
   begin
     if active then close;
     ParamByName('marcaID').AsInteger:= refMarca;
     Open;
     MovimientoStock.LoadFromDataSet(qStockPorMarca, 0, lmAppend);
     Close;
   end;
   CargarCantidadesStock;
end;

procedure TDM_PosProductosStock.AsentarMovimientos(tipoMovimiento: integer);
begin
  with MovimientoStock do
  begin
    DisableControls;
    if RecordCount > 0 then
    begin
      First;
      While Not EOF do
      begin
        case tipoMovimiento of
          MOV_INGRESO: AgregarProducto( MovimientoStockproducto_id.asString
                                      , MovimientoStockcolor_id.AsString
                                      , MovimientoStocktalle_id.AsString
                                      , MovimientoStockActualizar.AsFloat
                                      );
          MOV_EGRESO: QuitarProducto  ( MovimientoStockproducto_id.asString
                                      , MovimientoStockcolor_id.AsString
                                      , MovimientoStocktalle_id.AsString
                                      , MovimientoStockActualizar.AsFloat
                                      );
        end;

        Next;
      end;
    end;
    EnableControls;
  end;
end;

end.

