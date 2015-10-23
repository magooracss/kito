unit frm_ordendepagoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, curredit, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons, DBExtCtrls, DbCtrls,
  dmgeneral
  ;

type

  { TfrmOrdenDePagoAE }

  TfrmOrdenDePagoAE = class(TForm)
    BitBtn1: TBitBtn;
    btnCancelar: TBitBtn;
    btnBorrar: TBitBtn;
    btnBorrar1: TBitBtn;
    btnBuscarProveedor: TBitBtn;
    btnEditar: TBitBtn;
    btnEditar1: TBitBtn;
    btnNuevo: TBitBtn;
    btnNuevo1: TBitBtn;
    btnProveedorNuevo: TBitBtn;
    edTotalComprobantes: TCurrencyEdit;
    edTotalPagado: TCurrencyEdit;
    ds_OP: TDataSource;
    ds_OPComprobantes: TDataSource;
    ds_FormasPago: TDataSource;
    edTotalAdeudado: TCurrencyEdit;
    DBDateEdit1: TDBDateEdit;
    DBText1: TDBText;
    edProveedor: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    RxDBGrid1: TRxDBGrid;
    RxDBGrid2: TRxDBGrid;
    procedure btnBuscarProveedorClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure btnProveedorNuevoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _ordenPagoID: GUID_ID;
    function getOrdenPagoID: GUID_ID;

    procedure PantallaComprobantes (refComprobante: GUID_ID);
    procedure CalcularParciales; //Es un refresco de pantalla con las sumas parciales
  public
    property ordenPagoID: GUID_ID read getOrdenPagoID write _ordenPagoID;
  end;

var
  frmOrdenDePagoAE: TfrmOrdenDePagoAE;

implementation
{$R *.lfm}
uses
  dmordendepago
  ,frm_busquedaempresas
  ,frm_proveedoresae
  ,frm_busquedacompras
  ;

{ TfrmOrdenDePagoAE }

procedure TfrmOrdenDePagoAE.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_OrdenDePago, DM_OrdenDePago);
  _ordenPagoID:= GUIDNULO;
end;

procedure TfrmOrdenDePagoAE.FormDestroy(Sender: TObject);
begin
  DM_OrdenDePago.Free;
end;

procedure TfrmOrdenDePagoAE.FormShow(Sender: TObject);
begin
  if (_ordenPagoID = GUIDNULO ) then
  begin
    DM_OrdenDePago.Nueva;
  end
  else
  begin
    raise Exception.Create ('Falta levantar la orden de pago para editarla');
  end;

end;

function TfrmOrdenDePagoAE.getOrdenPagoID: GUID_ID;
begin
  _ordenPagoID:= DM_OrdenDePago.ordenPagoID;
  Result:= _ordenPagoID;
end;

procedure TfrmOrdenDePagoAE.PantallaComprobantes(refComprobante: GUID_ID);
begin

end;

procedure TfrmOrdenDePagoAE.CalcularParciales;
begin
  edTotalPagado.Value:= -1.23;
  edTotalComprobantes.Value:= DM_OrdenDePago.sumaSaldoComprobantes;
  edTotalAdeudado.Value:= -1.23;
end;

procedure TfrmOrdenDePagoAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmOrdenDePagoAE.btnProveedorNuevoClick(Sender: TObject);
var
  pant: TfrmProveedoresAE;
begin
  pant:= TfrmProveedoresAE.Create(self);
  try
    pant.idProveedor:= GUIDNULO;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmOrdenDePagoAE.btnBuscarProveedorClick(Sender: TObject);
var
  pant: TfrmBusquedaEmpresas;
begin
  pant:= TfrmBusquedaEmpresas.Create(self);
  try
    pant.restringirTipo:= IDX_PROVEEDOR;
    if pant.ShowModal = mrOK then
    begin
      edProveedor.Text:= pant.RazonSocial;
      DM_OrdenDePago.refProveedor:= pant.idProveedor;
    end;
  finally
    pant.Free;
  end;
end;

(*******************************************************************************
*** COMPROBANTES DE COMPRA
*******************************************************************************)
procedure TfrmOrdenDePagoAE.btnNuevoClick(Sender: TObject);
var
  pant: TfrmBusquedaCompras;
begin
  pant:= TfrmBusquedaCompras.Create(self);
  try
    if pant.ShowModal = mrOK then
    begin
      DM_OrdenDePago.AgregarComprobante (pant.comprobanteID);
      CalcularParciales;
    end;
  finally
    pant.Free;
  end;
end;



end.

