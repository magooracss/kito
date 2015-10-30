unit frm_listadocc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, Forms, Controls, Graphics, Dialogs,
  ExtCtrls;

type

  { TfrmListadoCC }

  TfrmListadoCC = class(TForm)
    ds_listadoCC: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    RxDBGrid1: TRxDBGrid;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmListadoCC: TfrmListadoCC;

implementation
{$R *.lfm}
uses
  dmcuentacorriente
  ;

{ TfrmListadoCC }

procedure TfrmListadoCC.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  DM_CuentaCorriente.Free;
end;

procedure TfrmListadoCC.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_CuentaCorriente, DM_CuentaCorriente);
end;


end.

