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
  SECCION_FI = 'FACTURA_IMPRESA';

  SERVIDOR_FB = 'RUTA_FB';  //Ruta al archivo de BD
  BASE_HOST='HOST';         //Dirección IP del HOST

  DIR_SERVIDOR = 'SERVIDOR';        //Ruta al archivo ejecutable
  RUTA_SERV_FE = 'SERV_FE'; //SERVIDOR Factura Electrónica
  RUTA_SERV_ARCON = 'SERV_ARCON'; //Servidor de facturación ARCON
  RUTA_LISTADOS = 'RUTA_LISTADOS';

  CFG_SEP_DECIMAL = 'SEP_DECIMAL';
  CFG_SEP_MILES='SEP_MILES';
  CFGD_IVA_PROD='IVA_PROD';
  CFGD_IVA_ID='IVA_ID';
  CFG_PTO_VTA = 'PTA_VTA';
  ART_BULTOS='ART_BULTOS'; //Se trata a cada artículo como un bulto
  PG_DESTINO='PG_DESTINO'; //Pone por default si el pago se hace en destino
  CFG_ES_SERVICIO = 'VTA_SERVICIO'; //Comprobante Vta es servicio
  CFG_ES_PRODUCTO = 'VTA_PRODUCTO'; //Comprobante Vta es producto

  //Factura Impresa
  FI_LOGO = 'FI_LOGO';
  FI_RAZON_SOCIAL = 'FI_RAZON_SOCIAL';
  FI_DOMICILIO = 'FI_DOMICILIO';
  FI_CONDICION_IVA = 'FI_CONDICION_IVA';
  FI_CUIT = 'FI_CUIT';
  FI_IB = 'FI_IB';
  FI_INIACT = 'FI_INIACT';
  FI_FACTURA = 'FI_FACTURA';


  PROD_BUS_CRIT = 'P_BUS_CRIT';
  LOCALIDAD = 'LOCALIDAD'; //Localidad por defecto para los domicilios
  CHK_REF_GRID = 'REFRESCAR_GRILLA';



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
