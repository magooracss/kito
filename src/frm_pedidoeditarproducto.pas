unit frm_pedidoeditarproducto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, RxDBSpinEdit, dbcurredit, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, Buttons, DbCtrls, StdCtrls;

type

  { TfrmPedidoEditarProducto }

  TfrmPedidoEditarProducto = class(TForm)
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    DBLookupComboBox1: TDBLookupComboBox;
    DBRadioGroup1: TDBRadioGroup;
    ds_pedidosDetalles: TDataSource;
    DBEdit1: TDBEdit;
    DBText1: TDBText;
    DBText2: TDBText;
    ds_ListaPrecios: TDataSource;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    RxDBCurrEdit1: TRxDBCurrEdit;
    RxDBCurrEdit2: TRxDBCurrEdit;
    RxDBCurrEdit3: TRxDBCurrEdit;
    RxDBSpinEdit1: TRxDBSpinEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public

  end;

var
  frmPedidoEditarProducto: TfrmPedidoEditarProducto;

implementation
{$R *.lfm}
uses
  dmpedidos
  ,dmproductos
  ;

{ TfrmPedidoEditarProducto }

procedure TfrmPedidoEditarProducto.btnCancelarClick(Sender: TObject);
begin
  DM_Pedidos.PedidosDetalles.Cancel;
  ModalResult:= mrCancel;
end;

procedure TfrmPedidoEditarProducto.btnGrabarClick(Sender: TObject);
begin
  With DM_Pedidos, PedidosDetalles do
  begin
    Edit;
    PedidosDetalleslxListaPrecio.asSTring:=DM_Productos.NombreListaPrecios(PedidosDetalleslistaPrecio_id.AsInteger);
    Post;
  end;
  ModalResult:= mrOK;
end;

procedure TfrmPedidoEditarProducto.DBEdit1Exit(Sender: TObject);
begin
  DM_Pedidos.AjustarPreciosProducto;
end;

procedure TfrmPedidoEditarProducto.FormShow(Sender: TObject);
begin
  DM_Pedidos.PedidosDetalles.Edit;
end;

end.

