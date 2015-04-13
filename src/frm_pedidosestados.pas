unit frm_pedidosEstados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, Buttons,
  ExtCtrls, DBGrids, StdCtrls, DbCtrls
  ,dmpedidos
  ,dmgeneral
  ;

type

  { TfrmPedidosEstados }

  TfrmPedidosEstados = class(TForm)
    btnBorrarEstado: TBitBtn;
    btnEditarEstado: TBitBtn;
    btnNuevoEstado: TBitBtn;
    btnSalir: TBitBtn;
    DBMemo1: TDBMemo;
    DBText2: TDBText;
    DBText3: TDBText;
    ds_estadoActual: TDataSource;
    DBGrid1: TDBGrid;
    ds_estadosPedidoHistorial: TDataSource;
    GbEstadoActual: TGroupBox;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure btnBorrarEstadoClick(Sender: TObject);
    procedure btnEditarEstadoClick(Sender: TObject);
    procedure btnNuevoEstadoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LevantarHistorial;
  private
    procedure pantallaEdicion (idEstado: string);
  public
  end;

var
  frmPedidosEstados: TfrmPedidosEstados;

implementation
{$R *.lfm}
uses
  frm_pedidoestadosae
  ;

{ TfrmPedidosEstados }

procedure TfrmPedidosEstados.LevantarHistorial;
begin
  DM_Pedidos.LevantarPedidoHistorialEstados;
end;


procedure TfrmPedidosEstados.pantallaEdicion(idEstado: string);
var
  pant: TfrmPedEstadosAE;
begin
  pant:= TfrmPedEstadosAE.Create(self);
  try
    pant.estadoID:= idEstado;
    pant.ShowModal;
    DM_Pedidos.GrabarEstados;
    LevantarHistorial;
  finally
    pant.Free;
  end;
end;

procedure TfrmPedidosEstados.btnNuevoEstadoClick(Sender: TObject);
begin
  pantallaEdicion(GUIDNULO);
end;

procedure TfrmPedidosEstados.btnSalirClick(Sender: TObject);
begin
  if DM_Pedidos.PedidosEstados.State in dsWriteModes then
   DM_Pedidos.PedidosEstados.Post;
  ModalResult:= mrOK;
end;

procedure TfrmPedidosEstados.btnEditarEstadoClick(Sender: TObject);
begin
  pantallaEdicion(DM_Pedidos.qPedidosEstadosHistorialID.AsString);
end;

procedure TfrmPedidosEstados.btnBorrarEstadoClick(Sender: TObject);
begin
  if DM_Pedidos.qPedidosEstadosHistorial.RecordCount > 1 then
  begin
    if (MessageDlg ('ATENCION'
                    , 'Borro el estado seleccionado?'
                    , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
    begin
      DM_Pedidos.BorrarEstado (DM_Pedidos.qPedidosEstadosHistorialID.AsString);
      DM_Pedidos.LevantarPedidoHistorialEstados;
    end;
  end
  else
   ShowMessage('No se pueden borrar todos los estados de un pedido');
end;


procedure TfrmPedidosEstados.FormShow(Sender: TObject);
begin
  LevantarHistorial;
end;


end.

