unit frm_pedidosbusqueda;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, ComCtrls, Spin, StdCtrls, DBGrids, EditBtn, DbCtrls
  , dmgeneral;

type

  { TfrmPedidosBusqueda }

  TfrmPedidosBusqueda = class(TForm)
    btnImprimir: TBitBtn;
    btnBuscarCliente: TBitBtn;
    btnBuscar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    edFechaToma: TDateEdit;
    ds_Resultados: TDataSource;
    DBGrid1: TDBGrid;
    edClienteRazonSocial: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    PcDatoBusqueda: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    rgCriterio: TRadioGroup;
    edNroPedido: TSpinEdit;
    tabNumero: TTabSheet;
    tabFechaTomado: TTabSheet;
    TabCliente: TTabSheet;
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure edFechaTomaChange(Sender: TObject);
    procedure edNroPedidoKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgCriterioSelectionChanged(Sender: TObject);
  private
    _idCliente: GUID_ID;
    procedure Buscar;
    function getPedidoID: GUID_ID;
  public
    property idPedidoSeleccionado: GUID_ID read getPedidoID;
  end;

var
  frmPedidosBusqueda: TfrmPedidosBusqueda;

implementation
{$R *.lfm}
uses
  dmbusquedapedidos
  ,frm_busquedaempresas
  ,dmpedidos
  ;

{ TfrmPedidosBusqueda }

procedure TfrmPedidosBusqueda.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_BusquedaPedidos, DM_BusquedaPedidos);
  _idCliente:= GUIDNULO;
end;

procedure TfrmPedidosBusqueda.btnBuscarClick(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmPedidosBusqueda.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmPedidosBusqueda.btnGrabarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmPedidosBusqueda.btnImprimirClick(Sender: TObject);
begin
  DM_Pedidos.ImprimirFrmPedido(getPedidoID);
end;

procedure TfrmPedidosBusqueda.edFechaTomaChange(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmPedidosBusqueda.edNroPedidoKeyPress(Sender: TObject; var Key: char
  );
begin
  if key = #13 then
   Buscar;
end;


procedure TfrmPedidosBusqueda.btnBuscarClienteClick(Sender: TObject);
var
  pant: TfrmBusquedaEmpresas;
begin
  pant:= TfrmBusquedaEmpresas.Create(self);
  try
    pant.restringirTipo:= IDX_CLIENTE;
    if pant.ShowModal = mrOK then
    begin
      edClienteRazonSocial.Text:= pant.RazonSocial;
      _idCliente:= pant.idCliente;
      Buscar;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmPedidosBusqueda.FormDestroy(Sender: TObject);
begin
  DM_BusquedaPedidos.Free;
end;

procedure TfrmPedidosBusqueda.FormShow(Sender: TObject);
begin
  PcDatoBusqueda.PageIndex:= rgCriterio.ItemIndex;
end;

procedure TfrmPedidosBusqueda.rgCriterioSelectionChanged(Sender: TObject);
begin
  PcDatoBusqueda.PageIndex:= rgCriterio.ItemIndex;
end;

procedure TfrmPedidosBusqueda.Buscar;
begin
  case rgCriterio.ItemIndex of
   0: DM_BusquedaPedidos.BuscarPorNumero(edNroPedido.Value);
   1: DM_BusquedaPedidos.BuscarPorFToma(edFechaToma.Date);
   2: DM_BusquedaPedidos.BuscarPorCliente(_idCliente);
  end;
end;

function TfrmPedidosBusqueda.getPedidoID: GUID_ID;
begin
  with DM_BusquedaPedidos, Resultados do
  begin
    if ((Active) and (RecordCount > 0)) then
     Result:= Resultadosid.AsString
    else
      Result:= GUIDNULO;
  end;
end;

end.

