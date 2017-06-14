unit frm_coloresae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, DBGrids, Buttons, DbCtrls, dmcolores, dmgeneral;

type

  { TfrmColoresAE }

  TfrmColoresAE = class(TForm)
    btnDelColor: TBitBtn;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    DBNavigator1: TDBNavigator;
    ds_color: TDataSource;
    PCColores: TPageControl;
    Panel1: TPanel;
    GrillaColores: TRxDBGrid;
    tabAvailableColors: TTabSheet;
    procedure btnCancelClick(Sender: TObject);
    procedure btnDelColorClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _id: integer;
    _selection: TStringList;
    procedure LoadSelection;
    procedure DelColor;
  public
    dmColors: TDM_Colores;
    property colorID: integer write _id;
    property selection: TStringList read _selection;
  end;

var
  frmColoresAE: TfrmColoresAE;

implementation
{$R *.lfm}

{ TfrmColoresAE }

procedure TfrmColoresAE.btnCancelClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmColoresAE.btnDelColorClick(Sender: TObject);
begin
  DelColor;
end;

procedure TfrmColoresAE.btnOKClick(Sender: TObject);
begin
  LoadSelection;
  dmColors.Save;
  ModalResult:= mrOK;
end;

procedure TfrmColoresAE.FormCreate(Sender: TObject);
begin
  _selection:= TStringList.Create;
  dmColors:= TDM_Colores.Create(self);
  ds_color.DataSet:= dmColors.Colores;
end;

procedure TfrmColoresAE.FormDestroy(Sender: TObject);
begin
  _selection.Free;
  dmColors.Free;
end;

procedure TfrmColoresAE.FormShow(Sender: TObject);
begin
  dmColors.LoadColors;
  PCColores.ActivePage:= tabAvailableColors;
  if _id = ID_NULO then
  begin
//    dmColors.New;
  end
  else
  begin
    dmColors.LoadColor(_id);
  end;
end;

procedure TfrmColoresAE.LoadSelection;
var
  lista: TBookmarkList;
  i: integer;
begin
   lista:= GrillaColores.SelectedRows;
   _selection.Clear;
   dmColors.Colores.DisableControls;
   try
     for i:= 0 to lista.Count - 1 do
     begin
       dmColors.Colores.GotoBookmark(lista.Items[i]);
       _selection.Add(IntToStr(dmColors.Coloresid.AsInteger));
     end
   finally
     dmColors.Colores.EnableControls;
   end;


end;

procedure TfrmColoresAE.DelColor;
begin
   if (MessageDlg ('ATENCION'
                 , 'Borro el color seleccionado?'
                 , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
                 dmColors.DelColor(ds_color.DataSet.FieldByName('id').AsInteger);
end;

end.

