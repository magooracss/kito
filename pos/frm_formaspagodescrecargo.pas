unit frm_formaspagodescrecargo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, curredit, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, Buttons, dmventas,dmgeneral;

type

  { TfrmFormaPagoDescRecargo }

  TfrmFormaPagoDescRecargo = class(TForm)
    btnCancel: TBitBtn;
    btnOK: TBitBtn;
    cbMovimiento: TComboBox;
    edMonto: TCurrencyEdit;
    Label3: TLabel;
    Movimiento: TLabel;
    Panel1: TPanel;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    dmVentas: TDM_Ventas;
    _tipoMovimiento: integer;
    _valor: double;
  public
    property dm:TDM_Ventas write dmVentas;
    property valor: double read _valor;
    property tipoMovimiento: integer read _tipoMovimiento;
  end;

var
  frmFormaPagoDescRecargo: TfrmFormaPagoDescRecargo;

implementation
{$R *.lfm}
const
 idx_Descuento = 0;
 idx_recargo = 1;

{ TfrmFormaPagoDescRecargo }

procedure TfrmFormaPagoDescRecargo.btnCancelClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmFormaPagoDescRecargo.btnOKClick(Sender: TObject);
var
  formaPagoID: integer;
  formaPagolb: string;
begin
  case cbMovimiento.ItemIndex of
   idx_Descuento:
     begin
       formaPagoID:= FP_DESCUENTO;
       formaPagolb:= FP_DESC_STR;
     end;
   idx_recargo:
     begin
       formaPagoID:= FP_RECARGO;
       formaPagolb:= FP_REC_STR;
     end;
  end;
  dmVentas.AgregarFormaPago(formaPagoID, edMonto.Value, formaPagolb);
  _valor:= edMonto.Value;
  _tipoMovimiento:= formaPagoID;
  ModalResult:= mrOK;
end;

procedure TfrmFormaPagoDescRecargo.FormShow(Sender: TObject);
begin
  _valor:= 0;
  _tipoMovimiento:= 0;
  cbMovimiento.ItemIndex:= idx_Descuento;
  edMonto.Value:= 0;
end;

end.

