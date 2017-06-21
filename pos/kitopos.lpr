program kitopos;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, rxnew, datetimectrls, zcomponent, frm_main
  { you can add units after this }
  ,dmgeneral, dmproductos, frm_productoae, frm_ediciontugs, dmediciontugs,
  frm_precioae, dmprecios, frm_coloresae, dmcolores, dmclientes, dmempresa,
  dmproveedores, frm_clientesae, dmcajamovimientos, frm_cajadiaria, 
frm_cajamovimientoae, rpt_movimentoscaja;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TDM_General, DM_General);
  Application.CreateForm(TDM_Productos, DM_Productos);
  Application.CreateForm(TDM_Empresa, DM_Empresa);
  Application.CreateForm(TDM_Clientes, DM_Clientes);
  Application.CreateForm(TDM_Proveedores, DM_Proveedores);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmMovimientoCajaAE, frmMovimientoCajaAE);
  Application.CreateForm(Trpt, rpt);
  Application.Run;
end.

