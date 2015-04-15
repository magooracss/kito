unit frm_movimientosstockbusqueda;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, ComCtrls, Spin, StdCtrls, EditBtn, DBGrids
  , dmbusquedamovstock, dmgeneral;

type

  { TfrmBusquedaMovimientosStock }

  TfrmBusquedaMovimientosStock = class(TForm)
    btnBuscar: TBitBtn;
    btnBuscarProveedor: TBitBtn;
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    ds_resultados: TDataSource;
    DBGrid1: TDBGrid;
    edProveedorRazonSocial: TEdit;
    edFecha: TDateEdit;
    edNroMovimiento: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PcDatoBusqueda: TPageControl;
    rgCriterio: TRadioGroup;
    TabCliente: TTabSheet;
    tabFechaTomado: TTabSheet;
    tabNumero: TTabSheet;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnBuscarProveedorClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure edFechaChange(Sender: TObject);
    procedure edNroMovimientoKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgCriterioSelectionChanged(Sender: TObject);
  private
    _idProveedor: GUID_ID;
    procedure Buscar;
    function getMovStockID: GUID_ID;
  public
    property idMovStockSeleccionado: GUID_ID read getMovStockID;
  end;

var
  frmBusquedaMovimientosStock: TfrmBusquedaMovimientosStock;

implementation
{$R *.lfm}
uses
  frm_busquedaempresas
  ;

{ TfrmBusquedaMovimientosStock }

procedure TfrmBusquedaMovimientosStock.FormCreate(Sender: TObject);
begin
  _idProveedor:= GUIDNULO;
  Application.CreateForm(TDM_BusquedaMovStock, DM_BusquedaMovStock);
end;

procedure TfrmBusquedaMovimientosStock.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmBusquedaMovimientosStock.btnGrabarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmBusquedaMovimientosStock.edFechaChange(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmBusquedaMovimientosStock.edNroMovimientoKeyPress(Sender: TObject;
  var Key: char);
begin
 if key = #13 then
   Buscar;
end;

procedure TfrmBusquedaMovimientosStock.btnBuscarClick(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmBusquedaMovimientosStock.btnBuscarProveedorClick(Sender: TObject);
var
  pant: TfrmBusquedaEmpresas;
begin
  pant:= TfrmBusquedaEmpresas.Create(self);
  try
    pant.restringirTipo:= IDX_PROVEEDOR;
    if pant.ShowModal = mrOK then
    begin
      edProveedorRazonSocial.Text:= pant.RazonSocial;
      _idProveedor:= pant.idProveedor;
      Buscar;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmBusquedaMovimientosStock.FormDestroy(Sender: TObject);
begin
  DM_BusquedaMovStock.Free;
end;

procedure TfrmBusquedaMovimientosStock.FormShow(Sender: TObject);
begin
  PcDatoBusqueda.PageIndex:= rgCriterio.ItemIndex;
end;

procedure TfrmBusquedaMovimientosStock.rgCriterioSelectionChanged(
  Sender: TObject);
begin
  PcDatoBusqueda.PageIndex:= rgCriterio.ItemIndex;
end;

procedure TfrmBusquedaMovimientosStock.Buscar;
begin
  case rgCriterio.ItemIndex of
   0: DM_BusquedaMovStock.BuscarPorNumero(edNroMovimiento.Value);
   1: DM_BusquedaMovStock.BuscarPorFecha(edFecha.Date);
   2: DM_BusquedaMovStock.BuscarPorProveedor(_idProveedor);
  end;
end;

function TfrmBusquedaMovimientosStock.getMovStockID: GUID_ID;
begin
  with DM_BusquedaMovStock, Resultados do
  begin
    if ((Active) and (RecordCount > 0)) then
     Result:= Resultadosid.AsString
    else
      Result:= GUIDNULO;
  end;
end;

end.

