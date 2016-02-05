unit dmasientomanual;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds;

type

  { TDM_AsientoManual }

  TDM_AsientoManual = class(TDataModule)
    AsientoManual: TRxMemoryData;
    AsientoManualbVisible: TLongintField;
    AsientoManualDebe: TFloatField;
    AsientoManualDetalle: TStringField;
    AsientoManualempresa_id: TStringField;
    AsientoManualFecha: TDateField;
    AsientoManualHaber: TFloatField;
    AsientoManualid: TStringField;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DM_AsientoManual: TDM_AsientoManual;

implementation

{$R *.lfm}

end.

