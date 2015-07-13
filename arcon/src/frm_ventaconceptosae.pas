unit frm_ventaconceptosae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, rxdbgrid, Forms, Controls, Graphics,
  Dialogs, ComCtrls, ExtCtrls, Buttons
  ,dmgeneral
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
    btnPedidosCancelar: TBitBtn;
    ds_pedidos: TDataSource;
    ds_detallePedido: TDataSource;
    Panel1: TPanel;
    PCConceptos: TPageControl;
    grillaPedidos: TRxDBGrid;
    GrillaItems: TRxDBGrid;
    Splitter1: TSplitter;
    TabGenerales: TTabSheet;
    TabSheet2: TTabSheet;
    procedure BitBtn2Click(Sender: TObject);
    procedure btnPedidosAceptarClick(Sender: TObject);
    procedure btnAgregarPedidosClick(Sender: TObject);
    procedure btnPedidosCancelarClick(Sender: TObject);
    procedure ds_pedidosDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _refCliente: GUID_ID;
    _tipoConcepto: integer;
    { private declarations }
    procedure Inicializar;
  public
    property tipoConcepto: integer read _tipoConcepto;
    property refCliente: GUID_ID write _refCliente;
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
  DM_General.ReiniciarTabla(DM_Ventas.Pedidos);
end;


procedure TfrmVentaConceptosAE.btnPedidosAceptarClick(Sender: TObject);
begin
  _tipoConcepto:= PCConceptos.ActivePageIndex;
  ModalResult:= mrOK;
end;

procedure TfrmVentaConceptosAE.BitBtn2Click(Sender: TObject);
begin

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


end.

