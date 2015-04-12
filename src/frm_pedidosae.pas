unit frm_pedidosae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbdateedit, dbcurredit, RxDBSpinEdit, rxspin,
  Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons, DbCtrls, StdCtrls,
  DBGrids, dmgeneral
  ;

type

  { TfrmPedidoAE }

  TfrmPedidoAE = class(TForm)
    BitBtn1: TBitBtn;
    btnBuscarProducto: TBitBtn;
    btnBusquedaCliente: TBitBtn;
    btnBusquedaVendedor: TBitBtn;
    btnBusquedaTransportista: TBitBtn;
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    cbListaPrecio: TComboBox;
    DBGrid1: TDBGrid;
    DBText2: TDBText;
    DBText3: TDBText;
    ds_PedidosDetalles: TDataSource;
    DBDateEdit1: TDBDateEdit;
    DBDateEdit2: TDBDateEdit;
    DBMemo1: TDBMemo;
    DBRadioGroup1: TDBRadioGroup;
    DBText1: TDBText;
    DS_Pedidos: TDataSource;
    DS_Clientes: TDataSource;
    ds_pedidosEstados: TDataSource;
    ds_PedidosTiposEstados: TDataSource;
    edCantidad: TRxSpinEdit;
    edClienteRazonSocial: TEdit;
    edBusCodigo: TEdit;
    edBusNombre: TEdit;
    edVendedorRazonSocial: TEdit;
    edTransportista: TEdit;
    GbCliente: TGroupBox;
    GbVendedor: TGroupBox;
    GbTransportista: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    RxDBCurrEdit1: TRxDBCurrEdit;
    RxDBCurrEdit2: TRxDBCurrEdit;
    RxDBCurrEdit3: TRxDBCurrEdit;
    RxDBCurrEdit4: TRxDBCurrEdit;
    RxDBSpinEdit1: TRxDBSpinEdit;
    procedure btnBuscarProductoClick(Sender: TObject);
    procedure btnBusquedaClienteClick(Sender: TObject);
    procedure btnBusquedaTransportistaClick(Sender: TObject);
    procedure btnBusquedaVendedorClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure edBusCodigoKeyPress(Sender: TObject; var Key: char);
    procedure edBusNombreKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure RxDBCurrEdit1Exit(Sender: TObject);

  private
    _idPedido: GUID_ID;
    procedure Inicializar;
    function DatosValidos: boolean;
    procedure AvisoError (mensaje: string);
    procedure PantallaBusProd(dato: string; Tipo: integer);
    procedure BusquedaProducto (dato: string; tipo: integer);
    procedure CargarProducto(productoID: GUID_ID);
  public
    property idPedido: GUID_ID read _idPedido write _idPedido;
  end;

var
  frmPedidoAE: TfrmPedidoAE;

implementation
{$R *.lfm}
uses
   dmpedidos
  ,dmclientes
  ,dmvendedores
  ,dmproductos
  ,frm_busquedaempresas
  ,dmbusquedaempresas
  ,frm_busquedaProductos
  ;

{ TfrmPedidoAE }

procedure TfrmPedidoAE.btnBusquedaClienteClick(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(Self);
  try
    pantBus.restringirTipo:= IDX_CLIENTE;
    if pantBus.ShowModal = mrOK then
    begin
      With DM_Pedidos, Pedidos do
      begin
        Edit;
        Pedidoscliente_id.AsString:= pantBus.idCliente;
        Post;
      end;
    DM_Clientes.Editar(pantBus.idCliente);
    edClienteRazonSocial.Text:= pantBus.RazonSocial;
    cbListaPrecio.ItemIndex:= DM_General.obtenerIdxCombo(cbListaPrecio
                                                       ,DM_Clientes.ClienteslistaPrecio_id.AsInteger);

    end;
  finally
    pantBus.Free;
  end;
end;


procedure TfrmPedidoAE.btnBusquedaTransportistaClick(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(Self);
  try
    pantBus.restringirTipo:= IDX_TRANSPORTISTA;
    if pantBus.ShowModal = mrOK then
    begin
      With DM_Pedidos, Pedidos do
      begin
        Edit;
        Pedidostransportista_id.AsString:= pantBus.idTransportista;
        Post;
      end;
    edTransportista.Text:= pantBus.RazonSocial;
    end;
  finally
    pantBus.Free;
  end;
end;

procedure TfrmPedidoAE.btnBusquedaVendedorClick(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(Self);
  try
    pantBus.restringirTipo:= IDX_VENDEDOR;
    if pantBus.ShowModal = mrOK then
    begin
      With DM_Pedidos, Pedidos do
      begin
        Edit;
        Pedidosvendedor_id.AsString:= pantBus.idVendedor;
        Post;
      end;
    edVendedorRazonSocial.Text:= pantBus.RazonSocial;
    end;
  finally
    pantBus.Free;
  end;
end;

procedure TfrmPedidoAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmPedidoAE.btnGrabarClick(Sender: TObject);
begin
  if DatosValidos then
  begin
   ModalResult:= mrOK;
  end;
end;

procedure TfrmPedidoAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmPedidoAE.RxDBCurrEdit1Exit(Sender: TObject);
begin
 DM_Pedidos.AjustarMontoPedido;
end;


procedure TfrmPedidoAE.Inicializar;
begin
  DM_General.CargarComboBox(cbListaPrecio, 'ListaPrecio', 'id', DM_Productos.qListasPrecios);
  if _idPedido = GUIDNULO then
  begin
    DM_Pedidos.Nuevo;
  end
  Else
  begin
    DM_Pedidos.LevantarPedido (_idPedido);
    edClienteRazonSocial.Text:= DM_Clientes.RazonSocial;
    edVendedorRazonSocial.Text:= DM_Vendedores.RazonSocial;
    cbListaPrecio.ItemIndex:= DM_General.obtenerIdxCombo(cbListaPrecio
                                                        ,DM_Clientes.ClienteslistaPrecio_id.AsInteger);
  end;
end;

function TfrmPedidoAE.DatosValidos: boolean;
begin
  Result:= True;
  with DM_Pedidos do
  begin
    if Pedidoscliente_id.AsString = GUIDNULO then
    begin
     AvisoError ('Falta vincular el cliente con el pedido!!');
     Result:= False;
    end;
  end;
end;

procedure TfrmPedidoAE.AvisoError(mensaje: string);
begin
  ShowMessage(mensaje);
end;

(*******************************************************************************
*** CARGA DE PRODUCTO
*******************************************************************************)

procedure TfrmPedidoAE.CargarProducto(productoID: GUID_ID);
begin
  DM_Pedidos.NuevoProducto (productoID
                            , DM_General.obtenerIDIntComboBox(cbListaPrecio)
                            ,edCantidad.Value);

end;


procedure TfrmPedidoAE.PantallaBusProd(dato: string; Tipo: integer);
var
  pant: TfrmBusquedaProducto;
begin
  pant:= TfrmBusquedaProducto.Create(self);
  try
    if (dato <> EmptyStr) then
    begin
      pant.DatoBuscar:= dato;
      pant.CriterioBuscar:= Tipo;
    end;
    if pant.ShowModal = mrOK then
    begin
     CargarProducto (pant.productoSeleccionado);
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmPedidoAE.btnBuscarProductoClick(Sender: TObject);
begin
  PantallaBusProd(EmptyStr, MaxInt);
end;

procedure TfrmPedidoAE.BusquedaProducto(dato: string; tipo: integer);
begin
  with DM_Productos do
  begin
    BuscarProducto(TRIM(dato), tipo);
    if ((qBuscarProductos.Active) and
         (qBuscarProductos.RecordCount = 1)) then
    begin
      CargarProducto (qBuscarProductosID.AsString);
    end
    else
    begin
      PantallaBusProd(dato, tipo);
    end;
  end;
end;

procedure TfrmPedidoAE.edBusCodigoKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    BusquedaProducto(edBusCodigo.Text, BUS_CODIGO);
    edBusCodigo.Clear;
    edBusCodigo.SetFocus;
  end;
end;

procedure TfrmPedidoAE.edBusNombreKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    BusquedaProducto(edBusNombre.Text, BUS_NOMBRE);
    edBusNombre.Clear;
    edBusNombre.SetFocus;
  end;

end;



end.

