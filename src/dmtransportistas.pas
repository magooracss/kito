unit dmtransportistas;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxmemds, ZDataset
  , dmempresa, dmgeneral
  ;

type

  { TDM_Transportistas }

  TDM_Transportistas = class(TDataModule)
    SELTransportistasBVISIBLE: TSmallintField;
    SELTransportistasCODIGO: TStringField;
    SELTransportistasEMPRESA_ID: TStringField;
    SELTransportistasID: TStringField;
    SELTransportistasZONA_ID: TLongintField;
    Transportistas: TRxMemoryData;
    TransportistasbVisible: TLongintField;
    Transportistascodigo: TStringField;
    TransportistasdomicilioFactura: TStringField;
    TransportistasemailFactura: TStringField;
    Transportistasempresa_id: TStringField;
    Transportistasid: TStringField;
    TransportistaslistaPrecio_id: TLongintField;
    Transportistaszona_id: TLongintField;
    DELTransportistas: TZQuery;
    INSTransportistas: TZQuery;
    qZonas: TZQuery;
    qZonasBVISIBLE: TSmallintField;
    qZonasID: TLongintField;
    qZonasZONA: TStringField;
    SELTransportistas: TZQuery;
    UPDTransportistas: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure TransportistasAfterInsert(DataSet: TDataSet);
  private
     _idEmpresa: GUID_ID;
     function getRazonSocial: String;
   public
     property RazonSocial: String read getRazonSocial;
     procedure Nuevo;
     procedure Editar (refTransportista: GUID_ID);
     procedure Grabar;
     procedure Borrar (refTransportista: GUID_ID);
  end;

var
  DM_Transportistas: TDM_Transportistas;

implementation

{$R *.lfm}

{ TDM_Transportistas }

procedure TDM_Transportistas.DataModuleCreate(Sender: TObject);
begin
  qZonas.Open;
end;

procedure TDM_Transportistas.TransportistasAfterInsert(DataSet: TDataSet);
begin
  Transportistasid.AsString:= DM_General.CrearGUID;
  Transportistasempresa_id.AsString:= _idEmpresa;
  Transportistascodigo.AsInteger:= 0;
  Transportistaszona_id.AsInteger:= 0;
  TransportistasbVisible.AsInteger:= 1;
end;

function TDM_Transportistas.getRazonSocial: String;
begin
  DM_Empresa.LevantarEmpresa(_idEmpresa);
  Result:= DM_Empresa.RazonSocial;
end;

procedure TDM_Transportistas.Nuevo;
begin
  _idEmpresa:= DM_Empresa.Nueva;
  DM_General.ReiniciarTabla(Transportistas);
  Transportistas.Insert;
end;

procedure TDM_Transportistas.Editar(refTransportista: GUID_ID);
begin
  DM_General.ReiniciarTabla(Transportistas);

  if SELTransportistas.Active then SELTransportistas.close;
  SELTransportistas.ParamByName('id').AsString:= refTransportista;
  SELTransportistas.Open;
  Transportistas.LoadFromDataSet(SELTransportistas, 0, lmAppend);
  SELTransportistas.Close;

  DM_Empresa.Editar(Transportistasempresa_id.AsString);
end;

procedure TDM_Transportistas.Grabar;
begin
  DM_Empresa.Grabar;
  DM_General.GrabarDatos(SELTransportistas, INSTransportistas, UPDTransportistas , Transportistas, 'id');
end;

procedure TDM_Transportistas.Borrar(refTransportista: GUID_ID);
begin
  with DELTransportistas do
  begin
    ParamByName('id').asString:= refTransportista;
    ExecSQL;
  end;
end;

end.

