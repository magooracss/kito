unit dmvendedores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral, dmempresa;

type

  { TDM_Vendedores }

  TDM_Vendedores = class(TDataModule)
    Vendedores: TRxMemoryData;
    DELVendedores: TZQuery;
    INSVendedores: TZQuery;
    qListasPrecios: TZQuery;
    qListasPreciosBVISIBLE: TSmallintField;
    qListasPreciosID: TLongintField;
    qListasPreciosLISTAPRECIO: TStringField;
    qZonas: TZQuery;
    qZonasBVISIBLE: TSmallintField;
    qZonasID: TLongintField;
    qZonasZONA: TStringField;
    SELVendedores: TZQuery;
    SELVendedoresBVISIBLE: TSmallintField;
    SELVendedoresCODIGO: TStringField;
    SELVendedoresEMPRESA_ID: TStringField;
    SELVendedoresID: TStringField;
    SELVendedoresLISTAPRECIO_ID: TLongintField;
    SELVendedoresZONA_ID: TLongintField;
    UPDVendedores: TZQuery;
    VendedoresbVisible: TLongintField;
    Vendedorescodigo: TStringField;
    Vendedoresempresa_id: TStringField;
    Vendedoresid: TStringField;
    VendedoreslistaPrecio_id: TLongintField;
    Vendedoreszona_id: TLongintField;
    procedure DataModuleCreate(Sender: TObject);
    procedure VendedoresAfterInsert(DataSet: TDataSet);
  private
    _idEmpresa: GUID_ID;
    function getRazonSocial: String;
  public
    property RazonSocial: String read getRazonSocial;
    procedure Nuevo;
    procedure Editar (refVendedor: GUID_ID);
    procedure Grabar;
    procedure Borrar (refVendedor: GUID_ID);
  end;

var
  DM_Vendedores: TDM_Vendedores;

implementation

{$R *.lfm}


{ TDM_Vendedores }

procedure TDM_Vendedores.DataModuleCreate(Sender: TObject);
begin
  qZonas.open;
  qListasPrecios.Open;
end;

procedure TDM_Vendedores.VendedoresAfterInsert(DataSet: TDataSet);
begin
  Vendedoresid.AsString:= DM_General.CrearGUID;
  Vendedoresempresa_id.AsString:= _idEmpresa;
  Vendedorescodigo.AsString:= EmptyStr;
  VendedoreslistaPrecio_id.AsInteger:= 0;
  Vendedoreszona_id.AsInteger:= 0;
  VendedoresbVisible.AsInteger:= 1;
end;

function TDM_Vendedores.getRazonSocial: String;
begin
  DM_Empresa.LevantarEmpresa(_idEmpresa);
  Result:= DM_Empresa.RazonSocial;
end;

procedure TDM_Vendedores.Nuevo;
begin
  _idEmpresa:= DM_Empresa.Nueva;
  DM_General.ReiniciarTabla(Vendedores);
  Vendedores.Insert;
end;

procedure TDM_Vendedores.Editar(refVendedor: GUID_ID);
begin
  DM_General.ReiniciarTabla(Vendedores);

  if SELVendedores.Active then SELVendedores.close;

  SELVendedores.ParamByName('id').AsString:= refVendedor;
  SELVendedores.Open;
  Vendedores.LoadFromDataSet(SELVendedores, 0, lmAppend);
  SELVendedores.Close;

  DM_Empresa.Editar(Vendedoresempresa_id.AsString);
end;

procedure TDM_Vendedores.Grabar;
begin
  DM_Empresa.Grabar;
  DM_General.GrabarDatos(SELVendedores, INSVendedores, UPDVendedores, Vendedores, 'id');
end;

procedure TDM_Vendedores.Borrar(refVendedor: GUID_ID);
begin
  with DELVendedores do
  begin
    ParamByName('id').asString:= refVendedor;
    ExecSQL;
  end;
end;

end.

