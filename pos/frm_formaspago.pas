unit frm_formasPago;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxlookup, dbcurredit, rxdbgrid, curredit,
  Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons, StdCtrls, dmventas
  ,dmgeneral;

type

  { TfrmFormasPago }

  TfrmFormasPago = class(TForm)
    btnDescuentoRecargo: TBitBtn;
    btnAceptar: TBitBtn;
    edMonto: TCurrencyEdit;
    ds_ventas: TDataSource;
    ds_VentaFormasPago: TDataSource;
    ds_FormasPago: TDataSource;
    GrillaPagos: TRxDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    RxDBCurrEdit2: TRxDBCurrEdit;
    cbFormaPago: TRxDBLookupCombo;
    btnQuitar: TSpeedButton;
    btnAgregar: TSpeedButton;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnDescuentoRecargoClick(Sender: TObject);
    procedure btnQuitarClick(Sender: TObject);
    procedure edMontoKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure btnAgregarClick(Sender: TObject);
  private
    dmVentas: TDM_Ventas;
    procedure AgregarItem;
    procedure QuitarItem;
    procedure AjustarResto;

    procedure ChequeoPagoUnico;
    function ValidarPago: boolean;
  public
    property dm:TDM_Ventas write dmVentas;
  end;

var
  frmFormasPago: TfrmFormasPago;

implementation
{$R *.lfm}
uses
  frm_formaspagodescrecargo
;

{ TfrmFormasPago }

procedure TfrmFormasPago.btnAceptarClick(Sender: TObject);
begin
  ChequeoPagoUnico;
  if ValidarPago then
    ModalResult:= mrOK
  else
   ShowMessage('Hay problemas entre lo cargado a pagar y el total de la venta');
end;

procedure TfrmFormasPago.btnDescuentoRecargoClick(Sender: TObject);
var
  scr: TfrmFormaPagoDescRecargo;
begin
  scr:= TfrmFormaPagoDescRecargo.Create(self);
  try
    scr.dm:= dmVentas;
    if scr.ShowModal = mrOK then
    begin
   //   dmVentas.AjustarTotalVenta (scr.valor, scr.TipoMovimiento);
      AjustarResto;
    end;
    cbFormaPago.SetFocus;
  finally
    scr.Free;
  end;
end;

procedure TfrmFormasPago.btnQuitarClick(Sender: TObject);
begin
  QuitarItem;
end;

procedure TfrmFormasPago.edMontoKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
   AgregarItem;
end;

procedure TfrmFormasPago.FormShow(Sender: TObject);
begin
  ds_VentaFormasPago.DataSet:= dmVentas.PosVentaFormaPago;
  ds_FormasPago.DataSet:= dmVentas.qFormasPago;
  ds_ventas.DataSet:= dmVentas.PosVentas;

  cbFormaPago.KeyValue:= 1;
  AjustarResto;
end;

procedure TfrmFormasPago.btnAgregarClick(Sender: TObject);
begin
  AgregarItem;
end;

procedure TfrmFormasPago.AgregarItem;
begin
  if edMonto.Value <> 0 then
  begin;
    with dmVentas.PosVentaFormaPago do
    begin
        dmVentas.AgregarFormaPago(dmVentas.qFormasPagoID.AsInteger
                                 ,edMonto.Value
                                 ,dmVentas.qFormasPagoFORMAPAGO.AsString);
        AjustarResto;
        cbFormaPago.SetFocus;
    end;
  end;
end;

procedure TfrmFormasPago.QuitarItem;
begin
   if (MessageDlg ('ATENCION'
                 , 'Quito la forma de pago seleccionada?'
                 , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
   begin
     dmVentas.QuitarFormaPago;
     AjustarResto;
   end;
end;

procedure TfrmFormasPago.AjustarResto;
var
  resto, acumulado: double;
begin
  resto:= 0;
  acumulado:= dmVentas.TotalFormasPago;
  if Acumulado > 0 then
   resto:= dmVentas.PosVentastotal.AsFloat - Acumulado
  else
  resto:= dmVentas.PosVentastotal.AsFloat + Acumulado;

  edMonto.Value:= resto;
end;

procedure TfrmFormasPago.ChequeoPagoUnico;
begin
  if dmVentas.PosVentaFormaPago.RecordCount < 1 then
  begin
    AgregarItem;
  end;
end;

function TfrmFormasPago.ValidarPago: boolean;
var
  resultado: boolean;
begin
  resultado:= DM_General.CmpIgualdadFloat (dmVentas.TotalFormasPago, dmVentas.PosVentastotal.AsFloat);
  if not resultado then
  begin
       resultado:= (MessageDlg ('ATENCION'
                , 'Va a pagar un monto mayor al total de la venta. Es correcto?'
                , mtConfirmation, [mbYes, mbNo],0 ) = mrYes);

  end;
  Result:= resultado;
end;


end.

