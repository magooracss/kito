unit frm_pedidoestadosae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbdateedit, RxDBTimeEdit, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, Buttons, DbCtrls, StdCtrls, EditBtn, DBGrids
  ,dmgeneral
  , dmpedidos , rxmemds
  ;

type

  { TfrmPedEstadosAE }

  TfrmPedEstadosAE = class(TForm)
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    cbEstado: TComboBox;
    dEstado: TDateEdit;
    ds_estados: TDataSource;
    ds_pedidosEstados: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edNotaEstado: TMemo;
    Panel1: TPanel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _estadoID: GUID_ID;
  public
    property estadoID: GUID_ID write _estadoID;
  end;

var
  frmPedEstadosAE: TfrmPedEstadosAE;

implementation
{$R *.lfm}

{ TfrmPedEstadosAE }

procedure TfrmPedEstadosAE.btnCancelarClick(Sender: TObject);
begin
  DM_Pedidos.PedidosEstados.Cancel;
  ModalResult:= mrCancel;
end;

procedure TfrmPedEstadosAE.btnGrabarClick(Sender: TObject);
begin
  if _estadoID = GUIDNULO then
    DM_Pedidos.CambiarEstado(DM_General.obtenerIDIntComboBox(cbEstado),dEstado.Date ,edNotaEstado.Lines.Text)
  else
  begin
    with DM_Pedidos do
    begin
      PedidosEstados.Edit;
      PedidosEstadostipoEstado_id.AsInteger:= DM_General.obtenerIDIntComboBox(cbEstado);
      PedidosEstadosfecha.AsDateTime:= dEstado.Date;
      PedidosEstadosNotas.AsString:= edNotaEstado.Lines.Text;
      PedidosEstados.Post;
    end;
  end;
 ModalResult:= mrOK;
end;

procedure TfrmPedEstadosAE.FormShow(Sender: TObject);
begin
  dEstado.Date:= Now;
  DM_General.CargarComboBox(cbEstado,'TipoEstado', 'id', DM_Pedidos.qEstados);
  if _estadoID <> GUIDNULO then
  with DM_Pedidos do
  begin
    DM_General.ReiniciarTabla(PedidosEstados);
    if SELPedidosEstados.Active then SELPEdidosEstados.Close;
    SELPedidosEstados.ParamByName('id').asString:= _estadoID;
    SELPedidosEstados.Open;
    PedidosEstados.LoadFromDataSet(SELPedidosEstados, 0, lmAppend);
    SELPedidosEstados.Close;

    dEstado.Date:= PedidosEstadosfecha.AsDateTime;
    cbEstado.ItemIndex:= DM_General.obtenerIdxCombo(cbEstado, PedidosEstadostipoEstado_id.AsInteger);
    edNotaEstado.Lines.Text:= PedidosEstadosNotas.AsString;
   end;
end;

end.

