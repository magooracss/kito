unit frm_comprasae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, rxdbcomb, rxlookup, curredit,
  Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons, DbCtrls, DBExtCtrls,
  StdCtrls, dmgeneral
  ;

type

  { TfrmComprasAE }

  TfrmComprasAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    btnProveedorNuevo: TBitBtn;
    btnNuevo: TBitBtn;
    btnEditar: TBitBtn;
    btnBorrar: TBitBtn;
    btnBuscarProveedor: TBitBtn;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    dbNro: TDBText;
    ds_Comprobante: TDataSource;
    ds_items: TDataSource;
    ds_FormasDePago: TDataSource;
    ds_PlazosPago: TDataSource;
    ds_TiposComprobantes: TDataSource;
    edProveedor: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    lbMontoNeto: TLabel;
    lbMontoIVA: TLabel;
    lbSumaMontos: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    RxDBGrid1: TRxDBGrid;
    RxDBLookupCombo1: TRxDBLookupCombo;
    RxDBLookupCombo2: TRxDBLookupCombo;
    RxDBLookupCombo3: TRxDBLookupCombo;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnBorrarClick(Sender: TObject);
    procedure btnBuscarProveedorClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure btnProveedorNuevoClick(Sender: TObject);
    procedure DBEdit3Exit(Sender: TObject);
    procedure ds_ComprobanteDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
  private
    idCompra: GUID_ID;
    procedure Inicializar;
    procedure AjustarMontos;
    procedure PantallaItems;
  public
    property compraID: GUID_ID read idCompra write idCompra;
  end;

var
  frmComprasAE: TfrmComprasAE;

implementation
{$R *.lfm}
uses
   dmcompras
  ,frm_busquedaempresas
  ,frm_compraitemsae
  ,frm_proveedoresae
  , dmproveedores
  ;

{ TfrmComprasAE }

procedure TfrmComprasAE.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_Compras, DM_Compras);
  inicializar;
end;

procedure TfrmComprasAE.btnBuscarProveedorClick(Sender: TObject);
var
  pant: TfrmBusquedaEmpresas;
begin
  pant:= TfrmBusquedaEmpresas.Create(self);
  try
    pant.restringirTipo:= IDX_PROVEEDOR;
    if pant.ShowModal = mrOK then
    begin
      DM_Compras.refProveedor:= pant.idProveedor;
      edProveedor.Text:= pant.RazonSocial;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmComprasAE.btnProveedorNuevoClick(Sender: TObject);
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


procedure TfrmComprasAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmComprasAE.btnBorrarClick(Sender: TObject);
begin
  if (MessageDlg ('Confirmación'
                  , 'Desea borrar el item seleccionado?'
                   , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
   Begin
      DM_Compras.BorrarItem;
      AjustarMontos;
   end;
end;

procedure TfrmComprasAE.btnAceptarClick(Sender: TObject);
begin
  DM_Compras.Grabar;
  ModalResult:= mrOK;
end;

procedure TfrmComprasAE.ds_ComprobanteDataChange(Sender: TObject; Field: TField
  );
begin
  dbNro.Visible:= (DM_Compras.Comprasnumero.asInteger <> -1);
end;

procedure TfrmComprasAE.FormDestroy(Sender: TObject);
begin
  DM_Compras.Free;
end;

procedure TfrmComprasAE.FormShow(Sender: TObject);
var
  proveedor: TDM_Proveedores;
begin
  proveedor:= TDM_Proveedores.Create(self);
  try
    if idCompra = GUIDNULO then
     DM_Compras.NuevaCompra
    else
    begin
      DM_Compras.Editar (idCompra);
      proveedor.Editar(DM_Compras.Comprasproveedor_id.AsString);
      edProveedor.Text:= proveedor.RazonSocial;
    end;
  finally
    proveedor.Free;
  end;
end;

procedure TfrmComprasAE.Panel1Click(Sender: TObject);
begin

end;


procedure TfrmComprasAE.Inicializar;
begin
  idCompra:= GUIDNULO;
  AjustarMontos;
end;

procedure TfrmComprasAE.AjustarMontos;
begin
  lbMontoNeto.Caption:= 'Monto Neto $' + FormatFloat (_FRM_MONEY,DM_Compras.montoNeto);
  lbMontoIVA.Caption:='Monto IVA $' + FormatFloat (_FRM_MONEY,DM_Compras.montoIVA);
  lbSumaMontos.Caption:='Monto Neto + IVA $' + FormatFloat (_FRM_MONEY,DM_Compras.montoNeto+DM_Compras.montoIVA);
end;

(*******************************************************************************
*** ITEMS DE LA COMPRA
*******************************************************************************)

procedure TfrmComprasAE.PantallaItems;
var
  pant: TfrmCompraItemAE;
begin
  pant:= TfrmCompraItemAE.Create(self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmComprasAE.btnNuevoClick(Sender: TObject);
begin
  DM_Compras.NuevoItem;
  PantallaItems;
  AjustarMontos;
end;


procedure TfrmComprasAE.DBEdit3Exit(Sender: TObject);
begin
   AjustarMontos;
end;

procedure TfrmComprasAE.btnEditarClick(Sender: TObject);
begin
  PantallaItems;
  AjustarMontos;
end;


end.

