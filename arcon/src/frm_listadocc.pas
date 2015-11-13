unit frm_listadocc;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, EditBtn, StdCtrls, Buttons
  ,dmcuentacorriente
  ,dmgeneral
  ;

type

  { TfrmListadoCC }

  TfrmListadoCC = class(TForm)
    btnBuscarEmpresa: TBitBtn;
    btnExportar: TBitBtn;
    btnObtener: TBitBtn;
    btnSalir: TBitBtn;
    ckIncluir: TCheckGroup;
    edFechaIni: TDateEdit;
    edFechaFin: TDateEdit;
    ds_listadoCC: TDataSource;
    edEmpresa: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    RxDBGrid1: TRxDBGrid;
    edSaldo: TStaticText;
    SD: TSaveDialog;
    procedure btnBuscarEmpresaClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure btnObtenerClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    dmCuentaCorriente: TDM_CuentaCorriente;
    _idEmpresa: GUID_ID;

    procedure Filtrar;
  public

    { public declarations }
  end;

var
  frmListadoCC: TfrmListadoCC;

implementation
{$R *.lfm}
uses
  dateutils
  ,frm_busquedaempresas
  ;

const
  MAX_INCLUIR = 4; //Cantidad de items a incluir (Compras, ventas, OP, Pedidos)
  INC_COMPRAS = 0;
  INC_VENTAS = 1;
  INC_OP = 2;
  INC_PEDIDOS = 3;

{ TfrmListadoCC }

procedure TfrmListadoCC.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
  dmCuentaCorriente.Free;
end;

procedure TfrmListadoCC.FormCreate(Sender: TObject);
begin
  dmCuentaCorriente:= TDM_CuentaCorriente.Create(self);
  ds_listadoCC.DataSet:= dmCuentaCorriente.CuentaCorriente;
  _idEmpresa:= GUIDNULO;
end;

procedure TfrmListadoCC.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmListadoCC.FormShow(Sender: TObject);
var
  idx: integer;
begin
  edFechaIni.Date:= EncodeDate(YearOf(now),MonthOf(Now),1);
  edFechaFin.Date:= EncodeDate(YearOf(Now),MonthOf(Now), DaysInMonth(Now));

  for idx:= 0 to MAX_INCLUIR -1 do
    ckIncluir.Checked[idx]:= true;

  edEmpresa.Clear;
end;

procedure TfrmListadoCC.Filtrar;
var
  idx: integer;
begin
  for idx:= 0 to MAX_INCLUIR - 1 do
    case idx of
      INC_COMPRAS: dmCuentaCorriente.incluirCompras:= ckIncluir.Checked[idx];
      INC_VENTAS: dmCuentaCorriente.incluirVentas:= ckIncluir.Checked[idx];
      INC_OP: dmCuentaCorriente.incluirOP:= ckIncluir.Checked[idx];
      INC_PEDIDOS: dmCuentaCorriente.incluirPedidos:= ckIncluir.Checked[idx];
    end;

  dmCuentaCorriente.empresaID:= _idEmpresa;

  dmCuentaCorriente.ListadoCompleto (edFechaIni.Date, edFechaFin.Date);
end;

procedure TfrmListadoCC.btnObtenerClick(Sender: TObject);
begin
  Filtrar;
  edSaldo.Caption:= 'Saldo: $' + FormatFloat('#############0.00',dmCuentaCorriente.Saldo);
end;

procedure TfrmListadoCC.btnBuscarEmpresaClick(Sender: TObject);
var
  pant: TfrmBusquedaEmpresas;
begin
  pant:= TfrmBusquedaEmpresas.Create(self);
  try
    pant.restringirTipo:= IDX_NINGUNO;
    if pant.ShowModal = mrOK then
    begin
      _idEmpresa:= pant.idEmpresa;
      edEmpresa.Text:= pant.RazonSocial;
    end
    else
    begin
      _idEmpresa:= GUIDNULO;
      edEmpresa.Clear;
    end;
  finally
    pant.Free;
  end;

end;

procedure TfrmListadoCC.btnExportarClick(Sender: TObject);
begin
  if _idEmpresa <> GUIDNULO then
    SD.FileName:= 'cc_' + TRIM(edEmpresa.text)+ '.xls';
  if SD.Execute then
    DM_General.ExportarXLS(dmCuentaCorriente.CuentaCorriente, sd.FileName, 'CuentaCorriente');
end;


end.

