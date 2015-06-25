unit frm_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZConnection, ZSqlProcessor, Forms, Controls,
  Graphics, Dialogs, StdCtrls, ExtCtrls, Buttons;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    btnCargar: TBitBtn;
    btnEjecutar: TBitBtn;
    cnxBase: TZConnection;
    instrucciones: TMemo;
    OD: TOpenDialog;
    Panel1: TPanel;
    Procesador: TZSQLProcessor;
    procedure btnCargarClick(Sender: TObject);
    procedure btnEjecutarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure AbrirConexion;
    procedure Inicializar;
    procedure Ejecutar;
  public
    { public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
{$R *.lfm}
uses
  SD_Configuracion;

{ TfrmMain }

procedure TfrmMain.btnCargarClick(Sender: TObject);
begin
  if OD.Execute then
   instrucciones.Lines.LoadFromFile(OD.FileName);
end;

procedure TfrmMain.btnEjecutarClick(Sender: TObject);
var
 elLog: TextFile;
 elArchivo: string;
begin
  elArchivo:= ExtractFilePath(Application.ExeName) + 'upddb.log';
  AssignFile(elLog, elArchivo);
  if FileExists(elArchivo) then
    Append(elLog)
  else
    Rewrite(elLog);
  try
   WriteLn(elLog, DateTimeToStr(Now) + ' <<<<<<<<<<<<<<<<<< INICIO EJECUCION >>>>>>>>>>>>>>>>>>>');
   WriteLn(elLog, instrucciones.Lines.Text);
   CloseFile(elLog);
   ejecutar;
   Application.Terminate;
  except
    on E: Exception do
    begin
      AssignFile(elLog, elArchivo);
      if FileExists(elArchivo) then
        Append(elLog)
      else
        Rewrite(elLog);
      WriteLn(elLog,' ----------------- Ruta a la Base: ' + cnxBase.Database);
      WriteLn(elLog, E.Message);
      WriteLn(elLog, DateTimeToStr(Now) + '<<<<<<<<<<<<<<<<<< FIN CON ERROR >>>>>>>>>>>>>>>>>>>');
      CloseFile(elLog);
      ShowMessage ('ERROR: ' + E.Message);
    end;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmMain.AbrirConexion;
var
 base: string;
 host: string;
begin
  if cnxBase.Connected then
   cnxBase.Disconnect;

  base:= LeerDato (SECCION_APP ,SERVIDOR_FB) ;
  if ((base <>  ERROR_APERTURA_CFG)
      and (base <> ERROR_CFG)) then
  begin
    base := base;
    host:= LeerDato (SECCION_APP, BASE_HOST);
    try
      with cnxBase do
      begin
        Database:=  base;
        HostName:= host;
        Connect;
      end;
    except
      Exception.Create('Error abriendo la base de datos');
    end;
  end
  else
    Exception.Create('Error abriendo la base de datos desde CFG');
end;

procedure TfrmMain.Inicializar;
var
  archivo: string;
begin
  AbrirConexion;
  archivo:= TRIM(ParamStr(1));
  if ((archivo <> EmptyStr) and (FileExists(archivo))) then
  begin
    instrucciones.Lines.LoadFromFile(archivo);
    Ejecutar;
    Application.ProcessMessages;
    Application.Terminate;
  end;
end;

procedure TfrmMain.Ejecutar;
begin
  if instrucciones.Lines.Count > 0 then
  begin
    procesador.Script:= instrucciones.Lines;
    procesador.Execute;
 end;
end;

end.

