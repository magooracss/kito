unit frm_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ActnList, Menus
  ,dmgeneral
  ;

type

  { TfrmMain }

  TfrmMain = class(TForm)
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
    procedure cliBorrarExecute(Sender: TObject);
    procedure cliEditarExecute(Sender: TObject);
    procedure cliNuevoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure prgSalirExecute(Sender: TObject);
    procedure prodBorrarExecute(Sender: TObject);
    procedure prodEditarExecute(Sender: TObject);
    procedure prodNuevoExecute(Sender: TObject);
    procedure provBorrarExecute(Sender: TObject);
    procedure provEditarExecute(Sender: TObject);
    procedure provNuevoExecute(Sender: TObject);
    procedure tranBorrarExecute(Sender: TObject);
    procedure tranEditarExecute(Sender: TObject);
    procedure tranNuevoExecute(Sender: TObject);
  private
     procedure Inicializar;
     procedure pantallaProducto (ID: GUID_ID);
     procedure pantallaCliente (ID: GUID_ID);
     procedure pantallaProveedores(ID: GUID_ID);
     procedure pantallaTransportistas(ID: GUID_ID);
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
end;


procedure TfrmMain.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmMain.prgSalirExecute(Sender: TObject);
begin
  Application.Terminate;
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



end.

