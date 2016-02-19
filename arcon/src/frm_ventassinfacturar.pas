unit frm_ventassinfacturar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, DBGrids, EditBtn, Buttons, StdCtrls
  ,dmgeneral
  ,dmventasSinFacturar;

type

  { TfrmVentasSinFacturar }

  TfrmVentasSinFacturar = class(TForm)
    BitBtn1: TBitBtn;
    btnImprimir: TBitBtn;
    btnFacturar: TBitBtn;
    btnEditar: TBitBtn;
    btnAnular: TBitBtn;
    btnFiltrar: TBitBtn;
    btnBuscarCliente: TBitBtn;
    ckSinFacturar: TCheckBox;
    ckSinCAE: TCheckBox;
    ds_Comprobantes: TDataSource;
    edIni: TDateEdit;
    edFin: TDateEdit;
    DBGrid1: TDBGrid;
    edRazonSocial: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnAnularClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnFacturarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _clienteID: GUID_ID;
    dmVentasSF: TDM_VentasSinFacturar;
    procedure Inicializar;
    procedure Filtrar;
  public
    { public declarations }
  end;

var
  frmVentasSinFacturar: TfrmVentasSinFacturar;

implementation
{$R *.lfm}
uses
  frm_busquedaempresas
  ,dateutils
  ,dmfacturas
  ,frm_ventaae
  ,dmfacturaelectronica
  ,dmventas
  ;

{ TfrmVentasSinFacturar }

procedure TfrmVentasSinFacturar.btnBuscarClienteClick(Sender: TObject);
var
  pant: TfrmBusquedaEmpresas;
begin
  pant:= TfrmBusquedaEmpresas.Create(self);
  try
    pant.restringirTipo:= IDX_CLIENTE;
    if pant.ShowModal = mrOK then
    begin
      _clienteID:= pant.idCliente;
      edRazonSocial.Text:= pant.RazonSocial;
    end
    else
    begin
      _clienteID:= GUIDNULO;
      edRazonSocial.Clear;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmVentasSinFacturar.btnFiltrarClick(Sender: TObject);
begin
 Filtrar;
end;

procedure TfrmVentasSinFacturar.FormCreate(Sender: TObject);
begin
  dmVentasSF:= TDM_VentasSinFacturar.Create(self);
  ds_Comprobantes.DataSet:= dmVentasSF.Comprobantes;
end;

procedure TfrmVentasSinFacturar.FormDestroy(Sender: TObject);
begin
  dmVentasSF.Free;
end;

procedure TfrmVentasSinFacturar.BitBtn1Click(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmVentasSinFacturar.btnAnularClick(Sender: TObject);
var
  ventasDM: TDM_Ventas;
  feDM: TDM_FacturaElectronica;
begin
  ventasDM:= TDM_Ventas.Create(self);
  feDM:= TDM_FacturaElectronica.Create(self);
  try
    if (MessageDlg ('Confirmación'
                     , 'Desea ELIMINAR el comprobante seleccionado?'
                      , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
    begin
      ventasDM.AnularComprobante(dmVentasSF.Comprobantesid.AsString);
      feDM.eliminarComprobante (dmVentasSF.Comprobantesfactura_id.AsString);
    end;
  finally
    ventasDM.Free;
    feDM.Free;
  end;
end;

procedure TfrmVentasSinFacturar.btnEditarClick(Sender: TObject);
var
  pant: TfrmVentasAE;
begin
  pant:= TfrmVentasAE.Create(self);
  try
    pant.ventaID:= dmVentasSF.Comprobantesid.AsString;
    if pant.ShowModal = mrOK then
     Filtrar;
  finally
    pant.Free;
  end;
end;

procedure TfrmVentasSinFacturar.btnFacturarClick(Sender: TObject);
var
  elDM: TDM_FacturaElectronica;
begin
  elDM:= TDM_FacturaElectronica.Create(self);
  try
    elDM.FacturarVenta(dmVentasSF.Comprobantesid.AsString);
  finally
    elDM.Free;
  end;
end;

procedure TfrmVentasSinFacturar.btnImprimirClick(Sender: TObject);
var
  eldm: TDM_Facturas;
begin
  eldm:= TDM_Facturas.Create(self);
  try
    if dmVentasSF.Comprobantesfactura_id.AsString <> GUIDNULO then
      elDm.ImprimirFactura(dmVentasSF.Comprobantesfactura_id.AsString)
    else
      ShowMessage('Solamente se pueden imprimir las facturas sin CAE');
  finally
    elDM.Free;
  end;
end;

procedure TfrmVentasSinFacturar.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmVentasSinFacturar.Inicializar;
var
  dia,mes, ano: word;
begin
  DecodeDate(now, ano, mes, dia);
  edIni.Date:= EncodeDate(ano, mes, 1);
  edFin.Date:= EncodeDate(ano,mes, DaysInAMonth(ano, mes));
  edRazonSocial.Clear;
  ckSinFacturar.Checked:= true;
  ckSinCAE.Checked:= False;
end;

procedure TfrmVentasSinFacturar.Filtrar;
begin
  if (TRIM(edRazonSocial.Text) = EmptyStr) then
    _clienteID:= GUIDNULO;
  dmVentasSF.clienteID:= _clienteID;
  dmVentasSF.sinFacturar:= ckSinFacturar.Checked;
  dmVentasSF.sinCAE:= ckSinCAE.Checked;
  dmVentasSF.ObtenerVentas (edIni.Date, edFin.date);
end;

end.

