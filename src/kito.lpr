program kito;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, rxnew, zcomponent, frm_main, dmgeneral, SD_Configuracion, versioninfo,
  frm_productoae, dmproductos, dmediciontugs, frm_ediciontugs,
  frm_busquedaProductos, frm_precioae, dmprecios, fra_empresa, dmempresa,
  frm_clientesae, frm_contactoae, dmclientes, frm_domicilioae,
  frm_localidadesae, frm_buscarlocalidad, frm_busquedaempresas, 
dmbusquedaempresas, frm_proveedoresae, dmproveedores;

{$R *.res}

begin
  Application.Title:='Kito';
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TDM_General, DM_General);
  Application.CreateForm(TDM_Precios, DM_Precios);
  Application.CreateForm(TDM_Productos, DM_Productos);
  Application.CreateForm(TDM_Empresa, DM_Empresa);
  Application.CreateForm(TDM_Clientes, DM_Clientes);
  Application.CreateForm(TDM_Proveedores, DM_Proveedores);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

