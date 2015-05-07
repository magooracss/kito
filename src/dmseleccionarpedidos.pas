unit dmseleccionarpedidos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ;

type

  { TDM_SeleccionarPedidos }

  TDM_SeleccionarPedidos = class(TDataModule)
    qPedidosEstadoCLIENTE: TStringField;
    qPedidosEstadoESTADO: TStringField;
    qPedidosEstadoFPROMETIDO: TDateField;
    qPedidosEstadoFTOMADO: TDateField;
    qPedidosEstadoIDPEDIDO: TStringField;
    qPedidosEstadoMONTO: TFloatField;
    qPedidosEstadoNROPEDIDO: TLongintField;
    SeleccionPedidos: TRxMemoryData;
    SeleccionPedidosCliente: TStringField;
    SeleccionPedidosEstado: TStringField;
    SeleccionPedidosfPrometido: TDateTimeField;
    SeleccionPedidosfTomado: TDateTimeField;
    SeleccionPedidosidPedido: TStringField;
    SeleccionPedidosMonto: TFloatField;
    SeleccionPedidosNroPedido: TLongintField;
    SeleccionPedidosSeleccionado: TBooleanField;
    qPedidosEstado: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure SeleccionPedidosAfterInsert(DataSet: TDataSet);
  private
    _ListaSeleccion: TStringList;
    function getPedidosSeleccionados: TStringList;
    { private declarations }
  public
    property PedidosSeleccionados: TStringList read getPedidosSeleccionados;
    procedure NuevaSeleccion;
    procedure ObtenerPedidosEstado (refEstado: integer);

    procedure CambiarEstadoFila;
  end;

var
  DM_SeleccionarPedidos: TDM_SeleccionarPedidos;

implementation

{$R *.lfm}

{ TDM_SeleccionarPedidos }


procedure TDM_SeleccionarPedidos.DataModuleCreate(Sender: TObject);
begin
  _ListaSeleccion:= TStringList.Create;
  DM_General.ReiniciarTabla(SeleccionPedidos);
end;

procedure TDM_SeleccionarPedidos.DataModuleDestroy(Sender: TObject);
begin
  _ListaSeleccion.Free;
end;

procedure TDM_SeleccionarPedidos.SeleccionPedidosAfterInsert(DataSet: TDataSet);
begin
  SeleccionPedidosSeleccionado.AsBoolean:= false;
end;

function TDM_SeleccionarPedidos.getPedidosSeleccionados: TStringList;
var
  marca: TBookmark;
begin
  _ListaSeleccion.Clear;
  with SeleccionPedidos do
  begin
    if ((Active) and (RecordCount > 0)) then
    begin
      marca:= GetBookmark;
      First;
      While Not EOF do
      begin
        if SeleccionPedidosSeleccionado.AsBoolean then
          _ListaSeleccion.Add(SeleccionPedidosidPedido.AsString);
        Next;
      end;
    end;
    GotoBookmark(marca);
    FreeBookmark(marca);
  end;
  //Si no llega a seleccionar nada, devuelvo el registro actual como el marcado
  if _ListaSeleccion.Count = 0 then
   _ListaSeleccion.Add(SeleccionPedidosidPedido.AsString);

  Result:= _ListaSeleccion;

end;

procedure TDM_SeleccionarPedidos.NuevaSeleccion;
begin
  DM_General.ReiniciarTabla(SeleccionPedidos);
end;

procedure TDM_SeleccionarPedidos.ObtenerPedidosEstado(refEstado: integer);
begin
  with qPedidosEstado do
  begin
    if active then close;
    ParamByName('tipoEstado_id').asInteger:= refEstado;
    Open;
    SeleccionPedidos.LoadFromDataSet(qPedidosEstado, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_SeleccionarPedidos.CambiarEstadoFila;
begin
  With SeleccionPedidos do
  begin
    Edit;
    SeleccionPedidosSeleccionado.AsBoolean:= NOT SeleccionPedidosSeleccionado.AsBoolean;
    Post;
  end;
end;

end.

