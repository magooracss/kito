unit frm_vendedoresae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DbCtrls, Buttons, fra_empresa
  , dmgeneral;

type

  { TfrmVendedoresAE }

  TfrmVendedoresAE = class(TForm)
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    btnTugListasPrecios: TSpeedButton;
    btnTugZonas: TSpeedButton;
    ds_Vendedor: TDataSource;
    ds_zonas: TDataSource;
    ds_ListaPrecios: TDataSource;
    DBEdit1: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    fraEmpresaVendedor: TfraEmpresa;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idVendedor: GUID_ID;
    procedure Inicializar;
  public
    property idVendedor: GUID_ID read _idVendedor write _idVendedor;
  end;

var
  frmVendedoresAE: TfrmVendedoresAE;

implementation
{$R *.lfm}
uses
   dmempresa
  ,dmvendedores
  ,dmediciontugs
  ,frm_ediciontugs
   ;

{ TfrmVendedoresAE }

procedure TfrmVendedoresAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmVendedoresAE.btnGrabarClick(Sender: TObject);
begin
   with DM_Empresa, Empresas do
  begin
    Edit;
    Empresascondicionfiscal_id.AsInteger:= DM_General.obtenerIDIntComboBox(fraEmpresaVendedor.cbCondicionFiscal);
    Post;
  end;
  DM_Vendedores.Grabar;
  ModalResult:= mrOK;
end;

procedure TfrmVendedoresAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmVendedoresAE.Inicializar;
begin
  DM_General.CargarComboBox(fraEmpresaVendedor.cbCondicionFiscal, 'CondicionFiscal', 'id', DM_Empresa.qCondicionesFiscales);
  if idVendedor = GUIDNULO then
  Begin
    DM_Vendedores.Nuevo;
  end
  else
  begin
    DM_Vendedores.Editar(idVendedor);
    fraEmpresaVendedor.cbCondicionFiscal.ItemIndex:= DM_General.obtenerIdxCombo(fraEmpresaVendedor.cbCondicionFiscal
                                                                               , DM_Empresa.Empresascondicionfiscal_id.AsInteger );
  end;
end;

end.

