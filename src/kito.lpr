program kito;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, rxnew, zcomponent, frm_main, dmgeneral, SD_Configuracion, versioninfo,
  frm_productoae, dmproductos, dmediciontugs, frm_ediciontugs,
frm_busquedaProductos, frm_precioae, dmprecios
  { you can add units after this };

{$R *.res}

begin
  Application.Title:='Kito';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TDM_General, DM_General);
  Application.CreateForm(TDM_Precios, DM_Precios);
  Application.CreateForm(TDM_Productos, DM_Productos);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

