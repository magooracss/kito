unit dmordendepago;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;

type

  { TDM_OrdenDePago }

  TDM_OrdenDePago = class(TDataModule)
    DELOP: TZQuery;
    DELOPComprobantes: TZQuery;
    DELOPFormasPago: TZQuery;
    INSOP: TZQuery;
    INSOPComprobantes: TZQuery;
    INSOPFormasPago: TZQuery;
    OPComprobantesbVisible: TLongintField;
    OPComprobantescomprobanteCompra_id: TStringField;
    OPComprobantesComprobanteFecha: TDateField;
    OPComprobantesComprobanteMonto: TFloatField;
    OPComprobantesComprobanteNro: TLongintField;
    OPComprobantesComprobantePagado: TFloatField;
    OPComprobantesid: TStringField;
    OPComprobantesmontoPagado: TFloatField;
    OPComprobantesordenDePago_id: TStringField;
    OPFormasPagobVisible: TLongintField;
    OPFormasPagocheque_id: TStringField;
    OPFormasPagoformaPago_id: TLongintField;
    OPFormasPagoid: TStringField;
    OPFormasPagomonto: TFloatField;
    OPFormasPagoordenDePago_id: TStringField;
    OrdenDePago: TRxMemoryData;
    OPComprobantes: TRxMemoryData;
    OPFormasPago: TRxMemoryData;
    OrdenDePagobAnulada: TLongintField;
    OrdenDePagobVisible: TLongintField;
    OrdenDePagofAnulada: TDateField;
    OrdenDePagofecha: TDateField;
    OrdenDePagoid: TStringField;
    OrdenDePagonumero: TLongintField;
    OrdenDePagoproveedor_id: TStringField;
    OrdenDePagototal: TFloatField;
    SELOP: TZQuery;
    SELOPComprobantes: TZQuery;
    SELOPFormasPago: TZQuery;
    SELOPBANULADA: TSmallintField;
    SELOPBVISIBLE: TSmallintField;
    SELOPComprobantesBVISIBLE: TSmallintField;
    SELOPComprobantesCOMPROBANTECOMPRA_ID: TStringField;
    SELOPComprobantesID: TStringField;
    SELOPComprobantesMONTOPAGADO: TFloatField;
    SELOPComprobantesORDENDEPAGO_ID: TStringField;
    SELOPFANULADA: TDateField;
    SELOPFECHA: TDateField;
    SELOPFormasPagoBVISIBLE: TSmallintField;
    SELOPFormasPagoCHEQUE_ID: TStringField;
    SELOPFormasPagoFORMAPAGO_ID: TLongintField;
    SELOPFormasPagoID: TStringField;
    SELOPFormasPagoMONTO: TFloatField;
    SELOPFormasPagoORDENDEPAGO_ID: TStringField;
    SELOPID: TStringField;
    SELOPNUMERO: TLongintField;
    SELOPPROVEEDOR_ID: TStringField;
    SELOPTOTAL: TFloatField;
    UPDOP: TZQuery;
    UPDOPComprobantes: TZQuery;
    UPDOPFormasPago: TZQuery;
    procedure OPComprobantesAfterInsert(DataSet: TDataSet);
    procedure OPFormasPagoAfterInsert(DataSet: TDataSet);
    procedure OrdenDePagoAfterInsert(DataSet: TDataSet);
  private
    function getIdProveedor: GUID_ID;
    procedure setIdProveedor(AValue: GUID_ID);
  public
    property refProveedor:GUID_ID read getIdProveedor write setIdProveedor;
  end;

var
  DM_OrdenDePago: TDM_OrdenDePago;

implementation

{$R *.lfm}

{ TDM_OrdenDePago }

procedure TDM_OrdenDePago.OrdenDePagoAfterInsert(DataSet: TDataSet);
begin
  OrdenDePagoid.AsString:= DM_General.CrearGUID;
  OrdenDePagonumero.AsInteger:= -1;
  OrdenDePagoproveedor_id.AsString:= GUIDNULO;
  OrdenDePagofecha.AsDateTime:= Now;
  OrdenDePagototal.AsFloat:= 0;
  OrdenDePagobAnulada.AsInteger:= 0;
  OrdenDePagofAnulada.AsDateTime:= 0;
  OrdenDePagobVisible.AsInteger:= 1;
end;

procedure TDM_OrdenDePago.OPComprobantesAfterInsert(DataSet: TDataSet);
begin
  OPComprobantesid.AsString:= DM_General.CrearGUID;
  OPComprobantesordenDePago_id.AsString:= OrdenDePagoid.AsString;
  OPComprobantescomprobanteCompra_id.AsString:= GUIDNULO;
  OPComprobantesmontoPagado.AsFloat:= 0;
  OPComprobantesbVisible.AsInteger:= 1;
end;

procedure TDM_OrdenDePago.OPFormasPagoAfterInsert(DataSet: TDataSet);
begin
  OPFormasPagoid.AsString:= DM_General.CrearGUID;
  OPFormasPagoordenDePago_id.AsString:= GUIDNULO;
  OPFormasPagocheque_id.AsString:= GUIDNULO;
  OPFormasPagoformaPago_id.AsInteger:= 0;
  OPFormasPagomonto.AsFloat:= 0;
  OPFormasPagobVisible.AsInteger:= 1;
end;

function TDM_OrdenDePago.getIdProveedor: GUID_ID;
begin
  raise Exception.Create('GetIdProveedor');
end;

procedure TDM_OrdenDePago.setIdProveedor(AValue: GUID_ID);
begin
    raise Exception.Create('SetIdProveedor');
end;

end.

