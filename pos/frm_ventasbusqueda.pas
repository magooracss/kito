unit frm_ventasbusqueda;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Buttons, DBGrids, StdCtrls, ComCtrls, EditBtn, DBExtCtrls,
  dmgeneral, dmventasbusqueda;

type

  { TfrmVentaBusqueda }

  TfrmVentaBusqueda = class(TForm)
    btnBusProducto: TBitBtn;
    btnBusCliente: TBitBtn;
    btnBuscar: TBitBtn;
    btnCancelar: TBitBtn;
    btnSeleccionar: TBitBtn;
    ds_resultados: TDataSource;
    edDateIni: TDateEdit;
    edDateFin: TDateEdit;
    dbGrillaProductos: TDBGrid;
    edNroVenta: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    lbNro: TLabel;
    lbProductoNombre: TLabel;
    lbClienteName: TLabel;
    PCBusqueda: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    rgCritero: TRadioGroup;
    tabNro: TTabSheet;
    tabProducto: TTabSheet;
    tabIntFechas: TTabSheet;
    tabCliente: TTabSheet;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnBusClienteClick(Sender: TObject);
    procedure btnBusProductoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgCriteroSelectionChanged(Sender: TObject);
  private
     _idGUID: GUID_ID;
     dmBus: TDM_VentasBusqueda;
     procedure BuscarProducto;
     procedure BuscarCliente;
     procedure Buscar;
     function getVentaId: GUID_ID;
  public
    property ventaSeleccionada: GUID_ID read getVentaId;
  end;

var
  frmVentaBusqueda: TfrmVentaBusqueda;

implementation
{$R *.lfm}
uses
  frm_busquedaProductos
, frm_busquedaempresas
, dateutils
  ;

const
  crit_nroVenta = 0;
  crit_producto = 1;
  crit_intFechas = 2;
  crit_cliente = 3;

{ TfrmVentaBusqueda }

procedure TfrmVentaBusqueda.FormShow(Sender: TObject);
begin
  lbProductoNombre.Caption:= '--';
  _idGUID:= GUIDNULO;
  rgCritero.ItemIndex:= 0;
  edNroVenta.Text:= EmptyStr;
  edDateIni.Date:= IncDay(Now, -30);
  edDateFin.Date:= Now;

end;

procedure TfrmVentaBusqueda.rgCriteroSelectionChanged(Sender: TObject);
begin
   PCBusqueda.ActivePageIndex:= rgCritero.ItemIndex;
end;

procedure TfrmVentaBusqueda.BuscarProducto;
var
  scr: TfrmBusquedaProducto;
begin
  scr:= TfrmBusquedaProducto.Create(self);
  try
    if scr.ShowModal = mrOK then
    begin
      lbProductoNombre.Caption:= scr.productoNombre;
      _idGUID:= scr.productoSeleccionado;
      Buscar;
    end
    else
    begin
      lbProductoNombre.Caption:= '---' ;
      _idGUID:= GUIDNULO;
    end;
  finally
    scr.free;
  end;
end;

procedure TfrmVentaBusqueda.BuscarCliente;
var
  scr: TfrmBusquedaEmpresas;
begin
  scr:= TfrmBusquedaEmpresas.Create(self);
  try
    scr.restringirTipo:= IDX_CLIENTE;
    if scr.ShowModal = mrOK then
     begin
       lbClienteName.Caption:= scr.RazonSocial;
       _idGUID:= scr.idCliente;
       Buscar;
     end
     else
     begin
       lbClienteName.Caption:= '---' ;
       _idGUID:= GUIDNULO;
     end;
  finally
    scr.Free;
  end;
end;

procedure TfrmVentaBusqueda.Buscar;
begin
  case rgCritero.ItemIndex of
    crit_nroVenta: dmBus.BusNroVenta(StrToIntDef(TRIM(edNroVenta.Text), 0));
    crit_intFechas: dmBus.BusFechasVenta(edDateIni.Date, edDateFin.Date);
    crit_producto: dmBus.BusProducto(_idGUID);
    crit_cliente: dmBus.BusCliente (_idGUID);
  end;
end;

function TfrmVentaBusqueda.getVentaId: GUID_ID;
begin
  Result:= dmBus.ventaSeleccionada;
end;

procedure TfrmVentaBusqueda.btnBusProductoClick(Sender: TObject);
begin
  BuscarProducto;
end;

procedure TfrmVentaBusqueda.btnBusClienteClick(Sender: TObject);
begin
  BuscarCliente;
end;

procedure TfrmVentaBusqueda.btnBuscarClick(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmVentaBusqueda.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmVentaBusqueda.FormCreate(Sender: TObject);
begin
  dmBus:= TDM_VentasBusqueda.Create(self);
  ds_resultados.DataSet:= dmBus.Resultados;
end;

procedure TfrmVentaBusqueda.FormDestroy(Sender: TObject);
begin
  dmBus.Free;
end;

end.

