unit frm_buscarrecibosinternos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxspin, tooledit, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons, DBGrids, dmgeneral
  ,dmbusquedarecibosinternos;

type

  { TfrmBusRecibosInternos }

  TfrmBusRecibosInternos = class(TForm)
    btnBuscar: TBitBtn;
    btnBuscarCliente: TBitBtn;
    btnCancelar: TBitBtn;
    btnImprimir: TBitBtn;
    btnSeleccionar: TBitBtn;
    ds_resultados: TDataSource;
    edCliente: TEdit;
    edFecha: TRxDateEdit;
    edNro: TRxSpinEdit;
    Grilla: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PCBusqueda: TPageControl;
    RgCriterio: TRadioGroup;
    tabCliente: TTabSheet;
    tabFecha: TTabSheet;
    tabNro: TTabSheet;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RgCriterioSelectionChanged(Sender: TObject);
  private
    idCliente: GUID_ID;
    dmBusqueda: TDM_BusquedaRecibosInternos;
    procedure Buscar;
    function getIdRecibo: GUID_ID;
  public
   property idRecibo: GUID_ID read getIdRecibo;
  end;

var
  frmBusRecibosInternos: TfrmBusRecibosInternos;

implementation
{$R *.lfm}
uses
    frm_busquedaempresas
  , dmrecibosinternos
  ;

{ TfrmBusRecibosInternos }

procedure TfrmBusRecibosInternos.btnBuscarClienteClick(Sender: TObject);
var
  pant: TfrmBusquedaEmpresas;
begin
  pant:= TfrmBusquedaEmpresas.Create(self);
  try
    pant.restringirTipo:= IDX_CLIENTE;
    if pant.ShowModal = mrOK then
    begin
      edCliente.Text:= pant.RazonSocial;
      idCliente:= pant.idCliente;
     end;
     Buscar;
  finally
    pant.Free;
  end;
end;

procedure TfrmBusRecibosInternos.btnBuscarClick(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmBusRecibosInternos.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmBusRecibosInternos.btnImprimirClick(Sender: TObject);
var
  dmRI: TDM_RecibosInternos;
begin
  dmRI:= TDM_RecibosInternos.Create(self);
  try
    dmRI.Print(idRecibo);
  finally
    dmRI.Free;
  end;

end;

procedure TfrmBusRecibosInternos.btnSeleccionarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmBusRecibosInternos.FormCreate(Sender: TObject);
begin
  dmBusqueda:= TDM_BusquedaRecibosInternos.Create(self);

  ds_resultados.DataSet:= dmBusqueda.Resultados;
end;

procedure TfrmBusRecibosInternos.FormDestroy(Sender: TObject);
begin
  dmBusqueda.Free;
end;

procedure TfrmBusRecibosInternos.FormShow(Sender: TObject);
begin
  edFecha.Date:= now;
  PCBusqueda.ActivePage:= tabFecha;
  RgCriterio.ItemIndex:= 1;
end;

procedure TfrmBusRecibosInternos.RgCriterioSelectionChanged(Sender: TObject);
begin
  case RgCriterio.ItemIndex of
   0: PCBusqueda.ActivePage:= tabNro;
   1: PCBusqueda.ActivePage:= tabFecha;
   2: PCBusqueda.ActivePage:= tabCliente;
  end;
end;

procedure TfrmBusRecibosInternos.Buscar;
begin
  case PCBusqueda.ActivePageIndex of
    0: dmBusqueda.BusNumero(edNro.AsInteger);
    1: dmBusqueda.BusFecha(edFecha.Date);
    2: dmBusqueda.BusCliente(idCliente);
  end;
end;

function TfrmBusRecibosInternos.getIdRecibo: GUID_ID;
begin
  if dmBusqueda.Resultados.RecordCount > 0 then
    Result:= dmBusqueda.ResultadosidRecibo.AsString
  else
    Result:= GUIDNULO;
end;

end.

