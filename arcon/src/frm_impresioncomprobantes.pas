unit frm_impresioncomprobantes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, curredit, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, ComCtrls, Buttons, StdCtrls, Spin, EditBtn,
   dmgeneral
  ,dmfacturas
  ;

type

  { TfrmImpresionComprobantes }

  TfrmImpresionComprobantes = class(TForm)
    btnSalir: TBitBtn;
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
    procedure btnSalirClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure edMontoKeyPress(Sender: TObject; var Key: char);
    procedure edNroComprobanteKeyPress(Sender: TObject; var Key: char);
    procedure edPtoVentaKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgCriterioFiltroSelectionChanged(Sender: TObject);
  private
    _refCliente: GUID_ID;
    _seleccion: boolean;
    DmFacturas: TDM_Facturas;

    function getSeleccionID: GUID_ID;
    procedure Inicializar;
    procedure Buscar;
  public
    property seleccion: boolean write _seleccion;
    property seleccionID: GUID_ID read getSeleccionID;
  end;

var
  frmImpresionComprobantes: TfrmImpresionComprobantes;

implementation
{$R *.lfm}
uses
  frm_busquedaempresas
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
  DM_General.CargarComboBox(cbTipoComprobante, 'ComprobanteVenta','id',DmFacturas.qTiposComprVentas);
  _refCliente:= GUIDNULO;
  if _seleccion then
    btnSalir.Caption:= 'Seleccionar';
end;

function TfrmImpresionComprobantes.getSeleccionID: GUID_ID;
begin
  if ((DmFacturas.Resultados.Active) and (DmFacturas.Resultados.RecordCount > 0)) then
    Result:= DmFacturas.ResultadosidComprobante.asString
  else
    Result:= GUIDNULO;
end;


procedure TfrmImpresionComprobantes.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmImpresionComprobantes.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmImpresionComprobantes.BitBtn2Click(Sender: TObject);
begin
  DmFacturas.ImprimirFactura(DmFacturas.Resultadosid_FE.AsString);
  DmFacturas.elReporte.ShowReport;
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
      Buscar;
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

procedure TfrmImpresionComprobantes.FormCreate(Sender: TObject);
begin
  DmFacturas:= TDM_Facturas.Create(self);
  _seleccion:= false;
end;

procedure TfrmImpresionComprobantes.FormDestroy(Sender: TObject);
begin
  DmFacturas.Free;
end;


procedure TfrmImpresionComprobantes.Buscar;
begin
   case rgCriterioFiltro.ItemIndex of
     0: DmFacturas.BuscarNroComprobante(edPtoVenta.Value, edNroComprobante.Value);
     1: DmFacturas.BuscarTiposComprobante (DM_General.obtenerIDIntComboBox(cbTipoComprobante));
     2: DmFacturas.BuscarFechaAFIP(edFechaAfip.Date);
     3: DmFacturas.BuscarCAE(Trim(edCAE.Text));
     4: DmFacturas.BuscarNroInterno(edComprobanteVenta.Value);
     5: if _refCliente <> GUIDNULO then
          DmFacturas.BuscarCliente(_refCliente)
        else
          ShowMessage('No hay ningún cliente seleccionado');
     6: DmFacturas.BuscarMonto(edMonto.Value);
     7: DmFacturas.BuscarFechaVenta(edFechaVenta.Date);

   end;
end;

end.

