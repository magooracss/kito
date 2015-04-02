unit frm_productoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls
  ,dmgeneral
  ;

type

  { TfrmProductoAE }

  TfrmProductoAE = class(TForm)
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
  private
    _id: GUID_ID;
  public
    property idProducto: GUID_ID read _id write _id;
  end;

var
  frmProductoAE: TfrmProductoAE;

implementation
{$R *.lfm}

{ TfrmProductoAE }


procedure TfrmProductoAE.FormCreate(Sender: TObject);
begin
  _id:= GUIDNULO;
end;

end.

