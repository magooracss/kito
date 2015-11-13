unit frm_busquedaempresas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, DBGrids
  ,dmgeneral
  ;

Const
  CRI_RAZONSOCIAL = 0;
  CRI_CUIT = 1;
  CRI_CODIGO = 2;
  CRI_DOMICILIO = 3;

  IDX_CLIENTE = 0;
  IDX_PROVEEDOR = 1;
  IDX_TRANSPORTISTA = 2;
  IDX_VENDEDOR = 3;
  IDX_NINGUNO = 99;

type

  { TfrmBusquedaEmpresas }

  TfrmBusquedaEmpresas = class(TForm)
    btnBuscar: TBitBtn;
    btnCancelar: TBitBtn;
    btnSeleccionar: TBitBtn;
    ckTipoEmpresa: TCheckGroup;
    DBGrid1: TDBGrid;
    ds_resultados: TDataSource;
    edDatoBusqueda: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    RgCriterioBusqueda: TRadioGroup;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure edDatoBusquedaKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    function getCUIT: string;
    function getIdCliente: GUID_ID;
    function getIdEmpresa: GUID_ID;
    procedure Buscar;
    function getIdProveedor: GUID_ID;
    function getIdTransportista: GUID_ID;
    function getIdVendedor: GUID_ID;
    function getRazonSocial: string;
    procedure SetrestringirTipo(AValue: integer);
    function DevolverResultadoID (tipo: string): GUID_ID;
  public
    property idEmpresa: GUID_ID read getIdEmpresa;
    property idCliente: GUID_ID read getIdCliente;
    property idProveedor: GUID_ID read getIdProveedor;
    property idTransportista: GUID_ID read getIdTransportista;
    property idVendedor: GUID_ID read getIdVendedor;
    property restringirTipo: integer write SetrestringirTipo;
    property RazonSocial: string read getRazonSocial;
    property CUIT: string read getCUIT;

  end;

var
  frmBusquedaEmpresas: TfrmBusquedaEmpresas;

implementation
 {$R *.lfm}
 uses
   dmbusquedaempresas
   ;

{ TfrmBusquedaEmpresas }

procedure TfrmBusquedaEmpresas.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_BusquedaEmpresas, DM_BusquedaEmpresas);
  ds_resultados.DataSet:= DM_BusquedaEmpresas.Resultados;
end;

procedure TfrmBusquedaEmpresas.FormDestroy(Sender: TObject);
begin
    DM_BusquedaEmpresas.Free;
end;

function TfrmBusquedaEmpresas.getCUIT: string;
begin
  Result:= EmptyStr;
  if (DM_BusquedaEmpresas.Resultados.Active)
      and (DM_BusquedaEmpresas.Resultados.RecordCount > 0)then
    Result:= DM_BusquedaEmpresas.ResultadosCuit.AsString;
end;

function TfrmBusquedaEmpresas.getIdCliente: GUID_ID;
begin
  Result:= DevolverResultadoID(TIP_CLIENTES);
end;

function TfrmBusquedaEmpresas.getIdEmpresa: GUID_ID;
begin
  Result:= GUIDNULO;
  if (DM_BusquedaEmpresas.Resultados.Active)
      and (DM_BusquedaEmpresas.Resultados.RecordCount > 0)then
    Result:= DM_BusquedaEmpresas.ResultadosidEmpresa.AsString;
end;

procedure TfrmBusquedaEmpresas.Buscar;
begin
  DM_BusquedaEmpresas.BusquedaNueva;
  case RgCriterioBusqueda.ItemIndex of
   CRI_RAZONSOCIAL:
   begin
      if ckTipoEmpresa.Checked[IDX_CLIENTE] then
        DM_BusquedaEmpresas.BuscarClientesPorRazonSocial(Trim(edDatoBusqueda.Text));
      if ckTipoEmpresa.Checked[IDX_PROVEEDOR] then
        DM_BusquedaEmpresas.BuscarProvPorRazonSocial(Trim(edDatoBusqueda.Text));
      if ckTipoEmpresa.Checked[IDX_TRANSPORTISTA] then
        DM_BusquedaEmpresas.BuscarTransportistaPorRazonSocial(Trim(edDatoBusqueda.Text));
      if ckTipoEmpresa.Checked[IDX_VENDEDOR] then
        DM_BusquedaEmpresas.BuscarVendedorPorRazonSocial(Trim(edDatoBusqueda.Text));
   end;
   CRI_CUIT:
   begin
     if ckTipoEmpresa.Checked[IDX_CLIENTE] then
        DM_BusquedaEmpresas.BuscarClientesPorCUIT(Trim(edDatoBusqueda.Text));
     if ckTipoEmpresa.Checked[IDX_PROVEEDOR] then
       DM_BusquedaEmpresas.BuscarProvPorCuit(Trim(edDatoBusqueda.Text));
     if ckTipoEmpresa.Checked[IDX_TRANSPORTISTA] then
       DM_BusquedaEmpresas.BuscarTransportistaPorCuit(Trim(edDatoBusqueda.Text));
     if ckTipoEmpresa.Checked[IDX_VENDEDOR] then
       DM_BusquedaEmpresas.BuscarVendedorPorCUIT(Trim(edDatoBusqueda.Text));
   end;
   CRI_CODIGO:
   begin
     if ckTipoEmpresa.Checked[IDX_CLIENTE] then
        DM_BusquedaEmpresas.BuscarClientesPorCodigo(Trim(edDatoBusqueda.Text));
     if ckTipoEmpresa.Checked[IDX_PROVEEDOR] then
       DM_BusquedaEmpresas.BuscarProvPorCodigo(Trim(edDatoBusqueda.Text));
     if ckTipoEmpresa.Checked[IDX_TRANSPORTISTA] then
       DM_BusquedaEmpresas.BuscarTransportistaPorCodigo(Trim(edDatoBusqueda.Text));
     if ckTipoEmpresa.Checked[IDX_VENDEDOR] then
       DM_BusquedaEmpresas.BuscarVendedorPorCodigo(Trim(edDatoBusqueda.Text));
   end;
   CRI_DOMICILIO:
   begin
     if ckTipoEmpresa.Checked[IDX_CLIENTE] then
        DM_BusquedaEmpresas.BuscarClientesPorDomicilio(Trim(edDatoBusqueda.Text));
     if ckTipoEmpresa.Checked[IDX_PROVEEDOR] then
       DM_BusquedaEmpresas.BuscarProvPorDomicilio(Trim(edDatoBusqueda.Text));
     if ckTipoEmpresa.Checked[IDX_TRANSPORTISTA] then
       DM_BusquedaEmpresas.BuscarTransportistaPorDomicilio(Trim(edDatoBusqueda.Text));
     if ckTipoEmpresa.Checked[IDX_VENDEDOR] then
       DM_BusquedaEmpresas.BuscarVendedorPorDomicilio(Trim(edDatoBusqueda.Text));
   end;
  end;
end;

function TfrmBusquedaEmpresas.getIdProveedor: GUID_ID;
begin
  Result:= DevolverResultadoID(TIP_PROVEEDORES);
end;

function TfrmBusquedaEmpresas.getIdTransportista: GUID_ID;
begin
  Result:= DevolverResultadoID(TIP_TRANSPORTISTAS);
end;

function TfrmBusquedaEmpresas.getIdVendedor: GUID_ID;
begin
  Result:= DevolverResultadoID(TIP_VENDEDORES);
end;

function TfrmBusquedaEmpresas.getRazonSocial: string;
begin
  Result:= EmptyStr;
  if (DM_BusquedaEmpresas.Resultados.Active)
      and (DM_BusquedaEmpresas.Resultados.RecordCount > 0)then
    Result:= DM_BusquedaEmpresas.ResultadosRazonSocial.AsString;
end;

procedure TfrmBusquedaEmpresas.SetrestringirTipo(AValue: integer);
var
  idx: integer;
begin
  if AValue <> IDX_NINGUNO then
  begin
    for idx:= 0 to ckTipoEmpresa.Items.Count -1 do
     ckTipoEmpresa.Checked[idx]:= false;
    ckTipoEmpresa.Checked[AValue]:= true;
    ckTipoEmpresa.Enabled:= False;
  end
  else
  begin
    for idx:= 0 to ckTipoEmpresa.Items.Count -1 do
      ckTipoEmpresa.Checked[idx]:= true;
    ckTipoEmpresa.Enabled:= true;
  end;
end;

function TfrmBusquedaEmpresas.DevolverResultadoID(tipo: string): GUID_ID;
begin
  Result:= GUIDNULO;
  if (DM_BusquedaEmpresas.Resultados.Active)
      and (DM_BusquedaEmpresas.Resultados.RecordCount > 0)
      and (Trim(DM_BusquedaEmpresas.ResultadosTIPO.AsString) = tipo)
      then
  Result:= DM_BusquedaEmpresas.ResultadosidTipo.AsString;
end;

procedure TfrmBusquedaEmpresas.btnBuscarClick(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmBusquedaEmpresas.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmBusquedaEmpresas.btnSeleccionarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmBusquedaEmpresas.edDatoBusquedaKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
   Buscar;
end;

end.

