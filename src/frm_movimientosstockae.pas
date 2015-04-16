unit frm_movimientosstockae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbdateedit, rxspin, curredit, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, Buttons, DbCtrls, StdCtrls, DBGrids,
  Menus, dmstock, dmgeneral
  ;

type

  { TfrmMovimientosStockAE }

  TfrmMovimientosStockAE = class(TForm)
    btnBuscarProveedor: TBitBtn;
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
    ImgListaMenuPopUp: TImageList;
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
    MnBorrarProducto: TMenuItem;
    MnModificar: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    pMenuProductos: TPopupMenu;
    rgMovimiento: TRadioGroup;
    procedure btnBuscarProveedorClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure edBusCodigoKeyPress(Sender: TObject; var Key: char);
    procedure edBusNombreKeyPress(Sender: TObject; var Key: char);
    procedure edCantidadKeyPress(Sender: TObject; var Key: char);
    procedure edPrecioTotalKeyPress(Sender: TObject; var Key: char);
    procedure edPrecioUnitarioKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MnBorrarProductoClick(Sender: TObject);
    procedure MnModificarClick(Sender: TObject);
  private
    _idMovimientoStock: GUID_ID;
    _idProducto: GUID_ID;
    laOperacion: TOperacion;

    function BusquedaProducto(dato: string; criterio: integer): boolean;
    procedure pantallaBusquedaProducto (dato: string; criterio:integer);
    procedure AjustarPantallaProducto (refProducto: GUID_ID);
    procedure CargarMovimiento;
    procedure AjustarTotales;

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
  ,frm_EditarProductoMovimientoStock
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

procedure TfrmMovimientosStockAE.edPrecioTotalKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
  begin
    cargarMovimiento;
  end;
end;

procedure TfrmMovimientosStockAE.edPrecioUnitarioKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
  begin
    AjustarPantallaProducto(_idProducto);
    edPrecioTotal.SetFocus;
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

procedure TfrmMovimientosStockAE.MnBorrarProductoClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION'
                  , 'Borro el Producto: '
                   + DM_Stock.MovimientosStockDetalleslxNombre.AsString
                   +'?'
                  , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Stock.eliminarProductoMovimientoStock;
    AjustarTotales;
  end;
end;

procedure TfrmMovimientosStockAE.MnModificarClick(Sender: TObject);
var
  pant: TfrmEditarProductoMovimientoStock;

begin
  pant:= TfrmEditarProductoMovimientoStock.Create(self);
  try
    if pant.ShowModal = mrOK then
    begin
      AjustarTotales;
    end;
  finally
    pant.Free;
  end;

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
  if edPrecioUnitario.Value = 0 then
    edPrecioUnitario.Value:= DM_Productos.precioProducto(refProducto
                            ,DM_General.obtenerIDIntComboBox(cbListaPrecio)
                            );
  edPrecioTotal.Value:= edPrecioUnitario.Value * edCantidad.Value;
  edPrecioUnitario.SetFocus;
end;

procedure TfrmMovimientosStockAE.CargarMovimiento;
var
  elMovimiento: string;
begin
  if rgMovimiento.ItemIndex = 0 then
    elMovimiento:= MOV_INGRESO
  else
    elMovimiento:= MOV_EGRESO;

  if _idProducto <> GUIDNULO then
  begin
    DM_Stock.cargarMovimiento (_idProducto
                              , edCantidad.Value
                              , edPrecioUnitario.Value
                              , edPrecioTotal.Value
                              , elMovimiento
                              , nuevo);

    AjustarTotales;
    (*
    ( edPrecioTotal.Value
                     ,(( DM_Productos.precioProducto(_idProducto
                          ,DM_General.obtenerIDIntComboBox(cbListaPrecio)) ) * edCantidad.Value
                      )
                    );
    *)

    edCantidad.SetFocus;
    _idProducto:= GUIDNULO;
    edBusNombre.Clear;
    edBusCodigo.Clear;
    edPrecioUnitario.Value:= 0;
    edPrecioTotal.Value:= 0;
  end
  else
    ShowMessage('Error buscando el producto seleccionado');
end;

procedure TfrmMovimientosStockAE.AjustarTotales;
var
  totalCargado, TotalLista: double;
begin
  DM_Stock.TotalMovimiento (DM_General.obtenerIDIntComboBox(cbListaPrecio)
                            , totalCargado
                            , totalLista);
  edTotalCargado.Value:= totalCargado;
  edTotalListaPrecio.Value:= totalLista;
end;

procedure TfrmMovimientosStockAE.Inicializar;
begin
  DM_General.CargarComboBox(cbListaPrecio,'ListaPrecio','id',DM_Productos.qListasPrecios);

  if _idMovimientoStock = GUIDNULO then
  Begin
    DM_Stock.NuevoMovimientoStock;
    laOperacion:= nuevo;
  end
  else
  begin
    laOperacion:= modificar;
    DM_Stock.EditarMovimiento(_idMovimientoStock);
    cbListaPrecio.ItemIndex:=  DM_General.obtenerIdxCombo(cbListaPrecio
                                            ,DM_Stock.MovimientosStocklistaprecio_id.AsInteger);
    edProveedor.Text:= DM_Proveedores.RazonSocial;
    AjustarTotales;
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

procedure TfrmMovimientosStockAE.edBusNombreKeyPress(Sender: TObject;
  var Key: char);
begin
   if Key = #13 then
  begin
    if BusquedaProducto(edBusNombre.Text, BUS_NOMBRE) then
    begin
      edPrecioUnitario.SetFocus;
    end;
  end;
end;

procedure TfrmMovimientosStockAE.btnBuscarProveedorClick(Sender: TObject);
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

procedure TfrmMovimientosStockAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmMovimientosStockAE.btnGrabarClick(Sender: TObject);
begin
  With DM_Stock, MovimientosStock do
  begin
    Edit;
    MovimientosStocklistaprecio_id.AsInteger:= DM_General.obtenerIDIntComboBox(cbListaPrecio);
    Post;
  end;
  DM_Stock.GrabarMovimientoStock;
  DM_Stock.RecalcularStockPorMovimiento;
  ModalResult:= mrOK;
end;

end.

