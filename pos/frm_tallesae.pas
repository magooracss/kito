unit frm_tallesae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, DBGrids, Buttons, DbCtrls, dmtalles, dmgeneral;

type

  { TfrmtallesAE }

  TfrmTallesAE = class(TForm)
    btnDeltalle: TBitBtn;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    DBNavigator1: TDBNavigator;
    ds_talle: TDataSource;
    PCtalles: TPageControl;
    Panel1: TPanel;
    Grillatalles: TRxDBGrid;
    tabAvailabletalles: TTabSheet;
    procedure btnCancelClick(Sender: TObject);
    procedure btnDeltalleClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _id: integer;
    _selection: TStringList;
    procedure LoadSelection;
    procedure Deltalle;
  public
    dmtalles: TDM_talles;
    property talleID: integer write _id;
    property selection: TStringList read _selection;
  end;

var
  frmTallesAE: TFrmtallesAE;

implementation
{$R *.lfm}

{ TfrmtallesAE }

procedure TfrmtallesAE.btnCancelClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmtallesAE.btnDeltalleClick(Sender: TObject);
begin
  Deltalle;
end;

procedure TfrmtallesAE.btnOKClick(Sender: TObject);
begin
  LoadSelection;
  dmtalles.Save;
  ModalResult:= mrOK;
end;

procedure TfrmtallesAE.FormCreate(Sender: TObject);
begin
  _selection:= TStringList.Create;
  dmtalles:= TDM_talles.Create(self);
  ds_talle.DataSet:= dmtalles.talles;
end;

procedure TfrmtallesAE.FormDestroy(Sender: TObject);
begin
  _selection.Free;
  dmtalles.Free;
end;

procedure TfrmtallesAE.FormShow(Sender: TObject);
begin
  dmtalles.Loadtalles;
  PCtalles.ActivePage:= tabAvailabletalles;
  if _id = ID_NULO then
  begin
//    dmtalles.New;
  end
  else
  begin
    dmtalles.Loadtalle(_id);
  end;
end;

procedure TfrmtallesAE.LoadSelection;
var
  lista: TBookmarkList;
  i: integer;
begin
   lista:= Grillatalles.SelectedRows;
   _selection.Clear;
   dmtalles.talles.DisableControls;
   try
     for i:= 0 to lista.Count - 1 do
     begin
       dmtalles.talles.GotoBookmark(lista.Items[i]);
       _selection.Add(IntToStr(dmtalles.tallesid.AsInteger));
     end
   finally
     dmtalles.talles.EnableControls;
   end;


end;

procedure TfrmtallesAE.Deltalle;
begin
   if (MessageDlg ('ATENCION'
                 , 'Borro el talle seleccionado?'
                 , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
                 dmtalles.Deltalle(ds_talle.DataSet.FieldByName('id').AsInteger);
end;

end.

