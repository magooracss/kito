unit dmclientes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  ,dmempresa
  ;

type

  { TDM_Clientes }

  TDM_Clientes = class(TDataModule)
    Clientes: TRxMemoryData;
    ClientesbVisible: TLongintField;
    Clientescodigo: TStringField;
    ClientesdomicilioFactura: TStringField;
    ClientesemailFactura: TStringField;
    Clientesempresa_id: TStringField;
    Clientesid: TStringField;
    ClienteslistaPrecio_id: TLongintField;
    Clienteszona_id: TLongintField;
    DELClientes: TZQuery;
    INSClientes: TZQuery;
    qListasPrecios: TZQuery;
    qListasPreciosBVISIBLE: TSmallintField;
    qListasPreciosID: TLongintField;
    qListasPreciosLISTAPRECIO: TStringField;
    qZonasClientesBVISIBLE: TSmallintField;
    qZonasClientesID: TLongintField;
    qZonasClientesZONA: TStringField;
    SELClientes: TZQuery;
    qZonasClientes: TZQuery;
    SELClientesBVISIBLE: TSmallintField;
    SELClientesCODIGO: TStringField;
    SELClientesDOMICILIOFACTURA: TStringField;
    SELClientesEMAILFACTURA: TStringField;
    SELClientesEMPRESA_ID: TStringField;
    SELClientesID: TStringField;
    SELClientesLISTAPRECIO_ID: TLongintField;
    SELClientesZONA_ID: TLongintField;
    UPDClientes: TZQuery;
    procedure ClientesAfterInsert(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
    _idEmpresa: GUID_ID;
    function getRazonSocial: String;
  public
    property RazonSocial: String read getRazonSocial;
    procedure Nuevo;
    procedure Editar (refCliente: GUID_ID);
    procedure Grabar;
    procedure Borrar (refCliente: GUID_ID);
  end;

var
  DM_Clientes: TDM_Clientes;

implementation

{$R *.lfm}

{ TDM_Clientes }

procedure TDM_Clientes.ClientesAfterInsert(DataSet: TDataSet);
begin
  Clientesid.AsString:= DM_General.CrearGUID;
  Clientesempresa_id.AsString:= _idEmpresa;
  Clientescodigo.AsString:= EmptyStr;
  ClientesemailFactura.AsString:= EmptyStr;
  ClientesdomicilioFactura.AsString:= EmptyStr;
  Clienteszona_id.AsInteger:= 0;
  ClienteslistaPrecio_id.AsInteger:= 0;
  ClientesbVisible.AsInteger:=1;
end;

procedure TDM_Clientes.DataModuleCreate(Sender: TObject);
begin
  qZonasClientes.Open;
  qListasPrecios.Open;
end;

function TDM_Clientes.getRazonSocial: String;
begin
  DM_Empresa.LevantarEmpresa(_idEmpresa);
  Result:= DM_Empresa.RazonSocial;
end;

procedure TDM_Clientes.Nuevo;
begin
  _idEmpresa:= DM_Empresa.Nueva;
  DM_General.ReiniciarTabla(Clientes);
  Clientes.Insert;
end;

procedure TDM_Clientes.Editar(refCliente: GUID_ID);
begin
  DM_General.ReiniciarTabla(Clientes);
  if SELClientes.Active then SELClientes.close;
  SELClientes.ParamByName('id').AsString:= refCliente;
  SELClientes.Open;
  Clientes.LoadFromDataSet(SELClientes, 0, lmAppend);
  SELClientes.Close;
  _idEmpresa:= Clientesempresa_id.AsString;
  DM_Empresa.Editar(Clientesempresa_id.AsString);
end;

procedure TDM_Clientes.Grabar;
begin
  DM_Empresa.Grabar;
  DM_General.GrabarDatos(SELClientes, INSClientes, UPDClientes, Clientes, 'id');
end;

procedure TDM_Clientes.Borrar(refCliente: GUID_ID);
begin
  with DELClientes do
  begin
    ParamByName('id').asString:= refCliente;
    ExecSQL;
  end;
end;

end.

