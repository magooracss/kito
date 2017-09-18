unit frm_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  Menus, ActnList
  ,dmgeneral;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    listados: TAction;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    merc_MovStock: TAction;
    MenuItem25: TMenuItem;
    merc_VentaAE: TAction;
    dinCajaDiaria: TAction;
    MenuItem24: TMenuItem;
    provEdit: TAction;
    provDel: TAction;
    provNew: TAction;
    cliDel: TAction;
    cliNew: TAction;
    cliEdit: TAction;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    prg_Config: TAction;
    prg_UpdateBD: TAction;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    prod_Del: TAction;
    prod_Edit: TAction;
    prod_New: TAction;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    prg_About: TAction;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    prg_Exit: TAction;
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    st: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure cliDelExecute(Sender: TObject);
    procedure cliEditExecute(Sender: TObject);
    procedure cliNewExecute(Sender: TObject);
    procedure dinCajaDiariaExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure listadosExecute(Sender: TObject);
    procedure merc_MovStockExecute(Sender: TObject);
    procedure merc_VentaAEExecute(Sender: TObject);
    procedure prg_AboutExecute(Sender: TObject);
    procedure prg_ConfigExecute(Sender: TObject);
    procedure prg_ExitExecute(Sender: TObject);
    procedure prg_UpdateBDExecute(Sender: TObject);
    procedure prod_DelExecute(Sender: TObject);
    procedure prod_EditExecute(Sender: TObject);
    procedure prod_NewExecute(Sender: TObject);
    procedure provDelExecute(Sender: TObject);
    procedure provEditExecute(Sender: TObject);
    procedure provNewExecute(Sender: TObject);
  private
    procedure ScreenProd (refProd: GUID_ID);
    procedure EjecutarPRG(programa: string);
    procedure ScreenCliente (refCliente: GUID_ID);
    procedure ScreenProveedores (refProveedor: GUID_ID);
    procedure ScreenVentas (refVenta: GUID_ID);
  public
    procedure Initialise;
  end;

var
  frmMain: TfrmMain;

implementation
{$R *.lfm}
uses
    process
,   versioninfo
,   frm_about
,   frm_productoae
,   frm_busquedaProductos
,   dmproductos
,   frm_clientesae
,   dmclientes
,   frm_busquedaempresas
,   frm_proveedoresae
,   dmproveedores
,   frm_cajadiaria
,   frm_ventaae
,   frm_movimientoStock
,   frm_listados
;

{ TfrmMain }

(******************************************************************************
*** PROGRAMA
******************************************************************************)

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Initialise;
end;

procedure TfrmMain.prg_AboutExecute(Sender: TObject);
var
  scr: TfrmAbout;
begin
  scr:= TfrmAbout.Create(self);
  try
    scr.ShowModal;
  finally
    scr.Free;
  end;
end;


procedure TfrmMain.prg_ExitExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.Initialise;
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

  st.Panels[0].Text:= '  v:' + NroVersion;
  st.Panels[1].Text:= FormatDateTime('dd/mm/yyyy', now)+ '        ';
end;


procedure TfrmMain.EjecutarPRG(programa: string);
var
  archivo: string;
  AProcess: TProcess;
begin
  archivo:= ExtractFilePath(Application.ExeName) + '\' + programa;
  if FileExists(archivo) then
  begin
   AProcess := TProcess.Create (nil);
   AProcess.CommandLine  :=  archivo;
   AProcess.Options  := AProcess.Options + [poWaitOnExit] ;
   AProcess.Execute;
   AProcess.Free;
  end
  else
   ShowMessage('No se encuentra el módulo: ' + programa);
end;

procedure TfrmMain.prg_ConfigExecute(Sender: TObject);
begin
  EjecutarPRG('configurador.exe');
end;

procedure TfrmMain.prg_UpdateBDExecute(Sender: TObject);
begin
  EjecutarPRG('upddb.exe');
end;


(******************************************************************************
*** PRODUCTOS
******************************************************************************)
procedure TfrmMain.ScreenProd(refProd: GUID_ID);
var
  scr: TfrmProductoAE;
begin
  scr:= TfrmProductoAE.Create(self);
  try
    scr.idProducto:= refProd;
    if scr.ShowModal = mrOK then
    begin
      ShowMessage('Refrescar grilla');
    end;
  finally
    scr.Free;
  end;
end;

procedure TfrmMain.prod_NewExecute(Sender: TObject);
begin
  ScreenProd(GUIDNULO);
end;

procedure TfrmMain.prod_EditExecute(Sender: TObject);
var
  scr: TfrmBusquedaProducto;
  scrProd: TfrmProductoAE;
begin
  scr:= TfrmBusquedaProducto.Create(self);
  scrProd:= TfrmProductoAE.Create(self);
  try
    if scr.ShowModal = mrOK then
    begin
      scrProd.idProducto:= scr.productoSeleccionado;
      scrProd.ShowModal;
    end;
  finally
    scrProd.Free;
    scr.Free;
  end;
end;

procedure TfrmMain.prod_DelExecute(Sender: TObject);
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

(******************************************************************************
*** CLIENTES
******************************************************************************)
procedure TfrmMain.ScreenCliente(refCliente: GUID_ID);
var
 pant: TfrmClientesAE;
begin
  pant:= TfrmClientesAE.Create(self);
  try
    pant.idCliente := refCliente;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmMain.cliNewExecute(Sender: TObject);
begin
 ScreenCliente(GUIDNULO);
end;



procedure TfrmMain.cliEditExecute(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(self);
  try
    pantBus.restringirTipo:= IDX_CLIENTE;
    if (pantBus.ShowModal = mrOK) and (pantBus.idCliente <> GUIDNULO)then
     ScreenCliente(pantBus.idCliente);
  finally
    pantBus.Free;
  end;
end;

procedure TfrmMain.cliDelExecute(Sender: TObject);
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


(******************************************************************************
*** PROVEEDORES
******************************************************************************)
procedure TfrmMain.ScreenProveedores(refProveedor: GUID_ID);
var
 pant: TfrmProveedoresAE;
begin
  pant:= TfrmProveedoresAE.Create(self);
  try
    pant.idProveedor := refProveedor;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmMain.provNewExecute(Sender: TObject);
begin
  ScreenProveedores(GUIDNULO);
end;

procedure TfrmMain.provEditExecute(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(self);
  try
    pantBus.restringirTipo:= IDX_PROVEEDOR;
    if (pantBus.ShowModal = mrOK) and (pantBus.idProveedor <> GUIDNULO)then
     ScreenProveedores(pantBus.idProveedor);
  finally
    pantBus.Free;
  end;
end;

procedure TfrmMain.provDelExecute(Sender: TObject);
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

(******************************************************************************
*** DINERO
******************************************************************************)
procedure TfrmMain.dinCajaDiariaExecute(Sender: TObject);
var
  scr: TfrmCajaDiaria;
begin
  scr:= TfrmCajaDiaria.Create(self);
  try
    scr.ShowModal;
  finally
    scr.Free;
  end;
end;

(******************************************************************************
*** Mercadería
******************************************************************************)

procedure TfrmMain.ScreenVentas(refVenta: GUID_ID);
var
  scr: TfrmVentaAE;
begin
  scr:= TfrmVentaAE.Create(self);
  try
    scr.ShowModal;
  finally
    scr.Free;
  end;
end;

procedure TfrmMain.merc_VentaAEExecute(Sender: TObject);
begin
  ScreenVentas(GUIDNULO);
end;


procedure TfrmMain.merc_MovStockExecute(Sender: TObject);
var
  scr: TfrmMovimientoStock;
begin
  scr:= TfrmMovimientoStock.Create(self);
  try
    scr.ShowModal
  finally
    scr.Free;
  end;
end;

(******************************************************************************
*** Listados
******************************************************************************)

procedure TfrmMain.listadosExecute(Sender: TObject);
var
  scr:TfrmListados;
begin
  scr:= TfrmListados.Create(self);
  try
    scr.ShowModal;
  finally
    scr.Free;
  end;
end;

end.

