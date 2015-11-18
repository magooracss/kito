unit dmcompras;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;

const
  EST_NO_PAGADO = 0;
  EST_PAGADO = 1;


type

  { TDM_Compras }

  TDM_Compras = class(TDataModule)
    BusquedaComprasbAnulado: TLongintField;
    BusquedaComprasbVisible: TLongintField;
    BusquedaComprascomprobanteNro: TLongintField;
    BusquedaComprascondicionPago_id: TLongintField;
    BusquedaComprasestadoPagado: TLongintField;
    BusquedaComprasfecha: TDateField;
    BusquedaComprasfechaAnulado: TDateField;
    BusquedaComprasid: TStringField;
    BusquedaComprasmontoTotal: TFloatField;
    BusquedaComprasnumero: TLongintField;
    BusquedaCompraspercepcionCapital: TFloatField;
    BusquedaCompraspercepcionIVA: TFloatField;
    BusquedaCompraspercepcionProvincia: TFloatField;
    BusquedaComprasplazoPago_id: TLongintField;
    BusquedaComprasproveedor_id: TStringField;
    BusquedaCompraspuntoVenta: TLongintField;
    BusquedaComprasRazonSocial: TStringField;
    BusquedaComprastipoComprobante_id: TLongintField;
    CompraItemsbVisible: TLongintField;
    CompraItemscantidad: TFloatField;
    CompraItemscomprobanteCompra_id: TStringField;
    CompraItemsconcepto: TStringField;
    CompraItemscuentaImputacion: TLongintField;
    CompraItemsid: TStringField;
    CompraItemsiva: TFloatField;
    CompraItemsmontoIVA: TFloatField;
    CompraItemsmontoTotal: TFloatField;
    CompraItemsmontoUnitario: TFloatField;
    Compras: TRxMemoryData;
    BusquedaCompras: TRxMemoryData;
    ComprasbAnulado: TLongintField;
    ComprasbVisible: TLongintField;
    ComprascomprobanteNro: TLongintField;
    ComprascondicionPago_id: TLongintField;
    ComprasestadoPagado: TLongintField;
    Comprasfecha: TDateField;
    ComprasfechaAnulado: TDateField;
    Comprasid: TStringField;
    ComprasmontoTotal: TFloatField;
    Comprasnumero: TLongintField;
    CompraspercepcionCapital: TFloatField;
    CompraspercepcionIVA: TFloatField;
    CompraspercepcionProvincia: TFloatField;
    ComprasplazoPago_id: TLongintField;
    Comprasproveedor_id: TStringField;
    CompraspuntoVenta: TLongintField;
    ComprastipoComprobante_id: TLongintField;
    CompraItems: TRxMemoryData;
    DELCompras: TZQuery;
    DELComprasItem: TZQuery;
    INSCompras: TZQuery;
    INSCompraItems: TZQuery;
    qBusComprasProveedorEstadoBANULADO: TSmallintField;
    qBusComprasProveedorEstadoBVISIBLE: TSmallintField;
    qBusComprasProveedorEstadoCOMPROBANTENRO: TLongintField;
    qBusComprasProveedorEstadoCONDICIONPAGO_ID: TLongintField;
    qBusComprasProveedorEstadoESTADOPAGADO: TSmallintField;
    qBusComprasProveedorEstadoFECHA: TDateField;
    qBusComprasProveedorEstadoFECHAANULADO: TDateField;
    qBusComprasProveedorEstadoID: TStringField;
    qBusComprasProveedorEstadoMONTOTOTAL: TFloatField;
    qBusComprasProveedorEstadoNUMERO: TLongintField;
    qBusComprasProveedorEstadoPERCEPCIONCAPITAL: TFloatField;
    qBusComprasProveedorEstadoPERCEPCIONIVA: TFloatField;
    qBusComprasProveedorEstadoPERCEPCIONPROVINCIA: TFloatField;
    qBusComprasProveedorEstadoPLAZOPAGO_ID: TLongintField;
    qBusComprasProveedorEstadoPROVEEDOR_ID: TStringField;
    qBusComprasProveedorEstadoPUNTOVENTA: TLongintField;
    qBusComprasProveedorEstadoRAZONSOCIAL: TStringField;
    qBusComprasProveedorEstadoTIPOCOMPROBANTE_ID: TLongintField;
    qFormasDePagoBVISIBLE: TSmallintField;
    qFormasDePagoFORMADEPAGO: TStringField;
    qFormasDePagoID: TLongintField;
    qItemsCompraBVISIBLE: TSmallintField;
    qItemsCompraCANTIDAD: TFloatField;
    qItemsCompraCOMPROBANTECOMPRA_ID: TStringField;
    qItemsCompraCONCEPTO: TStringField;
    qItemsCompraCUENTAIMPUTACION: TLongintField;
    qItemsCompraID: TStringField;
    qItemsCompraIVA: TFloatField;
    qItemsCompraMONTOIVA: TFloatField;
    qItemsCompraMONTOTOTAL: TFloatField;
    qItemsCompraMONTOUNITARIO: TFloatField;
    qPlanDeCuentas: TZQuery;
    qPlanDeCuentasBVISIBLE: TSmallintField;
    qPlanDeCuentasCODIGO: TStringField;
    qPlanDeCuentasCUENTA: TStringField;
    qPlanDeCuentasGRUPO: TLongintField;
    qPlanDeCuentasID: TLongintField;
    qPlanDeCuentasOPERACION: TStringField;
    qPlanDeCuentasPORCIVA: TFloatField;
    qPlazosPagoBVISIBLE: TSmallintField;
    qPlazosPagoID: TLongintField;
    qPlazosPagoPLAZOPAGO: TStringField;
    qTiposComprobantes: TZQuery;
    qFormasDePago: TZQuery;
    qPlazosPago: TZQuery;
    qTiposComprobantesBVISIBLE: TSmallintField;
    qTiposComprobantesCOMPROBANTECOMPRA: TStringField;
    qTiposComprobantesID: TLongintField;
    qItemsCompra: TZQuery;
    SELCompraItemsBVISIBLE: TSmallintField;
    SELCompraItemsCANTIDAD: TFloatField;
    SELCompraItemsCOMPROBANTECOMPRA_ID: TStringField;
    SELCompraItemsCONCEPTO: TStringField;
    SELCompraItemsCUENTAIMPUTACION: TLongintField;
    SELCompraItemsID: TStringField;
    SELCompraItemsIVA: TFloatField;
    SELCompraItemsMONTOIVA: TFloatField;
    SELCompraItemsMONTOTOTAL: TFloatField;
    SELCompraItemsMONTOUNITARIO: TFloatField;
    SELCompras: TZQuery;
    SELCompraItems: TZQuery;
    qBusComprasProveedorEstado: TZQuery;
    SELComprasBANULADO: TSmallintField;
    SELComprasBVISIBLE: TSmallintField;
    SELComprasCOMPROBANTENRO: TLongintField;
    SELComprasCONDICIONPAGO_ID: TLongintField;
    SELComprasESTADOPAGADO: TSmallintField;
    SELComprasFECHA: TDateField;
    SELComprasFECHAANULADO: TDateField;
    SELComprasID: TStringField;
    SELComprasMONTOTOTAL: TFloatField;
    SELComprasNUMERO: TLongintField;
    SELComprasPERCEPCIONCAPITAL: TFloatField;
    SELComprasPERCEPCIONIVA: TFloatField;
    SELComprasPERCEPCIONPROVINCIA: TFloatField;
    SELComprasPLAZOPAGO_ID: TLongintField;
    SELComprasPROVEEDOR_ID: TStringField;
    SELComprasPUNTOVENTA: TLongintField;
    SELComprasTIPOCOMPROBANTE_ID: TLongintField;
    UPDCompras: TZQuery;
    UPDCompraItems: TZQuery;
    procedure CompraItemsAfterInsert(DataSet: TDataSet);
    procedure ComprasAfterInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    idCompra: GUID_ID;
    mNeto, mIVA: double;
    procedure ajustarMontos;
    function getIdBusquedaCompras: GUID_ID;
    function getMontoIVA: double;
    function getMontoNeto: double;
    function getRefProveedor: GUID_ID;
    procedure setRefProveedor(AValue: GUID_ID);
  public
    property compraID: GUID_ID read idCompra write idCompra;
    property montoNeto: double read getMontoNeto;
    property montoIVA: double read getMontoIVA;
    property refProveedor: GUID_ID read getRefProveedor write setRefProveedor;
    property idBusquedaCompras: GUID_ID read getIdBusquedaCompras;

    procedure NuevoItem;
    procedure CalcularMontosItem;
    procedure BorrarItem;

    procedure NuevaCompra;
    procedure Editar (refCompra: GUID_ID);
    procedure Grabar;

    procedure ComprasProveedorEstado (Proveedor_id: GUID_ID; refEstado: integer);
    function montoComprasProveedorEstado (Proveedor_id: GUID_ID; refEstado: integer): double;

    procedure CompraPagada (refCompra:GUID_ID);

  end;

var
  DM_Compras: TDM_Compras;

implementation
uses
  SD_Configuracion
  ;

{$R *.lfm}

{ TDM_Compras }

procedure TDM_Compras.DataModuleCreate(Sender: TObject);
begin
  DM_General.ReiniciarTabla(Compras);
  DM_General.ReiniciarTabla(CompraItems);

  qTiposComprobantes.Open;
  qFormasDePago.Open;
  qPlazosPago.Open;
  qPlanDeCuentas.Open;
end;

procedure TDM_Compras.ajustarMontos;
begin
  mIVA:= 0;
  mNeto:= 0;
  with CompraItems do
  begin
    DisableControls;
    First;
    while not eof do
    begin
      mIVA:= mIVA + (((CompraItemsiva.asFloat /100) * CompraItemsmontoUnitario.asFloat)
                     * CompraItemscantidad.AsFloat);
      mNeto:= mNeto + (CompraItemsmontoUnitario.asFloat * CompraItemscantidad.AsFloat);
      Next;
    end;
    EnableControls;
  end;

  With Compras do
  begin
    DisableControls;
    Edit;
    ComprasmontoTotal.AsFloat:=    mNeto
                                 + mIVA
                                 + CompraspercepcionCapital.asFloat
                                 + CompraspercepcionProvincia.AsFloat
                                 + CompraspercepcionIVA.asFloat
                                 ;
    Post;
    EnableControls;
  end;
end;

function TDM_Compras.getIdBusquedaCompras: GUID_ID;
begin
  with BusquedaCompras do
  begin
    if ((Active) and (RecordCount > 0)) then
      Result:= BusquedaComprasid.AsString
    else
      Result:= GUIDNULO;
  end;
end;

function TDM_Compras.getMontoIVA: double;
begin
  ajustarMontos;
  Result:= mIVA;
end;

function TDM_Compras.getMontoNeto: double;
begin
  ajustarMontos;
  Result:= mNeto;
end;

function TDM_Compras.getRefProveedor: GUID_ID;
begin
  if ((Compras.Active) and (Compras.RecordCount > 0)) then
    Result:= Comprasproveedor_id.AsString
  else
    Result:= GUIDNULO;
end;

procedure TDM_Compras.setRefProveedor(AValue: GUID_ID);
begin
  Compras.Edit;
  Comprasproveedor_id.AsString:= AValue;
  Compras.Post;
end;

procedure TDM_Compras.NuevoItem;
begin
  CompraItems.Insert;
end;

procedure TDM_Compras.CalcularMontosItem;
var
  elIva: double;
begin
  elIva:= CompraItemsmontoUnitario.AsFloat * (CompraItemsiva.asFloat / 100);
  with CompraItems do
  begin
    DisableControls;
    Edit;
    CompraItemsmontoIVA.AsFloat:= CompraItemscantidad.asFloat * elIva;
    CompraItemsmontoTotal.AsFloat:= (CompraItemscantidad.asFloat
                                     * CompraItemsmontoUnitario.asFloat
                                    ) + CompraItemsmontoIVA.asFloat;
    Post;
    EnableControls;
  end;

end;

procedure TDM_Compras.BorrarItem;
begin
  if ((CompraItems.Active) and (CompraItems.RecordCount > 0)) then
  begin
    with DELComprasItem do
    begin
      ParamByName('id').AsString:= CompraItemsid.AsString;
      ExecSQL;
    end;
    CompraItems.Delete;
  end;
  CalcularMontosItem;
end;

procedure TDM_Compras.NuevaCompra;
begin
  DM_General.ReiniciarTabla(Compras);
  DM_General.ReiniciarTabla(CompraItems);
  Compras.Insert;
end;

procedure TDM_Compras.Editar(refCompra: GUID_ID);
begin
  DM_General.ReiniciarTabla(Compras);
  DM_General.ReiniciarTabla(CompraItems);

  if SELCompras.Active then
     SELCompras.Close;
  SELCompras.ParamByName('id').AsString:= refCompra;
  SELCompras.Open;
  Compras.LoadFromDataSet(SELCompras, 0, lmAppend);
  SELCompras.Close;

  if qItemsCompra.Active then
     qItemsCompra.Close;
  qItemsCompra.ParamByName('comprobanteCompra_id').asString:= refCompra;
  qItemsCompra.Open;
  CompraItems.LoadFromDataSet(qItemsCompra, 0, lmAppend);
  qItemsCompra.Close;

  Compras.Edit;
end;

procedure TDM_Compras.Grabar;
begin
  DM_General.cnxBase.StartTransaction;
  try
    DM_General.GrabarDatos(SELCompras, INSCompras, UPDCompras, Compras, 'id');
    DM_General.GrabarDatos(SELCompraItems, INSCompraItems, UPDCompraItems, CompraItems, 'id');
    DM_General.cnxBase.Commit;
  except
    DM_General.cnxBase.Rollback;
  end;
end;

procedure TDM_Compras.ComprasProveedorEstado(Proveedor_id: GUID_ID;
  refEstado: integer);
begin

  DM_General.ReiniciarTabla(BusquedaCompras);

  with qBusComprasProveedorEstado do
  begin
    if active then close;
    ParamByName('proveedor_id').AsString:= Proveedor_id;
    ParamByName('estadoPagado').asInteger:= refEstado;
    Open;

    BusquedaCompras.LoadFromDataSet(qBusComprasProveedorEstado, 0, lmAppend);
    Close;
  end;
end;

function TDM_Compras.montoComprasProveedorEstado(Proveedor_id: GUID_ID;
  refEstado: integer): double;
var
  suma: double;
begin
  suma:= 0;
  with qBusComprasProveedorEstado do
  begin
    if active then close;
    ParamByName('proveedor_id').AsString:= Proveedor_id;
    ParamByName('estadoPagado').asInteger:= refEstado;
    Open;
    First;

    while not eof do
    begin
      suma:= suma + qBusComprasProveedorEstadoMONTOTOTAL.AsFloat;
      Next;
    end;

    Result:= suma;
    Close;
  end;
end;

procedure TDM_Compras.CompraPagada(refCompra: GUID_ID);
begin
  Editar(refCompra);
  ComprasestadoPagado.AsInteger:= EST_PAGADO;
  Compras.Post;
  Grabar;
end;

procedure TDM_Compras.ComprasAfterInsert(DataSet: TDataSet);
begin
  idCompra:= DM_General.CrearGUID;;
  Comprasid.asString:= idCompra;
  Comprasnumero.AsInteger:=-1;
  Comprasproveedor_id.asString:= GUIDNULO;
  ComprastipoComprobante_id.AsInteger:= 0;
  CompraspuntoVenta.AsInteger:=0;
  ComprascomprobanteNro.AsInteger:=0;
  ComprascondicionPago_id.AsInteger:= 0;
  ComprasplazoPago_id.AsInteger:= 0;
  Comprasfecha.AsDateTime:= Now;
  ComprasmontoTotal.AsFloat:= 0;
  CompraspercepcionCapital.AsFloat:= 0;
  CompraspercepcionProvincia.AsFloat:= 0;
  CompraspercepcionIVA.AsFloat:= 0;
  ComprasestadoPagado.AsInteger:= 0;
  ComprasbAnulado.AsInteger:= 0;
  ComprasfechaAnulado.AsDateTime:= 0;
  ComprasbVisible.AsInteger:= 1;
end;

procedure TDM_Compras.CompraItemsAfterInsert(DataSet: TDataSet);
begin
  CompraItemsid.AsString:= DM_General.CrearGUID;
  CompraItemscomprobanteCompra_id.AsString:= idCompra;
  CompraItemscantidad.AsFloat:= 1;
  CompraItemsconcepto.asString:= EmptyStr;
  CompraItemscuentaImputacion.AsInteger:= 0;
  CompraItemsmontoUnitario.AsFloat:= 0;
  CompraItemsiva.AsFloat:= StrToFloatDef(LeerDato(SECCION_APP, CFGD_IVA_PROD), 0);
  CompraItemsmontoIVA.AsFloat:= 0;
  CompraItemsmontoTotal.AsFloat:= 0;
  CompraItemsbVisible.AsInteger:= 1;
end;

end.

