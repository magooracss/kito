unit frm_busquedahojaderuta;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxspin, tooledit, Forms, Controls, Graphics,
  Dialogs, ComCtrls, ExtCtrls, Buttons, DBGrids, StdCtrls, dmgeneral
  ;

type

  { TfrmBuscarHdR }

  TfrmBuscarHdR = class(TForm)
    btnBuscarTransp: TBitBtn;
    btnBuscar: TBitBtn;
    btnBuscarCliente: TBitBtn;
    btnCancelar: TBitBtn;
    btnSeleccionar: TBitBtn;
    ds_Grilla: TDataSource;
    edPedido: TRxSpinEdit;
    edTransportista: TEdit;
    edCliente: TEdit;
    Grilla: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    PCBusqueda: TPageControl;
    Panel1: TPanel;
    RgCriterio: TRadioGroup;
    edNroHdR: TRxSpinEdit;
    edFechaHdR: TRxDateEdit;
    tabNroHdR: TTabSheet;
    tabFechaHdR: TTabSheet;
    tabTransp: TTabSheet;
    tabCliente: TTabSheet;
    tabPedido: TTabSheet;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure btnBuscarTranspClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure edFechaHdRKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edNroHdRKeyPress(Sender: TObject; var Key: char);
    procedure FormShow(Sender: TObject);
    procedure RgCriterioSelectionChanged(Sender: TObject);
  private
     idTransportista
    , idCliente: GUID_ID;

    function getIdHojadeRuta: GUID_ID;
    procedure Inicializar;
    procedure BuscarEmpresa (tipo: integer; var RazonSocial: TEdit; var id: GUID_ID );

  public
    property idHojaDeRuta: GUID_ID read getIdHojadeRuta;
    procedure Buscar;
  end;

var
  frmBuscarHdR: TfrmBuscarHdR;

implementation
{$R *.lfm}
uses
  dmbusquedahojaderuta
  ,frm_busquedaempresas
  ;

const
  IDX_tabNroHdR = 0;
  IDX_tabFechaHdR = 1;
  IDX_tabTransportista = 2;
  IDX_tabCliente = 3;
  IDX_tabNroPedido = 4;

  COL_DATOS = 3; //Indice de la columna que maneja datos diversos

{ TfrmBuscarHdR }

procedure TfrmBuscarHdR.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_BuscarHdR, DM_BuscarHdR);
end;

procedure TfrmBuscarHdR.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmBuscarHdR.btnBuscarClick(Sender: TObject);
begin
  Buscar
end;


procedure TfrmBuscarHdR.btnSeleccionarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmBuscarHdR.edFechaHdRKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
   Buscar;
end;

procedure TfrmBuscarHdR.FormDestroy(Sender: TObject);
begin
  DM_BuscarHdR.Free;
end;

procedure TfrmBuscarHdR.edNroHdRKeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
   Buscar;
end;

procedure TfrmBuscarHdR.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmBuscarHdR.RgCriterioSelectionChanged(Sender: TObject);
begin
  PCBusqueda.ActivePageIndex:= RgCriterio.ItemIndex;
end;

function TfrmBuscarHdR.getIdHojadeRuta: GUID_ID;
begin
  with DM_BuscarHdR.Resultados do
  begin
    if ((active) and (RecordCount > 0)) then
    begin
      Result:= FieldByName('id').AsString;
    end
    else
      Result:= GUIDNULO;
  end;
end;

procedure TfrmBuscarHdR.Inicializar;
begin
  Grilla.Columns.Items[COL_DATOS].Visible:= False;
  RgCriterio.ItemIndex:= IDX_tabNroHdR;
  idTransportista:= GUIDNULO;
  idCliente:= GUIDNULO;
  PCBusqueda.ActivePageIndex:= RgCriterio.ItemIndex;
end;

procedure TfrmBuscarHdR.BuscarEmpresa(tipo: integer; var RazonSocial: TEdit;
  var id: GUID_ID);
var
  pant: TfrmBusquedaEmpresas;
begin
  pant:= TfrmBusquedaEmpresas.Create(self);
  try
    pant.restringirTipo:= tipo;
    if pant.ShowModal = mrOK then
    begin
      RazonSocial.Text:= pant.RazonSocial;
      case tipo of
        IDX_TRANSPORTISTA: id:= pant.idTransportista;
        IDX_CLIENTE: id:= pant.idCliente;
      end;
      Buscar;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmBuscarHdR.Buscar;
begin
  Grilla.Columns.Items[COL_DATOS].Visible:= False;
  case PCBusqueda.ActivePageIndex of
    IDX_tabNroHdR: DM_BuscarHdR.BuscarNroHdR(edNroHdR.AsInteger);
    IDX_tabFechaHdR: DM_BuscarHdR.BuscarFechaHdR(edFechaHdR.Date);
    IDX_tabTransportista: DM_BuscarHdR.BuscarTransportista(idTransportista);
    IDX_tabCliente:
    begin
      DM_BuscarHdR.BuscarCliente(idCliente);
      Grilla.Columns.Items[COL_DATOS].Visible:= True;
      Grilla.Columns.Items[COL_DATOS].Title.Caption:= 'Cliente';
    end;
    IDX_tabNroPedido:
    begin
      DM_BuscarHdR.BuscarNroPedido(edPedido.AsInteger);
      Grilla.Columns.Items[COL_DATOS].Visible:= True;
      Grilla.Columns.Items[COL_DATOS].Title.Caption:= 'Número de Pedido';
    end;

  end;
end;

procedure TfrmBuscarHdR.btnBuscarTranspClick(Sender: TObject);
begin
  BuscarEmpresa (IDX_TRANSPORTISTA, edTransportista, idTransportista );
end;

procedure TfrmBuscarHdR.btnBuscarClienteClick(Sender: TObject);
begin
  BuscarEmpresa (IDX_Cliente, edCliente, idCliente );
end;


end.

