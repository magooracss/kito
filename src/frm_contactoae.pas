unit frm_contactoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls, DbCtrls
  ,dmempresa, dmgeneral
  ;

type

  { TfrmContactoAE }

  TfrmContactoAE = class(TForm)
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    btnTugTipoContacto: TSpeedButton;
    cbTipoContacto: TComboBox;
    ds_contacto: TDataSource;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure btnTugTipoContactoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idContacto: GUID_ID;
    procedure Inicializar;
  public
    property idContacto: GUID_ID write _idContacto;
  end;

var
  frmContactoAE: TfrmContactoAE;

implementation
{$R *.lfm}
uses
  dmediciontugs
  ,frm_ediciontugs
  ;

{ TfrmContactoAE }
{ TODO : Esta duplicando los contactos }
procedure TfrmContactoAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmContactoAE.btnGrabarClick(Sender: TObject);
begin
  DM_Empresa.ActualizarTipoContacto (DM_General.obtenerIDIntComboBox(cbTipoContacto));
  DM_Empresa.GrabarContactos;
  ModalResult:= mrOK;
end;

procedure TfrmContactoAE.btnTugTipoContactoClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'TiposContactos';
      titulo:= 'Formas de contacto';
      AgregarCampo('TipoContacto','Nombre de la forma de contacto');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbTipoContacto, 'TipoContacto', 'id', DM_Empresa.qTiposContactos);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmContactoAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmContactoAE.Inicializar;
begin
  DM_General.CargarComboBox(cbTipoContacto, 'TipoContacto', 'id', DM_Empresa.qTiposContactos);
  if _idContacto = GUIDNULO then
  begin
    DM_Empresa.Contactos.Insert;
  end
  else
  begin
    cbTipoContacto.ItemIndex:= DM_General.obtenerIdxCombo(cbTipoContacto
                             , DM_Empresa.ContactostipoContacto_id.AsInteger);
    DM_Empresa.Contactos.Edit;
  end;
end;

end.

