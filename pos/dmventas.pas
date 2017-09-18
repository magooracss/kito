unit dmventas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ,c_itemventa
  ,dmproductosstock
  ,dmcajamovimientos
  ;

type

  { TDM_Ventas }

  TDM_Ventas = class(TDataModule)
    DELPosVentaFormaPago: TZQuery;
    INSPosVentaFormaPago: TZQuery;
    PosVentaFormaPago: TRxMemoryData;
    PosVentaFormaPagobVisible: TLongintField;
    PosVentaFormaPagoformaPago_id: TLongintField;
    PosVentaFormaPagoid: TStringField;
    PosVentaFormaPagolxFormaPago: TStringField;
    PosVentaFormaPagomonto: TFloatField;
    PosVentaFormaPagoventa_id: TStringField;
    PosVentaItemslxColor: TStringField;
    PosVentaItemslxProducto: TStringField;
    PosVentaItemslxTalle: TStringField;
    qFormasPagoBEDIT: TSmallintField;
    qFormasPagoBVISIBLE: TSmallintField;
    qFormasPagoFORMAPAGO: TStringField;
    qFormasPagoID: TLongintField;
    SELPosVentaFormaPago: TZQuery;
    SELPosVentaFormaPagoBVISIBLE: TSmallintField;
    SELPosVentaFormaPagoFORMAPAGO_ID: TLongintField;
    SELPosVentaFormaPagoID: TStringField;
    SELPosVentaFormaPagoMONTO: TFloatField;
    SELPosVentaFormaPagoVENTA_ID: TStringField;
    SELPosVentaItemsBVISIBLE: TSmallintField;
    SELPosVentaItemsCANTIDAD: TFloatField;
    SELPosVentaItemsDESCUENTO: TFloatField;
    SELPosVentaItemsID: TStringField;
    SELPosVentaItemsPRECIOUNITARIO: TFloatField;
    SELPosVentaItemsPRODUCTOSTOCK_ID: TStringField;
    SELPosVentaItemsRECARGO: TFloatField;
    SELPosVentaItemsTOTAL: TFloatField;
    SELPosVentaItemsVENTA_ID: TStringField;
    SELPosVentas: TZQuery;
    SELPosVentaItems: TZQuery;
    PosVentaItemsbVisible: TLongintField;
    PosVentaItemscantidad: TFloatField;
    PosVentaItemsdescuento: TFloatField;
    PosVentaItemsid: TStringField;
    PosVentaItemsprecioUnitario: TFloatField;
    PosVentaItemsproductostock_id: TStringField;
    PosVentaItemsrecargo: TFloatField;
    PosVentaItemstotal: TFloatField;
    PosVentaItemsventa_id: TStringField;
    PosVentas: TRxMemoryData;
    PosVentaItems: TRxMemoryData;
    PosVentasbAnulada: TLongintField;
    PosVentasbVisible: TLongintField;
    PosVentascliente_id: TStringField;
    PosVentasfecha: TDateField;
    PosVentasid: TStringField;
    PosVentasnumero: TLongintField;
    PosVentastotal: TFloatField;
    INSPosVentas: TZQuery;
    SELPosVentasBANULADA: TSmallintField;
    SELPosVentasBVISIBLE: TSmallintField;
    SELPosVentasCLIENTE_ID: TStringField;
    SELPosVentasFECHA: TDateField;
    SELPosVentasID: TStringField;
    SELPosVentasNUMERO: TLongintField;
    SELPosVentasTOTAL: TFloatField;
    UPDPosVentaFormaPago: TZQuery;
    UPDPosVentas: TZQuery;
    DELPosVentas: TZQuery;
    INSPosVentaItems: TZQuery;
    UPDPosVentaItems: TZQuery;
    DELPosVentaItems: TZQuery;
    qFormasPago: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure PosVentaFormaPagoAfterInsert(DataSet: TDataSet);
    procedure PosVentaItemsAfterInsert(DataSet: TDataSet);
    procedure PosVentasAfterInsert(DataSet: TDataSet);
  private
    { private declarations }
  public
    procedure New;
    procedure Save;
    procedure AgregarItem (elItem: TItemVenta);
    procedure LoadVenta (refID: GUID_ID);
    procedure QuitarItem;
    procedure AgregarFormaPago (formaPagoID: integer; monto: double
                               ; lxformaPago: string );
    procedure AjustarTotalVenta (monto: double; movimiento: integer);
    procedure QuitarFormaPago;
    procedure AjustarTotales;
    function TotalFormasPago: double;
    procedure AjustarStock;
    procedure AsentarCaja;
  end;

var
  DM_Ventas: TDM_Ventas;

implementation

{$R *.lfm}

{ TDM_Ventas }

procedure TDM_Ventas.PosVentasAfterInsert(DataSet: TDataSet);
begin
  PosVentasid.AsString:= DM_General.CrearGUID;
  PosVentasnumero.AsInteger:= -1;
  PosVentasfecha.AsDateTime:= Now;
  PosVentascliente_id.AsString:= GUIDNULO;
  PosVentastotal.AsFloat:= 0;
  PosVentasbAnulada.AsInteger:= 0;
  PosVentasbVisible.AsInteger:= 1;
end;

procedure TDM_Ventas.PosVentaItemsAfterInsert(DataSet: TDataSet);
begin
  PosVentaItemsid.AsString:= DM_General.CrearGUID;
  PosVentaItemsventa_id.AsString:= PosVentasid.AsString;
  PosVentaItemsproductostock_id.AsString:= GUIDNULO;
  PosVentaItemscantidad.AsFloat:= 0;
  PosVentaItemsprecioUnitario.AsFloat:= 0;
  PosVentaItemsdescuento.AsFloat:= 0;
  PosVentaItemsrecargo.AsFloat:= 0;
  PosVentaItemstotal.AsFloat:= 0;
  PosVentaItemsbVisible.asInteger:= 1;
end;

procedure TDM_Ventas.DataModuleCreate(Sender: TObject);
begin
  qFormasPago.Open;
end;

procedure TDM_Ventas.PosVentaFormaPagoAfterInsert(DataSet: TDataSet);
begin
  PosVentaFormaPagoid.AsString:= DM_General.CrearGUID;
  PosVentaFormaPagoventa_id.AsString:= PosVentasid.AsString;
  PosVentaFormaPagoformaPago_id.AsInteger:= 0;
  PosVentaFormaPagomonto.AsFloat:= 0;
  PosVentaFormaPagobVisible.AsInteger:=1;
end;

procedure TDM_Ventas.New;
begin
  DM_General.ReiniciarTabla(PosVentas);
  DM_General.ReiniciarTabla(PosVentaItems);
  DM_General.ReiniciarTabla(PosVentaFormaPago);
  PosVentas.Insert;
end;

procedure TDM_Ventas.Save;
begin
  DM_General.cnxBase.StartTransaction;
  try
    AjustarStock;
    DM_General.GrabarDatos(SELPosVentas, INSPosVentas, UPDPosVentas, PosVentas, 'id');
    DM_General.GrabarDatos(SELPosVentaItems, INSPosVentaItems, UPDPosVentaItems, PosVentaItems, 'id');
    DM_General.GrabarDatos(SELPosVentaFormaPago, INSPosVentaFormaPago, UPDPosVentaFormaPago, PosVentaFormaPago, 'id');
    DM_General.cnxBase.Commit;
    AsentarCaja;
  except
    DM_General.cnxBase.Rollback;
  end;
end;

procedure TDM_Ventas.AgregarItem(elItem: TItemVenta);
begin
  PosVentaItems.Insert;
  PosVentaItemsproductostock_id.AsString:= elItem.stockID;
  PosVentaItemscantidad.AsFloat:= elItem.cantidad;
  PosVentaItemstotal.asFloat:= elItem.precio;
  PosVentaItemslxColor.AsString:= elItem.color;
  PosVentaItemslxTalle.AsString:= elItem.talle;
  PosVentaItemslxProducto.AsString:= elItem.producto;
  PosVentaItems.Post;
end;

procedure TDM_Ventas.LoadVenta(refID: GUID_ID);
begin
  DM_General.ReiniciarTabla(PosVentas);
  IF SELPosVentas.Active then SELPosVentas.Close;

  SELPosVentas.ParamByName('id').AsString:= refID;
  SELPosVentas.Open;
  PosVentas.LoadFromDataSet(SELPosVentas, 0, lmAppend);

  SELPosVentas.Close;
end;

procedure TDM_Ventas.QuitarItem;
begin
  if ((PosVentaItems.Active) and (PosVentaItems.RecordCount > 0)) then
  begin
    DELPosVentaItems.ParamByName('id').AsString:= PosVentaItemsid.AsString;
    DELPosVentaItems.ExecSQL;
    PosVentaItems.Delete;
  end;
end;

procedure TDM_Ventas.AgregarFormaPago(formaPagoID: integer; monto: double;
  lxformaPago: string);
begin
    PosVentaFormaPago.Insert;
    PosVentaFormaPagoformaPago_id.AsInteger:= formaPagoID;
    PosVentaformaPagomonto.AsFloat:= monto;
    PosVentaFormaPagolxFormaPago.AsString:= lxformaPago;
    PosVentaformaPago.Post;
end;

procedure TDM_Ventas.AjustarTotalVenta(monto: double; movimiento: integer);
var
  ventaOriginal: double;
begin
  with PosVentas do
  begin
   ventaOriginal:= PosVentastotal.AsFloat;
   Edit;
   case movimiento of
    FP_DESCUENTO: ventaOriginal:= ventaOriginal - monto;
    FP_RECARGO: ventaOriginal:= ventaOriginal + monto;
   end;
   PosVentastotal.AsFloat:= ventaOriginal;
   Post;
  end;
end;

procedure TDM_Ventas.QuitarFormaPago;
begin
  if ((PosVentaFormaPago.Active) and (PosVentaFormaPago.RecordCount > 0)) then
  begin
    DELPosVentaFormaPago.ParamByName('id').AsString:= PosVentaFormaPagoid.AsString;
    DELPosVentaFormaPago.ExecSQL;
    //Devuelvo el dinero descontado o recargado
(*
    case PosVentaFormaPagoformaPago_id.AsInteger of
     FP_DESCUENTO: AjustarTotalVenta (PosVentaFormaPagomonto.AsFloat
                                     ,FP_RECARGO);

     FP_RECARGO: AjustarTotalVenta (PosVentaFormaPagomonto.AsFloat
                                     ,FP_DESCUENTO);
    end;
*)
    PosVentaFormaPago.Delete;
  end;
end;

procedure TDM_Ventas.AjustarTotales;
var
  elTotal: double;
begin
  elTotal:= 0;
  with PosVentaItems do
  begin
    if (active and (RecordCount > 0)) then
    begin
      DisableControls;
      First;
      while (not EOF ) do
      begin
        elTotal:= elTotal + PosVentaItemstotal.AsFloat;
        Next;
      end;
      EnableControls;

      Edit;
      PosVentastotal.AsFloat:= elTotal;
      Post;

    end;
  end;
end;

function TDM_Ventas.TotalFormasPago: double;
var
  acc: double;
begin
  acc:= 0;
  with PosVentaFormaPago do
  begin
    DisableControls;
    if ((Active) and (RecordCount > 0)) then
    begin
      First;
      While (not EOF) do
      begin
        //if PosVentaFormaPagoformaPago_id.AsInteger = FP_DESCUENTO then
        // acc:= acc - PosVentaFormaPagomonto.AsFloat
        //else
          acc:= acc + PosVentaFormaPagomonto.AsFloat;
        Next;
      end;
      Result:= acc;
    end
    else
      Result:= 0;
    EnableControls;
  end;
end;

procedure TDM_Ventas.AjustarStock;
var
  dmStock: TDM_PosProductosStock;
begin
  dmStock:= TDM_PosProductosStock.Create(self);
  try
    with PosVentaItems do
    begin
      DisableControls;
      First;
      While (not EOF) do
      begin
        dmStock.LevantarStockProductoIdMov(PosVentaItemsproductostock_id.AsString);
        dmStock.QuitarProducto(dmStock.ProductosStockproducto_id.AsString
                              ,dmStock.ProductosStockcolor_id.AsString
                              ,dmStock.ProductosStocktalle_id.AsString
                              ,PosVentaItemscantidad.AsFloat);
        Next;
      end;
      EnableControls;
    end;
  finally
    dmStock.Free;
  end;
end;

procedure TDM_Ventas.AsentarCaja;
var
  dmCaja: TDM_CajaMovimentos;
begin
  dmCaja:= TDM_CajaMovimentos.Create(self);
  LoadVenta (PosVentasid.AsString);
  try
    PosVentaFormaPago.First;
    dmCaja.New;
    while NOT PosVentaFormaPago.EOF do
    begin
     dmCaja.Add( PosVentasfecha.AsDateTime
               , MOV_INGRESO
               ,'VENTA: ' + IntToStr(PosVentasnumero.AsInteger)
               , PosVentaFormaPagomonto.AsFloat
               , PosVentaFormaPagoid.AsString
               , PosVentaFormaPagoformaPago_id.AsInteger);
     PosVentaFormaPago.Next;
    end;
    dmCaja.Save;
  finally
    dmCaja.Free;
  end;
end;

end.

