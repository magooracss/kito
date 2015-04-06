unit dmempresa;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxmemds, ZDataset
  ,dmgeneral
  , db;

type

  { TDM_Empresa }

  TDM_Empresa = class(TDataModule)
    ContactosbVisible: TLongintField;
    ContactosContacto: TStringField;
    Contactosempresa_id: TStringField;
    Contactosid: TStringField;
    ContactoslxTipoContacto: TStringField;
    ContactostipoContacto_id: TLongintField;
    DELContactos: TZQuery;
    DELEmpresas: TZQuery;
    Contactos: TRxMemoryData;
    DomiciliosbVisible: TLongintField;
    Domiciliosdomicilio: TStringField;
    Domiciliosempresa_id: TStringField;
    Domiciliosid: TStringField;
    Domicilioslocalidad_id: TLongintField;
    DELDomicilios: TZQuery;
    DomicilioslxLocalidad: TStringField;
    Empresas: TRxMemoryData;
    EmpresasbVisible: TLongintField;
    Empresascondicionfiscal_id: TLongintField;
    EmpresasCUIT: TStringField;
    Empresasid: TStringField;
    EmpresasRazonSocial: TStringField;
    INSDomicilios: TZQuery;
    Domicilios: TRxMemoryData;
    INSContactos: TZQuery;
    INSEmpresas: TZQuery;
    qCondicionesFiscales: TZQuery;
    qTiposContactos: TZQuery;
    qCondicionesFiscalesBVISIBLE: TSmallintField;
    qCondicionesFiscalesCONDICIONFISCAL: TStringField;
    qCondicionesFiscalesID: TLongintField;
    qCondicionesFiscalesTIPOFACTURA: TLongintField;
    qContPorEmpresa: TZQuery;
    qTiposContactosBVISIBLE: TSmallintField;
    qTiposContactosID: TLongintField;
    qTiposContactosTIPOCONTACTO: TStringField;
    SELContactosBVISIBLE: TSmallintField;
    SELContactosBVISIBLE1: TSmallintField;
    SELContactosCONTACTO: TStringField;
    SELContactosCONTACTO1: TStringField;
    SELContactosEMPRESA_ID: TStringField;
    SELContactosEMPRESA_ID1: TStringField;
    SELContactosID: TStringField;
    SELContactosID1: TStringField;
    SELContactosLXTIPOCONTACTO: TStringField;
    SELContactosLXTIPOCONTACTO1: TStringField;
    SELContactosTIPOCONTACTO_ID: TLongintField;
    SELContactosTIPOCONTACTO_ID1: TLongintField;
    SELDomicilios: TZQuery;
    SELContactos: TZQuery;
    qDomPorEmpresa: TZQuery;
    SELDomiciliosBVISIBLE1: TSmallintField;
    SELDomiciliosDOMICILIO1: TStringField;
    SELDomiciliosEMPRESA_ID1: TStringField;
    SELDomiciliosID1: TStringField;
    SELDomiciliosLOCALIDAD_ID1: TLongintField;
    SELDomiciliosLXLOCALIDAD1: TStringField;
    SELEmpresas: TZQuery;
    SELDomiciliosBVISIBLE: TSmallintField;
    SELDomiciliosDOMICILIO: TStringField;
    SELDomiciliosEMPRESA_ID: TStringField;
    SELDomiciliosID: TStringField;
    SELDomiciliosLOCALIDAD_ID: TLongintField;
    SELDomiciliosLXLOCALIDAD: TStringField;
    SELEmpresasBVISIBLE: TSmallintField;
    SELEmpresasCONDICIONFISCAL_ID: TLongintField;
    SELEmpresasCUIT: TStringField;
    SELEmpresasID: TStringField;
    SELEmpresasRAZONSOCIAL: TStringField;
    UPDDomicilios: TZQuery;
    UPDContactos: TZQuery;
    UPDEmpresas: TZQuery;
    procedure ContactosAfterInsert(DataSet: TDataSet);
    procedure DomiciliosAfterInsert(DataSet: TDataSet);
    procedure EmpresasAfterInsert(DataSet: TDataSet);
  private
    _idEmpresa: GUID_ID;
  public
    function Nueva: GUID_ID;
    procedure Editar (refEmpresa: GUID_ID);
    procedure Grabar;
    procedure LevantarEmpresa (refEmpresa: GUID_ID);

    procedure ActualizarTipoContacto (refTC: Integer);
    procedure GrabarContactos;
    procedure LevantarContactos;
  end;

var
  DM_Empresa: TDM_Empresa;

implementation

{$R *.lfm}

{ TDM_Empresa }

(*******************************************************************************
*** GENERALES
*******************************************************************************)
procedure TDM_Empresa.Grabar;
begin
  DM_General.GrabarDatos(SELEmpresas, INSEmpresas, UPDEmpresas, Empresas, 'id');
  DM_General.GrabarDatos(SELDomicilios, INSDomicilios, UPDDomicilios, Domicilios, 'id');
end;

procedure TDM_Empresa.LevantarEmpresa(refEmpresa: GUID_ID);
begin
  DM_General.ReiniciarTabla(Empresas);
  DM_General.ReiniciarTabla(Domicilios);
  DM_General.ReiniciarTabla(Contactos);

  _idEmpresa:= refEmpresa;

  if SELEmpresas.Active then SELEmpresas.close;
  SELEmpresas.ParamByName('id').AsString:= refEmpresa;
  SELEmpresas.Open;
  Empresas.LoadFromDataSet(SELEmpresas, 0, lmAppend);
  SELEmpresas.Close;

  if qDomPorEmpresa.Active then qDomPorEmpresa.Close;
  qDomPorEmpresa.ParamByName('refEmpresa').asString:= refEmpresa;
  qDomPorEmpresa.Open;
  Domicilios.LoadFromDataSet(qDomPorEmpresa, 0, lmAppend);
  qDomPorEmpresa.Close;

  LevantarContactos;
end;

(*******************************************************************************
*** Empresas
*******************************************************************************)
procedure TDM_Empresa.EmpresasAfterInsert(DataSet: TDataSet);
begin
  _idEmpresa:= DM_General.CrearGUID;
  Empresasid.AsString:= _idEmpresa;
  EmpresasRazonSocial.AsString:= EmptyStr;
  EmpresasCUIT.AsString:= EmptyStr;
  Empresascondicionfiscal_id.AsInteger:= 0;
  EmpresasbVisible.AsInteger:=1;
end;

function TDM_Empresa.Nueva: GUID_ID;
begin
  DM_General.ReiniciarTabla(Empresas);
  DM_General.ReiniciarTabla(Domicilios);
  DM_General.ReiniciarTabla(Contactos);
  Empresas.Insert;
  Result:= _idEmpresa;
end;

procedure TDM_Empresa.Editar(refEmpresa: GUID_ID);
begin
  DM_General.ReiniciarTabla(Empresas);
  LevantarEmpresa(refEmpresa);
  Empresas.Edit;
end;


(*******************************************************************************
*** DOMICILIOS
*******************************************************************************)
procedure TDM_Empresa.DomiciliosAfterInsert(DataSet: TDataSet);
begin
  Domiciliosid.AsString:= DM_General.CrearGUID;
  Domiciliosempresa_id.AsString:= Empresasid.AsString;
  Domiciliosdomicilio.AsString:= EmptyStr;
  Domicilioslocalidad_id.AsInteger:= 0;
  DomiciliosbVisible.AsInteger:= 1;
end;

(*******************************************************************************
*** CONTACTOS
*******************************************************************************)

procedure TDM_Empresa.ActualizarTipoContacto(refTC: Integer);
begin
  Contactos.Edit;
  ContactostipoContacto_id.AsInteger:= refTC;
  Contactos.Post;
end;

procedure TDM_Empresa.GrabarContactos;
begin
  DM_General.GrabarDatos(SELContactos, INSContactos, UPDContactos, Contactos, 'id');
end;

procedure TDM_Empresa.LevantarContactos;
begin
  if qContPorEmpresa.Active then qContPorEmpresa.Close;
  qContPorEmpresa.ParamByName('refEmpresa').asString:= _idEmpresa;
  qContPorEmpresa.Open;
  Contactos.LoadFromDataSet(qContPorEmpresa, 0, lmAppend);
  qContPorEmpresa.Close;
end;

procedure TDM_Empresa.ContactosAfterInsert(DataSet: TDataSet);
begin
  Contactosid.AsString:= DM_General.CrearGUID;
  Contactosempresa_id.AsString:= Empresasid.AsString;
  ContactosContacto.AsString:= EmptyStr;
  ContactostipoContacto_id.AsInteger:= 0;
  ContactosbVisible.AsInteger:= 1;
end;


end.

