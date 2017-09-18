unit frm_ventaae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, rxmemds, dbcurredit,
  DBDateTimePicker, Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons,
  ActnList, DbCtrls, StdCtrls, DBExtCtrls, dmgeneral, dmventas, c_itemventa;

type

  { TfrmVentaAE }

  TfrmVentaAE = class(TForm)
    cash_cerrarVenta: TAction;
    BitBtn4: TBitBtn;
    cash_cobrar: TAction;
    ds_VentasFormaPago: TDataSource;
    GrillaColores1: TRxDBGrid;
    Label3: TLabel;
    Panel4: TPanel;
    Panel5: TPanel;
    prod_quitar: TAction;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    btnBuscarCliente: TBitBtn;
    ds_VentasItems: TDataSource;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    ds_Ventas: TDataSource;
    edCliente: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    prod_agregar: TAction;
    ActionList1: TActionList;
    BitBtn1: TBitBtn;
    GrillaColores: TRxDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    RxDBCurrEdit1: TRxDBCurrEdit;
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure cash_cerrarVentaExecute(Sender: TObject);
    procedure cash_cobrarExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure prod_agregarExecute(Sender: TObject);
    procedure prod_quitarExecute(Sender: TObject);
  private
    dmVentas: TDM_Ventas;
    _idVenta: GUID_ID;
    _idCliente: GUID_ID;
    procedure ObtenerIDProductoStock (var stockID: GUID_ID
                                    ; productoID, colorID, talleID: GUID_ID);
    function CierreOK: integer;
  public
    property ventaID: GUID_ID read _idventa write _idVenta;
  end;

var
  frmVentaAE: TfrmVentaAE;

implementation
{$R *.lfm}
uses
  frm_busquedaProductos
, frm_seleccionproducto
, frm_busquedaempresas
, dmproductosstock
, frm_formasPago
;

const
  VENTA_OK = 0;
  ERR_VENTA_VACIA = 1;
  ERR_VENTA_IMPAGA = 2;

{ TfrmVentaAE }
procedure TfrmVentaAE.ObtenerIDProductoStock(var stockID: GUID_ID; productoID,
  colorID, talleID: GUID_ID);
var
  elDmStock: TDM_PosProductosStock;
begin
  elDmStock:= TDM_PosProductosStock.Create(self);
  try
    elDmStock.LevantarProducto(productoID, colorID, talleID);
    stockID:= elDmStock.ProductosStockid.AsString;
  finally
    elDmStock.Free;
  end;
end;

function TfrmVentaAE.CierreOK: integer;
var
  ok: integer;
begin
  ok:= 0;
  if dmVentas.PosVentaItems.RecordCount = 0 then
   ok:= ERR_VENTA_VACIA;
  if (dmVentas.TotalFormasPago < dmVentas.PosVentastotal.AsFloat) then
   ok:= ERR_VENTA_IMPAGA;
  Result:= ok;
end;

procedure TfrmVentaAE.prod_agregarExecute(Sender: TObject);
var
  scrSearch: TfrmBusquedaProducto;
  scrSelProd: TfrmSeleccionProducto;
  stockID: GUID_ID;
begin
  scrSearch:= TfrmBusquedaProducto.Create(self);
  scrSelProd:= TfrmSeleccionProducto.Create(self);
  try
    if scrSearch.ShowModal = mrOK then
    begin
      scrSelProd.productoID:= scrSearch.productoSeleccionado;
      scrSelProd.itemVentaseleccionado:= TItemVenta.Create;
      if scrSelProd.ShowModal = mrOK then
      begin
        stockID:= GUIDNULO;
        ObtenerIDProductoStock (stockID
                               ,scrSelProd.itemVentaseleccionado.productoID
                               ,scrSelProd.itemVentaseleccionado.colorID
                               ,scrSelProd.itemVentaseleccionado.talleid);
        scrSelProd.itemVentaseleccionado.stockID:= stockID;
        dmVentas.agregarItem (scrSelProd.itemVentaseleccionado);
        dmVentas.AjustarTotales;
      end;
    end;
  finally
    scrSearch.Free;
    scrSelProd.Free;
  end;
end;

procedure TfrmVentaAE.prod_quitarExecute(Sender: TObject);
begin
   if (MessageDlg ('ATENCION'
                 , 'Quito el producto seleccionado?'
                 , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
   begin
     dmVentas.QuitarItem;
     dmVentas.AjustarTotales;
   end;

end;


procedure TfrmVentaAE.FormCreate(Sender: TObject);
begin
  dmVentas:= TDM_Ventas.Create(self);

  _idVenta:= GUIDNULO;
  _idCliente:= GUIDNULO;

  ds_Ventas.DataSet:= dmVentas.PosVentas;
  ds_VentasItems.DataSet:= dmVentas.PosVentaItems;
  ds_VentasFormaPago.DataSet:= dmVentas.PosVentaFormaPago;
end;

procedure TfrmVentaAE.FormDestroy(Sender: TObject);
begin
  dmVentas.Free;
end;

procedure TfrmVentaAE.FormShow(Sender: TObject);
begin
  if _idVenta = GUIDNULO then
  begin
    dmVentas.New;
  end;
end;

procedure TfrmVentaAE.btnBuscarClienteClick(Sender: TObject);
var
  scrCliente: TfrmBusquedaEmpresas;
begin
  scrCliente:= TfrmBusquedaEmpresas.Create(self);
  try
    scrCliente.restringirTipo:= IDX_CLIENTE;
    if scrCliente.ShowModal = mrOK then
    begin
      edCliente.Text:= scrCliente.RazonSocial;
      _idCliente:= scrCliente.idCliente;
    end;
  finally
    scrCliente.Free;
  end;
end;

procedure TfrmVentaAE.cash_cerrarVentaExecute(Sender: TObject);
var
  checkCierre: integer;
begin
  checkCierre:= CierreOK;
  if checkCierre = VENTA_OK then
  begin
    dmVentas.Save;
    ModalResult:= mrOK;
  end
  else
  begin
    case checkCierre of
     ERR_VENTA_IMPAGA: ShowMessage('El total de la venta es mayor que la suma de las formas de pago');
     ERR_VENTA_VACIA: ShowMessage('La venta no tiene artículos cargados');
    end;
  end;
end;

procedure TfrmVentaAE.cash_cobrarExecute(Sender: TObject);
var
  scrFormaPago: TfrmFormasPago;
begin
  scrFormaPago:= TfrmFormasPago.Create(self);
  try
    scrFormaPago.dm:= dmVentas;
    if scrFormaPago.ShowModal = mrOK then
    begin

    end;
  finally
    scrFormaPago.Free;
  end;
end;

end.

