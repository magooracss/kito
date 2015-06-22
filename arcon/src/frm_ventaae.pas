unit frm_ventaae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DBDateTimePicker, Forms, Controls, Graphics,
  Dialogs, StdCtrls, ExtCtrls, Buttons, DBExtCtrls, dmgeneral;

type

  { TfrmVentasAE }

  TfrmVentasAE = class(TForm)
    btnClienteNuevo: TBitBtn;
    btnBuscar: TBitBtn;
    cbTipoComprobante: TComboBox;
    DBDateEdit1: TDBDateEdit;
    edCliente: TEdit;
    edCUIT: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnClienteNuevoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    _ventaID: GUID_ID;
  public
    property ventaID: GUID_ID read _ventaID write _VentaID;
  end;

var
  frmVentasAE: TfrmVentasAE;

implementation
{$R *.lfm}
uses
  dmventas
  ,frm_busquedaempresas
  ,frm_clientesae
  ;

{ TfrmVentasAE }

procedure TfrmVentasAE.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_Ventas, DM_Ventas);
end;

procedure TfrmVentasAE.btnBuscarClick(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(self);
  try
    pantBus.restringirTipo:= IDX_CLIENTE;
    if pantBus.ShowModal = mrOK then
    begin
      edCliente.Text:= pantBus.RazonSocial;
      edCUIT.Text:= pantBus.CUIT;
    end;
  finally
    pantBus.Free;
  end;
end;

procedure TfrmVentasAE.btnClienteNuevoClick(Sender: TObject);
var
  pant: TfrmClientesAE;
begin
  pant:= TfrmClientesAE.Create(self);
  try
    pant.idCliente:= GUIDNULO;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;

procedure TfrmVentasAE.FormDestroy(Sender: TObject);
begin
  DM_Ventas.Free;
end;

end.

