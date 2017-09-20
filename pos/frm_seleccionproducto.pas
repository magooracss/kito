unit frm_seleccionproducto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, rxlookup, curredit, dbcurredit,
  Forms, Controls, Graphics, Dialogs, ExtCtrls, DbCtrls, Buttons, Spin,
  StdCtrls, dmgeneral, dmproductos, dmproductosstock, c_itemventa
  ;

type

  { TfrmSeleccionProducto }

  TfrmSeleccionProducto = class(TForm)
    btnAccept: TBitBtn;
    btnCancel: TBitBtn;
    edPrecioUnitario: TCurrencyEdit;
    edPrecioTotal: TCurrencyEdit;
    DBText1: TDBText;
    DBText2: TDBText;
    ds_precios: TDataSource;
    ds_Stock: TDataSource;
    ds_producto: TDataSource;
    edCantidad: TFloatSpinEdit;
    GrillaColores: TRxDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    cbListaPrecios: TRxDBLookupCombo;
    procedure btnAcceptClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edCantidadChange(Sender: TObject);
    procedure edPrecioUnitarioChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RxDBLookupCombo1ChangeData(Sender: TObject);
  private
    dmProd: TDM_Productos;
    dmStock: TDM_PosProductosStock;
    _idProd: GUID_ID;
    _itemPrecio: double;
    _itemVenta: TItemVenta;
    procedure Initialise;
    procedure LevantarProducto;
    procedure CargarValoresSeleccionados;
    procedure ActualizarPrecioTotal;
    function chequearStock: boolean;
  public
    property productoID: GUID_ID read _idProd write _idProd;
    property itemVentaseleccionado: TItemVenta read _itemVenta write _itemVenta;
  end;

var
  frmSeleccionProducto: TfrmSeleccionProducto;

implementation

{$R *.lfm}

{ TfrmSeleccionProducto }


procedure TfrmSeleccionProducto.FormCreate(Sender: TObject);
begin
  dmProd:= TDM_Productos.Create(self);
  dmStock:= TDM_PosProductosStock.Create(self);

  _idProd:= GUIDNULO;

  ds_producto.DataSet:= dmProd.Productos;
  ds_Stock.DataSet:= dmStock.ProductosStock;
  ds_precios.DataSet:= dmProd.Precios;
end;

procedure TfrmSeleccionProducto.btnCancelClick(Sender: TObject);
begin
  modalResult:= mrCancel;
end;

procedure TfrmSeleccionProducto.edCantidadChange(Sender: TObject);
begin
  ActualizarPrecioTotal;
end;

procedure TfrmSeleccionProducto.edPrecioUnitarioChange(Sender: TObject);
begin
  ActualizarPrecioTotal
end;

procedure TfrmSeleccionProducto.btnAcceptClick(Sender: TObject);
begin
  if chequearStock then
  begin
    cargarValoresSeleccionados;
    ModalResult:= mrOK;
  end;
end;

procedure TfrmSeleccionProducto.FormDestroy(Sender: TObject);
begin
  dmProd.Free;
end;

procedure TfrmSeleccionProducto.FormShow(Sender: TObject);
begin
  Initialise;
end;

procedure TfrmSeleccionProducto.RxDBLookupCombo1ChangeData(Sender: TObject);
begin
  edPrecioUnitario.Value:= ds_precios.DataSet.FieldByName('monto').AsFloat ;
  ActualizarPrecioTotal;
end;

procedure TfrmSeleccionProducto.Initialise;
begin
  if _idProd = GUIDNULO then
  begin

  end
  else
  begin
    LevantarProducto;
  end;
end;

procedure TfrmSeleccionProducto.LevantarProducto;
begin
  dmProd.Editar(_idProd);
  dmStock.LevantarStockProducto(_idProd);
  cbListaPrecios.KeyValue:= dmProd.Preciosid.AsString;
end;

procedure TfrmSeleccionProducto.CargarValoresSeleccionados;
begin
  with _itemVenta do
  begin
    productoID:= _idProd;
    producto:= dmProd.Productosnombre.AsString;
   // stockID:= dmStock.ProductosStockid.AsString;
    colorID:= dmStock.ProductosStockcolor_id.AsString;
    color:= dmStock.ProductosStockColor.AsString;
    talle:= dmStock.ProductosStockTalle.AsString;
    talleID:= dmStock.ProductosStocktalle_id.AsString;
    cantidad:= edCantidad.Value;
    precio:= edPrecioTotal.Value;
    listaPrecio:= cbListaPrecios.Text;
    listaPrecioID:= cbListaPrecios.KeyValue;
  end;
end;

procedure TfrmSeleccionProducto.ActualizarPrecioTotal;
begin
  edPrecioTotal.Value:= edCantidad.Value * edPrecioUnitario.Value;
end;

function TfrmSeleccionProducto.chequearStock: boolean;
var
  resultado: boolean;
begin
   resultado:= True;
   if (dmStock.ProductosStockCantidad.AsFloat < edCantidad.Value) then
   begin
     resultado:= (MessageDlg ('ATENCION'
                   , 'El talle y color del producto seleccionado figura sin stock suficiente!'
                    +#10#13+ 'Igualmente lo selecciona?'
                   , mtConfirmation, [mbYes, mbNo],0 ) = mrYes);


   end;

   Result:= resultado;
end;

end.

