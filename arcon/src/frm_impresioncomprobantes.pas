unit frm_impresioncomprobantes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, curredit, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, ComCtrls, Buttons, StdCtrls, Spin, EditBtn,
  dmgeneral;

type

  { TfrmImpresionComprobantes }

  TfrmImpresionComprobantes = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    btnBuscarCliente: TBitBtn;
    btnFiltrar: TBitBtn;
    cbTipoComprobante: TComboBox;
    edFechaVenta: TDateEdit;
    edMonto: TCurrencyEdit;
    edFechaAfip: TDateEdit;
    ds_resultados: TDataSource;
    edCliRazonSocial: TEdit;
    edCAE: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    LabelFechaAfip: TLabel;
    LabelFechaAfip1: TLabel;
    PCFiltros: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    rgCriterioFiltro: TRadioGroup;
    RxDBGrid1: TRxDBGrid;
    edPtoVenta: TSpinEdit;
    edNroComprobante: TSpinEdit;
    edComprobanteVenta: TSpinEdit;
    tabNroAFIP: TTabSheet;
    tabNroCAE: TTabSheet;
    tabNroVenta: TTabSheet;
    tabCliente: TTabSheet;
    tabMonto: TTabSheet;
    tabVenta: TTabSheet;
    tabTipoComprobanteAFIP: TTabSheet;
    tabFechaComprAFIP: TTabSheet;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure edMontoKeyPress(Sender: TObject; var Key: char);
    procedure edNroComprobanteKeyPress(Sender: TObject; var Key: char);
    procedure edPtoVentaKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgCriterioFiltroSelectionChanged(Sender: TObject);
  private
    _refCliente: GUID_ID;
    procedure Inicializar;
    procedure Buscar;
  public
    { public declarations }
  end;

var
  frmImpresionComprobantes: TfrmImpresionComprobantes;

implementation
{$R *.lfm}
uses
  dmfacturas
  ,frm_busquedaempresas
  ;

  { TfrmImpresionComprobantes }

procedure TfrmImpresionComprobantes.rgCriterioFiltroSelectionChanged(
  Sender: TObject);
begin
  PCFiltros.ActivePageIndex:= rgCriterioFiltro.ItemIndex;
end;

procedure TfrmImpresionComprobantes.Inicializar;
begin
  rgCriterioFiltro.ItemIndex:= 0;
  DM_General.CargarComboBox(cbTipoComprobante, 'ComprobanteVenta','id',DM_Facturas.qTiposComprVentas);
  _refCliente:= GUIDNULO;
end;


procedure TfrmImpresionComprobantes.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmImpresionComprobantes.BitBtn1Click(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmImpresionComprobantes.BitBtn2Click(Sender: TObject);
begin
  DM_Facturas.ImprimirFactura(DM_Facturas.Resultadosid_FE.AsString);
  DM_Facturas.elReporte.ShowReport;
end;

procedure TfrmImpresionComprobantes.btnBuscarClienteClick(Sender: TObject);
var
  pant:TfrmBusquedaEmpresas;
begin
  pant:= TfrmBusquedaEmpresas.Create(self);
  try
    pant.restringirTipo:= IDX_CLIENTE;
    if pant.ShowModal = mrOK then
    begin
      edCliRazonSocial.Text:= pant.RazonSocial;
      _refCliente:= pant.idCliente;
    end
    else
    begin
      edCliRazonSocial.Clear;
      _refCliente:= GUIDNULO;
    end;
  finally
    pant.Free;
  end;


end;

procedure TfrmImpresionComprobantes.btnFiltrarClick(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmImpresionComprobantes.edMontoKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
    Buscar;
end;

procedure TfrmImpresionComprobantes.edNroComprobanteKeyPress(Sender: TObject;
  var Key: char);
begin
  if key  = #13 then
    Buscar;
end;

procedure TfrmImpresionComprobantes.edPtoVentaKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
   edNroComprobante.SetFocus;
end;

procedure TfrmImpresionComprobantes.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  DM_Facturas.Free;
end;

procedure TfrmImpresionComprobantes.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_Facturas, DM_Facturas);
end;


procedure TfrmImpresionComprobantes.Buscar;
begin
   case rgCriterioFiltro.ItemIndex of
     0: DM_Facturas.BuscarNroComprobante(edPtoVenta.Value, edNroComprobante.Value);
     1: DM_Facturas.BuscarTiposComprobante (DM_General.obtenerIDIntComboBox(cbTipoComprobante));
     2: DM_Facturas.BuscarFechaAFIP(edFechaAfip.Date);
     3: DM_Facturas.BuscarCAE(Trim(edCAE.Text));
     4: DM_Facturas.BuscarNroInterno(edComprobanteVenta.Value);
     5: if _refCliente <> GUIDNULO then
          DM_Facturas.BuscarCliente(_refCliente)
        else
          ShowMessage('No hay ningún cliente seleccionado');
     6: DM_Facturas.BuscarMonto(edMonto.Value);
     7: DM_Facturas.BuscarFechaVenta(edFechaVenta.Date);

   end;
end;

end.

