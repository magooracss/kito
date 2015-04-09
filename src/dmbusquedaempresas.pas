unit dmbusquedaempresas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset;

Const
  TIP_CLIENTES = 'CLIENTE';
  TIP_PROVEEDORES = 'PROVEEDOR';
  TIP_TRANSPORTISTAS = 'TRANSPORTISTA';
  TIP_VENDEDORES = 'VENDEDOR';

type

  { TDM_BusquedaEmpresas }

  TDM_BusquedaEmpresas = class(TDataModule)
    qBusquedaCODIGO: TStringField;
    qBusquedaCUIT: TStringField;
    qBusquedaIDEMPRESA: TStringField;
    qBusquedaIDTIPO: TStringField;
    qBusquedaRAZONSOCIAL: TStringField;
    qBusquedaTIPO: TStringField;
    Resultados: TRxMemoryData;
    Resultadoscodigo: TStringField;
    ResultadosCuit: TStringField;
    ResultadosidEmpresa: TStringField;
    ResultadosidTipo: TStringField;
    ResultadosRazonSocial: TStringField;
    ResultadosTIPO: TStringField;
    qBusqueda: TZQuery;
  private
    procedure SQLBaseClientes;
    procedure SQLBaseProveedores;
    procedure SQLBaseTransportistas;

  public
    procedure BusquedaNueva;
    procedure BuscarClientesPorRazonSocial(dato: string);
    procedure BuscarClientesPorCodigo(dato: string);
    procedure BuscarClientesPorCUIT(dato: string);

    procedure BuscarProvPorRazonSocial(dato: string);
    procedure BuscarProvPorCodigo(dato: string);
    procedure BuscarProvPorCUIT(dato: string);

    procedure BuscarTransportistaPorRazonSocial(dato: string);
    procedure BuscarTransportistaPorCodigo(dato: string);
    procedure BuscarTransportistaPorCUIT(dato: string);


  end;

var
  DM_BusquedaEmpresas: TDM_BusquedaEmpresas;

implementation
{$R *.lfm}
uses
  dmgeneral
  ;

{ TDM_BusquedaEmpresas }

procedure TDM_BusquedaEmpresas.SQLBaseClientes;
begin
  With qBusqueda do
  begin
    if active then close;
    SQL.Clear;
    SQL.Add('SELECT E.RazonSocial, E.Cuit, Cli.Codigo');
    SQL.Add(' ,'''+ TIP_CLIENTES +''' as Tipo,E.id as idEmpresa, Cli.id as idTipo');
    SQL.Add('FROM Empresas E ');
    SQL.Add('INNER JOIN Clientes Cli ON Cli.empresa_id = E.id');
    SQL.Add('WHERE (E.bVisible = 1) AND (Cli.bVisible = 1)');
  end;
end;

procedure TDM_BusquedaEmpresas.BusquedaNueva;
begin
  DM_General.ReiniciarTabla(Resultados);
end;

procedure TDM_BusquedaEmpresas.BuscarClientesPorRazonSocial(dato: string);
begin
  SQLBaseClientes;
  with qBusqueda do
  begin
    SQL.Add(' AND (UPPER(E.RazonSocial) LIKE UPPER(''%'+dato+'%''))');
    Open;
    Resultados.LoadFromDataSet(qBusqueda, 0, lmAppend);
  end;
end;

procedure TDM_BusquedaEmpresas.BuscarClientesPorCodigo(dato: string);
begin
  SQLBaseClientes;
  with qBusqueda do
  begin
    SQL.Add(' AND (UPPER(Cli.Codigo)  LIKE UPPER(''%'+dato+'%''))');
    Open;
    Resultados.LoadFromDataSet(qBusqueda, 0, lmAppend);
  end;
end;

procedure TDM_BusquedaEmpresas.BuscarClientesPorCUIT(dato: string);
begin
  SQLBaseClientes;
  with qBusqueda do
  begin
    SQL.Add(' AND (UPPER(E.CUIT)  LIKE UPPER(''%'+dato+'%''))');
    Open;
    Resultados.LoadFromDataSet(qBusqueda, 0, lmAppend);
  end;
end;

procedure TDM_BusquedaEmpresas.SQLBaseProveedores;
begin
  With qBusqueda do
   begin
     if active then close;
     SQL.Clear;
     SQL.Add('SELECT E.RazonSocial, E.Cuit, Prov.Codigo');
     SQL.Add(' ,'''+ TIP_PROVEEDORES +''' as Tipo,E.id as idEmpresa, Prov.id as idTipo');
     SQL.Add('FROM Empresas E ');
     SQL.Add('INNER JOIN Proveedores Prov ON Prov.empresa_id = E.id');
     SQL.Add('WHERE (E.bVisible = 1) AND (Prov.bVisible = 1)');
   end;
end;


procedure TDM_BusquedaEmpresas.BuscarProvPorRazonSocial(dato: string);
begin
  SQLBaseProveedores;
  with qBusqueda do
  begin
    SQL.Add(' AND (UPPER(E.RazonSocial) LIKE UPPER(''%'+dato+'%''))');
    Open;
    Resultados.LoadFromDataSet(qBusqueda, 0, lmAppend);
  end;
end;

procedure TDM_BusquedaEmpresas.BuscarProvPorCodigo(dato: string);
begin
  SQLBaseProveedores;
  with qBusqueda do
  begin
    SQL.Add(' AND (UPPER(Prov.Codigo)  LIKE UPPER(''%'+dato+'%''))');
    Open;
    Resultados.LoadFromDataSet(qBusqueda, 0, lmAppend);
  end;
end;

procedure TDM_BusquedaEmpresas.BuscarProvPorCUIT(dato: string);
begin
  SQLBaseProveedores;
  with qBusqueda do
  begin
    SQL.Add(' AND (UPPER(E.CUIT)  LIKE UPPER(''%'+dato+'%''))');
    Open;
    Resultados.LoadFromDataSet(qBusqueda, 0, lmAppend);
  end;
end;

procedure TDM_BusquedaEmpresas.SQLBaseTransportistas;
begin
  With qBusqueda do
   begin
     if active then close;
     SQL.Clear;
     SQL.Add('SELECT E.RazonSocial, E.Cuit, Trans.Codigo');
     SQL.Add(' ,'''+ TIP_TRANSPORTISTAS +''' as Tipo,E.id as idEmpresa, Trans.id as idTipo');
     SQL.Add('FROM Empresas E ');
     SQL.Add('INNER JOIN Transportistas Trans ON Trans.empresa_id = E.id');
     SQL.Add('WHERE (E.bVisible = 1) AND (Trans.bVisible = 1)');
   end;
end;

procedure TDM_BusquedaEmpresas.BuscarTransportistaPorRazonSocial(dato: string);
begin
  SQLBaseTransportistas;
  with qBusqueda do
  begin
    SQL.Add(' AND (UPPER(E.RazonSocial) LIKE UPPER(''%'+dato+'%''))');
    Open;
    Resultados.LoadFromDataSet(qBusqueda, 0, lmAppend);
  end;
end;

procedure TDM_BusquedaEmpresas.BuscarTransportistaPorCodigo(dato: string);
begin
  SQLBaseTransportistas;
  with qBusqueda do
  begin
    SQL.Add(' AND (UPPER(Trans.Codigo)  LIKE UPPER(''%'+dato+'%''))');
    Open;
    Resultados.LoadFromDataSet(qBusqueda, 0, lmAppend);
  end;
end;

procedure TDM_BusquedaEmpresas.BuscarTransportistaPorCUIT(dato: string);
begin
  SQLBaseTransportistas;
  with qBusqueda do
  begin
    SQL.Add(' AND (UPPER(E.CUIT)  LIKE UPPER(''%'+dato+'%''))');
    Open;
    Resultados.LoadFromDataSet(qBusqueda, 0, lmAppend);
  end;
end;

end.

