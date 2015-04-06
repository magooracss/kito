unit fra_empresa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, DbCtrls, Buttons, StdCtrls,
  ComCtrls, ExtCtrls, DBGrids, dmempresa, dmgeneral
  ;

type

  { TfraEmpresa }

  TfraEmpresa = class(TFrame)
    btnBorrarDomicilio: TBitBtn;
    btnEditarDomicilio: TBitBtn;
    btnNuevoContacto: TBitBtn;
    btnEditarContacto: TBitBtn;
    btnBorrarContacto: TBitBtn;
    btnNuevoDomicilio: TBitBtn;
    btnTugCondicionFiscal: TSpeedButton;
    cbCondicionFiscal: TComboBox;
    GrillaContactos: TDBGrid;
    GrillaDomicilios: TDBGrid;
    ds_Empresa: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    ds_Contactos: TDataSource;
    ds_Domicilios: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    tabContacto: TTabSheet;
    tabDomicilios: TTabSheet;
    procedure btnEditarContactoClick(Sender: TObject);
    procedure btnNuevoContactoClick(Sender: TObject);
    procedure btnTugCondicionFiscalClick(Sender: TObject);
  private
    procedure pantallaContacto (refContacto: GUID_ID);
  public
    { public declarations }
  end;

implementation
{$R *.lfm}
uses
  frm_ediciontugs
  , dmediciontugs
  ,frm_contactoae
  ;

{ TfraEmpresa }

procedure TfraEmpresa.btnTugCondicionFiscalClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'CondicionesFiscales';
      titulo:= 'Condiciones Fiscales';
      AgregarCampo('CondicionFiscal','CondicionFiscal');
      AgregarCampo('tipoFactura','Tipo Factura (1:A/2:B/3:C)');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbCondicionFiscal, 'CondicionFiscal', 'id', DM_Empresa.qCondicionesFiscales);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfraEmpresa.pantallaContacto(refContacto: GUID_ID);
var
  pant: TfrmContactoAE;
begin
  pant:= TfrmContactoAE.Create(self);
  try
    pant.idContacto:= refContacto;
    pant.ShowModal;
    DM_Empresa.levantarContactos;
  finally
    pant.Free;
  end;
end;


procedure TfraEmpresa.btnNuevoContactoClick(Sender: TObject);
begin
  pantallaContacto(GUIDNULO);
end;

procedure TfraEmpresa.btnEditarContactoClick(Sender: TObject);
begin
  pantallaContacto(DM_Empresa.Contactosid.AsString);
end;

end.

