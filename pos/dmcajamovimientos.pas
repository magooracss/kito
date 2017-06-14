unit dmcajamovimientos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds;

type

  { TDM_CajaMovimentos }

  TDM_CajaMovimentos = class(TDataModule)
    CajaMovimientos: TRxMemoryData;
    CajaMovimientosfecha: TDateField;
    CajaMovimientosid: TStringField;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DM_CajaMovimentos: TDM_CajaMovimentos;

implementation

{$R *.lfm}

end.

