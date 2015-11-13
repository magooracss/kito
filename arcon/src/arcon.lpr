program arcon;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, rxnew, datetimectrls, rx, zcomponent, frm_main, dmgeneral
  ,frm_ventaae, dmventas
  { you can add units after this }
  , dmclientes, dmempresa, dmseleccionarpedidos, frm_seleccionarpedidos,
  dmpedidos, dmprecios, SD_Configuracion, frm_proveedoresae,
  frm_ventaconceptosae, dmfacturaelectronica, dmfacturas,
  frm_impresioncomprobantes, frm_comprasae, dmcompras, frm_compraitemsae,
  dmproveedores, dmbusquedaempresas, frm_ordendepagoae, dmordendepago,
  frm_busquedacompras, frm_formaspagoae, dmcompensaciones,
  frm_distribuirdinerocomprobantes, frm_listadocc, dmcuentacorriente;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TDM_General, DM_General);
  Application.CreateForm(TDM_Empresa, DM_Empresa);
  Application.CreateForm(TDM_Clientes, DM_Clientes);
  Application.CreateForm(TDM_Pedidos, DM_Pedidos);
  Application.CreateForm(TDM_Proveedores, DM_Proveedores);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

