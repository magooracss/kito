unit frm_ventaae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DBDateTimePicker, RxDBSpinEdit, Forms, Controls,
  Graphics, Dialogs, StdCtrls, ExtCtrls, Buttons, DBExtCtrls, DbCtrls, DBGrids,
  dmgeneral;

type

  { TfrmVentasAE }

  TfrmVentasAE = class(TForm)
    btnAgregarConcepto: TBitBtn;
    btnAgregarConcepto1: TBitBtn;
    btnAgregarConcepto2: TBitBtn;
    btnAgregarConcepto3: TBitBtn;
    btnClienteNuevo: TBitBtn;
    btnBuscar: TBitBtn;
    cbTipoComprobante: TComboBox;
    cbFormaDePago: TComboBox;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBDateEdit1: TDBDateEdit;
    DBDateEdit2: TDBDateEdit;
    DBDateEdit3: TDBDateEdit;
    DBDateEdit4: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    edCliente: TEdit;
    edCUIT: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    procedure btnAgregarConceptoClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnClienteNuevoClick(Sender: TObject);
    procedure cbTipoComprobanteChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    _ventaID: GUID_ID;
    _clienteID: GUID_ID;
    _PtoVenta: integer;

    procedure Inicializar;
    procedure CargarCombos;
    procedure LevantarPuntoDeVenta;

    procedure AgregarConcepto;
    procedure AgregarConceptoGeneral;
    procedure AgregarConceptoPedidos;

  public
    property ventaID: GUID_ID read _ventaID write _VentaID;
  end;

var
  frmVentasAE: TfrmVentasAE;

implementation
{$R *.lfm}
uses
  dmventas
  , dmpedidos
  ,frm_busquedaempresas
  ,frm_clientesae
  ,frm_ventaconceptosae
  ,SD_Configuracion
  ;

{ TfrmVentasAE }

procedure TfrmVentasAE.Inicializar;
begin
  _clienteID:= GUIDNULO;
  _ventaID:= GUIDNULO;
  _PtoVenta:= StrToIntDef(LeerDato(SECCION_APP, CFG_PTO_VTA), 1);
  EscribirDato(SECCION_APP, CFG_PTO_VTA, IntToStr(_PtoVenta));

  CargarCombos;
end;

procedure TfrmVentasAE.CargarCombos;
begin
  DM_General.CargarComboBox(cbTipoComprobante,'comprobanteVenta', 'id', DM_Ventas.qTiposComprobantesVentas);
  DM_General.CargarComboBox(cbFormaDePago, 'formaDePago', 'id', DM_Ventas.qFormasPago);
end;

procedure TfrmVentasAE.LevantarPuntoDeVenta;
var
  comprobante: integer;
begin
  comprobante:= DM_Ventas.obtenerNroComprobante (DM_General.obtenerIDIntComboBox(cbTipoComprobante), _PtoVenta);
  if Comprobante = 0 then
  begin
    ShowMessage ('ERROR');
  end;
end;


procedure TfrmVentasAE.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_Pedidos, DM_Pedidos);
  Application.CreateForm(TDM_Ventas, DM_Ventas);
  Inicializar;
end;

procedure TfrmVentasAE.FormDestroy(Sender: TObject);
begin
  DM_Pedidos.Free;
  DM_Ventas.Free;
end;


procedure TfrmVentasAE.btnBuscarClick(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(self);
  try
    pantBus.restringirTipo:= IDX_CLIENTE;
    if pantBus.ShowModal = mrOK then
    begin
      edCliente.Text:= pantBus.RazonSocial;
      edCUIT.Text:= pantBus.CUIT;
      _clienteID:= pantBus.idCliente;
    end;
  finally
    pantBus.Free;
  end;
end;

procedure TfrmVentasAE.btnAgregarConceptoClick(Sender: TObject);
begin
  AgregarConcepto;
end;

procedure TfrmVentasAE.btnClienteNuevoClick(Sender: TObject);
var
  pant: TfrmClientesAE;
begin
  pant:= TfrmClientesAE.Create(self);
  try
    pant.idCliente:= GUIDNULO;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmVentasAE.cbTipoComprobanteChange(Sender: TObject);
begin
  LevantarPuntoDeVenta;
end;

(*******************************************************************************
*** CONCEPTOS
*******************************************************************************)

procedure TfrmVentasAE.AgregarConceptoGeneral;
begin

end;

procedure TfrmVentasAE.AgregarConceptoPedidos;
begin
  DM_Ventas.AgregarConceptoPedidos;
end;


procedure TfrmVentasAE.AgregarConcepto;
var
  pant: TfrmVentaConceptosAE;
begin
  pant:= TfrmVentaConceptosAE.Create(self);
  try
    pant.refCliente:= _clienteID;
    if pant.ShowModal = mrOK then
    begin
       if pant.tipoConcepto = CONCEPTO_PEDIDO then
        AgregarConceptoPedidos
       else
        AgregarConceptoGeneral;
    end;
  finally
    pant.Free;
  end;
end;

end.

