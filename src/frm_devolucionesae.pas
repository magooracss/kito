unit frm_devolucionesae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbdateedit, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Buttons, StdCtrls, DbCtrls, DBGrids
  , dmdevoluciones, dmgeneral
  ;

type

  { TfrmDevolucionesae }

  TfrmDevolucionesae = class(TForm)
    btnBuscarPedido: TBitBtn;
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    DBText5: TDBText;
    dsDevolucionDetalles: TDataSource;
    dsPedidos: TDataSource;
    DBMemo1: TDBMemo;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    dsDevolucion: TDataSource;
    GrillaPrecios: TDBGrid;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edRazonSocial: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    RxDBDateEdit1: TRxDBDateEdit;
    procedure btnBuscarPedidoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    _idPedido: GUID_ID;
  public
    { public declarations }
  end;

var
  frmDevolucionesae: TfrmDevolucionesae;

implementation
{$R *.lfm}
uses
  dmpedidos
  ,dmclientes
  ,frm_pedidosbusqueda
  ;

{ TfrmDevolucionesae }

procedure TfrmDevolucionesae.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_Devoluciones, DM_Devoluciones);
  _idPedido:= GUIDNULO;
end;

procedure TfrmDevolucionesae.FormDestroy(Sender: TObject);
begin
  DM_Devoluciones.Free;
end;

procedure TfrmDevolucionesae.btnBuscarPedidoClick(Sender: TObject);
var
  pant: TfrmPedidosBusqueda;
  flagCargar: boolean;
begin
  pant:= TfrmPedidosBusqueda.Create(self);
  flagCargar:= True;
  try
    if pant.ShowModal = mrOK then
    begin
      if DM_Devoluciones.PedidoConDevolucionCargada(pant.idPedidoSeleccionado) then
      begin
         if (MessageDlg ('ATENCION'
                      , 'El Pedido seleccionado ya tiene una devolución cargada. Desea continuar?'
                      , mtConfirmation, [mbYes, mbNo],0 ) = mrNo) then
            flagCargar:= false;
      end;
      if flagCargar then
      begin
        _idPedido:= pant.idPedidoSeleccionado;
        DM_Pedidos.LevantarPedido(_idPedido);
        DM_Clientes.Editar(DM_Pedidos.Pedidoscliente_id.AsString);
        edRazonSocial.Caption:= DM_Clientes.RazonSocial;
        DM_Devoluciones.cargarPedidoDevolucion (_idPedido);
      end;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmDevolucionesae.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmDevolucionesae.btnGrabarClick(Sender: TObject);
begin
  if ( (DM_Devoluciones.Devoluciones.Active)
      and (DM_Devoluciones.Devolucionespedido_id.AsString <> GUIDNULO)) then
  begin
    if (DM_Devoluciones.ValidarCantidades) then
    begin
     DM_Devoluciones.AjustarStock;
     DM_Devoluciones.Grabar;
     ModalResult:= mrOK;
    end
    else
     ShowMessage('Las cantidades devueltas exceden las cantidades contenidas en el pedido');
  end;
end;

end.

