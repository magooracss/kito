unit dmcompras;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;

type

  { TDM_Compras }

  TDM_Compras = class(TDataModule)
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
    ComprasbAnulado: TLongintField;
    ComprasbVisible: TLongintField;
    ComprascomprobanteNro: TLongintField;
    ComprascondicionPago_id: TLongintField;
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
    qFormasDePagoBVISIBLE: TSmallintField;
    qFormasDePagoFORMADEPAGO: TStringField;
    qFormasDePagoID: TLongintField;
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
    UPDCompras: TZQuery;
    UPDCompraItems: TZQuery;
    procedure CompraItemsAfterInsert(DataSet: TDataSet);
    procedure ComprasAfterInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    idCompra: GUID_ID;
    mNeto, mIVA: double;
    procedure ajustarMontos;
    function getMontoIVA: double;
    function getMontoNeto: double;
    function getRefProveedor: GUID_ID;
    procedure setRefProveedor(AValue: GUID_ID);
  public
    property compraID: GUID_ID read idCompra write idCompra;
    property montoNeto: double read getMontoNeto;
    property montoIVA: double read getMontoIVA;
    property refProveedor: GUID_ID read getRefProveedor write setRefProveedor;

    procedure NuevoItem;
    procedure CalcularMontosItem;
    procedure BorrarItem;

    procedure Grabar;
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
  ComprasbAnulado.AsInteger:= 0;
  ComprasfechaAnulado.AsDateTime:= 0;
  ComprasbVisible.AsInteger:= 0;
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

