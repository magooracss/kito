unit frm_hojaderutapresentarpedido;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbcurredit, Forms, Controls, Graphics,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DbCtrls;

type

  { TfrmHdRPresentacionPedido }

  TfrmHdRPresentacionPedido = class(TForm)
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    DBEdit1: TDBEdit;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DS_Pedido: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    RxDBCurrEdit1: TRxDBCurrEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmHdRPresentacionPedido: TfrmHdRPresentacionPedido;

implementation
{$R *.lfm}
uses
  dmhojaderutapresentacion
  ;

{ TfrmHdRPresentacionPedido }

procedure TfrmHdRPresentacionPedido.btnGrabarClick(Sender: TObject);
begin
  DS_Pedido.DataSet.Post;
  ModalResult:= mrOK;
end;

procedure TfrmHdRPresentacionPedido.btnCancelarClick(Sender: TObject);
begin
  DS_Pedido.DataSet.Cancel;
  ModalResult:= mrCancel;
end;

end.

