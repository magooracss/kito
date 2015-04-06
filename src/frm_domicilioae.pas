unit frm_domicilioae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, DbCtrls, StdCtrls
  ,dmempresa
  ,dmgeneral
  ;

type

  { TfrmDomicilioAE }

  TfrmDomicilioAE = class(TForm)
    BitBtn1: TBitBtn;
    btnEditorLocalidades: TBitBtn;
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    ds_Localidades: TDataSource;
    ds_domicilios: TDataSource;
    DBEdit1: TDBEdit;
    ds_provincias: TDataSource;
    ds_paises: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    procedure btnEditorLocalidadesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    _idDomilio: GUID_ID;
    _idLocalidad: Integer;

    procedure Inicializar;
  public
    property idDomicilio: GUID_ID write _idDomilio;
  end;

var
  frmDomicilioAE: TfrmDomicilioAE;

implementation
{$R *.lfm}
uses
  SD_Configuracion
  ,frm_localidadesae
  ;

{ TfrmDomicilioAE }

procedure TfrmDomicilioAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmDomicilioAE.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  EscribirDato(SECCION_SCR, LOCALIDAD, IntToStr(_idLocalidad));
end;

procedure TfrmDomicilioAE.btnEditorLocalidadesClick(Sender: TObject);
var
  pant: TfrmLocalidadesAE;
begin
  pant:= TfrmLocalidadesAE.Create(self);
  try
    pant.ShowModal;
    DM_Empresa.LocalidadPorID(_idLocalidad);
  finally
    pant.Free;
  end;
end;

procedure TfrmDomicilioAE.Inicializar;
begin
  _idLocalidad:= StrToIntDef(LeerDato(SECCION_SCR, LOCALIDAD),0);

  if _idDomilio = GUIDNULO then
  begin
    DM_General.ReiniciarTabla(DM_Empresa.Domicilios);
    DM_Empresa.Domicilios.Insert;
  end
  else
  begin
     DM_Empresa.Domicilios.Edit;
     _idLocalidad:= DM_Empresa.Domicilioslocalidad_id.AsInteger;
  end;
  DM_Empresa.LocalidadPorID(_idLocalidad);
end;

end.

