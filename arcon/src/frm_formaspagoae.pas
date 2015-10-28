unit frm_formaspagoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxlookup, dbcurredit, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, Buttons, StdCtrls
  ,dmgeneral
  ;

type

  { TfrmFormasPagoAE }

  TfrmFormasPagoAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    ds_formaPago: TDataSource;
    ds_TiposFormasDePago: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    RxDBCurrEdit1: TRxDBCurrEdit;
    RxDBLookupCombo1: TRxDBLookupCombo;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _formaPagoID: GUID_ID;
  public
    property formaPagoID: GUID_ID read _formaPagoID write _formaPagoID;
  end;

var
  frmFormasPagoAE: TfrmFormasPagoAE;

implementation
{$R *.lfm}
uses
  dmordendepago
  ;

{ TfrmFormasPagoAE }

procedure TfrmFormasPagoAE.btnCancelarClick(Sender: TObject);
begin
  ds_formaPago.DataSet.Cancel;
  ModalResult:= mrCancel;
end;

procedure TfrmFormasPagoAE.FormCreate(Sender: TObject);
begin
  _formaPagoID:= GUIDNULO;
end;

procedure TfrmFormasPagoAE.FormShow(Sender: TObject);
begin
  if _formaPagoID = GUIDNULO then
  begin
    DM_OrdenDePago.NuevaFormaPago;
  end
  else
  begin
    DM_OrdenDePago.EditarFormaPagoActual;
  end;
end;

procedure TfrmFormasPagoAE.btnAceptarClick(Sender: TObject);
begin
  with DM_OrdenDePago, OPFormasPago do
  begin
    Edit;
    OPFormasPagolxFormaDePago.AsString:= DM_OrdenDePago.NombreformaDePago (DM_OrdenDePago.OPFormasPagoformaPago_id.AsInteger);
    Post;
  end;
  ModalResult:= mrOK;
end;

end.

