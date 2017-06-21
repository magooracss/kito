unit frm_cajamovimientoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, DBDateTimePicker, rxdbcomb, rxlookup, Forms,
  Controls, Graphics, Dialogs, DBExtCtrls, StdCtrls, DbCtrls, ExtCtrls, Buttons,
  dmcajamovimientos, dmgeneral;

type

  { TfrmMovimientoCajaAE }

  TfrmMovimientoCajaAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    ds_Movimientos: TDataSource;
    ds_FormasDePago: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Panel1: TPanel;
    RxDBComboBox1: TRxDBComboBox;
    RxDBLookupCombo1: TRxDBLookupCombo;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    dmCaja: TDM_CajaMovimentos;
    _idMovimiento: GUID_ID;
    procedure Initialise;
  public
    property MovimientoID: GUID_ID write _idMovimiento;
  end;

var
  frmMovimientoCajaAE: TfrmMovimientoCajaAE;

implementation

{$R *.lfm}

{ TfrmMovimientoCajaAE }

procedure TfrmMovimientoCajaAE.FormCreate(Sender: TObject);
begin
  _idMovimiento:= GUIDNULO;
  dmCaja:= TDM_CajaMovimentos.Create(self);
end;

procedure TfrmMovimientoCajaAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmMovimientoCajaAE.btnAceptarClick(Sender: TObject);
begin
  dmCaja.Save;
  ModalResult:= mrOK;
end;

procedure TfrmMovimientoCajaAE.FormDestroy(Sender: TObject);
begin
  dmCaja.Free;
end;

procedure TfrmMovimientoCajaAE.FormShow(Sender: TObject);
begin
  initialise;
end;

procedure TfrmMovimientoCajaAE.Initialise;
begin
  ds_Movimientos.DataSet:= dmCaja.CajaMovimientos;
  if _idMovimiento = GUIDNULO then
  begin
    dmCaja.New;
    _idMovimiento:= dmCaja.CajaMovimientosid.AsString;
  end
  else
  begin
    dmCaja.Edit(_idMovimiento);
  end;
end;

end.

