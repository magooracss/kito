unit frm_distribuirdinerocomprobantes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, curredit, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons
  ,dmgeneral;

type

  { TfrmDistribuirDineroComprobantes }

  TfrmDistribuirDineroComprobantes = class(TForm)
    btnAceptar: TBitBtn;
    ds_OPComprobantes: TDataSource;
    edTotalComprobantes: TCurrencyEdit;
    edTotalPagado: TCurrencyEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    RxDBGrid1: TRxDBGrid;
    procedure btnAceptarClick(Sender: TObject);
    procedure ds_OPComprobantesDataChange(Sender: TObject; Field: TField);
    procedure ds_OPComprobantesUpdateData(Sender: TObject);
    procedure OrdenDePagototal(Sender: TObject);
  private
    _totalComprobantes: double;
    _totalDistribuir: double;
    _montoRestante: double;
    procedure setTotalComprobantes(AValue: double);
    procedure setTotalDistribuir(AValue: double);

    procedure CalcularRemanente;
    procedure GrabarDistribucion;
    function ValidarTotales: boolean;
  public
    property totalComprobantes: double read _totalComprobantes write setTotalComprobantes;
    property totalDistribuir:  double read _totalDistribuir write setTotalDistribuir;


  end;

var
  frmDistribuirDineroComprobantes: TfrmDistribuirDineroComprobantes;

implementation
{$R *.lfm}
uses
  dmordendepago;

{ TfrmDistribuirDineroComprobantes }

procedure TfrmDistribuirDineroComprobantes.btnAceptarClick(Sender: TObject);
begin

  if (_montoRestante < 0) then
  begin
    ShowMessage ('No se puede distribuir más de lo fijado en el pago!');
  end
  else
  begin
    if validarTotales then
    begin
      if (DM_General.CmpIgualdadFloat(0, _montoRestante)) then
      begin
        GrabarDistribucion;
        ModalResult:= mrOK;
      end
      else
        ShowMessage ('Debe distribuir todo el dinero en los comprobantes cargados para poder continuar');
    end
    else
      ShowMessage ('El monto distribuido no debe superar el saldo del comprobante');
  end;

end;

procedure TfrmDistribuirDineroComprobantes.ds_OPComprobantesDataChange(
  Sender: TObject; Field: TField);
begin

end;

procedure TfrmDistribuirDineroComprobantes.ds_OPComprobantesUpdateData(
  Sender: TObject);
begin
  CalcularRemanente;
end;

procedure TfrmDistribuirDineroComprobantes.OrdenDePagototal(Sender: TObject);
begin

end;

procedure TfrmDistribuirDineroComprobantes.setTotalComprobantes(AValue: double);
begin
  if _totalComprobantes=AValue then Exit;
  _totalComprobantes:=AValue;
  edTotalComprobantes.Value:= AValue;
end;

procedure TfrmDistribuirDineroComprobantes.setTotalDistribuir(AValue: double);
begin
  if _totalDistribuir=AValue then Exit;
  _totalDistribuir:=AValue;
  edTotalPagado.Value:= AValue;
end;

procedure TfrmDistribuirDineroComprobantes.CalcularRemanente;
var
  marca: TBookmark;
  acc: double;
begin
  acc:= 0;
  With ds_OPComprobantes.DataSet do
  begin
    DisableControls;
    marca:= GetBookmark;
    try
      First;
      While Not Eof do
      Begin
        acc:= acc + FieldByName('montoPagado').asFloat;
        Next;
      end;
      GotoBookmark(marca);
    finally
      FreeBookmark(marca);
    end;
    EnableControls;
  end;

  _montoRestante:= _totalDistribuir  - acc;
  edTotalPagado.Value:= _montoRestante;

end;

procedure TfrmDistribuirDineroComprobantes.GrabarDistribucion;
begin
  DM_OrdenDePago.MarcarComprobantesDistribuidos;
  DM_OrdenDePago.Grabar;
end;

function TfrmDistribuirDineroComprobantes.ValidarTotales: boolean;
begin
  Result:= True;
  with DM_OrdenDePago, OPComprobantes do
  begin
    DisableControls;
    First;
    while Not EOF do
    begin
      if (OPComprobantesComprobanteSaldo.AsFloat < OPComprobantesmontoPagado.AsFloat) then
      begin
        Result:= false;
      end;
      Next;
    end;
    EnableControls;
  end;
end;



end.

