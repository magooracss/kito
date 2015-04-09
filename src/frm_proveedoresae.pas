unit frm_proveedoresae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DbCtrls, Buttons, fra_empresa
  ,dmgeneral, dmempresa
  ;

type

  { TfrmProveedoresAE }

  TfrmProveedoresAE = class(TForm)
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    btnTugListasPrecios: TSpeedButton;
    ds_proveedorers: TDataSource;
    ds_listaPrecios: TDataSource;
    DBEdit1: TDBEdit;
    DBLookupComboBox2: TDBLookupComboBox;
    fraEmpresaProveedor: TfraEmpresa;
    Label3: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure btnTugListasPreciosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idProveedor: GUID_ID;
    procedure Inicializar;
  public
    property idProveedor: GUID_ID read _idProveedor write _idProveedor;
  end;

var
  frmProveedoresAE: TfrmProveedoresAE;

implementation
{$R *.lfm}
uses
  dmproveedores
  ,dmediciontugs
  ,frm_ediciontugs
  ;

{ TfrmProveedoresAE }

procedure TfrmProveedoresAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmProveedoresAE.btnGrabarClick(Sender: TObject);
begin
   with DM_Empresa, Empresas do
  begin
    Edit;
    Empresascondicionfiscal_id.AsInteger:= DM_General.obtenerIDIntComboBox(fraEmpresaProveedor.cbCondicionFiscal);
    Post;
  end;
  DM_Proveedores.Grabar;
  ModalResult:= mrOK;
end;

procedure TfrmProveedoresAE.btnTugListasPreciosClick(Sender: TObject);
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
    DM_Proveedores.qListasPrecios.Close;
    DM_Proveedores.qListasPrecios.Open;
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmProveedoresAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmProveedoresAE.Inicializar;
begin
   DM_General.CargarComboBox(fraEmpresaProveedor.cbCondicionFiscal, 'CondicionFiscal', 'id', DM_Empresa.qCondicionesFiscales);
  if idProveedor = GUIDNULO then
  Begin
    DM_Proveedores.Nuevo;
  end
  else
  begin
    DM_Proveedores.Editar(idProveedor);
    fraEmpresaProveedor.cbCondicionFiscal.ItemIndex:= DM_General.obtenerIdxCombo(fraEmpresaProveedor.cbCondicionFiscal
                                                                               , DM_Empresa.Empresascondicionfiscal_id.AsInteger );
  end;
end;

end.

