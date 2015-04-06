unit frm_productoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, DbCtrls, Buttons, DBGrids, dmgeneral
  ;

type

  { TfrmProductoAE }

  TfrmProductoAE = class(TForm)
    btnPrecioNuevo: TBitBtn;
    btnModificar: TBitBtn;
    btnBorrar: TBitBtn;
    btnGrabar: TBitBtn;
    btnCancelar: TBitBtn;
    cbMarcas: TComboBox;
    cbCategorias: TComboBox;
    cbUnidades: TComboBox;
    ds_precios: TDataSource;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    dbGrillaProductos: TDBGrid;
    ds_productos: TDataSource;
    dbNombre: TDBEdit;
    DBEdit2: TDBEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    btnTugMarca: TSpeedButton;
    btnTugCategoria: TSpeedButton;
    btnTugUnidad: TSpeedButton;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure btnBorrarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure btnModificarClick(Sender: TObject);
    procedure btnPrecioNuevoClick(Sender: TObject);
    procedure btnTugCategoriaClick(Sender: TObject);
    procedure btnTugUnidadClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnTugMarcaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _id: GUID_ID;

    procedure Inicializar;

    procedure PantallaPrecios (refPrecio: GUID_ID);
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


end.

