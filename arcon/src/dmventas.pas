unit dmventas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, ZDataset;

type

  { TDM_Ventas }

  TDM_Ventas = class(TDataModule)
    qTiposComprobantes: TZQuery;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DM_Ventas: TDM_Ventas;

implementation

{$R *.lfm}

{ TDM_Ventas }



end.

