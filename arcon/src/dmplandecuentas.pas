unit dmplandecuentas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZDataset, dmgeneral;

type

  { TDM_PlanDeCuentas }

  TDM_PlanDeCuentas = class(TDataModule)
    qPlanDeCuentas: TZQuery;
    qPlanDeCuentasBVISIBLE: TSmallintField;
    qPlanDeCuentasCODIGO: TStringField;
    qPlanDeCuentasCUENTA: TStringField;
    qPlanDeCuentasCUENTAPADRE_ID: TLongintField;
    qPlanDeCuentasID: TLongintField;
    qPlanDeCuentasOPERACION: TStringField;
    qPlanDeCuentasPORCIVA: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { private declarations }
  public
    procedure LevantarPlanDeCuentas;
  end;

var
  DM_PlanDeCuentas: TDM_PlanDeCuentas;

implementation

{$R *.lfm}

{ TDM_PlanDeCuentas }

procedure TDM_PlanDeCuentas.DataModuleCreate(Sender: TObject);
begin

end;

procedure TDM_PlanDeCuentas.LevantarPlanDeCuentas;
begin
  if qPlanDeCuentas.Active then qPlanDeCuentas.Close;
  qPlanDeCuentas.Open;
end;

end.

