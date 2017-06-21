unit frm_cajadiaria;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, tooledit, DateTimePicker, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, EditBtn, StdCtrls, Buttons,
  dmcajamovimientos, dmgeneral
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
    procedure btnMovDelClick(Sender: TObject);
    procedure btnMovEditClick(Sender: TObject);
    procedure btnMovNewClick(Sender: TObject);
    procedure btnMovPrintClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    dmCaja: TDM_CajaMovimentos;
    procedure Initialise;
    procedure scrMovimiento (refMovimiento: GUID_ID);
    procedure LevantarGrilla;
  public
    { public declarations }
  end;

var
  frmCajaDiaria: TfrmCajaDiaria;

implementation
{$R *.lfm}
uses
    frm_cajamovimientoae
  , rpt_movimentoscaja
  ;

{ TfrmCajaDiaria }

procedure TfrmCajaDiaria.FormCreate(Sender: TObject);
begin
  dmCaja:= TDM_CajaMovimentos.Create(self);
end;

procedure TfrmCajaDiaria.btnFiltrarClick(Sender: TObject);
begin
  LevantarGrilla;
end;

procedure TfrmCajaDiaria.btnMovDelClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro el movimiento seleccionado?', mtConfirmation
     , [mbYes, mbNo],0 ) = mrYes) then
  begin
     dmCaja.Delete(ds_cajaDiaria.DataSet.FieldByName('id').AsString);
     LevantarGrilla;
  end;
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

procedure TfrmCajaDiaria.LevantarGrilla;
begin
  dmCaja.LoadMovFechas(edFechaIni.Date, edFechaFin.Date);
end;

procedure TfrmCajaDiaria.scrMovimiento(refMovimiento: GUID_ID);
var
  scr: TfrmMovimientoCajaAE;
begin
  scr:= TfrmMovimientoCajaAE.Create(self);
  try
    scr.MovimientoID:= refMovimiento;
    if scr.ShowModal = mrOK then
    begin
      LevantarGrilla;
    end;
  finally
  end;
end;

procedure TfrmCajaDiaria.btnMovNewClick(Sender: TObject);
begin
  scrMovimiento(GUIDNULO);
end;

procedure TfrmCajaDiaria.btnMovPrintClick(Sender: TObject);
var
  elRpt: Trpt;
begin
  elRpt:= Trpt.Create(self);
  try
    elRpt.fIni:= edFechaIni.Date;
    elRpt.fFin:= edFechaFin.Date;
    elRpt.RunReport(raPrint);
  finally
    elRpt.Free;
  end;

end;

procedure TfrmCajaDiaria.btnMovEditClick(Sender: TObject);
begin
  scrMovimiento(ds_cajaDiaria.DataSet.FieldByName('id').AsString);
end;

end.

