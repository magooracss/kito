unit frm_ventaconceptosae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, rxdbgrid, rxspin, dbcurredit,
  RxDBSpinEdit, curredit, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ExtCtrls, Buttons, StdCtrls, DbCtrls, Spin, dmgeneral
  ;

const
  CONCEPTO_GRAL = 0;
  CONCEPTO_PEDIDO = 1;

type

  { TfrmVentaConceptosAE }

  TfrmVentaConceptosAE = class(TForm)
    btnAgregarPedidos: TBitBtn;
    BitBtn2: TBitBtn;
    btnPedidosAceptar: TBitBtn;
    btnConceptosAceptar: TBitBtn;
    btnPedidosCancelar: TBitBtn;
    btnPedidosCancelar1: TBitBtn;
    cbConceptos: TComboBox;
    cbAlicuotaIVACptoGral: TComboBox;
    edCtoGralGravado: TCurrencyEdit;
    edCtoGralNoGravado: TCurrencyEdit;
    edCtoGralExento: TCurrencyEdit;
    ds_conceptos: TDataSource;
    ds_pedidos: TDataSource;
    ds_detallePedido: TDataSource;
    edCtoGralDetalle: TEdit;
    edCtoGralCantidad: TFloatSpinEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PCConceptos: TPageControl;
    grillaPedidos: TRxDBGrid;
    GrillaItems: TRxDBGrid;
    Splitter1: TSplitter;
    TabGenerales: TTabSheet;
    TabSheet2: TTabSheet;
    procedure btnConceptosAceptarClick(Sender: TObject);
    procedure btnPedidosAceptarClick(Sender: TObject);
    procedure btnAgregarPedidosClick(Sender: TObject);
    procedure btnPedidosCancelarClick(Sender: TObject);
    procedure ds_pedidosDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _descripcion: string;
    _montoExento: double;
    _montoGravado: double;
    _montoNoGravado: double;
    _cantidad: double;
    _refAlicuotaIVA: integer;
    _refCliente: GUID_ID;
    _refConcepto: integer;
    _refProducto: GUID_ID;
    _tipoConcepto: integer;
    { private declarations }
    procedure Inicializar;
  public
    property tipoConcepto: integer read _tipoConcepto;
    property refCliente: GUID_ID write _refCliente;
    property cantidad: double read _cantidad write _cantidad;
    property refConcepto: integer read _refConcepto write _refConcepto;
    property descripcion: string read _descripcion write _descripcion;
    property montoGravado: double read _montoGravado write _montoGravado;
    property montoNoGravado: double read _montoNoGravado write _montoNoGravado;
    property montoExento: double read _montoExento write _montoExento;
    property refProducto: GUID_ID read _refProducto write _refProducto;
    property refAlicuotaIVA: integer read _refAlicuotaIVA write _refAlicuotaIVA;
  end;

var
  frmVentaConceptosAE: TfrmVentaConceptosAE;

implementation
{$R *.lfm}
uses
  frm_seleccionarpedidos
  ,dmventas
  ,dmpedidos
  ;

{ TfrmVentaConceptosAE }

procedure TfrmVentaConceptosAE.FormCreate(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmVentaConceptosAE.FormShow(Sender: TObject);
begin

end;

procedure TfrmVentaConceptosAE.Inicializar;
begin
  _tipoConcepto:= CONCEPTO_GRAL;
  _refCliente:= GUIDNULO;
  _cantidad:= 0;
  _refAlicuotaIVA:= 0;
  _refCliente:= GUIDNULO;
  _refConcepto:= 0;
  _refProducto:= GUIDNULO;
  _tipoConcepto:= 0;
  DM_General.ReiniciarTabla(DM_Ventas.Pedidos);
  DM_General.CargarComboBox(cbConceptos, 'nombre', 'id', DM_Ventas.qConceptos);
  DM_General.CargarComboBox(cbAlicuotaIVACptoGral, 'nombre','id', DM_Ventas.qAlicuotasIVA);
end;

(*******************************************************************************
*** CARGA DE PEDIDOS
*******************************************************************************)

procedure TfrmVentaConceptosAE.btnPedidosAceptarClick(Sender: TObject);
begin
  _tipoConcepto:= PCConceptos.ActivePageIndex;
  ModalResult:= mrOK;
end;

procedure TfrmVentaConceptosAE.btnAgregarPedidosClick(Sender: TObject);
var
  pant: TfrmSeleccionarPedidos;
  idx: integer;
begin
  pant:= TfrmSeleccionarPedidos.Create(self);
  try
    pant.restringirEstados:= IDX_AFACTURAR;
    pant.restringirCliente:= _refCliente;
    if pant.ShowModal = mrOK then
    begin
      for idx:= 0 to pant.PedidosSeleccionados.Count -1 do
        DM_Ventas.AgregarPedido(pant.PedidosSeleccionados.Strings[idx]);
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmVentaConceptosAE.btnPedidosCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmVentaConceptosAE.ds_pedidosDataChange(Sender: TObject;
  Field: TField);
begin
  if ((DM_Ventas.Pedidos.Active)and (DM_Ventas.Pedidos.RecordCount > 0 ) and
     grillaPedidos.Focused) then
  begin
    DM_Pedidos.LevantarPedido(DM_Ventas.Pedidosid.AsString);
   end;
end;

(*******************************************************************************
*** CARGA DE CONCEPTOS
*******************************************************************************)

procedure TfrmVentaConceptosAE.btnConceptosAceptarClick(Sender: TObject);
begin
  _tipoConcepto:= PCConceptos.ActivePageIndex;
  _cantidad:= edCtoGralCantidad.Value;
  _refConcepto:= DM_General.obtenerIDIntComboBox(cbConceptos);
  _descripcion:= edCtoGralDetalle.Text;
  _montoGravado:= edCtoGralGravado.Value;
  _montoNoGravado:= edCtoGralNoGravado.Value;
  _montoExento:= edCtoGralExento.Value;
  _refAlicuotaIVA:= DM_General.obtenerIDIntComboBox(cbAlicuotaIVACptoGral);

  ModalResult:= mrOK;
end;


end.

