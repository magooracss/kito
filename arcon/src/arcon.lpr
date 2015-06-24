program arcon;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, rxnew, datetimectrls, zcomponent, frm_main, dmgeneral
  ,frm_ventaae, dmventas
  { you can add units after this }
  , dmclientes, dmempresa, dmseleccionarpedidos, frm_seleccionarpedidos,
  dmpedidos, frm_ventaconceptosae;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TDM_General, DM_General);
  Application.CreateForm(TDM_Empresa, DM_Empresa);
  Application.CreateForm(TDM_Clientes, DM_Clientes);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

