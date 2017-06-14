unit dmtalles;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral;

type

  { TDM_talles }

  TDM_talles = class(TDataModule)
    tallesbVisible: TLongintField;
    tallestalle: TStringField;
    tallesid: TLongintField;
    DELtalles: TZQuery;
    INStalles: TZQuery;
    talles: TRxMemoryData;
    qAlltallesBVISIBLE: TSmallintField;
    qAlltallestalle: TStringField;
    qAlltallesID: TLongintField;
    SELtalles: TZQuery;
    qAlltalles: TZQuery;
    SELtallesBVISIBLE: TSmallintField;
    SELtallestalle: TStringField;
    SELtallesID: TLongintField;
    UPDtalles: TZQuery;
    procedure tallesAfterInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { private declarations }
  public
    procedure Loadtalles;
    procedure Save;
    procedure Loadtalle(talle_id: integer);
    procedure New;
    procedure Deltalle(talle_id: integer);
  end;

var
  DM_talles: TDM_talles;

implementation

{$R *.lfm}

{ TDM_talles }

procedure TDM_talles.DataModuleCreate(Sender: TObject);
begin
  DM_General.ReiniciarTabla(talles);
end;

procedure TDM_talles.tallesAfterInsert(DataSet: TDataSet);
begin
  tallesid.AsInteger:= -1;
  tallestalle.AsString:= EmptyStr;
  tallesbVisible.AsInteger:= 1;
end;

procedure TDM_talles.Loadtalles;
begin
  DM_General.ReiniciarTabla(talles);

  if qAlltalles.Active then qAlltalles.Close;
  qAlltalles.Open;
  talles.LoadFromDataSet(qAlltalles, 0, lmAppend);
  qAlltalles.Close;
end;

procedure TDM_talles.Save;
begin
  if talles.State in dsWriteModes then talles.Post;
  DM_General.GrabarDatos(SELtalles, INStalles, UPDtalles, talles, 'id');
end;

procedure TDM_talles.Loadtalle(talle_id: integer);
begin
  DM_General.ReiniciarTabla(talles);

  if SELtalles.Active then SELtalles.Close;
  SELtalles.ParamByName('id').AsInteger:= talle_id;
  talles.LoadFromDataSet(SELtalles, 0, lmAppend);
  SELtalles.Close;
end;

procedure TDM_talles.New;
begin
  talles.Insert;
end;

procedure TDM_talles.Deltalle(talle_id: integer);
begin
  DELtalles.ParamByName('id').AsInteger:= talle_id;
  DELtalles.ExecSQL;
  if talles.Locate('id',talle_id,[loCaseInsensitive]) then
   talles.Delete;
end;

end.

