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
    OPComprobantesComprobanteSaldo: TFloatField;
    OPComprobantesid: TStringField;
    OPComprobantesmontoPagado: TFloatField;
    OPComprobantesordenDePago_id: TStringField;
    OPFormasPagobVisible: TLongintField;
    OPFormasPagocheque_id: TStringField;
    OPFormasPagoformaPago_id: TLongintField;
    OPFormasPagoid: TStringField;
    OPFormasPagolxFormaDePago: TStringField;
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
    qFormasPago: TZQuery;
    qFormasPagoPorID: TZQuery;
    qFormasPagoBVISIBLE: TSmallintField;
    qFormasPagoFORMADEPAGO: TStringField;
    qFormasPagoID: TLongintField;
    qFormasPagoPorIDBVISIBLE: TSmallintField;
    qFormasPagoPorIDFORMADEPAGO: TStringField;
    qFormasPagoPorIDID: TLongintField;
    qPagadoComprobanteTOTALPAGADO: TFloatField;
    SELOP: TZQuery;
    SELOPComprobantes: TZQuery;
    qPagadoComprobante: TZQuery;
    SELOPComprOP: TZQuery;
    SELOPComprOPBVISIBLE: TSmallintField;
    SELOPComprOPCOMPROBANTECOMPRA_ID: TStringField;
    SELOPComprOPID: TStringField;
    SELOPComprOPMONTOPAGADO: TFloatField;
    SELOPComprOPORDENDEPAGO_ID: TStringField;
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
    SELOPFormasPagoOP: TZQuery;
    SELOPFormasPagoBVISIBLE: TSmallintField;
    SELOPFormasPagoCHEQUE_ID: TStringField;
    SELOPFormasPagoFORMAPAGO_ID: TLongintField;
    SELOPFormasPagoID: TStringField;
    SELOPFormasPagoLXFORMADEPAGO: TStringField;
    SELOPFormasPagoMONTO: TFloatField;
    SELOPFormasPagoOPBVISIBLE: TSmallintField;
    SELOPFormasPagoOPCHEQUE_ID: TStringField;
    SELOPFormasPagoOPFORMAPAGO_ID: TLongintField;
    SELOPFormasPagoOPID: TStringField;
    SELOPFormasPagoOPLXFORMADEPAGO: TStringField;
    SELOPFormasPagoOPMONTO: TFloatField;
    SELOPFormasPagoOPORDENDEPAGO_ID: TStringField;
    SELOPFormasPagoORDENDEPAGO_ID: TStringField;
    SELOPID: TStringField;
    SELOPNUMERO: TLongintField;
    SELOPPROVEEDOR_ID: TStringField;
    SELOPTOTAL: TFloatField;
    UPDOP: TZQuery;
    UPDOPComprobantes: TZQuery;
    UPDOPFormasPago: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure OPComprobantesAfterInsert(DataSet: TDataSet);
    procedure OPFormasPagoAfterInsert(DataSet: TDataSet);
    procedure OrdenDePagoAfterInsert(DataSet: TDataSet);
  private
    function getIdProveedor: GUID_ID;
    function getOrdenPagoID: GUID_ID;
    function getSumaComprasImpagas: double;
    function getSumaFormasPago: double;
    function getSumaSaldoComprobantes: double;
    procedure setIdProveedor(AValue: GUID_ID);
    procedure RecalcularOP;
    procedure DatosComprobante (refComprobante: GUID_ID);


  public
    property refProveedor:GUID_ID read getIdProveedor write setIdProveedor;
    property ordenPagoID: GUID_ID read getOrdenPagoID;
    property sumaSaldoComprobantes: double read getSumaSaldoComprobantes;
    property sumaFormasPago: double read getSumaFormasPago;
    property sumaComprasImpagas: double read getSumaComprasImpagas;

    procedure Nueva;
    procedure Editar (refOP: GUID_ID);
    procedure Grabar;

    procedure AgregarComprobante (refComprobante: GUID_ID);
    procedure QuitarComprobante;
    function PagadoComprobante (refComprobante:GUID_ID): Double ;
    procedure PagarComprobanteActual (monto: double);

    procedure EditarMontoAsignado(elMonto: double);

    procedure NuevaFormaPago;
    procedure EditarFormaPagoActual;
    function NombreformaDePago (refFormaPago: integer): string;
    procedure QuitarFP;


    procedure PagarTodosLosComprobantes;
    procedure MarcarComprobantesDistribuidos;


  end;

var
  DM_OrdenDePago: TDM_OrdenDePago;

implementation
{$R *.lfm}
uses
  dmcompras
  ,Forms
  ,dmcompensaciones
  ;

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

procedure TDM_OrdenDePago.DataModuleCreate(Sender: TObject);
begin
 Application.CreateForm(TDM_Compras, DM_Compras);
 qFormasPago.Open;
end;

procedure TDM_OrdenDePago.DataModuleDestroy(Sender: TObject);
begin
  DM_Compras.Free;
end;

procedure TDM_OrdenDePago.OPFormasPagoAfterInsert(DataSet: TDataSet);
begin
  OPFormasPagoid.AsString:= DM_General.CrearGUID;
  OPFormasPagoordenDePago_id.AsString:= OrdenDePagoid.AsString;
  OPFormasPagocheque_id.AsString:= GUIDNULO;
  OPFormasPagoformaPago_id.AsInteger:= 1;
  OPFormasPagomonto.AsFloat:= 0;
  OPFormasPagobVisible.AsInteger:= 1;
end;

function TDM_OrdenDePago.getIdProveedor: GUID_ID;
begin
  if ((OrdenDePago.Active) and (OrdenDePago.RecordCount > 0)) then
    Result:= OrdenDePagoproveedor_id.AsString
  else
    Result:= GUIDNULO;
end;

function TDM_OrdenDePago.getOrdenPagoID: GUID_ID;
begin
  if ((OrdenDePago.Active) and (OrdenDePago.RecordCount > 0)) then
    Result:= OrdenDePagoid.AsString
  else
    Result:= GUIDNULO;
end;

function TDM_OrdenDePago.getSumaComprasImpagas: double;
begin
  Result:= DM_Compras.montoComprasProveedorEstado(refProveedor, EST_NO_PAGADO);
end;

function TDM_OrdenDePago.getSumaSaldoComprobantes: double;
var
  acumulador: Double;
begin
  acumulador:= 0;
  with OPComprobantes do
  begin
    DisableControls;
    First;
    while not eof do
    begin
      acumulador:= acumulador + OPComprobantesComprobanteSaldo.AsFloat;
      Next;
    end;
    EnableControls;
    Result:= acumulador;
  end;
end;

procedure TDM_OrdenDePago.setIdProveedor(AValue: GUID_ID);
begin
  if (OrdenDePago.Active) then
  begin
    OrdenDePago.Edit;
    OrdenDePagoproveedor_id.AsString:= AValue;
    OrdenDePago.Post;
  end;
end;

procedure TDM_OrdenDePago.RecalcularOP;
var
  monto: Double;
  laCompensacion: TDM_Compensaciones;
begin
  monto:= 0;
  with OPComprobantes do
  begin
    DisableControls;
    First;

    while not EOF do
    begin
      monto:= monto + OPComprobantesmontoPagado.AsFloat;
      Next;
    end;
    EnableControls;
  end;

  laCompensacion:= TDM_Compensaciones.Create(self);
  try
    monto:= monto + laCompensacion.MontoCompensacionOP(OrdenDePagoid.AsString);
  finally
    laCompensacion.Free;
  end;

  with OrdenDePago do
  begin
    Edit;
    OrdenDePagototal.asFloat:= monto;
    Post;
  end;
end;

procedure TDM_OrdenDePago.DatosComprobante(refComprobante: GUID_ID);
var
  pagado: Double;
begin
  DM_Compras.Editar(refComprobante);
  OPcomprobantes.Edit;
  OPComprobantesComprobanteNro.AsInteger:= DM_Compras.ComprascomprobanteNro.AsInteger;
  OPComprobantesComprobanteFecha.AsDateTime:= DM_Compras.Comprasfecha.asDateTime;
  OPComprobantesComprobanteMonto.asFloat:= DM_Compras.ComprasmontoTotal.AsFloat;
  //Le resto al total pagado lo pagado en esta OP:
  pagado:= PagadoComprobante(refComprobante) - OPComprobantesmontoPagado.AsFloat;
  OPComprobantesComprobanteSaldo.asFloat:= (OPComprobantesComprobanteMonto.asFloat
                                           - pagado);
  OPComprobantesComprobantePagado.AsFloat:= pagado;
  OPComprobantes.Post;
end;

function TDM_OrdenDePago.NombreformaDePago(refFormaPago: integer): string;
begin
  with qFormasPagoPorID do
  begin
    if active then close;
    ParamByName('id').asInteger:= refFormaPago;
    Open;
    if RecordCount > 0 then
      Result:= qFormasPagoPorIDFORMADEPAGO.AsString
    else
       Result:= EmptyStr;
  end;
end;

procedure TDM_OrdenDePago.Nueva;
begin
  DM_General.ReiniciarTabla(OrdenDePago);
  DM_General.ReiniciarTabla(OPComprobantes);
  DM_General.ReiniciarTabla(OPFormasPago);
  OrdenDePago.Insert;
end;

procedure TDM_OrdenDePago.Editar(refOP: GUID_ID);
begin
  DM_General.ReiniciarTabla(OrdenDePago);
  DM_General.ReiniciarTabla(OPComprobantes);
  DM_General.ReiniciarTabla(OPFormasPago);

  with SELOP do
  begin
    if active then close;
    ParamByName('id').asString:= refOP;
    Open;
    OrdenDePago.LoadFromDataSet(SELOP, 0, lmAppend);
    Close;
  end;

  with SELOPComprOP do
  begin
    if active then close;
    ParamByName('ordenDePago_id').asString:= refOP;
    Open;
    OPComprobantes.LoadFromDataSet(SELOPComprOP, 0, lmAppend);
    if OPComprobantes. RecordCount > 0 then
      OPComprobantes.First;
    While not OPComprobantes.EOF do
    begin
      DatosComprobante(OPComprobantescomprobanteCompra_id.AsString);
      OPComprobantes.Next;
    end;
    Close;
  end;

  with SELOPFormasPagoOP do
  begin
    if active then close;
    ParamByName('ordenDePago_id').asString:= refOP;
    Open;
    OPFormasPago.LoadFromDataSet(SELOPFormasPagoOP, 0, lmAppend);
    Close;
  end;


end;

procedure TDM_OrdenDePago.Grabar;
begin
  RecalcularOP;
  DM_General.cnxBase.StartTransaction;
  try
    DM_General.GrabarDatos(SELOP, INSOP, UPDOP, OrdenDePago, 'id' );
    DM_General.GrabarDatos(SELOPComprobantes, INSOPComprobantes, UPDOPComprobantes, OPComprobantes, 'id' );
    DM_General.GrabarDatos(SELOPFormasPago, INSOPFormasPago, UPDOPFormasPago, OPFormasPago, 'id' );

    DM_General.cnxBase.Commit;
  except
    DM_General.cnxBase.Rollback;
  end;

end;

procedure TDM_OrdenDePago.AgregarComprobante(refComprobante: GUID_ID);
var
  pagado: double;
begin
  OPComprobantes.Insert;
  OPComprobantescomprobanteCompra_id.AsString:= refComprobante;
  DM_Compras.Editar(refComprobante);
  OPComprobantesComprobanteNro.AsInteger:= DM_Compras.ComprascomprobanteNro.AsInteger;
  OPComprobantesComprobanteFecha.AsDateTime:= DM_Compras.Comprasfecha.asDateTime;
  OPComprobantesComprobanteMonto.asFloat:= DM_Compras.ComprasmontoTotal.AsFloat;
  pagado:= PagadoComprobante(refComprobante);
  OPComprobantesComprobanteSaldo.asFloat:= (OPComprobantesComprobanteMonto.asFloat - pagado);
  OPComprobantesComprobantePagado.AsFloat:= pagado;
  OPComprobantes.Post;
  RecalcularOP;
end;

procedure TDM_OrdenDePago.QuitarComprobante;
begin
  if ((OPComprobantes.Active) and (OPComprobantes.RecordCount > 0)) then
  begin
    DELOPComprobantes.ParamByName('id').AsString:= OPComprobantesid.AsString;
    DELOPComprobantes.ExecSQL;
    OPComprobantes.Delete;
    RecalcularOP;
  end;
end;

function TDM_OrdenDePago.PagadoComprobante(refComprobante: GUID_ID): Double;
begin
  with qPagadoComprobante do
  begin
    if active then close;
    ParamByName('comprobanteCompra_id').asString:= refComprobante;
    Open;
    if RecordCount > 0 then
      Result:= qPagadoComprobanteTOTALPAGADO.AsFloat
    else
      Result:= 0;
    close;
  end;
end;

procedure TDM_OrdenDePago.EditarMontoAsignado(elMonto: double);
begin
  if ((OPComprobantes.Active) and (OPComprobantes.RecordCount > 0)) then
  begin
    OPComprobantes.Edit;
    OPComprobantesmontoPagado.AsFloat:= elMonto;
    OPComprobantesComprobanteSaldo.asFloat:= OPComprobantesComprobanteMonto.asFloat
                                            - PagadoComprobante(OPComprobantesid.AsString)
                                            - elMonto;
    OPComprobantes.Post;
  end;
end;

procedure TDM_OrdenDePago.NuevaFormaPago;
begin
  OPFormasPago.Insert;
end;

procedure TDM_OrdenDePago.EditarFormaPagoActual;
begin
  OPFormasPago.Edit;
end;

function TDM_OrdenDePago.getSumaFormasPago: double;
var
  acumulador: Double;
begin
  acumulador:= 0;
  with OPFormasPago do
  begin
    DisableControls;
    First;
    while Not EOF do
    begin
      acumulador:= acumulador + OPFormasPagomonto.AsFloat;
      Next;
    end;
    EnableControls;
    Result:= acumulador;
  end;
end;

procedure TDM_OrdenDePago.QuitarFP;
begin
  if ((OPFormasPago.Active) and (OPFormasPago.RecordCount > 0)) then
  begin
    DELOPFormasPago.ParamByName('id').AsString:= OPFormasPagoid.AsString;
    DELOPFormasPago.ExecSQL;
    OPFormasPago.Delete;
  end;
end;

procedure TDM_OrdenDePago.PagarComprobanteActual(monto: double);
begin
  with OPComprobantes do
  begin
    Edit;
    OPComprobantesmontoPagado.AsFloat:= monto;
    Post;
    if DM_General.CmpIgualdadFloat(monto, OPComprobantesComprobanteSaldo.AsFloat) then
    begin
     DM_Compras.CompraPagada (OPComprobantescomprobanteCompra_id.AsString);
    end;
  end;
end;

procedure TDM_OrdenDePago.PagarTodosLosComprobantes;
begin
  with OPComprobantes do
  begin
    First;
    while not EOF do
    begin
      PagarComprobanteActual(OPComprobantesComprobanteSaldo.AsFloat);
      Next;
    end;
  end;
end;

procedure TDM_OrdenDePago.MarcarComprobantesDistribuidos;
begin
  with OPComprobantes do
  begin
    First;
    while not EOF do
    begin
      if DM_General.CmpIgualdadFloat(OPComprobantesmontoPagado.AsFloat,OPComprobantesComprobanteSaldo.AsFloat) then
      begin
       DM_Compras.CompraPagada (OPComprobantescomprobanteCompra_id.AsString);
      end;
      Next;
    end;
  end;
end;

end.

