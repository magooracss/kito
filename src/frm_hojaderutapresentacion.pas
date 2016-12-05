unit frm_hojaderutapresentacion;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Buttons, StdCtrls, ComCtrls, DBGrids
  ,dmgeneral;

type

  { TfrmPresentacionHdR }

  TfrmPresentacionHdR = class(TForm)
    btnBuscar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    DS_Presentadas: TDataSource;
    edFecha: TDateTimePicker;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    PCBusqueda: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    rgCriterio: TRadioGroup;
    rgEstado: TRadioGroup;
    tabBlanco: TTabSheet;
    tabFecha: TTabSheet;
    procedure btnBuscarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgCriterioSelectionChanged(Sender: TObject);
  private
    function getIdHdR: GUID_ID;
    procedure Inicializar;
    procedure Buscar;
    procedure BuscarHdR;
  public
    property idHojaDeRuta: GUID_ID read getIdHdR;
  end;

var
  frmPresentacionHdR: TfrmPresentacionHdR;

implementation
{$R *.lfm}
uses
  dmhojaderutapresentacion
  ,frm_busquedahojaderuta
  ;


const
  IDX_BLANCO = 0;
  IDX_FECHA = 1;

  PC_IDX_BLANCO = 0;
  PD_IDX_FECHAREALIZACION = 1;

  CRITERIO_ESTADO = 0;
  CRITERIO_FECHA = 1;
  CRITERIO_BUSCARHdR = 2;

{ TfrmPresentacionHdR }

procedure TfrmPresentacionHdR.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_HdRPresentacion, DM_HdRPresentacion);
end;

procedure TfrmPresentacionHdR.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmPresentacionHdR.DBGrid1DblClick(Sender: TObject);
begin
  DM_HdRPresentacion.cambiarMarca;
end;

procedure TfrmPresentacionHdR.btnBuscarClick(Sender: TObject);
begin
  Buscar;
end;

procedure TfrmPresentacionHdR.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmPresentacionHdR.btnGrabarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmPresentacionHdR.FormDestroy(Sender: TObject);
begin
  DM_HdRPresentacion.Free;
end;

procedure TfrmPresentacionHdR.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmPresentacionHdR.rgCriterioSelectionChanged(Sender: TObject);
begin
  case rgCriterio.ItemIndex of
    CRITERIO_ESTADO: PCBusqueda.ActivePageIndex:= IDX_BLANCO;
    CRITERIO_FECHA:  PCBusqueda.ActivePageIndex:= IDX_FECHA;
    CRITERIO_BUSCARHdR: PCBusqueda.ActivePageIndex:= IDX_BLANCO;
  end;
end;

function TfrmPresentacionHdR.getIdHdR: GUID_ID;
begin
  Result:= DM_HdRPresentacion.idSeleccion;
end;

procedure TfrmPresentacionHdR.Inicializar;
begin
  PCBusqueda.ActivePageIndex:= PC_IDX_BLANCO;
  edFecha.Date:= now;
end;

procedure TfrmPresentacionHdR.Buscar;
begin
  case rgCriterio.ItemIndex of
   CRITERIO_ESTADO: DM_HdRPresentacion.BuscarEstado (rgEstado.ItemIndex + 1);
   CRITERIO_FECHA: DM_HdRPresentacion.BuscarFechaEstado (edFecha.Date,rgEstado.ItemIndex + 1 );
   CRITERIO_BUSCARHdR: BuscarHdR;
  end;
end;

procedure TfrmPresentacionHdR.BuscarHdR;
var
 pant: TfrmBuscarHdR;
begin
  pant:= TfrmBuscarHdR.Create(self);
  try
    if pant.ShowModal = mrOK then
    begin
      DM_HdRPresentacion.BuscarHdR (pant.idHojaDeRuta);
    end;
  finally
    pant.Free;
  end;
end;

end.

