unit dmclientes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds
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
    procedure ClientesAfterInsert(DataSet: TDataSet);
  private
    _idEmpresa: GUID_ID;
  public
    procedure Nuevo;
    procedure Editar (refCliente: GUID_ID);
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

procedure TDM_Clientes.Nuevo;
begin
  _idEmpresa:= DM_Empresa.Nueva;
  DM_General.ReiniciarTabla(Clientes);
  Clientes.Insert;
end;

procedure TDM_Clientes.Editar(refCliente: GUID_ID);
begin
  { TODO : Levantar tabla Clientes }
   DM_Empresa.Editar(Clientesempresa_id.AsString);
end;

end.

