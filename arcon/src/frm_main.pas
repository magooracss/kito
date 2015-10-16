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
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    procedure factImpresionExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure movCompraExecute(Sender: TObject);
    procedure movVentaExecute(Sender: TObject);
    procedure prgFacturarExecute(Sender: TObject);
    procedure prgModificarFacturaExecute(Sender: TObject);
    procedure prgModificarReporteExecute(Sender: TObject);
    procedure PrgSalirExecute(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
  private
    procedure PantallaVentas (idVenta: GUID_ID);
    procedure PantallaCompras (refCompra: GUID_ID);
    procedure Inicializar;
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

procedure TfrmMain.ToolButton7Click(Sender: TObject);
begin
  Application.CreateForm(TDM_Facturas, DM_Facturas);
  try
    DM_Facturas.ImprimirFactura('{A764B110-1DD9-4624-AF6C-1FB30339E311}');
    DM_Facturas.elReporte.DesignReport;
  finally
    DM_Facturas.Free;
  end;
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


end.

