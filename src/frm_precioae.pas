unit frm_precioae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DbCtrls,
  StdCtrls, Buttons, dmprecios, dmgeneral;

type

  { TfrmPrecioAE }

  TfrmPrecioAE = class(TForm)
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    btnTugUnidad: TSpeedButton;
    cbListaPrecios: TComboBox;
    ds_productos: TDataSource;
    ds_Precios: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBText1: TDBText;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure btnTugUnidadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _idPrecio: GUID_ID;
    _idProducto: GUID_ID;
    _IVACFG: Double;
    procedure Inicializar;
  public
    property refProducto: GUID_ID write _idProducto;
    property idPrecio: GUID_ID read _idPrecio write _idPrecio ;
  end;

var
  frmPrecioAE: TfrmPrecioAE;

implementation
{$R *.lfm}
uses
    dmediciontugs
  ,frm_ediciontugs
  ,SD_Configuracion
  ,dmproductos
  ;

{ TfrmPrecioAE }

procedure TfrmPrecioAE.FormShow(Sender: TObject);
begin
  Inicializar;
  if (_idPrecio = GUIDNULO) then
  begin
    DM_Productos.NuevoPrecio (_IVACFG);
  end
  else
  begin
    DM_Productos.EditarPrecio(_idPrecio);
    cbListaPrecios.ItemIndex:= DM_General.obtenerIdxCombo(cbListaPrecios, DM_Productos.PrecioslistaPrecio_id.AsInteger);
  end;
end;

procedure TfrmPrecioAE.FormCreate(Sender: TObject);
begin
  _idPrecio:= GUIDNULO;
  _idProducto:= GUIDNULO;
end;

procedure TfrmPrecioAE.btnCancelarClick(Sender: TObject);
begin
  DM_Productos.Precios.Cancel;
  ModalResult:= mrCancel;
end;

procedure TfrmPrecioAE.btnGrabarClick(Sender: TObject);
begin
  DM_Productos.ActualizarRefsCbPrecios(DM_General.obtenerIDIntComboBox(cbListaPrecios));
  DM_Productos.GrabarPrecios;
  ModalResult:= mrOK;
end;

procedure TfrmPrecioAE.btnTugUnidadClick(Sender: TObject);
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
    DM_General.CargarComboBox(cbListaPrecios, 'ListaPrecio', 'id',DM_Productos.qListasPrecios);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmPrecioAE.Inicializar;
begin
  _IVACFG:= StrToFloatDef(LeerDato(SECCION_APP, CFGD_IVA_PROD),0);
  DM_General.CargarComboBox(cbListaPrecios, 'listaPrecio', 'id',DM_Productos.qListasPrecios);
end;

end.

