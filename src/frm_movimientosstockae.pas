unit frm_movimientosstockae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbdateedit, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, Buttons, DbCtrls, StdCtrls, DBGrids, dmstock
  ;

type

  { TfrmMovimientosStockAE }

  TfrmMovimientosStockAE = class(TForm)
    BitBtn1: TBitBtn;
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBGrid1: TDBGrid;
    DBLookupComboBox1: TDBLookupComboBox;
    DBMemo1: TDBMemo;
    ds_MovStock: TDataSource;
    DBText1: TDBText;
    ds_MovStockDet: TDataSource;
    edProveedor: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmMovimientosStockAE: TfrmMovimientosStockAE;

implementation

{$R *.lfm}

end.

