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
    DELProvincias: TZQuery;
    DELLocalidades: TZQuery;
    INSProvincias: TZQuery;
    INSLocalidades: TZQuery;
    Paises: TRxMemoryData;
    ContactosbVisible: TLongintField;
    ContactosContacto: TStringField;
    Contactosempresa_id: TStringField;
    Contactosid: TStringField;
    ContactoslxTipoContacto: TStringField;
    ContactostipoContacto_id: TLongintField;
    DELContactos: TZQuery;
    DELPaises: TZQuery;
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
    INSPaises: TZQuery;
    INSDomicilios: TZQuery;
    Domicilios: TRxMemoryData;
    INSContactos: TZQuery;
    INSEmpresas: TZQuery;
    LocalidadesBVISIBLE: TSmallintField;
    LocalidadesCODIGOPOSTAL: TStringField;
    LocalidadesID: TLongintField;
    LocalidadesLOCALIDAD: TStringField;
    LocalidadesPROVINCIA_ID: TLongintField;
    Provincias: TRxMemoryData;
    PaisesBVISIBLE: TSmallintField;
    PaisesID: TLongintField;
    PaisesPAIS: TStringField;
    Localidades: TRxMemoryData;
    ProvinciasBVISIBLE: TSmallintField;
    ProvinciasID: TLongintField;
    ProvinciasPAIS_ID: TLongintField;
    ProvinciasPROVINCIA: TStringField;
    qCondicionesFiscales: TZQuery;
    qLocalidadesProvincia: TZQuery;
    qLocalidadPorNombre: TZQuery;
    qLocalidadesProvinciaBVISIBLE: TSmallintField;
    qLocalidadesProvinciaCODIGOPOSTAL: TStringField;
    qLocalidadesProvinciaID: TLongintField;
    qLocalidadesProvinciaLOCALIDAD: TStringField;
    qLocalidadesProvinciaPROVINCIA_ID: TLongintField;
    qLocalidadPorNombreCODIGOPOSTAL: TStringField;
    qLocalidadPorNombreID: TLongintField;
    qLocalidadPorNombreLOCALIDAD: TStringField;
    qLocalidadPorNombrePAIS: TStringField;
    qLocalidadPorNombrePROVINCIA: TStringField;
    qTodosLosPaises: TZQuery;
    qLocalidadIDBVISIBLE: TSmallintField;
    qLocalidadIDBVISIBLE_1: TSmallintField;
    qLocalidadIDBVISIBLE_2: TSmallintField;
    qLocalidadIDCODIGOPOSTAL: TStringField;
    qLocalidadIDID: TLongintField;
    qLocalidadIDID_1: TLongintField;
    qLocalidadIDID_2: TLongintField;
    qLocalidadIDLOCALIDAD: TStringField;
    qLocalidadIDPAIS: TStringField;
    qLocalidadIDPAIS_ID: TLongintField;
    qLocalidadIDPROVINCIA: TStringField;
    qLocalidadIDPROVINCIA_ID: TLongintField;
    qPaisesBVISIBLE: TSmallintField;
    qPaisesID: TLongintField;
    qPaisesPAIS: TStringField;
    qTiposContactos: TZQuery;
    qCondicionesFiscalesBVISIBLE: TSmallintField;
    qCondicionesFiscalesCONDICIONFISCAL: TStringField;
    qCondicionesFiscalesID: TLongintField;
    qCondicionesFiscalesTIPOFACTURA: TLongintField;
    qContPorEmpresa: TZQuery;
    qTiposContactosBVISIBLE: TSmallintField;
    qTiposContactosID: TLongintField;
    qTiposContactosTIPOCONTACTO: TStringField;
    qProvinciasPais: TZQuery;
    qProvinciasPaisBVISIBLE: TSmallintField;
    qProvinciasPaisID: TLongintField;
    qProvinciasPaisPAIS_ID: TLongintField;
    qProvinciasPaisPROVINCIA: TStringField;
    qTodosLosPaisesBVISIBLE: TSmallintField;
    qTodosLosPaisesID: TLongintField;
    qTodosLosPaisesPAIS: TStringField;
    SELLocalidadesBVISIBLE: TSmallintField;
    SELLocalidadesBVISIBLE1: TSmallintField;
    SELLocalidadesCODIGOPOSTAL: TStringField;
    SELLocalidadesCODIGOPOSTAL1: TStringField;
    SELLocalidadesID: TLongintField;
    SELLocalidadesID1: TLongintField;
    SELLocalidadesLOCALIDAD: TStringField;
    SELLocalidadesLOCALIDAD1: TStringField;
    SELLocalidadesPROVINCIA_ID: TLongintField;
    SELLocalidadesPROVINCIA_ID1: TLongintField;
    SELPaises: TZQuery;
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
    SELProvincias: TZQuery;
    SELPaisesBVISIBLE: TSmallintField;
    SELPaisesID: TLongintField;
    SELPaisesPAIS: TStringField;
    SELLocalidades: TZQuery;
    SELProvinciasBVISIBLE: TSmallintField;
    SELProvinciasID: TLongintField;
    SELProvinciasPAIS_ID: TLongintField;
    SELProvinciasPROVINCIA: TStringField;
    UPDPaises: TZQuery;
    UPDDomicilios: TZQuery;
    UPDContactos: TZQuery;
    UPDEmpresas: TZQuery;
    UPDProvincias: TZQuery;
    UPDLocalidades: TZQuery;
    procedure ContactosAfterInsert(DataSet: TDataSet);
    procedure DomiciliosAfterInsert(DataSet: TDataSet);
    procedure EmpresasAfterInsert(DataSet: TDataSet);
    procedure LocalidadesAfterInsert(DataSet: TDataSet);
    procedure PaisesAfterInsert(DataSet: TDataSet);
    procedure ProvinciasAfterInsert(DataSet: TDataSet);
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
    procedure BorrarContacto (refContacto: GUID_ID);

    procedure LocalidadPorID (refLocalidad: Integer);
    procedure ProvinciasPorPais (refPais: integer);
    procedure LocalidadesPorProvincia(refProvincia: integer);
    procedure BuscarLocalidadNombre (nombre: string);
    procedure GrabarDomicilios;
    procedure LevantarDomicilios;
    procedure BorrarDomicilio (refDomicilio: GUID_ID);
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
end;

procedure TDM_Empresa.LevantarEmpresa(refEmpresa: GUID_ID);
begin
  DM_General.ReiniciarTabla(Empresas);

  if SELEmpresas.Active then SELEmpresas.close;
  SELEmpresas.ParamByName('id').AsString:= refEmpresa;
  SELEmpresas.Open;
  Empresas.LoadFromDataSet(SELEmpresas, 0, lmAppend);
  SELEmpresas.Close;

  _idEmpresa:= refEmpresa;

  LevantarContactos;
  LevantarDomicilios;
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

procedure TDM_Empresa.PaisesAfterInsert(DataSet: TDataSet);
begin
  Paisesid.AsInteger:= -1;
  PaisesPAIS.AsString:= EmptyStr;
  PaisesBVISIBLE.AsInteger:= 1;
end;

procedure TDM_Empresa.ProvinciasAfterInsert(DataSet: TDataSet);
begin
  ProvinciasID.AsInteger:= -1;
  ProvinciasPROVINCIA.AsString:= EmptyStr;
  ProvinciasPAIS_ID.AsInteger:= PaisesID.AsInteger;
  ProvinciasBVISIBLE.AsInteger:= 1;
end;

procedure TDM_Empresa.LocalidadPorID(refLocalidad: Integer);
begin
  DM_General.ReiniciarTabla(Localidades);
  DM_General.ReiniciarTabla(Provincias);
  DM_General.ReiniciarTabla(Paises);

  with SELLocalidades do
  begin
    if active then close;
    ParamByName('id').asInteger:= refLocalidad;
    Open;
    Localidades.LoadFromDataSet(SELLocalidades, 0, lmAppend);
    close;
  end;
  with SELProvincias do
  begin
    if active then close;
    ParamByName('id').asInteger:= LocalidadesPROVINCIA_ID.AsInteger;
    Open;
    Provincias.LoadFromDataSet(SELProvincias, 0, lmAppend);
    close;
  end;
  with SELPaises do
  begin
    if active then close;
    ParamByName('id').asInteger:= ProvinciasPAIS_ID.AsInteger;
    Open;
    Paises.LoadFromDataSet(SELPaises, 0, lmAppend);
    close;
  end;
end;

procedure TDM_Empresa.ProvinciasPorPais(refPais: integer);
begin
  DM_General.ReiniciarTabla(Provincias);
  with qProvinciasPais do
  begin
    if active then close;
    ParamByName('refPais').AsInteger:= refPais;
    Open;
    Provincias.LoadFromDataSet(qProvinciasPais, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_Empresa.LocalidadesPorProvincia(refProvincia: integer);
begin
  DM_General.ReiniciarTabla(Localidades);
  with qLocalidadesProvincia do
  begin
    if active then close;
    ParamByName('refProvincia').AsInteger:= refProvincia;
    Open;
    Localidades.LoadFromDataSet(qLocalidadesProvincia, 0, lmAppend);
    Close;
  end;
end;

procedure TDM_Empresa.BuscarLocalidadNombre(nombre: string);
begin
  with qLocalidadPorNombre do
  begin
    if active then close;
    ParamByName('nombre').asString:= UpperCase(Trim(nombre));
    Open;
  end;
end;

procedure TDM_Empresa.GrabarDomicilios;
begin
  DM_General.GrabarDatos(SELDomicilios, INSDomicilios, UPDDomicilios, Domicilios, 'id');
end;

procedure TDM_Empresa.LevantarDomicilios;
begin
  DM_General.ReiniciarTabla(Domicilios);

  if qDomPorEmpresa.Active then qDomPorEmpresa.Close;
  qDomPorEmpresa.ParamByName('refEmpresa').asString:= _idEmpresa;
  qDomPorEmpresa.Open;
  Domicilios.LoadFromDataSet(qDomPorEmpresa, 0, lmAppend);
  qDomPorEmpresa.Close;
end;

procedure TDM_Empresa.LocalidadesAfterInsert(DataSet: TDataSet);
begin
  LocalidadesID.AsInteger:= -1;
  LocalidadesLOCALIDAD.AsString:= EmptyStr;
  LocalidadesCODIGOPOSTAL.AsString:= EmptyStr;
  LocalidadesPROVINCIA_ID.AsInteger:= 0;
  LocalidadesBVISIBLE.asInteger:= 1;
end;

procedure TDM_Empresa.BorrarDomicilio(refDomicilio: GUID_ID);
begin
  DELDomicilios.ParamByName('id').AsString:= refDomicilio;
  DELDomicilios.ExecSQL;
end;


(*******************************************************************************
*** CONTACTOS
*******************************************************************************)

procedure TDM_Empresa.ContactosAfterInsert(DataSet: TDataSet);
begin
  Contactosid.AsString:= DM_General.CrearGUID;
  Contactosempresa_id.AsString:= Empresasid.AsString;
  ContactosContacto.AsString:= EmptyStr;
  ContactostipoContacto_id.AsInteger:= 0;
  ContactosbVisible.AsInteger:= 1;
end;

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
  DM_General.ReiniciarTabla(Contactos);
  if qContPorEmpresa.Active then qContPorEmpresa.Close;

  qContPorEmpresa.ParamByName('refEmpresa').asString:= _idEmpresa;
  qContPorEmpresa.Open;
  Contactos.LoadFromDataSet(qContPorEmpresa, 0, lmAppend);
  qContPorEmpresa.Close;
end;

procedure TDM_Empresa.BorrarContacto(refContacto: GUID_ID);
begin
  DELContactos.ParamByName('id').AsString:= refContacto;
  DELContactos.ExecSQL;
end;


end.

