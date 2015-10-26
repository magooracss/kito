unit frm_busquedacompras;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, Buttons, DBGrids, dmgeneral
  ;

type

  { TfrmBusquedaCompras }

  TfrmBusquedaCompras = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ds_Resultados: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    RxDBGrid1: TRxDBGrid;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idComprobante: GUID_ID;
    _proveedorID: GUID_ID;
    function getIdComprobante: GUID_ID;
  public
    property comprobanteID: GUID_ID read getIdComprobante write _idComprobante;
    property proveedorID: GUID_ID read _proveedorID write _proveedorID;

  end;

var
  frmBusquedaCompras: TfrmBusquedaCompras;

implementation
{$R *.lfm}
uses
  dmcompras
  ;

{ TfrmBusquedaCompras }

procedure TfrmBusquedaCompras.BitBtn2Click(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmBusquedaCompras.FormShow(Sender: TObject);
begin
  DM_Compras.ComprasProveedorEstado(_proveedorID, EST_NO_PAGADO);
end;

function TfrmBusquedaCompras.getIdComprobante: GUID_ID;
begin
  Result:= DM_Compras.IdBusquedaCompras;
end;

procedure TfrmBusquedaCompras.BitBtn1Click(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

end.

