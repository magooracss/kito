unit frm_recibointernocobros;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbcurredit, Forms, Controls, Graphics,
  Dialogs, Buttons, DbCtrls, StdCtrls
  ,dmrecibosinternos;

type

  { TfrmRecIntFormaCobro }

  TfrmRecIntFormaCobro = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ds_tugFormasPago: TDataSource;
    dsFormaCobro: TDataSource;
    DBLookupComboBox1: TDBLookupComboBox;
    Label1: TLabel;
    Label2: TLabel;
    RxDBCurrEdit1: TRxDBCurrEdit;
  private
    elDM: TDM_RecibosInternos;
  public
    constructor Create  (MrOwner: TComponent; var dm: TDM_RecibosInternos);
  end;

var
  frmRecIntFormaCobro: TfrmRecIntFormaCobro;

implementation

{$R *.lfm}

{ TfrmRecIntFormaCobro }

constructor TfrmRecIntFormaCobro.Create(MrOwner: TComponent;
  var dm: TDM_RecibosInternos);
begin
  inherited Create (MrOwner) ;
  elDM:= dm;
  elDM.FormasPago.Open;
  dsFormaCobro.DataSet:= elDM.RecibosIntMontos;
  ds_tugFormasPago.DataSet:= elDM.FormasPago;
end;

end.

