unit frm_ventassinfacturar;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, DBGrids, EditBtn, Buttons, StdCtrls
  ,dmgeneral
  ,dmventasSinFacturar;

type

  { TfrmVentasSinFacturar }

  TfrmVentasSinFacturar = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
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
    procedure btnBuscarClienteClick(Sender: TObject);
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
  dmVentasSF.clienteID:= _clienteID;
  dmVentasSF.sinFacturar:= ckSinFacturar.Checked;
  dmVentasSF.sinCAE:= ckSinCAE.Checked;
  dmVentasSF.ObtenerVentas (edIni.Date, edFin.date);
end;

end.

