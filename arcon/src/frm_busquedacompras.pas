unit frm_busquedacompras;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons
  , dmgeneral
  ;

type

  { TfrmBusquedaCompras }

  TfrmBusquedaCompras = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    _idComprobante: GUID_ID;
    function getIdComprobante: GUID_ID;
    { private declarations }
  public
    property comprobanteID: GUID_ID read getIdComprobante write _idComprobante;
  end;

var
  frmBusquedaCompras: TfrmBusquedaCompras;

implementation

{$R *.lfm}

{ TfrmBusquedaCompras }

procedure TfrmBusquedaCompras.BitBtn2Click(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

function TfrmBusquedaCompras.getIdComprobante: GUID_ID;
begin
  raise Exception.Create('Devolver el id del comprobante en la pantalla de búsqueda');
end;

procedure TfrmBusquedaCompras.BitBtn1Click(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

end.

