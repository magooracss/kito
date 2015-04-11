unit frm_busquedaProductos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, sqldb, FileUtil, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, DBGrids, StdCtrls, Buttons, dmgeneral, dmproductos

  ;

type

  { TfrmBusquedaProducto }

  TfrmBusquedaProducto = class(TForm)
    btnBuscar: TBitBtn;
    btnCancelar: TBitBtn;
    btnSeleccionar: TBitBtn;
    dsGrillaProductos: TDataSource;
    dbGrillaProductos: TDBGrid;
    edBuscarDato: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    rgCritero: TRadioGroup;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSeleccionarClick(Sender: TObject);
    procedure edBuscarDatoKeyPress(Sender: TObject; var Key: char);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _criterioBuscar: integer;
    _datoBuscar: string;
    function getIdProducto: GUID_ID;
    function getProductoNombre: string;
    procedure Inicializar;
    procedure Finalizar;
    procedure Buscar;
  public
    property productoSeleccionado: GUID_ID read getIdProducto;
    property productoNombre: string read getProductoNombre;
    property DatoBuscar: string write _datoBuscar;
    property CriterioBuscar: integer write _criterioBuscar;
  end;

var
  frmBusquedaProducto: TfrmBusquedaProducto;

implementation
{$R *.lfm}
uses
  SD_Configuracion
  ;

{ TfrmBusquedaProducto }

procedure TfrmBusquedaProducto.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  Finalizar;
end;

procedure TfrmBusquedaProducto.FormCreate(Sender: TObject);
begin
  _datoBuscar:= EmptyStr;
  _criterioBuscar:= 0;
end;

procedure TfrmBusquedaProducto.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmBusquedaProducto.btnBuscarClick(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmBusquedaProducto.btnSeleccionarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmBusquedaProducto.edBuscarDatoKeyPress(Sender: TObject;
  var Key: char);
begin
  if key = #13 then
    Buscar;
end;


procedure TfrmBusquedaProducto.FormShow(Sender: TObject);
begin
  Inicializar;
end;

function TfrmBusquedaProducto.getIdProducto: GUID_ID;
begin
  if (DM_Productos.qBuscarProductos.Active) and
     (DM_Productos.qBuscarProductos.RecordCount > 0) then
   Result:= DM_Productos.qBuscarProductosID.AsString
  else
    Result:= GUIDNULO;
end;

function TfrmBusquedaProducto.getProductoNombre: string;
begin
  if (DM_Productos.qBuscarProductos.Active) and
     (DM_Productos.qBuscarProductos.RecordCount > 0) then
   Result:= DM_Productos.qBuscarProductosNOMBRE.AsString
  else
    Result:= EmptyStr;
end;

procedure TfrmBusquedaProducto.Inicializar;
begin
  DM_Productos.qBuscarProductos.Close;
  edBuscarDato.Clear;
  edBuscarDato.SetFocus;
  rgCritero.ItemIndex:= StrToIntDef(LeerDato(SECCION_SCR, PROD_BUS_CRIT),0);
  if (_datoBuscar <> EmptyStr) then
  begin
    edBuscarDato.Text:= _datoBuscar;
    rgCritero.ItemIndex:= _criterioBuscar;
    Buscar;
  end;
end;

procedure TfrmBusquedaProducto.Finalizar;
begin
  EscribirDato(SECCION_SCR, PROD_BUS_CRIT, IntToStr(rgCritero.ItemIndex));
end;

procedure TfrmBusquedaProducto.Buscar;
begin
  if Trim (edBuscarDato.Text) <> EmptyStr then
    DM_Productos.BuscarProducto(TRIM(edBuscarDato.Text), rgCritero.ItemIndex)
  else
    ShowMessage('No se puede buscar con el campo BUSCAR en blanco');
end;

end.

