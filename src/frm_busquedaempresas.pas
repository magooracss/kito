unit frm_busquedaempresas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls;

type

  { TfrmBusquedaEmpresas }

  TfrmBusquedaEmpresas = class(TForm)
    btnBuscar: TBitBtn;
    btnCancelar: TBitBtn;
    btnSeleccionar: TBitBtn;
    ckTipoEmpresa: TCheckGroup;
    DataSource1: TDataSource;
    edDatoBusqueda: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    RgCriterioBusqueda: TRadioGroup;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    function getIdCliente: GUID_ID;
    function getIdEmpresa: GUID_ID;
    { private declarations }
  public
    property idEmpresa: GUID_ID read getIdEmpresa;
    property idCliente: GUID_ID read getIdCliente;
  end;

var
  frmBusquedaEmpresas: TfrmBusquedaEmpresas;

implementation
 {$R *.lfm}
 uses
   dmbusquedaempresas
   ;

{ TfrmBusquedaEmpresas }

procedure TfrmBusquedaEmpresas.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_BusquedaEmpresas, DM_BusquedaEmpresas);
end;

function TfrmBusquedaEmpresas.getIdCliente: GUID_ID;
begin

end;

function TfrmBusquedaEmpresas.getIdEmpresa: GUID_ID;
begin

end;

procedure TfrmBusquedaEmpresas.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  DM_BusquedaEmpresas.Free;
end;

end.

