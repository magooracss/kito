unit frm_hojaderutapresentarpedidos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs
  , dmgeneral
  ;

type

  { TfrmHdRPresentacionPedidos }

  TfrmHdRPresentacionPedidos = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    _idHojaDeRuta: GUID_ID;
    { private declarations }
  public
    property idHojaDeRuta: GUID_ID write _idHojaDeRuta;
  end;

var
  frmHdRPresentacionPedidos: TfrmHdRPresentacionPedidos;

implementation

{$R *.lfm}

{ TfrmHdRPresentacionPedidos }

procedure TfrmHdRPresentacionPedidos.FormCreate(Sender: TObject);
begin
  _idHojaDeRuta:= GUIDNULO;
end;

end.

