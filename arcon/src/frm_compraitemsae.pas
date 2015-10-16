unit frm_compraitemsae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, RxDBSpinEdit, rxlookup, Forms, Controls,
  Graphics, Dialogs, DbCtrls, StdCtrls, Buttons;

type

  { TfrmCompraItemAE }

  TfrmCompraItemAE = class(TForm)
    btnNuevo: TBitBtn;
    BitBtn2: TBitBtn;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit6: TDBEdit;
    ds_compraItems: TDataSource;
    DBEdit1: TDBEdit;
    ds_PlanDeCuentas: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edCantidad: TRxDBSpinEdit;
    RxDBLookupCombo1: TRxDBLookupCombo;
    procedure BitBtn2Click(Sender: TObject);
    procedure btnNuevoClick(Sender: TObject);
    procedure DBEdit2Exit(Sender: TObject);
  private
  public
    { public declarations }
  end;

var
  frmCompraItemAE: TfrmCompraItemAE;

implementation
uses
  dmcompras
  ;

{$R *.lfm}

{ TfrmCompraItemAE }

procedure TfrmCompraItemAE.BitBtn2Click(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmCompraItemAE.btnNuevoClick(Sender: TObject);
begin
  DM_Compras.NuevoItem;
  edCantidad.SetFocus;
end;

procedure TfrmCompraItemAE.DBEdit2Exit(Sender: TObject);
begin
  DM_Compras.CalcularMontosItem;
end;


end.

