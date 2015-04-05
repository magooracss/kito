unit dmempresa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  , db;

type

  { TDM_Empresa }

  TDM_Empresa = class(TDataModule)
    Empresa: TRxMemoryData;
    EmpresabVisible: TLongintField;
    Empresacondicionfiscal_id: TLongintField;
    EmpresaCUIT: TStringField;
    Empresaid: TStringField;
    EmpresaRazonSocial: TStringField;
    qCondicionesFiscales: TZQuery;
    qCondicionesFiscalesBVISIBLE: TSmallintField;
    qCondicionesFiscalesCONDICIONFISCAL: TStringField;
    qCondicionesFiscalesID: TLongintField;
    qCondicionesFiscalesTIPOFACTURA: TLongintField;
    procedure EmpresaAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DM_Empresa: TDM_Empresa;

implementation

{$R *.lfm}

{ TDM_Empresa }

procedure TDM_Empresa.EmpresaAfterInsert(DataSet: TDataSet);
begin
  Empresaid.AsString:= DM_General.CrearGUID;
  EmpresaRazonSocial.AsString:= EmptyStr;
  EmpresaCUIT.AsString:= EmptyStr;
  Empresacondicionfiscal_id.AsInteger:= 0;
  EmpresabVisible.AsInteger:=1;
end;


end.

