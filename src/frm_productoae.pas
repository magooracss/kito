unit frm_productoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DbCtrls, Buttons, DBGrids, ComCtrls, dmgeneral
  ;

type

  { TfrmProductoAE }

  TfrmProductoAE = class(TForm)
    btnDELTalle: TBitBtn;
    btnINSColor: TBitBtn;
    btnDELColor: TBitBtn;
    btnINSTalle: TBitBtn;
    btnPrecioNuevo: TBitBtn;
    btnModificar: TBitBtn;
    btnBorrar: TBitBtn;
    btnGrabar: TBitBtn;
    btnCancelar: TBitBtn;
    btnTugUnidad: TSpeedButton;
    cbMarcas: TComboBox;
    cbCategorias: TComboBox;
    cbUnidades: TComboBox;
    DBEdit4: TDBEdit;
    dbGrillaProductos1: TDBGrid;
    dbGrillaProductos2: TDBGrid;
    ds_talles: TDataSource;
    ds_precios: TDataSource;
    DBEdit3: TDBEdit;
    DBEdit5: TDBEdit;
    dbGrillaProductos: TDBGrid;
    ds_colores: TDataSource;
    ds_productos: TDataSource;
    dbNombre: TDBEdit;
    DBEdit2: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel4: TPanel;
    Panel5: TPanel;
    PCDatosAdicionales: TPageControl;
    Panel1: TPanel;
    btnTugMarca: TSpeedButton;
    btnTugCategoria: TSpeedButton;
    Panel2: TPanel;
    Panel3: TPanel;
    tabUnidades: TTabSheet;
    tabColores: TTabSheet;
    tabTalles: TTabSheet;
    procedure btnBorrarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnDELColorClick(Sender: TObject);
    procedure btnDELTalleClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure btnINSColorClick(Sender: TObject);
    procedure btnINSTalleClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnPrecioNuevoClick(Sender: TObject);
    procedure btnTugCategoriaClick(Sender: TObject);
    procedure btnTugUnidadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnTugMarcaClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _id: GUID_ID;

    procedure Inicializar;

    procedure PantallaPrecios (refPrecio: GUID_ID);
    procedure pantallaColores (refColor: integer);
    procedure pantallaTalles (refTalle: integer);

  public
    property idProducto: GUID_ID read _id write _id;
  end;

var
  frmProductoAE: TfrmProductoAE;

implementation
{$R *.lfm}
uses
  dmediciontugs
  ,frm_ediciontugs
  ,dmproductos
  ,frm_precioae
  ,SD_Configuracion
  , frm_coloresae
  , frm_tallesae
  ;

{ TfrmProductoAE }


procedure TfrmProductoAE.FormCreate(Sender: TObject);
begin
  _id:= GUIDNULO;
end;

procedure TfrmProductoAE.btnTugMarcaClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'Marcas';
      titulo:= 'Nombres de marcas';
      AgregarCampo('Marca','Nombre de la marca');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbMarcas, 'Marca', 'id',DM_Productos.qMarcas);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmProductoAE.FormDestroy(Sender: TObject);
begin
  EscribirDato(SECCION_APP, CFG_PROD_DATO_AD, IntToStr(PCDatosAdicionales.ActivePageIndex));
end;

procedure TfrmProductoAE.btnTugCategoriaClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'Categorias';
      titulo:= 'Nombres de categorías';
      AgregarCampo('Categoria','Nombre de la categoría');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbCategorias, 'Categoria', 'id',DM_Productos.qCategorias);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

procedure TfrmProductoAE.btnTugUnidadClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'Unidades';
      titulo:= 'Unidades de medida';
      AgregarCampo('Unidad','Unidad de medida');
      AgregarCampo('Totaliza','Unidad de medida totalizadora');
      AgregarCampo('Factor','Factor de Unidad para ser Totalizada');

    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbUnidades, 'Unidad', 'id', DM_Productos.qUnidades);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;


procedure TfrmProductoAE.FormShow(Sender: TObject);
begin
  Inicializar;
  if (_id = GUIDNULO) then
  begin
    DM_Productos.Nuevo;
  end
  else
  begin
    DM_Productos.Editar(_id);
    cbMarcas.ItemIndex:= DM_General.obtenerIdxCombo(cbMarcas, DM_Productos.Productosmarca_id.AsInteger);
    cbCategorias.ItemIndex:= DM_General.obtenerIdxCombo(cbCategorias, DM_Productos.Productoscategoria_id.AsInteger);
    cbUnidades.ItemIndex:= DM_General.obtenerIdxCombo(cbUnidades, DM_Productos.Productosunidad_id.AsInteger);
  end;
end;

procedure TfrmProductoAE.Inicializar;
begin
  DM_General.CargarComboBox(cbMarcas, 'Marca', 'id',DM_Productos.qMarcas);
  DM_General.CargarComboBox(cbCategorias, 'Categoria', 'id',DM_Productos.qCategorias);
  DM_General.CargarComboBox(cbUnidades, 'Unidad', 'id',DM_Productos.qUnidades);
  PCDatosAdicionales.ActivePageIndex:= StrToInt64Def(LeerDato(SECCION_APP, CFG_PROD_DATO_AD),0);
end;

procedure TfrmProductoAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;



procedure TfrmProductoAE.btnGrabarClick(Sender: TObject);
begin
  if TRIM(DM_Productos.Productosnombre.AsString) <> EmptyStr then
  begin
    DM_Productos.ActualizarRefsCb(
               DM_General.obtenerIDIntComboBox(cbMarcas)
              ,DM_General.obtenerIDIntComboBox(cbCategorias)
              ,DM_General.obtenerIDIntComboBox(cbUnidades)
                                  );
    DM_Productos.Grabar;
    ModalResult:= mrOK;
  end
  else
  begin
   ShowMessage('No puede haber productos con el nombre en blanco');
   dbNombre.SetFocus;
  end;
end;

procedure TfrmProductoAE.PantallaPrecios(refPrecio: GUID_ID);
var
 pant: TfrmPrecioAE;
begin
  pant:= TfrmPrecioAE.Create(self);
  try
    pant.idPrecio:= refPrecio;
    pant.ShowModal;
    DM_Productos.LevantarPreciosProducto;
  finally
    pant.Free;
  end;
end;

procedure TfrmProductoAE.btnPrecioNuevoClick(Sender: TObject);
begin
  PantallaPrecios(GUIDNULO);
end;

procedure TfrmProductoAE.btnModificarClick(Sender: TObject);
begin
  PantallaPrecios(DM_Productos.Preciosid.AsString);
end;


procedure TfrmProductoAE.btnBorrarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el precio seleccionado?'
                 , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Productos.BorrarPrecio(DM_Productos.Preciosid.AsString);
    DM_Productos.LevantarPreciosProducto;
  end;
end;

(******************************************************************************
*** COLORES
*******************************************************************************)
procedure TfrmProductoAE.pantallaColores(refColor: integer);
var
 scrn: TfrmColoresAE;
 idx: integer;
begin
  scrn:= TfrmColoresAE.Create(self);
  scrn.colorID:= refColor;
  if scrn.ShowModal = mrOK then
  begin
    for idx:= 0 to scrn.selection.Count - 1 do
     begin
       DM_Productos.AgregarColorDisponible(StrToIntDef(scrn.selection[idx],0));
     end;
     DM_Productos.LevantarColores;
  end;
end;

procedure TfrmProductoAE.btnINSColorClick(Sender: TObject);
begin
  pantallaColores(ID_NULO);
end;


procedure TfrmProductoAE.btnDELColorClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el color seleccionado?'
                 , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Productos.QuitarColorDisponible(ds_colores.DataSet.FieldByName('color_id').AsInteger);
    DM_Productos.LevantarColores;
  end;
end;


(******************************************************************************
*** TALLES
*******************************************************************************)

procedure TfrmProductoAE.pantallaTalles(refTalle: integer);
var
 scrn: TfrmTallesAE;
 idx: integer;
begin
  scrn:= TfrmTallesAE.Create(self);
  scrn.talleID:= refTalle;
  if scrn.ShowModal = mrOK then
  begin
    for idx:= 0 to scrn.selection.Count - 1 do
     begin
       DM_Productos.AgregarTalleDisponible(StrToIntDef(scrn.selection[idx],0));
     end;
     DM_Productos.LevantarTalles;
  end;
end;


procedure TfrmProductoAE.btnINSTalleClick(Sender: TObject);
begin
 pantallaTalles(ID_NULO);
end;

procedure TfrmProductoAE.btnDELTalleClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el talle seleccionado?'
                 , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Productos.QuitarTalleDisponible(ds_talles.DataSet.FieldByName('talle_id').AsInteger);
    DM_Productos.LevantarTalles;
  end;
end;


end.

