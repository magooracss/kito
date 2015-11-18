unit frm_ordendepagoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, curredit, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, StdCtrls, Buttons, DBExtCtrls, DbCtrls, DBGrids,
  dmgeneral
  ;

type

  { TfrmOrdenDePagoAE }

  TfrmOrdenDePagoAE = class(TForm)
    btnGrabar: TBitBtn;
    btnCancelar: TBitBtn;
    btnBorrar: TBitBtn;
    btnBorrarFP: TBitBtn;
    btnBuscarProveedor: TBitBtn;
    btnEditar: TBitBtn;
    btnEditarFP: TBitBtn;
    btnNuevo: TBitBtn;
    btnNuevoFP: TBitBtn;
    btnProveedorNuevo: TBitBtn;
    edTotalComprobantes: TCurrencyEdit;
    edTotalPagado: TCurrencyEdit;
    ds_OP: TDataSource;
    ds_OPComprobantes: TDataSource;
    ds_FormasPago: TDataSource;
    edTotalAdeudado: TCurrencyEdit;
    DBDateEdit1: TDBDateEdit;
    dbNro: TDBText;
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
    procedure btnGrabarClick(Sender: TObject);
    procedure btnBorrarFPClick(Sender: TObject);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnBuscarProveedorClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarFPClick(Sender: TObject);
    procedure btnNuevoFPClick(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure btnProveedorNuevoClick(Sender: TObject);
    procedure ds_OPDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _ordenPagoID: GUID_ID;
    function getOrdenPagoID: GUID_ID;

    procedure PantallaComprobantes (refComprobante: GUID_ID);
    procedure CalcularParciales; //Es un refresco de pantalla con las sumas parciales

    procedure PantallaFormasPago (refFP: GUID_ID);

    function ValidarGrabacion: boolean;
    procedure GrabarOrdenDePago;
    procedure DistribuirPagos;

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
  ,frm_formaspagoae
  ,dmcompensaciones
  ,frm_distribuirdinerocomprobantes
  ,dmproveedores
  ;

{ TfrmOrdenDePagoAE }

procedure TfrmOrdenDePagoAE.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_OrdenDePago, DM_OrdenDePago);
  Application.CreateForm(TDM_Compensaciones, DM_Compensaciones);
  _ordenPagoID:= GUIDNULO;
end;

procedure TfrmOrdenDePagoAE.FormDestroy(Sender: TObject);
begin
  DM_Compensaciones.Free;
  DM_OrdenDePago.Free;
end;

procedure TfrmOrdenDePagoAE.FormShow(Sender: TObject);
var
  proveedor: TDM_Proveedores;
begin
  proveedor:= TDM_Proveedores.Create(self);
  try
    if (_ordenPagoID = GUIDNULO ) then
    begin
      DM_OrdenDePago.Nueva;
    end
    else
    begin
      DM_OrdenDePago.Editar(_ordenPagoID);
      CalcularParciales;
      proveedor.Editar(DM_OrdenDePago.OrdenDePagoproveedor_id.AsString);
      edProveedor.Caption:= proveedor.RazonSocial;
    end;
  finally
    proveedor.Free;
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
  edTotalPagado.Value:= DM_OrdenDePago.sumaFormasPago;
  edTotalComprobantes.Value:= DM_OrdenDePago.sumaSaldoComprobantes;
  edTotalAdeudado.Value:= DM_OrdenDePago.sumaComprasImpagas;
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

procedure TfrmOrdenDePagoAE.ds_OPDataChange(Sender: TObject; Field: TField);
begin
  dbNro.Visible := (DM_OrdenDePago.OrdenDePagonumero.AsInteger > 0 )
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
      CalcularParciales;
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
    pant.proveedorID:= DM_OrdenDePago.refProveedor;
    if pant.ShowModal = mrOK then
    begin
      DM_OrdenDePago.AgregarComprobante (pant.comprobanteID);
      CalcularParciales;
    end;
  finally
    pant.Free;
  end;
end;


procedure TfrmOrdenDePagoAE.btnBorrarClick(Sender: TObject);
begin
   if (MessageDlg ('Confirmación'
                  , 'Desea quitar el comprobante seleccionado?'
                   , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
   Begin
      DM_OrdenDePago.QuitarComprobante;
      CalcularParciales;
   end;

end;


(*******************************************************************************
*** FORMAS DE PAGO
*******************************************************************************)

procedure TfrmOrdenDePagoAE.PantallaFormasPago(refFP: GUID_ID);
var
  pant: TfrmFormasPagoAE;
begin
   pant:= TfrmFormasPagoAE.Create(self);
   try
     pant.formaPagoID:= refFP;
     if pant.ShowModal = mrOK then
     begin
       CalcularParciales;
     end;
   finally
     pant.Free;
   end;
end;


procedure TfrmOrdenDePagoAE.btnNuevoFPClick(Sender: TObject);
begin
  PantallaFormasPago(GUIDNULO);
end;

procedure TfrmOrdenDePagoAE.btnEditarFPClick(Sender: TObject);
begin
  PantallaFormasPago(ds_OPComprobantes.DataSet.FieldByName('id').asString);
end;


procedure TfrmOrdenDePagoAE.btnBorrarFPClick(Sender: TObject);
begin
   if (MessageDlg ('Confirmación'
                  , 'Desea quitar la forma de pago seleccionada?'
                   , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
   Begin
      DM_OrdenDePago.QuitarFP;
      CalcularParciales;
   end;
end;


(*******************************************************************************
*** PERSISTENCIA DE DATOS
*******************************************************************************)

function TfrmOrdenDePagoAE.ValidarGrabacion: boolean;
var
  montoAdeudado
, montoAPagar: double;
  flgGrabar: boolean;
begin
   montoAdeudado:= edTotalComprobantes.Value;
   montoAPagar:= edTotalPagado.Value;
   flgGrabar:= false;

   if DM_OrdenDePago.refProveedor = GUIDNULO then
     ShowMessage('No se puede grabar una orden de pago sin seleccionar el proveedor');

   if (DM_General.CmpIgualdadFloat(0,montoAPagar)) then
     ShowMessage('No se puede grabar una orden de pago por $ 0.00');

   if  (NOT DM_General.CmpIgualdadFloat(montoAdeudado,montoAPagar)) then
   begin
     flgGrabar:=  (MessageDlg ('Atención'
                    , 'El monto a pagar difiere del total a cobrar. Desea corregirlo?'
                     , mtConfirmation, [mbYes, mbNo],0 ) = mrNo);
   end
   else
     flgGrabar:= true;

   Result:= flgGrabar;
end;


procedure TfrmOrdenDePagoAE.DistribuirPagos;
var
  pantDistr: TfrmDistribuirDineroComprobantes;
begin
  if (ds_OPComprobantes.DataSet.RecordCount = 1) then
  begin
    DM_OrdenDePago.PagarComprobanteActual(edTotalPagado.Value);
  end
  else
  begin
    pantDistr:= TfrmDistribuirDineroComprobantes.Create(self);
    try
      pantDistr.totalComprobantes:= edTotalComprobantes.Value;
      pantDistr.totalDistribuir:= edTotalPagado.Value;
      pantDistr.ShowModal;
    finally
      pantDistr.Free;
    end;
  end;
end;


procedure TfrmOrdenDePagoAE.GrabarOrdenDePago;
var
  montoAdeudado
, montoAPagar: double;

begin
  montoAdeudado:= edTotalComprobantes.Value;
  montoAPagar:= edTotalPagado.Value;

  if (montoAdeudado > montoAPagar) then
  begin
    DistribuirPagos;
  end
  else
  begin
    //Se marca todo como pagado y se hacen las compensaciones si corresponde
    DM_OrdenDePago.PagarTodosLosComprobantes;

    if (NOT (DM_General.CmpIgualdadFloat(montoAdeudado,montoAPagar))) then
    begin
      DM_Compensaciones.Nueva (DM_OrdenDePago.OrdenDePagoid.AsString
                               ,(montoAPagar - montoAdeudado)
                              );
      DM_Compensaciones.Grabar
    end;
  end;

  DM_OrdenDePago.Grabar;
end;


procedure TfrmOrdenDePagoAE.btnGrabarClick(Sender: TObject);
begin
  if ValidarGrabacion then
  begin
    GrabarOrdenDePago;
    ModalResult:= mrOK;
  end;
end;

end.

