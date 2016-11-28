unit dmrecibosinternos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  , dmgeneral;

type

  { TDM_RecibosInternos }

  TDM_RecibosInternos = class(TDataModule)
    INSRecIntCptos: TZQuery;
    INSRecIntMontos: TZQuery;
    LoadCptsByHeaderBVISIBLE: TSmallintField;
    LoadCptsByHeaderCONCEPTO: TStringField;
    LoadCptsByHeaderID: TStringField;
    LoadCptsByHeaderMONTO: TFloatField;
    LoadCptsByHeaderPEDIDO_ID: TStringField;
    LoadCptsByHeaderRECIBO_ID: TStringField;
    LoadMontosByHeader: TZQuery;
    LoadMontosByHeaderBVISIBLE: TSmallintField;
    LoadMontosByHeaderFORMAPAGO_ID: TLongintField;
    LoadMontosByHeaderID: TStringField;
    LoadMontosByHeaderRECIBO_ID: TStringField;
    RecibosIntCptosbVisible: TLongintField;
    RecibosIntCptosconcepto: TStringField;
    RecibosIntCptosid: TStringField;
    RecibosIntCptosmonto: TFloatField;
    RecibosIntCptospedido_id: TStringField;
    RecibosIntCptosrecibo_id: TStringField;
    RecibosInternos: TRxMemoryData;
    RecibosIntCptos: TRxMemoryData;
    RecibosInternosbAnulado: TLongintField;
    RecibosInternosbCerrado: TLongintField;
    RecibosInternosbVisible: TLongintField;
    RecibosInternoscliente_id: TStringField;
    RecibosInternosfAnulado: TDateTimeField;
    RecibosInternosfecha: TDateTimeField;
    RecibosInternosid: TStringField;
    RecibosInternosMonto: TFloatField;
    RecibosInternosnumero: TLongintField;
    RecibosIntMontos: TRxMemoryData;
    RecibosIntMontosbVisible: TLongintField;
    RecibosIntMontosformaPago_id: TLongintField;
    RecibosIntMontosid: TStringField;
    RecibosIntMontosMonto: TFloatField;
    RecibosIntMontosrecibo_id: TStringField;
    SELRecInt: TZQuery;
    SELRecIntBCERRADO: TSmallintField;
    SELRecIntCptos: TZQuery;
    SELRecIntBANULADO: TSmallintField;
    SELRecIntBVISIBLE: TSmallintField;
    SELRecIntCLIENTE_ID: TStringField;
    LoadCptsByHeader: TZQuery;
    SELRecIntFANULADO: TDateField;
    SELRecIntMontos: TZQuery;
    SELRecIntCptosBVISIBLE: TSmallintField;
    SELRecIntCptosCONCEPTO: TStringField;
    SELRecIntCptosID: TStringField;
    SELRecIntCptosMONTO: TFloatField;
    SELRecIntCptosPEDIDO_ID: TStringField;
    SELRecIntCptosRECIBO_ID: TStringField;
    SELRecIntFECHA: TDateField;
    SELRecIntID: TStringField;
    SELRecIntMONTO: TFloatField;
    SELRecIntMontosBVISIBLE: TSmallintField;
    SELRecIntMontosFORMAPAGO_ID: TLongintField;
    SELRecIntMontosID: TStringField;
    SELRecIntMontosMONTO: TFloatField;
    SELRecIntMontosRECIBO_ID: TStringField;
    SELRecIntNUMERO: TLongintField;
    INSRecInt: TZQuery;
    UPDRecInt: TZQuery;
    RecIntCancel: TZQuery;
    UPDRecIntCptos: TZQuery;
    UPDRecIntMontos: TZQuery;
    procedure RecibosInternosAfterInsert(DataSet: TDataSet);
    procedure RecibosIntCptosAfterInsert(DataSet: TDataSet);
    procedure RecibosIntMontosAfterInsert(DataSet: TDataSet);
  private
    procedure LoadReciboInterno(refID: GUID_ID);
  public
    procedure New;
    procedure Edit(refID: GUID_ID);
    procedure Cancel (refID: GUID_ID; fAnulado: TDate);//Anula un recibo y le pone fecha de anulación
    procedure Save;
    procedure InsertHeader (fecha: TDate; monto: double; cliente: GUID_ID; Cerrado: Word);
    procedure InsertConcept (concepto: string; monto: double; pedido: GUID_ID);
    procedure InsertAmount (formaPago: integer; monto: double);
    function CheckAmounts: boolean; //true si los montos de los conceptos, las formas de pago y header son iguales
  end;

var
  DM_RecibosInternos: TDM_RecibosInternos;

implementation

{$R *.lfm}

{ TDM_RecibosInternos }

procedure TDM_RecibosInternos.RecibosInternosAfterInsert(DataSet: TDataSet);
begin
  RecibosInternosid.AsString:= DM_General.CrearGUID;
  RecibosInternosnumero.asInteger:= -1;
  RecibosInternosfecha.AsDateTime:= Now;
  RecibosInternosMonto.AsFloat:= 0;
  RecibosInternoscliente_id.AsString:= GUIDNULO;
  RecibosInternosbAnulado.AsInteger:= 0;
  RecibosInternosfAnulado.AsDateTime:= 0;
  RecibosInternosbCerrado.AsInteger:= 0;
  RecibosInternosbVisible.AsInteger:= 1;
end;

procedure TDM_RecibosInternos.RecibosIntCptosAfterInsert(DataSet: TDataSet);
begin
  RecibosIntCptosid.AsString:= DM_General.CrearGUID;
  RecibosIntCptosrecibo_id.AsString:= RecibosInternosid.AsString;
  RecibosIntCptosconcepto.AsString:= EmptyStr;
  RecibosIntCptosmonto.AsFloat:= 0;
  RecibosIntCptospedido_id.AsString:= GUIDNULO;
  RecibosIntCptosbVisible.AsInteger:= 1;
end;

procedure TDM_RecibosInternos.RecibosIntMontosAfterInsert(DataSet: TDataSet);
begin
  RecibosIntMontosid.AsString:= DM_General.CrearGUID;
  RecibosIntMontosrecibo_id.AsString:= RecibosInternosid.AsString;
  RecibosIntMontosformaPago_id.AsInteger:= 0;
  RecibosIntMontosMonto.AsFloat:= 0;
  RecibosIntMontosbVisible.AsInteger:= 1;
end;

procedure TDM_RecibosInternos.LoadReciboInterno(refID: GUID_ID);
begin
  DM_General.ReiniciarTabla(RecibosInternos);
  DM_General.ReiniciarTabla(RecibosIntCptos);
  DM_General.ReiniciarTabla(RecibosIntMontos);

  with SELRecInt do
  begin
    if active then close;
    ParamByName('id').AsString:= refID;
    Open;
    RecibosInternos.LoadFromDataSet(SELRecInt, 0, lmAppend);
    Close;
  end;

  with LoadCptsByHeader do
  begin
    if active then close;
    ParamByName('recibo_id').AsString:= refID;
    Open;
    RecibosIntCptos.LoadFromDataSet(LoadCptsByHeader, 0, lmAppend);
    Close;
  end;

  with LoadMontosByHeader do
  begin
    if active then close;
    ParamByName('recibo_id').AsString:= refID;
    Open;
    RecibosIntMontos.LoadFromDataSet(LoadMontosByHeader, 0, lmAppend);
    Close;
  end;

end;

procedure TDM_RecibosInternos.New;
begin
  DM_General.ReiniciarTabla(RecibosInternos);
  DM_General.ReiniciarTabla(RecibosIntCptos);
  DM_General.ReiniciarTabla(RecibosIntMontos);
  RecibosInternos.Insert;
end;

procedure TDM_RecibosInternos.Edit(refID: GUID_ID);
begin
  LoadReciboInterno(refID);
  RecibosInternos.Edit;
end;

procedure TDM_RecibosInternos.Cancel(refID: GUID_ID; fAnulado: TDate);
begin
  with RecIntCancel do
  begin
    ParamByName('id').asString:= refID;
    ParamByName('fAnulado').AsDateTime:= fAnulado;
    ExecSQL;
  end;
end;

procedure TDM_RecibosInternos.Save;
begin
  DM_General.cnxBase.StartTransaction;
  try
    DM_General.GrabarDatos(SELRecInt, INSRecInt, UPDRecInt, RecibosInternos, 'id');
    DM_General.GrabarDatos(SELRecIntCptos, INSRecIntCptos, UPDRecIntCptos, RecibosIntCptos, 'id');
    DM_General.GrabarDatos(SELRecIntMontos, INSRecIntMontos, UPDRecIntMontos, RecibosIntMontos, 'id');

    DM_General.cnxBase.Commit;
  except
    DM_General.cnxBase.Rollback;
  end;
end;

procedure TDM_RecibosInternos.InsertHeader(fecha: TDate; monto: double;
  cliente: GUID_ID; Cerrado: Word);
begin
  New;
  RecibosInternosfecha.AsDateTime:= fecha;
  RecibosInternosMonto.AsFloat:= monto;
  RecibosInternoscliente_id.AsString:= cliente;
  RecibosInternosbCerrado.AsInteger:= Cerrado;
end;

procedure TDM_RecibosInternos.InsertConcept(concepto: string; monto: double;
  pedido: GUID_ID);
begin
  RecibosIntCptos.Insert;
  RecibosIntCptosconcepto.AsString:= concepto;
  RecibosIntCptosmonto.AsFloat:= monto;
  RecibosIntCptospedido_id.AsString:= pedido;
  RecibosIntCptos.Post;
end;

procedure TDM_RecibosInternos.InsertAmount(formaPago: integer; monto: double);
begin
  RecibosIntMontos.Insert;
  RecibosIntMontosformaPago_id.AsInteger:= formaPago;
  RecibosIntMontosMonto.AsFloat:= monto;
  RecibosIntMontos.Post;
end;

function TDM_RecibosInternos.CheckAmounts: boolean;
var
  mntH, mntC, mntA: double;
begin
  mntH:= 0;
  mntC:= 0;
  mntA:= 0;

  mntH:= RecibosInternosMonto.AsFloat;

  with RecibosIntCptos do
  begin
    DisableControls;
    if (RecordCount > 0) then First;
    while Not EOF do
    begin
      mntC:= mntC + RecibosIntCptosmonto.AsFloat;
      Next;
    end;
    EnableControls;
  end;

  with RecibosIntMontos do
  begin
    DisableControls;
    if (RecordCount > 0) then First;
    while Not EOF do
    begin
      mntA:= mntA + RecibosIntMontosMonto.AsFloat;
      Next;
    end;
    EnableControls;
  end;

  Result:= ((mntH = mntC) and (mntH = mntA));
end;

end.

