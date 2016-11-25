unit dmrecibosinternos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds;

type

  { TDM_RecibosInternos }

  TDM_RecibosInternos = class(TDataModule)
    RecibosIntCptosbVisible: TLongintField;
    RecibosIntCptosconcepto: TStringField;
    RecibosIntCptosid: TStringField;
    RecibosIntCptosmonto: TFloatField;
    RecibosIntCptospedido_id: TStringField;
    RecibosIntCptosrecibo_id: TStringField;
    RecibosInternos: TRxMemoryData;
    RecibosIntCptos: TRxMemoryData;
    RecibosInternosbAnulado: TLongintField;
    RecibosInternosbVisible: TLongintField;
    RecibosInternoscliente_id: TStringField;
    RecibosInternosfecha: TDateTimeField;
    RecibosInternosid: TStringField;
    RecibosInternosMonto: TFloatField;
    RecibosInternosnumero: TLongintField;
    RecibosIntMontos: TRxMemoryData;
    RecibosIntMontosbVisible: TLongintField;
    RecibosIntMontosformaPago_id: TLongintField;
    RecibosIntMontosid: TStringField;
    RecibosIntMontosrecibo_id: TStringField;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  DM_RecibosInternos: TDM_RecibosInternos;

implementation

{$R *.lfm}

end.

