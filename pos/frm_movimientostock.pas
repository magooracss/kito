unit frm_movimientoStock;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, rxdbcomb, rxlookup, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons, dmproductosstock,
  dmproductos
;

type

  { TfrmMovimientoStock }

  TfrmMovimientoStock = class(TForm)
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    ds_Marcas: TDataSource;
    ds_movStock: TDataSource;
    GrillaColores: TRxDBGrid;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    rgTipoMovimiento: TRadioGroup;
    RxDBLookupCombo1: TRxDBLookupCombo;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RxDBLookupCombo1Change(Sender: TObject);
  private
    dmStock: TDM_PosProductosStock;
    dmProd: TDM_Productos;
    procedure Initialise;
  public
    { public declarations }
  end;

var
  frmMovimientoStock: TfrmMovimientoStock;

implementation

{$R *.lfm}

{ TfrmMovimientoStock }

procedure TfrmMovimientoStock.FormCreate(Sender: TObject);
begin
  dmStock:= TDM_PosProductosStock.Create(self);
  dmProd:= TDM_Productos.Create(self);

  ds_movStock.DataSet:= dmStock.MovimientoStock;
  ds_Marcas.DataSet:= dmProd.qMarcas;

  dmProd.LevantarMarcas;
end;

procedure TfrmMovimientoStock.btnCancelClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmMovimientoStock.btnSaveClick(Sender: TObject);
begin
  dmStock.asentarMovimientos (rgTipoMovimiento.ItemIndex + 1);
  ModalResult:= mrOK;
end;

procedure TfrmMovimientoStock.FormDestroy(Sender: TObject);
begin
  dmStock.Free;
end;

procedure TfrmMovimientoStock.FormShow(Sender: TObject);
begin
  initialise;
end;

procedure TfrmMovimientoStock.RxDBLookupCombo1Change(Sender: TObject);
begin
   dmStock.LevantarMovStockMarca(ds_Marcas.DataSet.FieldByName('id').AsInteger);
end;

procedure TfrmMovimientoStock.Initialise;
begin
  dmStock.LevantarMovStockMarca(0);
end;

end.

