unit frm_hojaderutapresentarpedido;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons, ExtCtrls;

type

  { TfrmHdRPresentacionPedido }

  TfrmHdRPresentacionPedido = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmHdRPresentacionPedido: TfrmHdRPresentacionPedido;

implementation

{$R *.lfm}

end.

