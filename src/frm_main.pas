unit frm_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ActnList, Menus, ExtCtrls, StdCtrls, Buttons, DBGrids
  ,dmgeneral
  , Grids;

type
   TipoFiltro = (nulo, codigo, nombre);
  { TfrmMain }

  TfrmMain = class(TForm)
    HdRModificar: TAction;
    HrRNueva: TAction;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem40: TMenuItem;
    prgListados: TAction;
    MenuItem37: TMenuItem;
    OD: TOpenDialog;
    prgEditarReporte: TAction;
    MenuItem35: TMenuItem;
    MenuItem36: TMenuItem;
    stkRecalcularTodo: TAction;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    pedDevolucion: TAction;
    Label3: TLabel;
    MenuItem32: TMenuItem;
    Panel2: TPanel;
    prgEditarProducto: TAction;
    btnFiltradoQuitar: TBitBtn;
    ckRefrescarGrilla: TCheckBox;
    Grilla: TDBGrid;
    ds_GrillaPrincipal: TDataSource;
    edFiltroCodigo: TEdit;
    edFiltroNombre: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    MenuItem31: TMenuItem;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    Precios: TMenuItem;
    prodPreciosModificar: TAction;
    MenuItem30: TMenuItem;
    Shape1: TShape;
    stkEditar: TAction;
    stkNuevo: TAction;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem29: TMenuItem;
    pedModificar: TAction;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    pedNuevo: TAction;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    tRefrescarGrilla: TTimer;
    ToolButton3: TToolButton;
    vendEditar: TAction;
    vendBorrar: TAction;
    vendNuevo: TAction;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem20: TMenuItem;
    tranEditar: TAction;
    tranBorrar: TAction;
    tranNuevo: TAction;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem9: TMenuItem;
    provBorrar: TAction;
    provEditar: TAction;
    provNuevo: TAction;
    cliNuevo: TAction;
    cliEditar: TAction;
    cliBorrar: TAction;
    prodEditar: TAction;
    prodBorrar: TAction;
    MenuItem8: TMenuItem;
    prodNuevo: TAction;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    prgSalir: TAction;
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    st: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure btnFiltradoQuitarClick(Sender: TObject);
    procedure ckRefrescarGrillaChange(Sender: TObject);
    procedure cliBorrarExecute(Sender: TObject);
    procedure cliEditarExecute(Sender: TObject);
    procedure cliNuevoExecute(Sender: TObject);
    procedure GrillaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edFiltroCodigoKeyPress(Sender: TObject; var Key: char);
    procedure edFiltroNombreKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure HdRModificarExecute(Sender: TObject);
    procedure HrRNuevaExecute(Sender: TObject);
    procedure pedDevolucionExecute(Sender: TObject);
    procedure pedModificarExecute(Sender: TObject);
    procedure pedNuevoExecute(Sender: TObject);
    procedure prgEditarProductoExecute(Sender: TObject);
    procedure prgEditarReporteExecute(Sender: TObject);
    procedure prgListadosExecute(Sender: TObject);
    procedure prgSalirExecute(Sender: TObject);
    procedure prodBorrarExecute(Sender: TObject);
    procedure prodEditarExecute(Sender: TObject);
    procedure prodNuevoExecute(Sender: TObject);
    procedure prodPreciosModificarExecute(Sender: TObject);
    procedure provBorrarExecute(Sender: TObject);
    procedure provEditarExecute(Sender: TObject);
    procedure provNuevoExecute(Sender: TObject);
    procedure stkEditarExecute(Sender: TObject);
    procedure stkNuevoExecute(Sender: TObject);
    procedure stkRecalcularTodoExecute(Sender: TObject);
    procedure tranBorrarExecute(Sender: TObject);
    procedure tranEditarExecute(Sender: TObject);
    procedure tranNuevoExecute(Sender: TObject);
    procedure tRefrescarGrillaTimer(Sender: TObject);
    procedure vendBorrarExecute(Sender: TObject);
    procedure vendEditarExecute(Sender: TObject);
    procedure vendNuevoExecute(Sender: TObject);
  private
    Filtrado: TipoFiltro;

     procedure Inicializar;
     procedure RefrescarGrilla;
     procedure pantallaProducto (ID: GUID_ID);
     procedure pantallaCliente (ID: GUID_ID);
     procedure pantallaProveedores(ID: GUID_ID);
     procedure pantallaTransportistas(ID: GUID_ID);
     procedure pantallaVendedores(ID: GUID_ID);
     procedure pantallaPedidos(ID: GUID_ID);
     procedure pantallaMovimientosStock (ID: GUID_ID);
     procedure pantallaHojaDeRuta (ID: GUID_ID);
  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
{$R *.lfm}
uses
  versioninfo
  ,frm_productoae
  ,frm_busquedaProductos
  ,dmproductos
  ,frm_clientesae
  ,dmclientes
  ,frm_busquedaempresas
  ,dmproveedores
  ,frm_proveedoresae
  ,dmtransportistas
  ,frm_transportistasae
  ,dmvendedores
  ,frm_vendedoresae
  ,frm_pedidosae
  ,frm_pedidosbusqueda
  ,frm_movimientosstockae
  ,frm_movimientosstockbusqueda
  ,frm_modificarprecios
  ,SD_Configuracion
  ,frm_devolucionesae
  ,dmstock
  ,frm_listados
  ,dmlistados
  ,frm_hojaderutaae
  ,frm_busquedahojaderuta
  ;

{ TfrmMain }

procedure TfrmMain.Inicializar;
Var
  NroVersion: String;
  Info: TVersionInfo;
begin
  Info := TVersionInfo.Create;
  Info.Load(HINSTANCE);
  NroVersion := IntToStr(Info.FixedInfo.FileVersion[0])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[1])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[2])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[3]);
  Info.Free;

  st.Panels[0].Text:= 'v:' + NroVersion;
  st.Panels[1].Text:= FormatDateTime('dd/mm/yyyy', now)+ '        ';
  ckRefrescarGrilla.Checked:= StrToBoolDef(LeerDato(SECCION_SCR, CHK_REF_GRID), true);
  Filtrado:= nulo;
  RefrescarGrilla;
end;

procedure TfrmMain.RefrescarGrilla;
begin
  case Filtrado of
   nulo: DM_Productos.FiltradoGrillaNulo;
   codigo: DM_Productos.FiltradoGrillaCodigo(TRIM(edFiltroCodigo.Text));
   nombre: DM_Productos.FiltradoGrillaNombre(TRIM(edFiltroNombre.Text));
  end;
end;


procedure TfrmMain.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmMain.prgSalirExecute(Sender: TObject);
begin
  EscribirDato(SECCION_SCR, CHK_REF_GRID, BoolToStr(ckRefrescarGrilla.Checked));
  Application.Terminate;
end;


procedure TfrmMain.prgEditarReporteExecute(Sender: TObject);
begin
  try
    Application.CreateForm(TDM_Listados, DM_Listados);
    DM_General.EditarReporte;
  finally
    DM_Listados.Free;
  end;

end;

procedure TfrmMain.prgListadosExecute(Sender: TObject);
var
  pant: TfrmListados;
begin
  pant:= TfrmListados.Create(self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;


(*******************************************************************************
*** PRODUCTOS
*******************************************************************************)

procedure TfrmMain.pantallaProducto(ID: GUID_ID);
var
 pant: TfrmProductoAE;
begin
  pant:= TfrmProductoAE.Create(self);
  try
    pant.idProducto := ID;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmMain.prodNuevoExecute(Sender: TObject);
begin
   pantallaProducto(GUIDNULO);
end;

procedure TfrmMain.prodEditarExecute(Sender: TObject);
var
 pantBus: TfrmBusquedaProducto;
begin
  pantBus:= TfrmBusquedaProducto.Create(self);
  try
    if (pantBus.ShowModal = mrOK)
     and (pantBus.productoSeleccionado <> GUIDNULO) then
    begin
      pantallaProducto(pantBus.productoSeleccionado);
    end;
  finally
    pantBus.Free;
  end;
end;

procedure TfrmMain.prodBorrarExecute(Sender: TObject);
var
 pantBus: TfrmBusquedaProducto;
begin
  pantBus:= TfrmBusquedaProducto.Create(self);
  try
    if (pantBus.ShowModal = mrOK)
     and (pantBus.productoSeleccionado <> GUIDNULO) then
    begin
      if (MessageDlg ('ATENCION'
                     , 'Borro el producto: '+pantBus.productoNombre +'?'
                     , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
      begin
         DM_Productos.idProducto:= pantBus.productoSeleccionado;
         DM_Productos.Borrar;
      end;
    end;
  finally
    pantBus.Free;
  end;
end;

procedure TfrmMain.prgEditarProductoExecute(Sender: TObject);
begin
  pantallaProducto(DM_Productos.qGrillaPrincipalIDPRODUCTO.AsString);
end;

(*******************************************************************************
*** CLIENTES
*******************************************************************************)
procedure TfrmMain.pantallaCliente(ID: GUID_ID);
var
 pant: TfrmClientesAE;
begin
  pant:= TfrmClientesAE.Create(self);
  try
    pant.idCliente := ID;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmMain.cliNuevoExecute(Sender: TObject);
begin
  pantallaCliente(GUIDNULO);
end;




procedure TfrmMain.cliEditarExecute(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(self);
  try
    pantBus.restringirTipo:= IDX_CLIENTE;
    if (pantBus.ShowModal = mrOK) and (pantBus.idCliente <> GUIDNULO)then
     pantallaCliente(pantBus.idCliente);
  finally
    pantBus.Free;
  end;
end;

procedure TfrmMain.cliBorrarExecute(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(self);
  try
    pantBus.restringirTipo:= IDX_CLIENTE;
    if (pantBus.ShowModal = mrOK) and (pantBus.idCliente <> GUIDNULO)then
      if (MessageDlg ('ATENCION'
                      , 'Borro el cliente: '+pantBus.RazonSocial +'?'
                      , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
       begin
         DM_Clientes.Borrar(pantBus.idCliente);
       end;
  finally
    pantBus.Free;
  end;

end;


(*******************************************************************************
*** PROVEEDORES
*******************************************************************************)
procedure TfrmMain.pantallaProveedores(ID: GUID_ID);
var
 pant: TfrmProveedoresAE;
begin
  pant:= TfrmProveedoresAE.Create(self);
  try
    pant.idProveedor := ID;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmMain.provNuevoExecute(Sender: TObject);
begin
  pantallaProveedores(GUIDNULO);
end;

procedure TfrmMain.provEditarExecute(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(self);
  try
    pantBus.restringirTipo:= IDX_PROVEEDOR;
    if (pantBus.ShowModal = mrOK) and (pantBus.idProveedor <> GUIDNULO)then
     pantallaProveedores(pantBus.idProveedor);
  finally
    pantBus.Free;
  end;
end;

procedure TfrmMain.provBorrarExecute(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(self);
  try
    pantBus.restringirTipo:= IDX_PROVEEDOR;
    if (pantBus.ShowModal = mrOK) and (pantBus.idProveedor <> GUIDNULO)then
      if (MessageDlg ('ATENCION'
                      , 'Borro el proveedor: '+pantBus.RazonSocial +'?'
                      , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
       begin
         DM_Proveedores.Borrar(pantBus.idProveedor);
       end;
  finally
    pantBus.Free;
  end;
end;

(*******************************************************************************
*** TRANSPORTISTAS
*******************************************************************************)

procedure TfrmMain.pantallaTransportistas(ID: GUID_ID);
var
 pant: TfrmTransportistasAE;
begin
  pant:= TfrmTransportistasAE.Create(self);
  try
    pant.idTransportista := ID;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmMain.tranNuevoExecute(Sender: TObject);
begin
  pantallaTransportistas(GUIDNULO);
end;


procedure TfrmMain.tranEditarExecute(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(self);
  try
    pantBus.restringirTipo:= IDX_TRANSPORTISTA;
    if (pantBus.ShowModal = mrOK) and (pantBus.idTransportista <> GUIDNULO)then
     pantallaTransportistas(pantBus.idTransportista);
  finally
    pantBus.Free;
  end;
end;

procedure TfrmMain.tranBorrarExecute(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(self);
  try
    pantBus.restringirTipo:= IDX_TRANSPORTISTA;
    if (pantBus.ShowModal = mrOK) and (pantBus.idTransportista <> GUIDNULO)then
      if (MessageDlg ('ATENCION'
                      , 'Borro el transportista: '+pantBus.RazonSocial +'?'
                      , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
       begin
         DM_Transportistas.Borrar(pantBus.idTransportista);
       end;
  finally
    pantBus.Free;
  end;
end;

(*******************************************************************************
*** VENDEDORES
*******************************************************************************)

procedure TfrmMain.pantallaVendedores(ID: GUID_ID);
var
 pant: TfrmVendedoresAE;
begin
  pant:= TfrmVendedoresAE.Create(self);
  try
    pant.idVendedor := ID;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmMain.vendNuevoExecute(Sender: TObject);
begin
  pantallaVendedores(GUIDNULO);
end;

procedure TfrmMain.vendEditarExecute(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(self);
  try
    pantBus.restringirTipo:= IDX_VENDEDOR;
    if (pantBus.ShowModal = mrOK) and (pantBus.idVendedor <> GUIDNULO)then
     pantallaVendedores(pantBus.idVendedor);
  finally
    pantBus.Free;
  end;
end;

procedure TfrmMain.vendBorrarExecute(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(self);
  try
    pantBus.restringirTipo:= IDX_VENDEDOR;
    if (pantBus.ShowModal = mrOK) and (pantBus.idVendedor <> GUIDNULO)then
      if (MessageDlg ('ATENCION'
                      , 'Borro el vendedor: '+pantBus.RazonSocial +'?'
                      , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
       begin
         DM_Vendedores.Borrar(pantBus.idVendedor);
       end;
  finally
    pantBus.Free;
  end;
end;

(*******************************************************************************
*** PEDIDOS
*******************************************************************************)

procedure TfrmMain.pantallaPedidos(ID: GUID_ID);
var
 pant: TfrmPedidoAE;
begin
  pant:= TfrmPedidoAE.Create(self);
  try
    pant.idPedido := ID;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmMain.pedNuevoExecute(Sender: TObject);
begin
  pantallaPedidos(GUIDNULO);
end;

procedure TfrmMain.pedModificarExecute(Sender: TObject);
var
 pant: TfrmPedidosBusqueda;
begin
  pant:= TfrmPedidosBusqueda.Create(self);
  try
    if pant.ShowModal = mrOK then
    begin
      pantallaPedidos(pant.idPedidoSeleccionado);
    end;
  finally
    pant.Free;
  end;
end;



procedure TfrmMain.pedDevolucionExecute(Sender: TObject);
var
 pant: TfrmDevolucionesae;
begin
  pant:= TfrmDevolucionesae.Create(self);
  try
    if pant.ShowModal = mrOK  then
     RefrescarGrilla;
  finally
    pant.Free;
  end;
end;


(*******************************************************************************
*** MOVIMIENTOS DE STOCK
*******************************************************************************)
procedure TfrmMain.pantallaMovimientosStock(ID: GUID_ID);
var
  pant: TfrmMovimientosStockAE;
begin
  pant:= TfrmMovimientosStockAE.Create(self);
  try
    pant.idMovimientoStock:= ID;
    if pant.ShowModal = mrOK then
    begin
      RefrescarGrilla;
    end;
  finally
    pant.Free;
  end;

end;

procedure TfrmMain.stkNuevoExecute(Sender: TObject);
begin
  pantallaMovimientosStock (GUIDNULO);
end;

procedure TfrmMain.stkEditarExecute(Sender: TObject);
var
 pant: TfrmBusquedaMovimientosStock;
begin
  pant:= TfrmBusquedaMovimientosStock.Create(self);
  try
    if pant.ShowModal = mrOK then
    begin
      pantallaMovimientosStock(pant.idMovStockSeleccionado);
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmMain.stkRecalcularTodoExecute(Sender: TObject);
begin
  if (MessageDlg ('AVISO'
                  , 'Está por ejecutar un proceso que puede demorar varios minutos. Desea continuar?'
                  , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
     DM_Stock.RecalcularStockCompleto;
     ShowMessage('Proceso de recálculo del Stock completo');
     RefrescarGrilla;
  end;
end;


(*******************************************************************************
*** PRECIOS
*******************************************************************************)

procedure TfrmMain.prodPreciosModificarExecute(Sender: TObject);
var
 pant: TfrmModificarPrecios;
begin
  pant:= TfrmModificarPrecios.Create(self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

(*******************************************************************************
*** FILTRADO DE GRILLA
*******************************************************************************)

procedure TfrmMain.edFiltroCodigoKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Filtrado:= codigo;
    RefrescarGrilla;
  end;
end;

procedure TfrmMain.edFiltroNombreKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
  begin
    Filtrado:= nombre;
    RefrescarGrilla;
  end;
end;

procedure TfrmMain.btnFiltradoQuitarClick(Sender: TObject);
begin
  Filtrado:= nulo;
  RefrescarGrilla;
end;

procedure TfrmMain.ckRefrescarGrillaChange(Sender: TObject);
begin
  tRefrescarGrilla.Enabled:= ckRefrescarGrilla.Checked;
end;

procedure TfrmMain.tRefrescarGrillaTimer(Sender: TObject);
begin
  RefrescarGrilla;
end;

procedure TfrmMain.GrillaDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
const
  clPaleRoja =   TColor($0000FF);
begin
 with DM_Productos do
  begin
   if (DM_Productos.qGrillaPrincipalDISPONIBLE.AsFloat <
       DM_Productos.qGrillaPrincipalMINIMO.AsFloat) then
       Grilla.canvas.brush.color := clPaleRoja;

   Grilla.Canvas.FillRect(Rect);
   Grilla.DefaultDrawColumnCell(rect,DataCol,Column,State)
  end;
end;


(*******************************************************************************
*** HOJAS DE RUTA
*******************************************************************************)
procedure TfrmMain.pantallaHojaDeRuta(ID: GUID_ID);
var
 pant: TfrmHojaDeRutaAE;
begin
  pant:= TfrmHojaDeRutaAE.Create(self);
  try
    pant.HojaDeRutaID:= ID;
    if pant.ShowModal = mrOK then
    begin

    end;
  finally
    pant.Free;
  end;
end;


procedure TfrmMain.HrRNuevaExecute(Sender: TObject);
begin
  pantallaHojaDeRuta(GUIDNULO);
end;


procedure TfrmMain.HdRModificarExecute(Sender: TObject);
var
 pantBus: TfrmBuscarHdR;
begin
  pantBus:= TfrmBuscarHdR.Create(self);
  try
    if (pantBus.ShowModal = mrOK)
      and (pantBus.idHojaDeRuta <> GUIDNULO) then
    begin
      pantallaHojaDeRuta(pantBus.idHojaDeRuta);
    end;
  finally
    pantBus.Free;
  end;
end;


end.

