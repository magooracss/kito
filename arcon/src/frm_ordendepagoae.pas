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
    CurrencyEdit1: TCurrencyEdit;
    CurrencyEdit2: TCurrencyEdit;
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
    procedure btnProveedorNuevoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmOrdenDePagoAE: TfrmOrdenDePagoAE;

implementation
{$R *.lfm}
uses
  dmordendepago
  ,frm_busquedaempresas
  ,frm_proveedoresae
  ;

{ TfrmOrdenDePagoAE }

procedure TfrmOrdenDePagoAE.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_OrdenDePago, DM_OrdenDePago);
end;

procedure TfrmOrdenDePagoAE.FormDestroy(Sender: TObject);
begin
  DM_OrdenDePago.Free;
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



end.

