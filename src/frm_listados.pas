unit frm_listados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, DBGrids, Buttons, EditBtn, StdCtrls, types
   , dmgeneral
  ;

type

  { TfrmListados }

  TfrmListados = class(TForm)
    btnBusTrans: TBitBtn;
    btnBusVend: TBitBtn;
    btnBusCli: TBitBtn;
    btnSalir: TBitBtn;
    btnMostrar: TBitBtn;
    cbTabListaPrecio: TComboBox;
    cbTabZonas: TComboBox;
    cbTabPedidosEstado: TComboBox;
    edFechaFinTabPedEst: TDateEdit;
    edFechaIniTabPedEst: TDateEdit;
    edTrans: TEdit;
    edFechaFinTabTrans: TDateEdit;
    edFechaFinTabVend: TDateEdit;
    edFechaFinTabCli: TDateEdit;
    edFechaIniTabTrans: TDateEdit;
    edFechaIniTabFechas: TDateEdit;
    edFechaFinTabFechas: TDateEdit;
    ds_GrupoListado: TDataSource;
    ds_Listados: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    edFechaIniTabVend: TDateEdit;
    edFechaIniTabCli: TDateEdit;
    edVend: TEdit;
    edCli: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    PCParametros: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    TabNada: TTabSheet;
    TabFechas: TTabSheet;
    TabListaPrecio: TTabSheet;
    TabClienteFechas: TTabSheet;
    TabPedidosEstados: TTabSheet;
    TabTransportista: TTabSheet;
    TabVendedorFechas: TTabSheet;
    TabZonas: TTabSheet;
    procedure btnBusCliClick(Sender: TObject);
    procedure btnBusTransClick(Sender: TObject);
    procedure btnBusVendClick(Sender: TObject);
    procedure btnMostrarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure ds_GrupoListadoDataChange(Sender: TObject; Field: TField);
    procedure ds_ListadosDataChange(Sender: TObject; Field: TField);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TabClienteFechasShow(Sender: TObject);
    procedure TabFechasShow(Sender: TObject);
    procedure TabListaPrecioShow(Sender: TObject);
    procedure TabPedidosEstadosShow(Sender: TObject);
    procedure TabTransportistaShow(Sender: TObject);
    procedure TabVendedorFechasShow(Sender: TObject);
    procedure TabZonasShow(Sender: TObject);
  private
    _idx: Integer;
    _idVendedor: GUID_ID;
    _idCliente: GUID_ID;
    _idTransportista: GUID_ID;
    _RazonSocial: String;
    procedure AjustarPantalla;
    procedure BuscarEmpresa (tipo: integer);
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
 , frm_busquedaempresas
  ;

{ TfrmListados }

procedure TfrmListados.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_Listados, DM_Listados);
  _idx:= 0;
  _idCliente:= GUIDNULO;
  _idTransportista:=GUIDNULO;
  _idVendedor:= GUIDNULO;
  _RazonSocial:= EmptyStr;
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

procedure TfrmListados.TabClienteFechasShow(Sender: TObject);
begin
  edFechaIniTabCli.Date:= EncodeDate(YearOf(Now), MonthOf(Now), 1);
  edFechaFinTabCli.Date:= Now;
  edCli.Clear;
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

procedure TfrmListados.TabPedidosEstadosShow(Sender: TObject);
begin
  DM_General.CargarComboBox(cbTabPedidosEstado, 'TipoEstado', 'id', DM_Listados.qPedidosTiposEstados);
  edFechaIniTabPedEst.Date:= EncodeDate(YearOf(Now), MonthOf(Now), 1);
  edFechaFinTabPedEst.Date:= Now;
end;

procedure TfrmListados.TabTransportistaShow(Sender: TObject);
begin
  edFechaIniTabTrans.Date:= EncodeDate(YearOf(Now), MonthOf(Now), 1);
  edFechaFinTabTrans.Date:= Now;
  edTrans.Clear;
end;

procedure TfrmListados.TabVendedorFechasShow(Sender: TObject);
begin
  edFechaIniTabVend.Date:= EncodeDate(YearOf(Now), MonthOf(Now), 1);
  edFechaFinTabVend.Date:= Now;
  edVend.Clear;
end;

procedure TfrmListados.TabZonasShow(Sender: TObject);
begin
  DM_General.CargarComboBox(cbTabZonas, 'Zona', 'id', DM_Listados.qZonas);
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
    LST_ListaClientesZona: PCParametros.ActivePage:= TabZonas;
    LST_ListaClientesCompleta: PCParametros.ActivePage:= TabNada;
    LST_PedidosVendedor: PCParametros.ActivePage:= TabVendedorFechas;
    LST_PedidosCliente: PCParametros.ActivePage:= TabClienteFechas;
    LST_PedidosFechasTomado: PCParametros.ActivePage:= TabFechas;
    LST_PedidosTransportista: PCParametros.ActivePage:= TabTransportista;
    LST_PedidosEstado: PCParametros.ActivePage:= TabPedidosEstados;
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
    LST_ListaClientesZona: DM_Listados.ListaClientesZonas(DM_General.obtenerIDIntComboBox(cbTabZonas));
    LST_ListaClientesCompleta: DM_Listados.ListaClientesTodos;
    LST_PedidosVendedor: DM_Listados.PedidosVendedor(_idVendedor, edFechaIniTabVend.Date
                                                    , edFechaFinTabVend.Date);
    LST_PedidosCliente: DM_Listados.PedidosCliente(_idCliente, edFechaIniTabCli.Date
                                                    , edFechaFinTabCli.Date);
    LST_PedidosFechasTomado: DM_Listados.PedidosFechaTomado (edFechaIniTabFechas.Date
                                                           , edFechaFinTabFechas.Date);
    LST_PedidosTransportista: DM_Listados.PedidosTransportista(_idTransportista, edFechaIniTabTrans.Date
                                                    , edFechaFinTabTrans.Date);
    LST_PedidosEstado: DM_Listados.PedidosPorEstado(DM_General.obtenerIDIntComboBox(cbTabPedidosEstado)
                                                    , edFechaIniTabPedEst.Date
                                                    , edFechaFinTabPedEst.Date);

  end;

end;


procedure TfrmListados.BuscarEmpresa(tipo: integer);
var
  pant: TfrmBusquedaEmpresas;
begin
  pant:= TfrmBusquedaEmpresas.Create(self);
  try
    pant.restringirTipo:= tipo;
    if pant.ShowModal = mrOK then
    begin
      _idCliente:= pant.idCliente;
      _idTransportista:= pant.idTransportista;
      _idVendedor:= pant.idVendedor;
      _RazonSocial:= pant.RazonSocial;
    end
    else
    begin
      _idCliente:= GUIDNULO;
      _idTransportista:=GUIDNULO;
      _idVendedor:= GUIDNULO;
      _RazonSocial:= EmptyStr;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmListados.btnBusVendClick(Sender: TObject);
begin
  BuscarEmpresa(IDX_VENDEDOR);
  edVend.Text:= _RazonSocial;
end;

procedure TfrmListados.btnBusCliClick(Sender: TObject);
begin
  BuscarEmpresa(IDX_CLIENTE);
  edCli.Text:= _RazonSocial;
end;

procedure TfrmListados.btnBusTransClick(Sender: TObject);
begin
  BuscarEmpresa(IDX_TRANSPORTISTA);
  edTrans.Text:= _RazonSocial;
end;


end.
