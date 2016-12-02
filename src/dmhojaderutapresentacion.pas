unit dmhojaderutapresentacion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  , dmgeneral  ,dmhojaderuta ;
const
  HdR_TODOS_LOS_ESTADOS = 3;
type

  { TDM_HdRPresentacion }

  TDM_HdRPresentacion = class(TDataModule)
    Presentacion: TRxMemoryData;
    Presentacionfecha: TDateTimeField;
    PresentacionfPresentada: TDateTimeField;
    Presentacionid: TStringField;
    PresentacionlxEstado: TStringField;
    Presentacionmarca: TBooleanField;
    PresentacionNumero: TLongintField;
    PresPedidoscliente: TStringField;
    PresPedidosclienteID: TStringField;
    PresPedidosestado_id: TLongintField;
    PresPedidoshojaderuta_id: TStringField;
    PresPedidoslxEstado: TStringField;
    PresPedidosmarca: TBooleanField;
    PresPedidosmontoCobrado: TFloatField;
    PresPedidosmontoPedido: TFloatField;
    PresPedidosnroPedido: TLongintField;
    PresPedidospedido_id: TStringField;
    qBuscar: TZQuery;
    qBuscarFECHA: TDateField;
    qBuscarFPRESENTADA: TDateField;
    qBuscarID: TStringField;
    qBuscarLXESTADO: TStringField;
    qBuscarNUMERO: TLongintField;
    PresPedidos: TRxMemoryData;
    qLevantaPedidos: TZQuery;
    qLevantaPedidosCLIENTE: TStringField;
    qLevantaPedidosCLIENTEID: TStringField;
    qLevantaPedidosESTADO_ID: TStringField;
    qLevantaPedidosHOJADERUTA_ID: TStringField;
    qLevantaPedidosLXESTADO: TStringField;
    qLevantaPedidosMONTOCOBRADO: TFloatField;
    qLevantaPedidosMONTOPEDIDO: TFloatField;
    qLevantaPedidosNROPEDIDO: TLongintField;
    qLevantaPedidosPEDIDO_ID: TStringField;
    qMotivosNoEntrega: TZQuery;
    qMotivosNoEntregaBVISIBLE: TSmallintField;
    qMotivosNoEntregaID: TLongintField;
    qMotivosNoEntregaMOTIVONOENTREGA: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure PresentacionAfterInsert(DataSet: TDataSet);
    procedure PresPedidosAfterInsert(DataSet: TDataSet);
  private
    dmHdR: TDM_HojaDeRuta;
    procedure CabeceraSQL (consulta: TZQuery);
    procedure ConsultaATabla;
    function getIdSeleccion: GUID_ID;
  public
    property idSeleccion: GUID_ID read getIdSeleccion;

    procedure BuscarEstado (refEstado: integer);
    procedure BuscarFechaEstado (laFecha: TDate; refEstado: integer);
    procedure BuscarHdR (refHojaDeRuta: GUID_ID );

    procedure CambiarMarca;

    procedure PresentarPedido ( refPedido: GUID_ID
                              ; refDevolucion: GUID_ID
                              ; montoPresentado: Double
                              ; refEstado: integer
                              ; refHdRDetalle: GUID_ID
                              ; refMotivoNoEntrega: integer
                              );

    procedure LevantarPedidosHdR (refHojaDeRuta: GUID_ID);
    procedure CambiarMarcaPedido;

    procedure PedMarcadosEntregaCompleta;
    procedure PedMarcadosNoEntregados(refMotivoNoEntrega: integer);
    procedure PedMarcadoDevuelto (refDevolucion: GUID_ID);



  end;

var
  DM_HdRPresentacion: TDM_HdRPresentacion;

implementation
{$R *.lfm}
uses
  dmpedidos
  ;

{ TDM_HdRPresentacion }

procedure TDM_HdRPresentacion.PresentacionAfterInsert(DataSet: TDataSet);
begin
  Presentacionmarca.AsBoolean:= False;
end;

procedure TDM_HdRPresentacion.DataModuleCreate(Sender: TObject);
begin
  dmHdR:= TDM_HojaDeRuta.Create(self);
end;

procedure TDM_HdRPresentacion.DataModuleDestroy(Sender: TObject);
begin
  dmHdR.Free;
end;

procedure TDM_HdRPresentacion.PresPedidosAfterInsert(DataSet: TDataSet);
begin
  PresPedidosmarca.AsBoolean:= false;
end;

procedure TDM_HdRPresentacion.CabeceraSQL(consulta: TZQuery);
begin
  With consulta do
  begin
    SQL.Clear;
    SQL.Add('select  H.ID, H.FECHA, H.NUMERO , case ');
    SQL.Add('    when H.ESTADO = 1 THEN ''REALIZADA'' ');
    SQL.Add('    when H.ESTADO = 2 THEN ''PRESENTADA'' ');
    SQL.Add('end as lxEstado, H.FPRESENTADA');
    SQL.Add('from HOJASDERUTA H');
    SQL.Add('where (H.BVISIBLE = 1)');
  end;
end;

procedure TDM_HdRPresentacion.ConsultaATabla;
begin
  DM_General.ReiniciarTabla(Presentacion);
  qBuscar.Open;
  Presentacion.LoadFromDataSet(qBuscar, 0 , lmAppend);
  qBuscar.Close;
end;

function TDM_HdRPresentacion.getIdSeleccion: GUID_ID;
begin
  with Presentacion do
  begin
    if ((active) and (RecordCount > 0)) then
     Result:= Presentacionid.AsString
    else
      Result:= GUIDNULO;
  end;
end;

procedure TDM_HdRPresentacion.BuscarEstado(refEstado: integer);
begin
  CabeceraSQL (qBuscar);
  if refEstado < HdR_TODOS_LOS_ESTADOS then
    qBuscar.SQL.Add(' and (H.Estado = '+ IntToStr (refEstado) +')');
  ConsultaATabla;
end;

procedure TDM_HdRPresentacion.BuscarFechaEstado(laFecha: TDate;
  refEstado: integer);
begin
  CabeceraSQL (qBuscar);
  qBuscar.SQL.Add(' and (H.fecha = CAST('''+ FormatDateTime ('MM-DD-YYYY',laFecha) +''' as date))');
  if refEstado < HdR_TODOS_LOS_ESTADOS then
    qBuscar.SQL.Add(' and (H.Estado = '+ IntToStr (refEstado) +')');

  ConsultaATabla;
end;

procedure TDM_HdRPresentacion.BuscarHdR(refHojaDeRuta: GUID_ID);
begin
  CabeceraSQL (qBuscar);
  qBuscar.SQL.Add(' and (H.id = '''+refHojaDeRuta +''')');
  ConsultaATabla;
end;

procedure TDM_HdRPresentacion.CambiarMarca;
begin
  with Presentacion do
  begin
    if ((Active) and (RecordCount > 0)) then
    begin
      Edit;
      Presentacionmarca.AsBoolean:= NOT Presentacionmarca.AsBoolean;
      Post;
    end;
  end;
end;

procedure TDM_HdRPresentacion.PresentarPedido(refPedido: GUID_ID;
  refDevolucion: GUID_ID; montoPresentado: Double; refEstado: integer;
  refHdRDetalle: GUID_ID; refMotivoNoEntrega: integer);
begin
  DM_General.cnxBase.StartTransaction;
  try
     DM_Pedidos.CambiarEstadoPedido(refEstado, refPedido);

     dmHdR.LevantarRenglon(refHdRDetalle);

     dmHdR.HojaDeRutaDetalles.Edit;
     dmHdR.HojaDeRutaDetallesmontoCobrado.AsFloat:= montoPresentado;
     if refDevolucion <> GUIDNULO then
     begin
       dmHdR.HojaDeRutaDetallesdevolucion_id.AsString:= refDevolucion;
       dmHdR.HojaDeRutaDetallesbEntregaCompleto.AsInteger:= 0;
     end
     else
        dmHdR.HojaDeRutaDetallesbEntregaCompleto.AsInteger:= 1;

     if refMotivoNoEntrega > -1 then
     begin
        dmHdR.HojaDeRutaDetallesbEntregaCompleto.AsInteger:= 0;
        dmHdR.HojaDeRutaDetallesmotivoNoEntrega_id.AsInteger:= refMotivoNoEntrega ;
     end;

     dmHdR.HojaDeRutaDetalles.Post;
     dmHdR.GrabarDetalles;

     DM_General.cnxBase.Commit;
  Except
    DM_General.cnxBase.Rollback;
  end;
end;

procedure TDM_HdRPresentacion.LevantarPedidosHdR(refHojaDeRuta: GUID_ID);
begin
  DM_General.ReiniciarTabla(PresPedidos);
  with qLevantaPedidos do
  begin
    if active then close;
    ParamByName('hojaderuta_id').asString:= refHojaDeRuta;
    Open;
    PresPedidos.LoadFromDataSet(qLevantaPedidos, 0, lmAppend);
    close;
  end;
end;

procedure TDM_HdRPresentacion.CambiarMarcaPedido;
begin
  with PresPedidos do
  begin
    if ((Active) and (RecordCount > 0)) then
    begin
      Edit;
      PresPedidosmarca.AsBoolean:= NOT PresPedidosmarca.AsBoolean;
      Post;
    end;
  end;
end;

procedure TDM_HdRPresentacion.PedMarcadosEntregaCompleta;
begin
  with PresPedidos do
  begin
    DisableControls;
    First;
    while Not EOF do
    begin
      if PresPedidosmarca.AsBoolean then
      begin
        PresentarPedido(PresPedidospedido_id.AsString
                       ,GUIDNULO
                       ,PresPedidosmontoCobrado.AsFloat
                       ,EST_ENTREGADO
                       ,PresPedidoshojaderuta_id.AsString
                       ,0
                       );
      end;
      Next;
    end;
    EnableControls;
  end;
end;

procedure TDM_HdRPresentacion.PedMarcadosNoEntregados(
  refMotivoNoEntrega: integer);
begin
  with PresPedidos do
  begin
    DisableControls;
    First;
    while Not EOF do
    begin
      if PresPedidosmarca.AsBoolean then
      begin
        PresentarPedido(PresPedidospedido_id.AsString
                       ,GUIDNULO
                       ,0
                       ,EST_ARMADO
                       ,PresPedidoshojaderuta_id.AsString
                       ,refMotivoNoEntrega
                       );
      end;
      Next;
    end;
    EnableControls;
  end;
end;

procedure TDM_HdRPresentacion.PedMarcadoDevuelto(refDevolucion: GUID_ID);
begin
  with PresPedidos do
  begin
     PresentarPedido(PresPedidospedido_id.AsString
                    ,refDevolucion
                     ,PresPedidosmontoCobrado.AsFloat
                     ,EST_DEVPARCIAL
                     ,PresPedidoshojaderuta_id.AsString
                     ,0
                     );
  end;
end;

end.

