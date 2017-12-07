unit frm_prodventaseleccion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons;

type

  { TfrmProdVentaSel }

  TfrmProdVentaSel = class(TForm)
    btnCancelar: TBitBtn;
    btnSeleccionar: TBitBtn;
    Panel2: TPanel;
    procedure btnCancelarClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmProdVentaSel: TfrmProdVentaSel;

implementation

{$R *.lfm}

{ TfrmProdVentaSel }

procedure TfrmProdVentaSel.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

end.

