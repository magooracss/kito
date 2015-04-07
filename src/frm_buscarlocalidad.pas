unit frm_buscarlocalidad;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, DBGrids, dmempresa;

type

  { TfrmBuscarLocalidad }

  TfrmBuscarLocalidad = class(TForm)
    btnCancelar: TBitBtn;
    btnAceptar: TBitBtn;
    GrillaResultados: TDBGrid;
    ds_busLocalidad: TDataSource;
    edNombre: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure edNombreKeyPress(Sender: TObject; var Key: char);
  private
    function getLocalidad: integer;
    { private declarations }
  public
    property idLocalidad: integer read getLocalidad;
  end;

var
  frmBuscarLocalidad: TfrmBuscarLocalidad;

implementation

{$R *.lfm}

{ TfrmBuscarLocalidad }

procedure TfrmBuscarLocalidad.edNombreKeyPress(Sender: TObject; var Key: char);
begin
  // if Key = #13 then
   begin
     DM_Empresa.BuscarLocalidadNombre (Trim(edNombre.Text));
   end;
end;

procedure TfrmBuscarLocalidad.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmBuscarLocalidad.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

function TfrmBuscarLocalidad.getLocalidad: integer;
begin
  if ds_busLocalidad.DataSet.Active then
    Result:= DM_Empresa.qLocalidadPorNombreID.AsInteger
  else
    Result:= 0;
end;

end.

