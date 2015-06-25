unit dmventas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  , dmgeneral;

type

  { TDM_Ventas }

  TDM_Ventas = class(TDataModule)
    PedidosfToma: TDateTimeField;
    Pedidosid: TStringField;
    PedidosNumero: TLongintField;
    PedidosTotalPedido: TFloatField;
    qTiposComprobantes: TZQuery;
    Pedidos: TRxMemoryData;
    ComproVta: TRxMemoryData;
    ComproVtaConceptos: TRxMemoryData;
  private
    { private declarations }
  public
    procedure AgregarPedido (refPedido: GUID_ID);
    procedure AgregarConceptoPedidos;
  end;

var
  DM_Ventas: TDM_Ventas;

implementation
{$R *.lfm}
uses
  dmpedidos
  ;

{ TDM_Ventas }

procedure TDM_Ventas.AgregarPedido(refPedido: GUID_ID);
begin
  DM_Pedidos.LevantarPedido(refPedido);
  Pedidos.LoadFromDataSet(DM_Pedidos.Pedidos, 0, lmAppend);
end;

procedure TDM_Ventas.AgregarConceptoPedidos;
begin
  Pedidos.First;
  While Not Pedidos.EOF do
  begin
    DM_Pedidos.VincularFactura();

    Pedidos.Next;
  end;
end;

end.

