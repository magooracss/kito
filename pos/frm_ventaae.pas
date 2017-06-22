unit frm_ventaae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxdbgrid, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, Buttons, ActnList, dmgeneral, dmventas;

type

  { TfrmVentaAE }

  TfrmVentaAE = class(TForm)
    prod_agregar: TAction;
    ActionList1: TActionList;
    BitBtn1: TBitBtn;
    GrillaColores: TRxDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure prod_agregarExecute(Sender: TObject);
  private
    dmVentas: TDM_Ventas;
  public
    { public declarations }
  end;

var
  frmVentaAE: TfrmVentaAE;

implementation

{$R *.lfm}

{ TfrmVentaAE }

procedure TfrmVentaAE.prod_agregarExecute(Sender: TObject);
begin
 //
end;

procedure TfrmVentaAE.FormCreate(Sender: TObject);
begin
  dmVentas:= TDM_Ventas.Create(self);
end;

procedure TfrmVentaAE.FormDestroy(Sender: TObject);
begin
  dmVentas.Free;
end;

end.

