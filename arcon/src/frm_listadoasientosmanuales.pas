unit frm_listadoasientosmanuales;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, DateTimePicker, tooledit, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, Buttons, StdCtrls, EditBtn, DBGrids
  ,dmgeneral
  ,dmasientomanual
  ;

type

  { TfrmListadoAsientosManuales }

  TfrmListadoAsientosManuales = class(TForm)
    btnEditar: TBitBtn;
    btnNuevo: TBitBtn;
    btnEliminar: TBitBtn;
    btnFiltrar: TBitBtn;
    btnBuscarEmpresa: TBitBtn;
    btnSalir: TBitBtn;
    dsAsiento: TDataSource;
    edFechaIni: TDateEdit;
    edFechaFin: TDateEdit;
    DBGrid1: TDBGrid;
    edRazonSocial: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnBuscarEmpresaClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnEliminarClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    _empresaID: GUID_ID;
    dmAsientos: TDM_AsientoManual;

    procedure LevantarAsientos;
    procedure pantallaAsiento (refID: GUID_ID);
  public

  end;

var
  frmListadoAsientosManuales: TfrmListadoAsientosManuales;

implementation
{$R *.lfm}
uses
  frm_busquedaempresas
  ,dateutils
  ,frm_asientomanualae
  ;

{ TfrmListadoAsientosManuales }

procedure TfrmListadoAsientosManuales.btnBuscarEmpresaClick(Sender: TObject);
var
  panBus: TfrmBusquedaEmpresas;
begin
  panBus:= TfrmBusquedaEmpresas.Create(self);
  try
    panBus.restringirTipo:= IDX_NINGUNO;
    if panBus.ShowModal = mrOK then
    begin
       _empresaID:= panBus.idEmpresa;
       edRazonSocial.Text:= panBus.RazonSocial;
       LevantarAsientos;
    end
    else
      _empresaID:= GUIDNULO;
  finally
    panBus.Free;
  end;
end;

procedure TfrmListadoAsientosManuales.btnFiltrarClick(Sender: TObject);
begin
  LevantarAsientos;
end;

procedure TfrmListadoAsientosManuales.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmListadoAsientosManuales.FormCreate(Sender: TObject);
begin
  _empresaID:= GUIDNULO;
  dmAsientos:= TDM_AsientoManual.Create(self);

  dsAsiento.DataSet:= dmAsientos.AsientoManual;

  edFechaIni.Date:= Now;
  edFechaFin.Date:= IncDay(now,30);
end;

procedure TfrmListadoAsientosManuales.FormDestroy(Sender: TObject);
begin
  dmAsientos.Free;
end;

procedure TfrmListadoAsientosManuales.LevantarAsientos;
begin
  dmAsientos.levantarAsientos(_empresaID, edFechaIni.Date, edFechaFin.Date);
end;

procedure TfrmListadoAsientosManuales.pantallaAsiento(refID: GUID_ID);
var
  pant: TfrmAsientoManualAE;
begin
  pant:= TfrmAsientoManualAE.Create(self);
  try
    pant.asientoID:= refID;
    pant.empresaID:= _empresaID;
    pant.ShowModal;
  finally
    pant.Free;
  end;
  LevantarAsientos;
end;

procedure TfrmListadoAsientosManuales.btnNuevoClick(Sender: TObject);
begin
  pantallaAsiento(GUIDNULO);
end;

procedure TfrmListadoAsientosManuales.btnEditarClick(Sender: TObject);
begin
  pantallaAsiento(dsAsiento.DataSet.FieldByName('id').AsString);
end;

procedure TfrmListadoAsientosManuales.btnEliminarClick(Sender: TObject);
begin
  if (MessageDlg ('Confirmación'
                 , 'Realmente desea eliminar el asiento seleccionado?'
                 , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    dmAsientos.Borrar;
    LevantarAsientos;
  end;
end;


end.


