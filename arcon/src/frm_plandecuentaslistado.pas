unit frm_plandecuentaslistado;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DbCtrls, ZedDBTreeView, dmgeneral, dmplandecuentas;

type

  { TfrmPlanDeCuentasListado }

  TfrmPlanDeCuentasListado = class(TForm)
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    ds_PlanDeCuentas: TDataSource;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    ZedDBTreeView1: TZedDBTreeView;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    dmPlanDeCuentas: TDM_PlanDeCuentas;
  public
    { public declarations }
  end;

var
  frmPlanDeCuentasListado: TfrmPlanDeCuentasListado;

implementation

{$R *.lfm}

{ TfrmPlanDeCuentasListado }


procedure TfrmPlanDeCuentasListado.FormCreate(Sender: TObject);
begin
  dmPlanDeCuentas:= TDM_PlanDeCuentas.Create(self);

  ds_PlanDeCuentas.DataSet:= dmPlanDeCuentas.qPlanDeCuentas;
end;

procedure TfrmPlanDeCuentasListado.FormDestroy(Sender: TObject);
begin
  dmPlanDeCuentas.Free;
end;

procedure TfrmPlanDeCuentasListado.FormShow(Sender: TObject);
begin
  dmPlanDeCuentas.LevantarPlanDeCuentas;
end;

end.

