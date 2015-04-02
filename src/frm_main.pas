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
    prodEditar: TAction;
    prodBorrar: TAction;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    prodNuevo: TAction;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    prgSalir: TAction;
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    st: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure FormShow(Sender: TObject);
    procedure prgSalirExecute(Sender: TObject);
    procedure prodNuevoExecute(Sender: TObject);
  private
     procedure Inicializar;
     procedure pantallaProducto (ID: GUID_ID);
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


end.

