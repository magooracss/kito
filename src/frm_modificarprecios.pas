unit frm_modificarprecios;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons;

type

  { TfrmModificarPrecios }

  TfrmModificarPrecios = class(TForm)
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    Panel1: TPanel;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmModificarPrecios: TfrmModificarPrecios;

implementation

{$R *.lfm}

end.

