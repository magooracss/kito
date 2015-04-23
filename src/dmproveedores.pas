unit dmproveedores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ,dmempresa
  ;

type

  { TDM_Proveedores }

  TDM_Proveedores = class(TDataModule)
    Proveedores: TRxMemoryData;
    DELProveedores: TZQuery;
    INSProveedores: TZQuery;
    ProveedoresbVisible: TLongintField;
    Proveedorescodigo: TStringField;
    Proveedoresempresa_id: TStringField;
    Proveedoresid: TStringField;
    ProveedoreslistaPrecio_id: TLongintField;
    qListasPrecios: TZQuery;
    qListasPreciosBVISIBLE: TSmallintField;
    qListasPreciosID: TLongintField;
    qListasPreciosLISTAPRECIO: TStringField;
    SELProveedores: TZQuery;
    SELProveedoresBVISIBLE: TSmallintField;
    SELProveedoresCODIGO: TStringField;
    SELProveedoresEMPRESA_ID: TStringField;
    SELProveedoresID: TStringField;
    SELProveedoresLISTAPRECIO_ID: TLongintField;
    UPDProveedores: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure ProveedoresAfterInsert(DataSet: TDataSet);
  private
   _idEmpresa: GUID_ID;
   function getRazonSocial: String;
  public
    property RazonSocial: String read getRazonSocial;
    procedure Nuevo;
    procedure Editar (refProveedor: GUID_ID);
    procedure Borrar (refProveedor: GUID_ID);
    procedure Grabar;
  end;

var
  DM_Proveedores: TDM_Proveedores;

implementation

{$R *.lfm}

{ TDM_Proveedores }

procedure TDM_Proveedores.DataModuleCreate(Sender: TObject);
begin
  qListasPrecios.Open;
end;

procedure TDM_Proveedores.ProveedoresAfterInsert(DataSet: TDataSet);
begin
  Proveedoresid.AsString:= DM_General.CrearGUID;
  Proveedoresempresa_id.AsString:= _idEmpresa;
  Proveedorescodigo.AsString:= EmptyStr;
  ProveedoreslistaPrecio_id.AsInteger:= 0;
  ProveedoresbVisible.AsInteger:= 1;
end;

function TDM_Proveedores.getRazonSocial: String;
begin
  DM_Empresa.LevantarEmpresa(_idEmpresa);
  Result:= DM_Empresa.RazonSocial;
end;

procedure TDM_Proveedores.Nuevo;
begin
  _idEmpresa:= DM_Empresa.Nueva;
  DM_General.ReiniciarTabla(Proveedores);
  Proveedores.Insert;
end;

procedure TDM_Proveedores.Editar(refProveedor: GUID_ID);
begin

  DM_General.ReiniciarTabla(Proveedores);
  if SELProveedores.Active then SELProveedores.close;
  SELProveedores.ParamByName('id').AsString:= refProveedor;
  SELProveedores.Open;
  Proveedores.LoadFromDataSet(SELProveedores, 0, lmAppend);
  SELProveedores.Close;
  _idEmpresa:= Proveedoresempresa_id.AsString;
  DM_Empresa.Editar(Proveedoresempresa_id.AsString);
end;

procedure TDM_Proveedores.Borrar(refProveedor: GUID_ID);
begin
   with DELProveedores do
  begin
    ParamByName('id').asString:= refProveedor;
    ExecSQL;
  end;
end;

procedure TDM_Proveedores.Grabar;
begin
  DM_Empresa.Grabar;
  DM_General.GrabarDatos(SELProveedores, INSProveedores, UPDProveedores, Proveedores, 'id');
end;

end.

