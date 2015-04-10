unit frm_pedidosae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbdateedit, dbcurredit, RxDBSpinEdit, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, Buttons, DbCtrls, StdCtrls, DBGrids,
  dmgeneral
  ;

type

  { TfrmPedidoAE }

  TfrmPedidoAE = class(TForm)
    BitBtn1: TBitBtn;
    btnBusquedaCliente: TBitBtn;
    btnBusquedaVendedor: TBitBtn;
    btnBusquedaTransportista: TBitBtn;
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    DBGrid1: TDBGrid;
    ds_PedidosDetalles: TDataSource;
    DBDateEdit1: TDBDateEdit;
    DBDateEdit2: TDBDateEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    DBRadioGroup1: TDBRadioGroup;
    DBText1: TDBText;
    DS_Pedidos: TDataSource;
    DS_Clientes: TDataSource;
    ds_pedidosEstados: TDataSource;
    ds_PedidosTiposEstados: TDataSource;
    edClienteRazonSocial: TEdit;
    edVendedorRazonSocial: TEdit;
    edTransportista: TEdit;
    GbCliente: TGroupBox;
    GbVendedor: TGroupBox;
    GbTransportista: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    RxDBCurrEdit1: TRxDBCurrEdit;
    RxDBCurrEdit2: TRxDBCurrEdit;
    RxDBCurrEdit3: TRxDBCurrEdit;
    RxDBCurrEdit4: TRxDBCurrEdit;
    RxDBSpinEdit1: TRxDBSpinEdit;
    procedure btnBusquedaClienteClick(Sender: TObject);
    procedure btnBusquedaTransportistaClick(Sender: TObject);
    procedure btnBusquedaVendedorClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idPedido: GUID_ID;
    procedure Inicializar;
    function DatosValidos: boolean;
    procedure AvisoError (mensaje: string);
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
  ,frm_busquedaempresas
  ,dmbusquedaempresas
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
    edClienteRazonSocial.Text:= pantBus.RazonSocial;
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

procedure TfrmPedidoAE.Inicializar;
begin
  if _idPedido = GUIDNULO then
  begin
    DM_Pedidos.Nuevo;
  end
  Else
  begin
    DM_Pedidos.LevantarPedido (_idPedido);
    edClienteRazonSocial.Text:= DM_Clientes.RazonSocial;
    edVendedorRazonSocial.Text:= DM_Vendedores.RazonSocial;
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

end.

