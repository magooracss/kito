unit frm_recibointernoconcepto;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbcurredit, Forms, Controls, Graphics,
  Dialogs, DbCtrls, StdCtrls, Buttons, dmrecibosinternos
  ,dmgeneral;

type

  { TfrmRecIntConceptoAE }

  TfrmRecIntConceptoAE = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    btnVincularPedido: TBitBtn;
    DBEdit1: TDBEdit;
    ds_conceptos: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    RxDBCurrEdit1: TRxDBCurrEdit;
    procedure btnVincularPedidoClick(Sender: TObject);
  private
    idCliente: GUID_ID;
    dmRecibos: TDM_RecibosInternos;
  public
    constructor Create (MrOwner: TComponent; var dm: TDM_RecibosInternos; clienteID: GUID_ID);
  end;

var
  frmRecIntConceptoAE: TfrmRecIntConceptoAE;

implementation
{$R *.lfm}
uses
  frm_seleccionarpedidos
  ,dmpedidos;

{ TfrmRecIntConceptoAE }

procedure TfrmRecIntConceptoAE.btnVincularPedidoClick(Sender: TObject);
var
  pant: TfrmSeleccionarPedidos;
  idPedido: GUID_ID;
  texto: string;
  Monto: double;
begin
  pant:= TfrmSeleccionarPedidos.Create(self);
  pant.restringirCliente:= idCliente;
  try
    if pant.ShowModal = mrOK then
    begin
      if pant.PedidosSeleccionados.Count > 0 then
      begin
       idPedido:= pant.PedidosSeleccionados[0];
       DM_Pedidos.LevantarPedido(idPedido);
       texto:= 'Pedido: ' + IntToStr(DM_Pedidos.Pedidosnumero.AsInteger);
       monto:= DM_Pedidos.PedidosTotalPedido.AsFloat;
      end
      else
      begin
        idPedido:= GUIDNULO;
        texto:= 'Error al recuperar los datos del pedido';
        monto:= 0;
      end;
    end
    else
    begin
      idPedido:= GUIDNULO;
      texto:= EmptyStr;
      monto:= 0;
    end;

     with dmRecibos do
     begin
       RecibosIntCptos.Edit;
       RecibosIntCptospedido_id.AsString:= idPedido;
       RecibosIntCptosconcepto.AsString:= texto;
       RecibosIntCptosmonto.AsFloat:= monto;
       RecibosIntCptos.Post;
     end;
  finally
    pant.free;
  end;

end;

constructor TfrmRecIntConceptoAE.Create(MrOwner: TComponent;
  var dm: TDM_RecibosInternos; clienteID: GUID_ID);
begin
  inherited Create (MrOwner) ;
  dmRecibos:= dm;
  ds_conceptos.DataSet:= dmRecibos.RecibosIntCptos;
  idCliente:= clienteID;

end;

end.

