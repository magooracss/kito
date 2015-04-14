unit dmstock;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;


type

  { TDM_Stock }

  TDM_Stock = class(TDataModule)
    qStockProductoARMADO: TFloatField;
    qStockProductoDISPONIBLE: TFloatField;
    qStockProductoID: TStringField;
    qStockProductoPEDIDOS: TFloatField;
    qStockProductoPRODUCTO_ID: TStringField;
    SELStockARMADO: TFloatField;
    SELStockDISPONIBLE: TFloatField;
    SELStockID: TStringField;
    SELStockPEDIDOS: TFloatField;
    SELStockPRODUCTO_ID: TStringField;
    stock: TRxMemoryData;
    stockarmado: TFloatField;
    stockdisponible: TFloatField;
    stockid: TStringField;
    stockpedidos: TFloatField;
    stockproducto_id: TStringField;
    qStockProducto: TZQuery;
    SELStock: TZQuery;
    INSStock: TZQuery;
    UPDStock: TZQuery;
    procedure stockAfterInsert(DataSet: TDataSet);
  private
    function Getarmado: double;
    function Getdisponible: double;
    function GetidProducto: GUID_ID;
    function Getpedidos: double;
    procedure SetidProducto(AValue: GUID_ID);
  public
    property idProducto: GUID_ID read GetidProducto write SetidProducto;
    property disponible: double read Getdisponible;
    property pedidos: double read Getpedidos;
    property armado: double read Getarmado;


    procedure productoDisponible (cantidad: double); //carga los productos a pedir
    procedure productoPedido (cantidad: double); //Baja de Disponible, incrementa Pedidos
    procedure productoArmado (cantidad: double); //Baja de pedidos, incrementa Armados
    procedure productoEntregado (cantidad: Double); //Baja de Stock Armados

    procedure Grabar;
  end;

var
  DM_Stock: TDM_Stock;

implementation

{$R *.lfm}

{ TDM_Stock }

procedure TDM_Stock.stockAfterInsert(DataSet: TDataSet);
begin
  stockid.AsString:= DM_General.CrearGUID;
  stockproducto_id.AsString:= GUIDNULO;
  stockdisponible.AsFloat:= 0;
  stockpedidos.AsFloat:= 0;
  stockarmado.AsFloat:= 0;
end;

function TDM_Stock.Getarmado: double;
begin
  if ((stock.Active) and (stock.RecordCount > 0)) then
    Result:= stockarmado.AsFloat
  else
    Result:= 0;
end;

function TDM_Stock.Getdisponible: double;
begin
  if ((stock.Active) and (stock.RecordCount > 0)) then
    Result:= stockdisponible.AsFloat
  else
    Result:= 0;
end;

function TDM_Stock.GetidProducto: GUID_ID;
begin
  if ((stock.Active) and (stock.RecordCount > 0)) then
    Result:= stockproducto_id.AsString
  else
    Result:= GUIDNULO;
end;

function TDM_Stock.Getpedidos: double;
begin
  if ((stock.Active) and (stock.RecordCount > 0)) then
    Result:= stockpedidos.AsFloat
  else
    Result:= 0;
end;

procedure TDM_Stock.SetidProducto(AValue: GUID_ID);
begin
  DM_General.ReiniciarTabla(stock);
  with qStockProducto do
  begin
    if active then close;
    ParamByName('producto_id').AsString:= AValue;
    Open;
    stock.LoadFromDataSet(qStockProducto, 0, lmAppend);
    Close;
  end;
end;


procedure TDM_Stock.productoDisponible(cantidad: double);
begin
  with Stock do
  begin
    Edit;
    stockdisponible.AsFloat:= stockdisponible.AsFloat + cantidad;
    Post;
  end;
end;

procedure TDM_Stock.productoPedido(cantidad: double);
begin
  with Stock do
  begin
    Edit;
    stockdisponible.AsFloat:= stockdisponible.AsFloat - cantidad;
    stockpedidos.AsFloat:= stockpedidos.AsFloat + cantidad;
    Post;
  end;
end;

procedure TDM_Stock.productoArmado(cantidad: double);
begin
  with Stock do
  begin
    Edit;
    stockpedidos.AsFloat:= stockpedidos.AsFloat - cantidad;
    stockarmado.AsFloat:= stockarmado.AsFloat + cantidad;
    Post;
  end;
end;

procedure TDM_Stock.productoEntregado(cantidad: Double);
begin
  with Stock do
  begin
    Edit;
    stockarmado.AsFloat:= stockarmado.AsFloat - cantidad;
    Post;
  end;
end;

procedure TDM_Stock.Grabar;
begin
  DM_General.GrabarDatos(SELStock, INSStock, UPDStock, stock, 'id');
end;

end.

