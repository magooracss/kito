unit frm_modificarprecios;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, curredit, rxspin, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Buttons, StdCtrls, ComCtrls, DBGrids
  ,dmgeneral
  ;

type

  { TfrmModificarPrecios }

  TfrmModificarPrecios = class(TForm)
    btnAplicarGlobal: TBitBtn;
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    cbListaPrecio: TComboBox;
    ds_ModificarPrecios: TDataSource;
    GrillaPrecios: TDBGrid;
    edMonto: TCurrencyEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    PCCriterio: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    rgOperacion: TRadioGroup;
    edPorcentaje: TRxSpinEdit;
    tabMonto: TTabSheet;
    tabPorcentaje: TTabSheet;
    procedure btnAplicarGlobalClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure cbListaPrecioChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure Inicializar;
  public
    { public declarations }
  end;

var
  frmModificarPrecios: TfrmModificarPrecios;

implementation
{$R *.lfm}
uses
  dmmodificarprecios
  ,dmproductos
  ;

{ TfrmModificarPrecios }

procedure TfrmModificarPrecios.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_ModificarPrecios, DM_ModificarPrecios);
end;

procedure TfrmModificarPrecios.FormDestroy(Sender: TObject);
begin
  DM_ModificarPrecios.Free;
end;

procedure TfrmModificarPrecios.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmModificarPrecios.Inicializar;
begin
  DM_General.CargarComboBox(cbListaPrecio,'ListaPrecio', 'id',DM_Productos.qListasPrecios );
  PCCriterio.ActivePage:= tabMonto;
  rgOperacion.ItemIndex:= IDX_INCREMENTO;
end;

procedure TfrmModificarPrecios.cbListaPrecioChange(Sender: TObject);
begin
  DM_ModificarPrecios.LevantarListaPrecio(DM_General.obtenerIDIntComboBox(cbListaPrecio));
end;

procedure TfrmModificarPrecios.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmModificarPrecios.btnGrabarClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION'
                 , 'Grabo las modificaciones realizadas?'
                 , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_ModificarPrecios.Grabar;
    ModalResult:= mrOK;
  end;
end;

procedure TfrmModificarPrecios.btnAplicarGlobalClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION - CAMBIO GLOBAL!!!'
                 , 'Aplico el cambio a TODOS los artículos de la lista?'
                 , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    if PCCriterio.ActivePage = tabMonto then
      DM_ModificarPrecios.ModificarGlobalValor(edMonto.Value, rgOperacion.ItemIndex)
    else
      DM_ModificarPrecios.ModificarGlobalPorcentaje(edPorcentaje.Value, rgOperacion.ItemIndex);
  end;

end;


end.

