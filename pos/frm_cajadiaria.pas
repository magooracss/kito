unit frm_cajadiaria;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, tooledit, DateTimePicker, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, EditBtn, StdCtrls, Buttons,
  dmcajamovimientos
  ;

type

  { TfrmCajaDiaria }

  TfrmCajaDiaria = class(TForm)
    btnSalir: TBitBtn;
    btnMovNew: TBitBtn;
    btnMovEdit: TBitBtn;
    btnMovPrint: TBitBtn;
    btnMovDel: TBitBtn;
    btnFiltrar: TBitBtn;
    edFechaIni: TDateEdit;
    edFechaFin: TDateEdit;
    ds_cajaDiaria: TDataSource;
    Grillatalles: TRxDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    procedure btnFiltrarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    dmCaja: TDM_CajaMovimentos;
    procedure Initialise;
  public
    { public declarations }
  end;

var
  frmCajaDiaria: TfrmCajaDiaria;

implementation

{$R *.lfm}

{ TfrmCajaDiaria }

procedure TfrmCajaDiaria.FormCreate(Sender: TObject);
begin
  dmCaja:= TDM_CajaMovimentos.Create(self);
end;

procedure TfrmCajaDiaria.btnFiltrarClick(Sender: TObject);
begin
  dmCaja.LoadMovFechas(edFechaIni.Date, edFechaFin.Date);
end;

procedure TfrmCajaDiaria.btnSalirClick(Sender: TObject);
begin
  dmCaja.Save;
  ModalResult:= mrOK;
end;

procedure TfrmCajaDiaria.FormDestroy(Sender: TObject);
begin
  dmCaja.Free;
end;

procedure TfrmCajaDiaria.FormShow(Sender: TObject);
begin
  Initialise;
end;

procedure TfrmCajaDiaria.Initialise;
begin
  ds_cajaDiaria.DataSet:= dmCaja.CajaMovimientos;
  edFechaIni.Date:= Now;
  edFechaFin.Date:= Now;
  dmCaja.LoadMovFechas(Now,Now);
end;

end.

