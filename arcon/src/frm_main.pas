unit frm_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  ActnList, Menus
  , dmgeneral;

type

  { TfrmMain }

  TfrmMain = class(TForm)
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
    procedure FormShow(Sender: TObject);
    procedure movVentaExecute(Sender: TObject);
    procedure PrgSalirExecute(Sender: TObject);
  private
    procedure PantallaVentas (idVenta: GUID_ID);
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
  ,frm_ventaae
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


end.

