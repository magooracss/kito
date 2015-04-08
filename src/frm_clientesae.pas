unit frm_clientesae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, Buttons, DbCtrls, StdCtrls, fra_empresa,
  dmgeneral;

type

  { TfrmClientesAE }

  TfrmClientesAE = class(TForm)
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    btnTugListasPrecios: TSpeedButton;
    btnTugZonas: TSpeedButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    ds_Clientes: TDataSource;
    ds_ListasPrecios: TDataSource;
    ds_zonas: TDataSource;
    fraEmpresaCliente: TfraEmpresa;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure btnTugListasPreciosClick(Sender: TObject);
    procedure btnTugZonasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idCliente: GUID_ID;
    procedure Inicializar;
  public
    property idCliente: GUID_ID read _idCliente write _idCliente;
  end;

var
  frmClientesAE: TfrmClientesAE;

implementation
{$R *.lfm}
uses
  dmempresa
  ,dmclientes
  ,dmediciontugs
  ,frm_ediciontugs
  ;

{ TfrmClientesAE }

procedure TfrmClientesAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmClientesAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmClientesAE.btnGrabarClick(Sender: TObject);
begin
  with DM_Empresa, Empresas do
  begin
    Edit;
    Empresascondicionfiscal_id.AsInteger:= DM_General.obtenerIDIntComboBox(fraEmpresaCliente.cbCondicionFiscal);
    Post;
  end;
  DM_Clientes.Grabar;
  ModalResult:= mrOK;
end;

procedure TfrmClientesAE.btnTugListasPreciosClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'ListasPrecios';
      titulo:= 'Nombres de las listas de precios';
      AgregarCampo('ListaPrecio','Nombre de la lista');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_Clientes.qListasPrecios.Close;
    DM_Clientes.qListasPrecios.Open;
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmClientesAE.btnTugZonasClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'zonas';
      titulo:= 'Nombres de las zonas de distribución, cobro, acceso, etc';
      AgregarCampo('zona','Nombre de la zona');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_Clientes.qZonasClientes.Close;
    DM_Clientes.qZonasClientes.Open;

  finally
    datos.Free;
    pantalla.Free;
  end;
end;


procedure TfrmClientesAE.Inicializar;
begin
  DM_General.CargarComboBox(fraEmpresaCliente.cbCondicionFiscal, 'CondicionFiscal', 'id', DM_Empresa.qCondicionesFiscales);
  if idCliente = GUIDNULO then
  Begin
    DM_Clientes.Nuevo;
  end
  else
  begin
    DM_Clientes.Editar(idCliente);
    fraEmpresaCliente.cbCondicionFiscal.ItemIndex:= DM_General.obtenerIdxCombo(fraEmpresaCliente.cbCondicionFiscal
                                                                               , DM_Empresa.Empresascondicionfiscal_id.AsInteger );
  end;

end;

end.

