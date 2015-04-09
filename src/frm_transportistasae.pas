unit frm_transportistasae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DbCtrls, Buttons, fra_empresa
  ,dmgeneral;

type

  { TfrmTransportistasAE }

  TfrmTransportistasAE = class(TForm)
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    btnTugZonas: TSpeedButton;
    ds_zonas: TDataSource;
    ds_transportista: TDataSource;
    DBEdit1: TDBEdit;
    DBLookupComboBox1: TDBLookupComboBox;
    fraEmpresaTransportista: TfraEmpresa;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure btnTugZonasClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idTransportista: GUID_ID;
    procedure Inicializar;
  public
    property idTransportista: GUID_ID read _idTransportista write _idTransportista;
  end;

var
  frmTransportistasAE: TfrmTransportistasAE;

implementation
{$R *.lfm}
uses
  dmempresa
  ,dmtransportistas
  ,dmediciontugs
  ,frm_ediciontugs
  ;

{ TfrmTransportistasAE }

procedure TfrmTransportistasAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmTransportistasAE.btnTugZonasClick(Sender: TObject);
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
    DM_Transportistas.qZonas.Close;
    DM_Transportistas.qZonas.Open;

  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmTransportistasAE.btnGrabarClick(Sender: TObject);
begin
  with DM_Empresa, Empresas do
  begin
    Edit;
    Empresascondicionfiscal_id.AsInteger:= DM_General.obtenerIDIntComboBox(fraEmpresaTransportista.cbCondicionFiscal);
    Post;
  end;
  DM_Transportistas.Grabar;
  ModalResult:= mrOK;
end;

procedure TfrmTransportistasAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;


procedure TfrmTransportistasAE.Inicializar;
begin
  DM_General.CargarComboBox(fraEmpresaTransportista.cbCondicionFiscal, 'CondicionFiscal', 'id', DM_Empresa.qCondicionesFiscales);
  if idTransportista = GUIDNULO then
  Begin
    DM_Transportistas.Nuevo;
  end
  else
  begin
    DM_Transportistas.Editar(idTransportista);
    fraEmpresaTransportista.cbCondicionFiscal.ItemIndex:= DM_General.obtenerIdxCombo(fraEmpresaTransportista.cbCondicionFiscal
                                                                               , DM_Empresa.Empresascondicionfiscal_id.AsInteger );
  end;

end;

end.

