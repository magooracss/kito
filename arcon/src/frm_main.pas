unit frm_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ActnList, Menus, DBGrids
  , dmgeneral;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    MenuItem23: TMenuItem;
    movVerBorrarAsientosManuales: TAction;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    movAsientoManualIns: TAction;
    cliBorrar: TAction;
    cliEditar: TAction;
    cliAgregar: TAction;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    movCompraEditar: TAction;
    movOPEditar: TAction;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    movVentaEditar: TAction;
    lstCuentaCorriente: TAction;
    MenuItem10: TMenuItem;
    MenuItem9: TMenuItem;
    movOrdenPago: TAction;
    factImpresion: TAction;
    MenuItem8: TMenuItem;
    prgModificarFactura: TAction;
    MenuItem7: TMenuItem;
    prgModificarReporte: TAction;
    prgFacturar: TAction;
    movCompra: TAction;
    movVenta: TAction;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    PrgSalir: TAction;
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    st: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure cliAgregarExecute(Sender: TObject);
    procedure cliBorrarExecute(Sender: TObject);
    procedure cliEditarExecute(Sender: TObject);
    procedure factImpresionExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lstCuentaCorrienteExecute(Sender: TObject);
    procedure movAsientoManualInsExecute(Sender: TObject);
    procedure movCompraEditarExecute(Sender: TObject);
    procedure movCompraExecute(Sender: TObject);
    procedure movOPEditarExecute(Sender: TObject);
    procedure movOrdenPagoExecute(Sender: TObject);
    procedure movVentaEditarExecute(Sender: TObject);
    procedure movVentaExecute(Sender: TObject);
    procedure movVerBorrarAsientosManualesExecute(Sender: TObject);
    procedure prgFacturarExecute(Sender: TObject);
    procedure prgModificarFacturaExecute(Sender: TObject);
    procedure prgModificarReporteExecute(Sender: TObject);
    procedure PrgSalirExecute(Sender: TObject);
  private
    procedure PantallaVentas (idVenta: GUID_ID);
    procedure PantallaCompras (refCompra: GUID_ID);
    procedure PantallaOrdenesPago (refOP: GUID_ID);
    procedure PantallaAsientos (refAsiento: GUID_ID);
    procedure Inicializar;

    procedure PantallaClientes (refID: GUID_ID);
    procedure BuscarComprobante (var ResultadoID: GUID_ID; var tipoID: integer);
  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
{$R *.lfm}
uses
    versioninfo
  , frm_ventaae
  , SD_Configuracion
  , process
  , dmfacturas
  , frm_impresioncomprobantes
  , frm_comprasae
  , frm_ordendepagoae
  , frm_listadocc
  , frm_clientesae
  , frm_busquedaempresas
  , dmclientes
  , frm_asientomanualae
  , frm_listadoasientosmanuales
  ;

{ TfrmMain }

procedure TfrmMain.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmMain.PrgSalirExecute(Sender: TObject);
begin
  Application.Terminate;
end;


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

procedure TfrmMain.prgModificarReporteExecute(Sender: TObject);
begin
  DM_General.LevantarReporte('blanco.lrf', DM_General.qTugDesc);
  DM_General.EditarReporte;
end;


procedure TfrmMain.prgModificarFacturaExecute(Sender: TObject);
begin
  Application.CreateForm(TDM_Facturas, DM_Facturas);
  try
    DM_General.LevantarFactura(DM_Facturas.Cabecera);
    DM_General.EditarReporte;
  finally
    DM_Facturas.Free;
  end;

end;

(*******************************************************************************
*** Asientos manuales
*******************************************************************************)
procedure TfrmMain.PantallaAsientos(refAsiento: GUID_ID);
var
  pant: TfrmAsientoManualAE;
begin
  pant:= TfrmAsientoManualAE.Create(self);
  try
    pant.asientoID:= refAsiento;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmMain.movAsientoManualInsExecute(Sender: TObject);
begin
  PantallaAsientos(GUIDNULO);
end;


procedure TfrmMain.movVerBorrarAsientosManualesExecute(Sender: TObject);
var
  pant: TfrmListadoAsientosManuales;
begin
  pant:= TfrmListadoAsientosManuales.Create(self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;


(*******************************************************************************
*** Búsqueda genérica de comprobantes
*******************************************************************************)


procedure TfrmMain.BuscarComprobante(var ResultadoID: GUID_ID;
  var tipoID: integer);
var
  pant: TfrmListadoCC;
begin
  pant:= TfrmListadoCC.Create(self);
  try
    pant.modoBusqueda:= true;
    pant.tipoSeleccion:= tipoID;
    if pant.ShowModal = mrOK then
    begin
     ResultadoID:= pant.seleccionID;
     tipoID:= tipoID;
    end
    else
      ResultadoID:= GUIDNULO;
  finally
    pant.Free;
  end;
end;



(*******************************************************************************
*** VENTAS
*******************************************************************************)
procedure TfrmMain.PantallaVentas(idVenta: GUID_ID);
var
  pant: TfrmVentasAE;
begin
  pant:= TfrmVentasAE.Create(self);
  try
    pant.ventaID:= idVenta;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;


procedure TfrmMain.movVentaExecute(Sender: TObject);
begin
  PantallaVentas(GUIDNULO);
end;

procedure TfrmMain.movVentaEditarExecute(Sender: TObject);
var
  pant: TfrmImpresionComprobantes;
begin
  pant:= TfrmImpresionComprobantes.Create(self);
  try
    pant.seleccion:= true;
    if ((pant.ShowModal = mrOK) and (pant.seleccionID <> GUIDNULO)) then
     PantallaVentas(pant.seleccionID);
  finally
    pant.Free;
  end;
end;


(*******************************************************************************
*** COMPRAS
*******************************************************************************)
procedure TfrmMain.PantallaCompras(refCompra: GUID_ID);
var
  pant: TfrmComprasAE;
begin
  pant:= TfrmComprasAE.Create(self);
  try
    pant.compraID:= refCompra;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmMain.movCompraExecute(Sender: TObject);
begin
  PantallaCompras(GUIDNULO);
end;

procedure TfrmMain.movCompraEditarExecute(Sender: TObject);
var
  resultado: GUID_ID;
  tipo: integer;
begin
  tipo:= INC_COMPRAS;
  resultado:= GUIDNULO;
  BuscarComprobante(resultado, tipo);
  if ((resultado <> GUIDNULO) and (tipo = INC_COMPRAS)) then
   PantallaCompras(resultado);
end;


(*******************************************************************************
*** FACTURAR
*******************************************************************************)
procedure TfrmMain.prgFacturarExecute(Sender: TObject);
var
  archivo: string;
  AProcess: TProcess;
begin

  archivo:= LeerDato(SECCION_APP, RUTA_SERV_FE);

  if FileExists(archivo) then
  begin
   AProcess := TProcess.Create (nil);
   AProcess.CommandLine  :=  archivo;
   AProcess.Options  := AProcess.Options + [poWaitOnExit] ;
   AProcess.Execute;
   AProcess.Free;
  end
  else
   ShowMessage('No se encuentra el módulo de facturación: ' + archivo);
end;

procedure TfrmMain.factImpresionExecute(Sender: TObject);
var
  pant: TfrmImpresionComprobantes;
begin
  pant:= TfrmImpresionComprobantes.Create(self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;


(*******************************************************************************
*** ORDENES DE PAGO
*******************************************************************************)
procedure TfrmMain.PantallaOrdenesPago(refOP: GUID_ID);
var
  pant: TfrmOrdenDePagoAE;
begin
  pant:= TfrmOrdenDePagoAE.Create(self);
  try
    pant.ordenPagoID:= refOP;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;


procedure TfrmMain.movOrdenPagoExecute(Sender: TObject);
begin
  PantallaOrdenesPago(GUIDNULO);
end;

procedure TfrmMain.movOPEditarExecute(Sender: TObject);
var
  resultado: GUID_ID;
  tipo: integer;
begin
  tipo:= INC_OP;
  resultado:= GUIDNULO;
  BuscarComprobante(resultado, tipo);
  if ((resultado <> GUIDNULO) and (tipo = INC_OP)) then
   PantallaOrdenesPago(resultado);
end;

(*******************************************************************************
*** Clientes
*******************************************************************************)
procedure TfrmMain.PantallaClientes(refID: GUID_ID);
var
  pant: TfrmClientesAE;
begin
  pant:= TfrmClientesAE.Create(self);
  try
    pant.idCliente:= refID;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmMain.cliAgregarExecute(Sender: TObject);
begin
  PantallaClientes(GUIDNULO);
end;
procedure TfrmMain.cliEditarExecute(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(self);
  try
    pantBus.restringirTipo:= IDX_CLIENTE;
    if pantBus.ShowModal = mrOK then
      PantallaClientes(pantBus.idCliente);
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
    if pantBus.ShowModal = mrOK then
    if (MessageDlg ('Confirmación'
                     , 'Desea eliminar a ' + pantBus.RazonSocial +' de la base de datos?'
                      , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
       DM_Clientes.Borrar(pantBus.idCliente);
  finally
    pantBus.Free;
  end;
end;


(*******************************************************************************
*** Listados
*******************************************************************************)
procedure TfrmMain.lstCuentaCorrienteExecute(Sender: TObject);
var
  pant: TfrmListadoCC;
begin
  pant:= TfrmListadoCC.Create(self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;



end.

