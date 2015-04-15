unit frm_EditarProductoMovimientoStock;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbcurredit, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Buttons, DbCtrls, StdCtrls, dmstock
  ;

type

  { TfrmEditarProductoMovimientoStock }

  TfrmEditarProductoMovimientoStock = class(TForm)
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    DBEdit1: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    DBText1: TDBText;
    DBText2: TDBText;
    ds_stock: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    edPrecioUnitario: TRxDBCurrEdit;
    edPrecioTotal: TRxDBCurrEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: char);
    procedure edPrecioUnitarioKeyPress(Sender: TObject; var Key: char);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmEditarProductoMovimientoStock: TfrmEditarProductoMovimientoStock;

implementation

{$R *.lfm}

{ TfrmEditarProductoMovimientoStock }

procedure TfrmEditarProductoMovimientoStock.btnCancelarClick(Sender: TObject);
begin
  DM_Stock.MovimientosStockDetalles.Cancel;
  ModalResult:= mrCancel;
end;

procedure TfrmEditarProductoMovimientoStock.btnGrabarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmEditarProductoMovimientoStock.DBEdit1KeyPress(Sender: TObject;
  var Key: char);
begin
  if Key = #13 then
    edPrecioUnitario.SetFocus;
end;

procedure TfrmEditarProductoMovimientoStock.edPrecioUnitarioKeyPress(
  Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    With DM_Stock  do
    begin
      MovimientosStockDetalles.Edit;
      MovimientosStockDetallesprecioTotal.asFloat:= MovimientosStockDetallesprecioUnitario.AsFloat
                                                  * MovimientosStockDetallescantidad.AsFloat;
      MovimientosStockDetalles.Post;
    end;
    edPrecioTotal.SetFocus;
  end;

end;

end.

