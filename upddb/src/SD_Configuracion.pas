unit SD_Configuracion;

interface
uses
  IniFiles;

const
  ARCHIVO_CFG= 'programa.cfg';
  ERROR_APERTURA_CFG= 'ErrorAperturaCFG';
  ERROR_CFG= 'ErrorLecturaCFG';

  SECCION_APP = 'APLICACION';
  SECCION_SCR = 'PANTALLAS';

  SERVIDOR_FB = 'RUTA_FB';  //Ruta al archivo de BD
  BASE_HOST='HOST';         //Dirección IP del HOST

  DIR_SERVIDOR = 'SERVIDOR';        //Ruta al archivo ejecutable



  function AbrirArchivo: TIniFile;
  function LeerDato (Clave, Etiqueta: string): string;
  procedure EscribirDato (Clave, Etiqueta, Dato: string);


implementation

uses
  SysUtils
  ,forms, Dialogs
  ;

function AbrirArchivo: TIniFile;
begin
  Result:= TiniFile.Create(ExtractFilePath(Application.ExeName) + ARCHIVO_CFG);
end;

function LeerDato (Clave, Etiqueta: string): string;
var
 elArchivo: TIniFile;
begin
   elArchivo:=  AbrirArchivo;
   try
    if (elArchivo <> nil) and (FileExists(elArchivo.FileName))  then
      Result:= elArchivo.ReadString(Clave,Etiqueta, ERROR_CFG)
    else
    begin
     Result:= ERROR_APERTURA_CFG;
    end;
  finally
    elArchivo.Free;
  end;
end;


procedure EscribirDato (Clave, Etiqueta, Dato: string);
var
 elArchivo: TIniFile;
begin
   elArchivo:=  AbrirArchivo;
   try
    if (elArchivo <> nil) and (FileExists(elArchivo.FileName))  then
      elArchivo.WriteString(Clave,Etiqueta, Dato)
  finally
    elArchivo.Free;
  end;
end;


end.
