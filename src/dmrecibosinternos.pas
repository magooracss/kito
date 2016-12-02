unit dmrecibosinternos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, LR_DBSet, ZDataset
  , dmgeneral;


const
  REC_INT_ABIERTO = 0;
  REC_INT_CERRADO = 1;

type

  { TDM_RecibosInternos }

  TDM_RecibosInternos = class(TDataModule)
    FormasPagoBEDIT: TSmallintField;
    FormasPagoBVISIBLE: TSmallintField;
    FormasPagoFORMAPAGO: TStringField;
    FormasPagoID: TLongintField;
    frDBRecibosInternos: TfrDBDataSet;
    frDBRecIntConceptos: TfrDBDataSet;
    frDBMontos: TfrDBDataSet;
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
    LoadMontosByHeaderMONTO: TFloatField;
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
    RecibosInternoslxCliente: TStringField;
    RecibosInternosMonto: TFloatField;
    RecibosInternosnumero: TLongintField;
    RecibosIntMontos: TRxMemoryData;
    RecibosIntMontosbVisible: TLongintField;
    RecibosIntMontosformaPago_id: TLongintField;
    RecibosIntMontosid: TStringField;
    RecibosIntMontoslxFormaCobro: TStringField;
    RecibosIntMontosMonto: TFloatField;
    RecibosIntMontosrecibo_id: TStringField;
    SELRecInt: TZQuery;
    SELRecIntBCERRADO: TSmallintField;
    SELRecIntCptos: TZQuery;
    SELRecIntBANULADO: TSmallintField;
    SELRecIntBVISIBLE: TSmallintField;
    SELRecIntCLIENTE_ID: TStringField;
    LoadCptsByHeader: TZQuery;
    DELRecIntCpto: TZQuery;
    SELRecIntCptosBVISIBLE1: TSmallintField;
    SELRecIntCptosCONCEPTO1: TStringField;
    SELRecIntCptosID1: TStringField;
    SELRecIntCptosMONTO1: TFloatField;
    SELRecIntCptosPEDIDO_ID1: TStringField;
    SELRecIntCptosRECIBO_ID1: TStringField;
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
    DELRecIntMonto: TZQuery;
    SELRecIntMontosBVISIBLE: TSmallintField;
    SELRecIntMontosBVISIBLE1: TSmallintField;
    SELRecIntMontosFORMAPAGO_ID: TLongintField;
    SELRecIntMontosFORMAPAGO_ID1: TLongintField;
    SELRecIntMontosID: TStringField;
    SELRecIntMontosID1: TStringField;
    SELRecIntMontosMONTO: TFloatField;
    SELRecIntMontosMONTO1: TFloatField;
    SELRecIntMontosRECIBO_ID: TStringField;
    SELRecIntMontosRECIBO_ID1: TStringField;
    SELRecIntNUMERO: TLongintField;
    INSRecInt: TZQuery;
    UPDRecInt: TZQuery;
    RecIntCancel: TZQuery;
    UPDRecIntCptos: TZQuery;
    UPDRecIntMontos: TZQuery;
    FormasPago: TZTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure RecibosInternosAfterInsert(DataSet: TDataSet);
    procedure RecibosIntCptosAfterInsert(DataSet: TDataSet);
    procedure RecibosIntMontosAfterInsert(DataSet: TDataSet);
  private
    procedure LoadReciboInterno(refID: GUID_ID);
  public
    function New: GUID_ID;
    procedure Edit(refID: GUID_ID);
    procedure Cancel (refID: GUID_ID; fAnulado: TDate);//Anula un recibo y le pone fecha de anulación
    procedure Save;
    procedure Print(refID: GUID_ID);
    function InsertHeader (fecha: TDateTime; monto: double; cliente: GUID_ID; Cerrado: Word): GUID_ID;
    procedure InsertConcept (concepto: string; monto: double; pedido: GUID_ID);
    procedure InsertAmount (formaPago: integer; monto: double);
    function CheckAmounts: boolean; //true si los montos de los conceptos, las formas de pago y header son iguales
    function SumConcepts: double;
    function SumAmounts: double;
    procedure DeleteConcept;
    procedure DeleteAmount;
    procedure SumPagoACuenta; //Cubre la diferencia del pago a conceptos con dinero a cuenta
    procedure Refresh; //Verifica la integridad. Para cuando meto mano en las tablas desde afuera
  end;

var
  DM_RecibosInternos: TDM_RecibosInternos;

implementation
{$R *.lfm}
uses
  dmclientes
  ,Num2Letra
  ;


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

procedure TDM_RecibosInternos.DataModuleCreate(Sender: TObject);
begin
  FormasPago.Open;
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
var
  DMcli: TDM_Clientes;
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

  DMcli:= TDM_Clientes.Create(self);
  try
    DMcli.Editar(RecibosInternoscliente_id.AsString);
    RecibosInternos.Edit;
    RecibosInternoslxCliente.AsString:= DMcli.RazonSocial;
    RecibosInternos.Post;
  finally
    DMcli.Free;
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

function TDM_RecibosInternos.New: GUID_ID;
begin
  DM_General.ReiniciarTabla(RecibosInternos);
  DM_General.ReiniciarTabla(RecibosIntCptos);
  DM_General.ReiniciarTabla(RecibosIntMontos);

  RecibosInternos.Insert;
  Result:= RecibosInternosid.AsString;
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
    Refresh;

    DM_General.GrabarDatos(SELRecInt, INSRecInt, UPDRecInt, RecibosInternos, 'id');
    DM_General.GrabarDatos(SELRecIntCptos, INSRecIntCptos, UPDRecIntCptos, RecibosIntCptos, 'id');
    DM_General.GrabarDatos(SELRecIntMontos, INSRecIntMontos, UPDRecIntMontos, RecibosIntMontos, 'id');

    DM_General.cnxBase.Commit;
  except
    DM_General.cnxBase.Rollback;
  end;
end;

procedure TDM_RecibosInternos.Print(refID: GUID_ID);
begin
  Edit(refID);
  DM_General.LevantarReporte(_PRN_RECIBOS_INTERNO_, RecibosInternos);
  DM_General.AgregarVariableReporte('NRO_LETRAS', NumeroToLetra(RecibosInternosMonto.AsFloat) );
  DM_General.EjecutarReporte;
end;

function TDM_RecibosInternos.InsertHeader(fecha: TDateTime; monto: double;
  cliente: GUID_ID; Cerrado: Word): GUID_ID;
var
  elId: GUID_ID;
begin
  elId:= New;
  RecibosInternosfecha.AsDateTime:= fecha;
  RecibosInternosMonto.AsFloat:= monto;
  RecibosInternoscliente_id.AsString:= cliente;
  RecibosInternosbCerrado.AsInteger:= Cerrado;
  Result:= elId;
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

function TDM_RecibosInternos.SumConcepts: double;
var
  sumC: Double;
begin
  sumC:= 0;
  with RecibosIntCptos do
  begin
    DisableControls;
    First;
    While not EOF do
    begin
      sumC:= sumC + RecibosIntCptosmonto.AsFloat;
      Next;
    end;
    EnableControls;
  end;
  Result:= sumC;
end;

function TDM_RecibosInternos.SumAmounts: double;
var
  sumA: Double;
begin
  sumA:= 0;
  with RecibosIntMontos do
  begin
    DisableControls;
    First;
    While not EOF do
    begin
      sumA:= sumA + RecibosIntMontosMonto.AsFloat;
      Next;
    end;
    EnableControls;
  end;
  Result:= sumA;
end;

procedure TDM_RecibosInternos.DeleteConcept;
begin
  if (RecibosIntCptos.RecordCount > 0) then
  begin
    DELRecIntCpto.ParamByName('id').AsString:= RecibosIntCptosid.AsString;
    DELRecIntCpto.ExecSQL;

    RecibosIntCptos.Delete;
  end;
end;

procedure TDM_RecibosInternos.DeleteAmount;
begin
  if (RecibosIntMontos.RecordCount > 0) then
  begin
    DELRecIntMonto.ParamByName('id').AsString:= RecibosIntMontosid.AsString;
    DELRecIntMonto.ExecSQL;

    RecibosIntMontos.Delete;
  end;
end;

procedure TDM_RecibosInternos.SumPagoACuenta;
var
  diff: double;
begin
  diff:= SumConcepts - SumAmounts;
  if (diff > 0) then // Solamente si hay que cubrir monto de los conceptos. Evito cargas negativas
  begin
    InsertAmount(FC_CUENTA_CORRIENTE , diff);
  end;
end;

procedure TDM_RecibosInternos.Refresh;
begin
  RecibosInternos.Edit;
  RecibosInternosMonto.AsFloat:= SumAmounts;
  RecibosInternos.Post;
end;

end.

