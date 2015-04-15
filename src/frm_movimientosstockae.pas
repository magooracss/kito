unit frm_movimientosstockae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbdateedit, rxspin, curredit, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, Buttons, DbCtrls, StdCtrls, DBGrids,
  dmstock
  ,dmgeneral
  ;

type

  { TfrmMovimientosStockAE }

  TfrmMovimientosStockAE = class(TForm)
    BitBtn1: TBitBtn;
    btnBuscarProducto: TBitBtn;
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    cbListaPrecio: TComboBox;
    edPrecioUnitario: TCurrencyEdit;
    edPrecioTotal: TCurrencyEdit;
    edTotalCargado: TCurrencyEdit;
    edTotalListaPrecio: TCurrencyEdit;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBGrid1: TDBGrid;
    DBMemo1: TDBMemo;
    ds_MovStock: TDataSource;
    DBText1: TDBText;
    ds_MovStockDet: TDataSource;
    edBusCodigo: TEdit;
    edBusNombre: TEdit;
    edCantidad: TRxSpinEdit;
    edProveedor: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure edBusCodigoKeyPress(Sender: TObject; var Key: char);
    procedure edCantidadKeyPress(Sender: TObject; var Key: char);
    procedure edPrecioUnitarioKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idMovimientoStock: GUID_ID;
    _idProducto: GUID_ID;

    function BusquedaProducto(dato: string; criterio: integer): boolean;
    procedure pantallaBusquedaProducto (dato: string; criterio:integer);
    procedure AjustarPantallaProducto (refProducto: GUID_ID);

    procedure Inicializar;
  public
    property idMovimientoStock: GUID_ID write _idMovimientoStock;
  end;

var
  frmMovimientosStockAE: TfrmMovimientosStockAE;

implementation
{$R *.lfm}
uses
  dmproductos
  ,frm_busquedaProductos
  ,frm_busquedaempresas
  ,dmproveedores
  ;

{ TfrmMovimientosStockAE }

procedure TfrmMovimientosStockAE.edCantidadKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
  begin
    edBusCodigo.SetFocus;
  end;
end;

procedure TfrmMovimientosStockAE.edPrecioUnitarioKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
  begin
    AjustarPantallaProducto(_idProducto);
    edTotalCargado.SetFocus;
  end;
end;

procedure TfrmMovimientosStockAE.FormCreate(Sender: TObject);
begin
  _idMovimientoStock:= GUIDNULO;
  _idProducto:= GUIDNULO;
end;

procedure TfrmMovimientosStockAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

function TfrmMovimientosStockAE.BusquedaProducto(dato: string; criterio: integer
  ): boolean;
begin
  with DM_Productos do
  begin
    BuscarProducto(TRIM(dato), criterio);
    if ((qBuscarProductos.Active) and
         (qBuscarProductos.RecordCount = 1)) then
    begin
      AjustarPantallaProducto (qBuscarProductosID.AsString);
      _idProducto:= qBuscarProductosID.AsString;
    end
    else
    begin
      pantallaBusquedaProducto(dato, criterio);
    end;
  end;
end;

procedure TfrmMovimientosStockAE.pantallaBusquedaProducto(dato: string;
  criterio: integer);
var
  pant: TfrmBusquedaProducto;
begin
  pant:= TfrmBusquedaProducto.Create(self);
  try
    if (dato <> EmptyStr) then
    begin
      pant.DatoBuscar:= dato;
      pant.CriterioBuscar:= criterio;
    end;
    if pant.ShowModal = mrOK then
    begin
     _idProducto:=pant.productoSeleccionado;
     AjustarPantallaProducto (pant.productoSeleccionado);
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmMovimientosStockAE.AjustarPantallaProducto(refProducto: GUID_ID);
begin
  DM_Productos.Editar(refProducto);
  edBusCodigo.Text:= DM_Productos.Productoscodigo.AsString;
  edBusNombre.Text:= DM_Productos.Productosnombre.AsString;
  edPrecioUnitario.Value:= DM_Productos.precioProducto(refProducto
                          ,DM_General.obtenerIDIntComboBox(cbListaPrecio)
                          );
  edPrecioTotal.Value:= edPrecioUnitario.Value * edCantidad.Value;
  edPrecioUnitario.SetFocus;
end;

procedure TfrmMovimientosStockAE.Inicializar;
begin
  DM_General.CargarComboBox(cbListaPrecio,'ListaPrecio','id',DM_Productos.qListasPrecios);

  if _idMovimientoStock = GUIDNULO then
  Begin
    DM_Stock.NuevoMovimientoStock;
  end;


end;


procedure TfrmMovimientosStockAE.edBusCodigoKeyPress(Sender: TObject;
  var Key: char);
begin
  if Key = #13 then
  begin
    if BusquedaProducto(edBusCodigo.Text, BUS_CODIGO) then
    begin
      edPrecioUnitario.SetFocus;
    end;
  end;
end;

procedure TfrmMovimientosStockAE.BitBtn1Click(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(Self);
  try
    pantBus.restringirTipo:= IDX_PROVEEDOR;
    if pantBus.ShowModal = mrOK then
    begin
      With DM_Stock, MovimientosStock do
      begin
        Edit;
        MovimientosStockproveedor_id.AsString:= pantBus.idProveedor;
        Post;
      end;
    DM_Proveedores.Editar(pantBus.idProveedor);
    edProveedor.Text:= pantBus.RazonSocial;
    cbListaPrecio.ItemIndex:= DM_General.obtenerIdxCombo(cbListaPrecio
                                                       ,DM_Proveedores.ProveedoreslistaPrecio_id.AsInteger);

    end;
  finally
    pantBus.Free;
  end;
end;

end.

