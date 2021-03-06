program kito;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, rxnew, rx, datetimectrls, zcomponent, frm_main, dmgeneral,
  SD_Configuracion, versioninfo, frm_productoae, dmproductos, dmediciontugs,
  frm_ediciontugs, frm_busquedaProductos, frm_precioae, dmprecios, fra_empresa,
  dmempresa, frm_clientesae, frm_contactoae, dmclientes, frm_domicilioae,
  frm_localidadesae, frm_buscarlocalidad, frm_busquedaempresas,
  dmbusquedaempresas, frm_proveedoresae, dmproveedores, frm_transportistasae,
  dmtransportistas, frm_vendedoresae, dmvendedores, frm_pedidosae, dmpedidos,
  sysutils, frm_pedidoeditarproducto, frm_pedidosEstados, frm_pedidoestadosae,
  frm_pedidosbusqueda, dmbusquedapedidos, dmstock, frm_movimientosstockae,
  frm_EditarProductoMovimientoStock, frm_movimientosstockbusqueda,
  dmbusquedamovstock, frm_modificarprecios, dmmodificarprecios,
  frm_devolucionesae, dmdevoluciones, dmlistados, frm_listados,
  frm_hojaderutaae, dmhojaderuta, frm_seleccionarpedidos, dmseleccionarpedidos,
  frm_hojaderutapedido, frm_busquedahojaderuta, dmbusquedahojaderuta,
  frm_hojaderutapresentacion, dmhojaderutapresentacion,
  frm_hojaderutapresentarpedidos, frm_hojaderutapresentarpedido,
  frm_seleccionmotivonoentrega, dmrecibosinternos, frm_recibointernoae,
  frm_recibointernoconcepto, frm_recibointernocobros, frm_buscarrecibosinternos,
  dmbusquedarecibosinternos, rpt_etiquetas_hdr;

{$R *.res}

begin
  Application.Title:='Kito';

  sysutils.DecimalSeparator:=  (LeerDato(SECCION_APP,CFG_SEP_DECIMAL)[1]);
  sysutils.ThousandSeparator:= (LeerDato(SECCION_APP,CFG_SEP_MILES)[1]);

  RequireDerivedFormResource := True;

  Application.Initialize;
  Application.CreateForm(TDM_General, DM_General);
  Application.CreateForm(TDM_Precios, DM_Precios);
  Application.CreateForm(TDM_Productos, DM_Productos);
  Application.CreateForm(TDM_Stock, DM_Stock);
  Application.CreateForm(TDM_Empresa, DM_Empresa);
  Application.CreateForm(TDM_Clientes, DM_Clientes);
  Application.CreateForm(TDM_Proveedores, DM_Proveedores);
  Application.CreateForm(TDM_Transportistas, DM_Transportistas);
  Application.CreateForm(TDM_Vendedores, DM_Vendedores);
  Application.CreateForm(TDM_Pedidos, DM_Pedidos);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

