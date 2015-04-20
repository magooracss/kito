unit frm_listados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, DBGrids, Buttons, EditBtn, StdCtrls, types;

type

  { TfrmListados }

  TfrmListados = class(TForm)
    btnSalir: TBitBtn;
    btnMostrar: TBitBtn;
    cbTabListaPrecio: TComboBox;
    edFechaIniTabFechas: TDateEdit;
    edFechaFinTabFechas: TDateEdit;
    ds_GrupoListado: TDataSource;
    ds_Listados: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    PCParametros: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    TabNada: TTabSheet;
    TabFechas: TTabSheet;
    TabListaPrecio: TTabSheet;
    procedure btnMostrarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure ds_GrupoListadoDataChange(Sender: TObject; Field: TField);
    procedure ds_ListadosDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TabFechasShow(Sender: TObject);
    procedure TabListaPrecioShow(Sender: TObject);
  private
    _idx: Integer;
    procedure AjustarPantalla;
  public
    { public declarations }
  end;

var
  frmListados: TfrmListados;

implementation
{$R *.lfm}
uses
  dmlistados
 , dateutils
 , dmgeneral
  ;

{ TfrmListados }

procedure TfrmListados.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_Listados, DM_Listados);
  _idx:= 0;
end;

procedure TfrmListados.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmListados.ds_GrupoListadoDataChange(Sender: TObject; Field: TField
  );
begin
  DM_Listados.ListadoPorGrupo(DM_Listados.qGruposListadosID.AsInteger);
end;

procedure TfrmListados.ds_ListadosDataChange(Sender: TObject; Field: TField);
begin
  AjustarPantalla;
end;

procedure TfrmListados.FormDestroy(Sender: TObject);
begin
  DM_Listados.Free;
end;

procedure TfrmListados.FormShow(Sender: TObject);
begin
  AjustarPantalla;
end;

procedure TfrmListados.TabFechasShow(Sender: TObject);
begin
  edFechaIniTabFechas.Date:= EncodeDate(YearOf(Now), MonthOf(Now), 1);
  edFechaFinTabFechas.Date:= Now;
end;

procedure TfrmListados.TabListaPrecioShow(Sender: TObject);
begin
  DM_General.CargarComboBox(cbTabListaPrecio, 'ListaPrecio', 'id', DM_Listados.qListaPrecio);
end;

procedure TfrmListados.AjustarPantalla;
begin
  _idx:= DM_Listados.qListadosIDX.asInteger;
  case _idx of
    LST_StockMinimo : PCParametros.ActivePage:= TabNada;
    LST_ProductosDevueltosDetalle: PCParametros.ActivePage:= TabFechas;
    LST_ProductosDevueltosTotalizado: PCParametros.ActivePage:= TabFechas;
    LST_ProductosConsumidos: PCParametros.ActivePage:= TabFechas;
    LST_ListaDePrecios: PCParametros.ActivePage:= TabListaPrecio;
  end;
end;


procedure TfrmListados.btnMostrarClick(Sender: TObject);
begin
  case _idx of
    LST_StockMinimo : DM_Listados.StockMinimimo;
    LST_ProductosDevueltosDetalle: DM_Listados.ProductosDevueltosDetalle (edFechaIniTabFechas.Date
                                                                   , edFechaFinTabFechas.Date);
    LST_ProductosDevueltosTotalizado: DM_Listados.ProductosDevueltosTotalizado (edFechaIniTabFechas.Date
                                                                   , edFechaFinTabFechas.Date);
    LST_ProductosConsumidos: DM_Listados.ProductosConsumidos(edFechaIniTabFechas.Date
                                                                   , edFechaFinTabFechas.Date);
    LST_ListaDePrecios: DM_Listados.ListaDePrecios(DM_General.obtenerIDIntComboBox(cbTabListaPrecio));

  end;

end;


end.

