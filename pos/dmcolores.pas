unit dmcolores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral;

type

  { TDM_Colores }

  TDM_Colores = class(TDataModule)
    ColoresbVisible: TLongintField;
    ColoresColor: TStringField;
    Coloresid: TLongintField;
    DELColores: TZQuery;
    INSColores: TZQuery;
    Colores: TRxMemoryData;
    qAllColoresBVISIBLE: TSmallintField;
    qAllColoresCOLOR: TStringField;
    qAllColoresID: TLongintField;
    SELColores: TZQuery;
    qAllColores: TZQuery;
    SELColoresBVISIBLE: TSmallintField;
    SELColoresCOLOR: TStringField;
    SELColoresID: TLongintField;
    UPDColores: TZQuery;
    procedure ColoresAfterInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    { private declarations }
  public
    procedure LoadColors;
    procedure Save;
    procedure LoadColor(color_id: integer);
    procedure New;
    procedure DelColor(color_id: integer);
  end;

var
  DM_Colores: TDM_Colores;

implementation

{$R *.lfm}

{ TDM_Colores }

procedure TDM_Colores.DataModuleCreate(Sender: TObject);
begin
  DM_General.ReiniciarTabla(Colores);
end;

procedure TDM_Colores.ColoresAfterInsert(DataSet: TDataSet);
begin
  Coloresid.AsInteger:= -1;
  ColoresColor.AsString:= EmptyStr;
  ColoresbVisible.AsInteger:= 1;
end;

procedure TDM_Colores.LoadColors;
begin
  DM_General.ReiniciarTabla(Colores);

  if qAllColores.Active then qAllColores.Close;
  qAllColores.Open;
  colores.LoadFromDataSet(qAllColores, 0, lmAppend);
  qAllColores.Close;
end;

procedure TDM_Colores.Save;
begin
  if Colores.State in dsWriteModes then colores.Post;
  DM_General.GrabarDatos(SELColores, INSColores, UPDColores, Colores, 'id');
end;

procedure TDM_Colores.LoadColor(color_id: integer);
begin
  DM_General.ReiniciarTabla(Colores);

  if SELColores.Active then SELColores.Close;
  SELColores.ParamByName('id').AsInteger:= color_id;
  colores.LoadFromDataSet(SELColores, 0, lmAppend);
  SELColores.Close;
end;

procedure TDM_Colores.New;
begin
  Colores.Insert;
end;

procedure TDM_Colores.DelColor(color_id: integer);
begin
  DELColores.ParamByName('id').AsInteger:= color_id;
  DELColores.ExecSQL;
  if Colores.Locate('id',color_id,[loCaseInsensitive]) then
   Colores.Delete;
end;

end.

