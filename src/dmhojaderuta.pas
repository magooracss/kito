unit dmhojaderuta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, StrHolder, ZDataset
  ,dmgeneral
  ;
const

FORMULARIO_HDR = 'frmHojaDeRuta.lrf';
FORMULARIO_HDR_TOTALIZADO = 'frmHojaDeRutaTot.lrf';
HdR_ESTADO_REALIZADA = 1;
HdR_ESTADO_PRESENTADA = 2;

type

  { TDM_HojaDeRuta }

  TDM_HojaDeRuta = class(TDataModule)
    EtiquetasBulto: TLongintField;
    EtiquetasBultosTotal: TLongintField;
    EtiquetasCliente: TStringField;
    EtiquetasDireccion: TStringField;
    EtiquetasNroHojaDeRuta: TLongintField;
    EtiquetasNroPedido: TLongintField;
    HojaDeRuta: TRxMemoryData;
    HojaDeRutabAnulada: TLongintField;
    HojaDeRutabVisible: TLongintField;
    HojaDeRutaDetallesbCobroDestino: TLongintField;
    HojaDeRutaDetallesbEntregaCompleto: TLongintField;
    HojaDeRutaDetallesbNoEntregado: TLongintField;
    HojaDeRutaDetallesbultos: TLongintField;
    HojaDeRutaDetallesbVisible: TLongintField;
    HojaDeRutaDetallesclienteDireccion_id: TStringField;
    HojaDeRutaDetallesdevolucion_id: TStringField;
    HojaDeRutaDetalleshojaDeRuta_id: TStringField;
    HojaDeRutaDetallesid: TStringField;
    HojaDeRutaDetalleslxCliente: TStringField;
    HojaDeRutaDetalleslxClienteDir: TStringField;
    HojaDeRutaDetalleslxPedidoNro: TLongintField;
    HojaDeRutaDetallesmontoCobrado: TFloatField;
    HojaDeRutaDetallesmontoCobrar: TFloatField;
    HojaDeRutaDetallesmotivoNoEntrega_id: TLongintField;
    HojaDeRutaDetallesnota: TStringField;
    HojaDeRutaDetallesnroOrdena: TLongintField;
    HojaDeRutaDetallespedido_id: TStringField;
    HojaDeRutaEstado: TLongintField;
    HojaDeRutafAnulada: TDateTimeField;
    HojaDeRutaFecha: TDateTimeField;
    HojaDeRutafPresentada: TDateTimeField;
    HojaDeRutaid: TStringField;
    HojaDeRutanumero: TLongintField;
    HojaDeRutatransportista_id: TStringField;
    HojaDeRutaDetalles: TRxMemoryData;
    INSHdR: TZQuery;
    INSHdRDet: TZQuery;
    qDetHdRLXCLIENTE: TStringField;
    qDetHdRLXCLIENTEDIR: TStringField;
    qDetHdRLXPEDIDONRO: TLongintField;
    qTotalizarHdRCANTIDAD: TFloatField;
    qTotalizarHdRCODIGO: TStringField;
    qTotalizarHdRMARCA: TStringField;
    qTotalizarHdRNOMBRE: TStringField;
    Etiquetas: TRxMemoryData;
    SELHdR: TZQuery;
    SELHdRDet: TZQuery;
    SELHdRBANULADA: TSmallintField;
    SELHdRBVISIBLE: TSmallintField;
    qDetHdR: TZQuery;
    qTotalizarHdR: TZQuery;
    SELHdRDetBCOBRODESTINO: TSmallintField;
    SELHdRDetBCOBRODESTINO1: TSmallintField;
    SELHdRDetBENTREGACOMPLETO: TSmallintField;
    SELHdRDetBENTREGACOMPLETO1: TSmallintField;
    SELHdRDetBNOENTREGADO: TSmallintField;
    SELHdRDetBNOENTREGADO1: TSmallintField;
    SELHdRDetBULTOS: TLongintField;
    SELHdRDetBULTOS1: TLongintField;
    SELHdRDetBVISIBLE: TSmallintField;
    SELHdRDetBVISIBLE1: TSmallintField;
    SELHdRDetCLIENTEDIRECCION_ID: TStringField;
    SELHdRDetCLIENTEDIRECCION_ID1: TStringField;
    SELHdRDetDEVOLUCION_ID: TStringField;
    SELHdRDetDEVOLUCION_ID1: TStringField;
    SELHdRDetHOJADERUTA_ID: TStringField;
    SELHdRDetHOJADERUTA_ID1: TStringField;
    SELHdRDetID: TStringField;
    SELHdRDetID1: TStringField;
    SELHdRDetMONTOCOBRADO: TFloatField;
    SELHdRDetMONTOCOBRADO1: TFloatField;
    SELHdRDetMONTOCOBRAR: TFloatField;
    SELHdRDetMONTOCOBRAR1: TFloatField;
    SELHdRDetMOTIVONOENTREGA_ID: TLongintField;
    SELHdRDetMOTIVONOENTREGA_ID1: TLongintField;
    SELHdRDetNOTA: TStringField;
    SELHdRDetNOTA1: TStringField;
    SELHdRDetNROORDENA: TLongintField;
    SELHdRDetNROORDENA1: TLongintField;
    SELHdRDetPEDIDO_ID: TStringField;
    SELHdRDetPEDIDO_ID1: TStringField;
    SELHdRESTADO: TSmallintField;
    SELHdRFANULADA: TDateField;
    SELHdRFECHA: TDateField;
    SELHdRFPRESENTADA: TDateField;
    SELHdRID: TStringField;
    SELHdRNUMERO: TLongintField;
    SELHdRTRANSPORTISTA_ID: TStringField;
    sacarPedidos: TStrHolder;
    UPDHdR: TZQuery;
    UPDHdRDet: TZQuery;
    DELHdRDet: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure HojaDeRutaAfterInsert(DataSet: TDataSet);
    procedure HojaDeRutaDetallesAfterInsert(DataSet: TDataSet);
  private
    bArtSonBultos: Boolean;
    bPagoDestino: Boolean;

    procedure RenumerarDetalle;
    procedure TotalizarPedidos (refHojaDeRuta: GUID_ID);
    procedure CargarEtiquetas;


  public
    procedure Nuevo;
    procedure Editar (refHojaDeRuta: GUID_ID);
    procedure LevantarRenglon (refHojaDeRutaDetalle: GUID_ID);
    procedure GrabarDetalles;
    procedure Grabar;

    procedure ModificarPosicionPedido(pasos: integer);
    procedure CambiarEstado(elEstado: integer);
    procedure CambiarEstadosPedidos;

    procedure AgregarPedido (refPedido: GUID_ID);
    procedure EliminarPedido;

    procedure ImprimirFrmHdR(refHojaDeRuta: GUID_ID);
    procedure ImprimirHdRTotalizada(refHojaDeRuta: GUID_ID);
    procedure ImprimirEtiquetasHdR(refHojaDeRuta: GUID_ID; accion: TReportAction);

  end;

var
  DM_HojaDeRuta: TDM_HojaDeRuta;

implementation
{$R *.lfm}
uses
  SD_Configuracion
  ,dmempresa
  ,dmpedidos
  ,dmclientes
  ,dmtransportistas
  ,rpt_etiquetas_hdr
  ;


{ TDM_HojaDeRuta }

procedure TDM_HojaDeRuta.DataModuleCreate(Sender: TObject);
begin
  bArtSonBultos:= StrToBoolDef(LeerDato(SECCION_APP, ART_BULTOS), true);
  bPagoDestino:= StrToBoolDef(LeerDato(SECCION_APP, PG_DESTINO), false);
end;

procedure TDM_HojaDeRuta.DataModuleDestroy(Sender: TObject);
begin
  EscribirDato(SECCION_APP, ART_BULTOS, BoolToStr(bArtSonBultos));
  EscribirDato(SECCION_APP, PG_DESTINO, BoolToStr(bPagoDestino));
end;

procedure TDM_HojaDeRuta.HojaDeRutaAfterInsert(DataSet: TDataSet);
begin
  HojaDeRutaid.AsString:= DM_General.CrearGUID;
  HojaDeRutanumero.AsInteger:= -1;
  HojaDeRutatransportista_id.AsString:= GUIDNULO;
  HojaDeRutaFecha.AsDateTime:= Now;
  HojaDeRutabAnulada.AsInteger:= 0;
  HojaDeRutafAnulada.AsDateTime:= 0;
  HojaDeRutabVisible.asInteger:= 1;
  HojaDeRutafPresentada.AsDateTime:= 0;
  HojaDeRutaEstado.asInteger:= HdR_ESTADO_REALIZADA;
end;

procedure TDM_HojaDeRuta.HojaDeRutaDetallesAfterInsert(DataSet: TDataSet);
begin
  HojaDeRutaDetallesid.AsString:= DM_General.CrearGUID;
  HojaDeRutaDetalleshojaDeRuta_id.AsString:= HojaDeRutaid.AsString;
  HojaDeRutaDetallesnroOrdena.AsInteger:= HojaDeRutaDetalles.RecordCount;
  HojaDeRutaDetallespedido_id.AsString:= GUIDNULO;
  HojaDeRutaDetallesclienteDireccion_id.AsString:= GUIDNULO;
  HojaDeRutaDetallesbultos.AsInteger:= 0;
  if bPagoDestino then
    HojaDeRutaDetallesbCobroDestino.AsInteger:= 1
  else
   HojaDeRutaDetallesbCobroDestino.AsInteger:= 0;
  HojaDeRutaDetallesmontoCobrar.AsFloat:= 0;
  HojaDeRutaDetallesnota.AsString:= '-';
  HojaDeRutaDetallesbEntregaCompleto.AsInteger:= 0;
  HojaDeRutaDetallesmontoCobrado.AsFloat:= 0;
  HojaDeRutaDetallesdevolucion_id.AsString:= GUIDNULO;
  HojaDeRutaDetallesbNoEntregado.AsInteger:= 0;
  HojaDeRutaDetallesmotivoNoEntrega_id.AsInteger:= 0;
  HojaDeRutaDetallesbVisible.AsInteger:= 1;
  HojaDeRutaDetalleslxPedidoNro.AsInteger:= 0;
  HojaDeRutaDetalleslxCliente.asString:= EmptyStr;
  HojaDeRutaDetalleslxClienteDir.AsString:= EmptyStr;
end;


procedure TDM_HojaDeRuta.Nuevo;
begin
  DM_General.ReiniciarTabla(HojaDeRuta);
  DM_General.ReiniciarTabla(HojaDeRutaDetalles);
  HojaDeRuta.Insert;
end;

procedure TDM_HojaDeRuta.Editar(refHojaDeRuta: GUID_ID);
begin
  DM_General.ReiniciarTabla(HojaDeRuta);
  DM_General.ReiniciarTabla(HojaDeRutaDetalles);

  With SELHdR do
  begin
    if active then close;
    ParamByName('id').asString:= refHojaDeRuta;
    open;
    HojaDeRuta.LoadFromDataSet(SELHdR, 0, lmAppend);
    Close;
  end;

  with qDetHdR do
  begin
    if active then close;
    ParamByName('HojaDeRuta_ID').asString:= refHojaDeRuta;
    open;
    HojaDeRutaDetalles.LoadFromDataSet(qDetHdR, 0, lmAppend);
    Close;
    HojaDeRutaDetalles.SortOnFields('nroOrdena');
  end;

end;

procedure TDM_HojaDeRuta.LevantarRenglon(refHojaDeRutaDetalle: GUID_ID);
begin
  DM_General.ReiniciarTabla(HojaDeRutaDetalles);

  with SELHdRDet  do
  begin
    if active then close;
    ParamByName('id').asString:= refHojaDeRutaDetalle;
    open;
    HojaDeRutaDetalles.LoadFromDataSet(SELHdRDet, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_HojaDeRuta.GrabarDetalles;
begin
  DM_General.GrabarDatos(SELHdRDet, INSHdRDet, UPDHdRDet, HojaDeRutaDetalles, 'id');
end;

procedure TDM_HojaDeRuta.Grabar;
begin
  DM_General.cnxBase.StartTransaction;
  try
    DM_General.GrabarDatos(SELHdR, INSHdR, UPDHdR, HojaDeRuta, 'id');
    GrabarDetalles;
//    CambiarEstadosPedidos;
    DM_General.cnxBase.Commit;
  except
    DM_General.cnxBase.Rollback;
  end;

end;

procedure TDM_HojaDeRuta.RenumerarDetalle;
var
  marca: TBookmark;
  idx: integer;
begin
  with HojaDeRutaDetalles do
  begin
    marca:= GetBookmark;
    try
      First;
      idx:= 0;
      While Not Eof do
      begin
        Edit;
        HojaDeRutaDetallesnroOrdena.AsInteger:= idx;
        Inc(idx);
        Post;
        Next;
      end;
      GotoBookmark(marca);
    finally
      FreeBookmark(marca);
    end;
  end;
end;

procedure TDM_HojaDeRuta.CambiarEstadosPedidos;
var
  idx: integer;
  tempo: string;
begin

  With HojaDeRutaDetalles do
  begin
    DisableControls;
    First;
    While Not EOF do
    begin
      DM_Pedidos.CambiarEstadoPedido(EST_TRANSP, HojaDeRutaDetallespedido_id.AsString);
      Next;
    end;
    EnableControls;
  end;

  for idx:= 0 to sacarPedidos.Strings.Count -1 do
  begin
    //Valido que se esté trabajando sobre un estado transportista antes de volverlo al estado de ARMADO
    DM_Pedidos.LevantarPedido(sacarPedidos.Strings[idx]);
    DM_Pedidos.LevantarEstadoActual;
    tempo:= sacarPedidos.Strings[idx];
    if DM_Pedidos.PedidosEstadostipoEstado_id.AsInteger = EST_TRANSP then
      DM_Pedidos.CambiarEstadoPedido(EST_ARMADO, sacarPedidos.Strings[idx]);
  end;

end;


procedure TDM_HojaDeRuta.ModificarPosicionPedido(pasos: integer);
var
  tmp: integer;
  marca: TBookmark;
begin
  with HojaDeRutaDetalles do
  begin
    marca:= GetBookmark;
    Edit;
    HojaDeRutaDetallesnroOrdena.AsInteger:= HojaDeRutaDetallesnroOrdena.AsInteger + pasos;
    Post;
    if pasos > 0 then
    begin //Avanzo
      next;
      next;
      While Not eof do
      begin
        Edit;
        HojaDeRutaDetallesnroOrdena.AsInteger:= HojaDeRutaDetallesnroOrdena.AsInteger + 1;
        Post;
        Next;
      end;
    end
    else //Retrocedo
    begin
      Prior;
      Prior;
      While Not bof do
      begin
        Edit;
        HojaDeRutaDetallesnroOrdena.AsInteger:= HojaDeRutaDetallesnroOrdena.AsInteger - 1;
        Post;
        Prior;
      end;
    end;
    GotoBookmark(marca);
    FreeBookmark(marca);
  end;
  HojaDeRutaDetalles.SortOnFields('nroOrdena');
  RenumerarDetalle;
end;

procedure TDM_HojaDeRuta.CambiarEstado(elEstado: integer);
begin
  With HojaDeRuta do
  begin
    Edit;
    HojaDeRutaEstado.AsInteger:= elEstado;
    Post;
  end;
end;

procedure TDM_HojaDeRuta.AgregarPedido(refPedido: GUID_ID);
begin
  if NOT HojaDeRutaDetalles.Locate('pedido_id',refPedido, []) then
  begin
    DM_Pedidos.LevantarPedido(refPedido);
    DM_Clientes.Editar(DM_Pedidos.Pedidoscliente_id.AsString);

    HojaDeRutaDetalles.Insert;
    HojaDeRutaDetallespedido_id.AsString:= refPedido;
    if bArtSonBultos then
      HojaDeRutaDetallesbultos.AsInteger:= DM_Pedidos.CantidadArticulosPedido;
    HojaDeRutaDetallesmontoCobrar.AsFloat:= DM_Pedidos.PedidosTotalPedido.AsFloat;
    //Por defecto se cobra todo lo presentado
    HojaDeRutaDetallesmontoCobrado.asFloat:= DM_Pedidos.PedidosTotalPedido.AsFloat;
    HojaDeRutaDetalleslxCliente.AsString:= DM_Clientes.RazonSocial;
    HojaDeRutaDetallesclienteDireccion_id.AsString:= DM_Empresa.Domiciliosid.AsString;
    HojaDeRutaDetalleslxClienteDir.AsString:= DM_Clientes.Domicilio;
    HojaDeRutaDetalleslxPedidoNro.asInteger:= DM_Pedidos.Pedidosnumero.AsInteger;
    HojaDeRutaDetalles.Post;
    HojaDeRutaDetalles.SortOnFields('nroOrdena');
  end;
end;

procedure TDM_HojaDeRuta.EliminarPedido;
begin
  if ((HojaDeRutaDetalles.Active) and (HojaDeRutaDetalles.RecordCount > 0)) then
  begin
    sacarPedidos.Strings.Add(HojaDeRutaDetallespedido_id.AsString);
    DELHdRDet.ParamByName('id').AsString:= HojaDeRutaDetallesid.AsString;
    DELHdRDet.ExecSQL;
    HojaDeRutaDetalles.Delete;
  end;

end;

(*******************************************************************************
*** LISTADOS
*******************************************************************************)

procedure TDM_HojaDeRuta.ImprimirFrmHdR(refHojaDeRuta: GUID_ID);
begin
  Editar(refHojaDeRuta);
  DM_General.LevantarReporte(FORMULARIO_HDR, HojaDeRutaDetalles);
  DM_Transportistas.Editar(HojaDeRutatransportista_id.AsString);
  DM_General.AgregarVariableReporte('Transportista',DM_Transportistas.RazonSocial);
  DM_General.EjecutarReporte;
end;

procedure TDM_HojaDeRuta.TotalizarPedidos(refHojaDeRuta: GUID_ID);
begin
  with qTotalizarHdR do
  begin
    if active then close;
    ParamByName('hojaderuta_id').AsString:= refHojaDeRuta;
    Open;
  end;
end;

procedure TDM_HojaDeRuta.ImprimirHdRTotalizada(refHojaDeRuta: GUID_ID);
begin
  Editar(refHojaDeRuta);
  TotalizarPedidos (refHojaDeRuta);
  DM_General.LevantarReporte(FORMULARIO_HDR_TOTALIZADO, qTotalizarHdR);
  DM_Transportistas.Editar(HojaDeRutatransportista_id.AsString);
  DM_General.AgregarVariableReporte('Transportista',DM_Transportistas.RazonSocial);
  DM_General.EjecutarReporte;
end;


procedure TDM_HojaDeRuta.CargarEtiquetas;
var
  nroHdR, nroPedido
  , bulto, totalbultos: integer;
  cliente, direccion: string;
begin
  DM_General.ReiniciarTabla(Etiquetas);

  with HojaDeRutaDetalles do
  begin
    if (active and (RecordCount > 0)) then
    begin
      First;
      While Not EOF do
      begin
        bulto:= 1;
        totalbultos:= HojaDeRutaDetallesbultos.AsInteger;
        nroHdR:= HojaDeRutanumero.AsInteger;
        nroPedido:= HojaDeRutaDetalleslxPedidoNro.AsInteger;
        cliente:= HojaDeRutaDetalleslxCliente.AsString;
        direccion:= HojaDeRutaDetalleslxClienteDir.AsString;

        while (bulto <= totalbultos) do
        begin
          Etiquetas.Insert;
          EtiquetasNroHojaDeRuta.AsInteger:= nroHdR;
          EtiquetasNroPedido.AsInteger:= nroPedido;
          EtiquetasCliente.AsString:= cliente;
          EtiquetasDireccion.AsString:= direccion;
          EtiquetasBulto.AsInteger:= bulto;
          EtiquetasBultosTotal.AsInteger:= totalbultos;
          Etiquetas.Post;
          Inc(bulto);
        end;

        Next;
      end;
      Etiquetas.SortOnFields('NroPedido;BultosTotal;Bulto');
    end;
  end;
end;

procedure TDM_HojaDeRuta.ImprimirEtiquetasHdR(refHojaDeRuta: GUID_ID;
  accion: TReportAction);
var
  rep: TrepEtiquetasHdR;
begin
  Editar(refHojaDeRuta);
  CargarEtiquetas;
  rep:= TrepEtiquetasHdR.Create(self);
  try
   rep.dm:= Self;
   rep.RunReport(accion);

  finally
    rep.Free;
  end;


end;

end.

