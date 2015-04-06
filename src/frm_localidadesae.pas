unit frm_localidadesae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  DbCtrls, StdCtrls, Buttons, ExtCtrls
  ,dmgeneral
  ,dmempresa;

type

  { TfrmLocalidadesAE }

  TfrmLocalidadesAE = class(TForm)
    btnALocalidad: TSpeedButton;
    btnBLocalidad: TSpeedButton;
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    btnMLocalidad: TSpeedButton;
    cbPaises: TComboBox;
    cbProvincias: TComboBox;
    cbLocalidades: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    btnAPais: TSpeedButton;
    btnMPais: TSpeedButton;
    btnBPais: TSpeedButton;
    btnAProvincia: TSpeedButton;
    btnMProvincia: TSpeedButton;
    btnBProvincia: TSpeedButton;
    procedure btnALocalidadClick(Sender: TObject);
    procedure btnAPaisClick(Sender: TObject);
    procedure btnAProvinciaClick(Sender: TObject);
    procedure btnBLocalidadClick(Sender: TObject);
    procedure btnBPaisClick(Sender: TObject);
    procedure btnBProvinciaClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure btnMLocalidadClick(Sender: TObject);
    procedure btnMPaisClick(Sender: TObject);
    procedure btnMProvinciaClick(Sender: TObject);
    procedure cbLocalidadesChange(Sender: TObject);
    procedure cbPaisesChange(Sender: TObject);
    procedure cbProvinciasChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure Inicializar;
    procedure CargarProvinciasPais (refPais: integer);
    procedure CargarLocalidadesProvincia (refProvincia: integer);
  public
    { public declarations }
  end;

var
  frmLocalidadesAE: TfrmLocalidadesAE;

implementation
{$R *.lfm}
uses
  rxmemds;

{ TfrmLocalidadesAE }

procedure TfrmLocalidadesAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmLocalidadesAE.btnGrabarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmLocalidadesAE.btnMLocalidadClick(Sender: TObject);
var
  laLocalidad
  ,elCP: string;
begin
  laLocalidad:= EmptyStr;
  if ( (DM_Empresa.Localidades.Active)
       and
      (DM_Empresa.Localidades.RecordCount > 0)) then
  begin
    laLocalidad:= DM_Empresa.LocalidadesLOCALIDAD.asString;

    if InputQuery('Localidades', 'Nombre de la localidad',laLocalidad)
       and (TRIM(laLocalidad) <> EmptyStr) then
    begin
      elCP:= InputBox('Localidades', 'Código Postal', DM_Empresa.LocalidadesCODIGOPOSTAL.AsString);
      with DM_Empresa do
      begin
        Localidades.Edit;
        LocalidadesLOCALIDAD.AsString:= laLocalidad;
        LocalidadesCODIGOPOSTAL.AsString:= elCP;
        Localidades.Post;
        DM_General.GrabarDatos(SELLocalidades, INSLocalidades, UPDLocalidades, Localidades, 'id');
        CargarLocalidadesProvincia(DM_General.obtenerIDIntComboBox(cbProvincias));
      end;
    end;
  end;
end;

procedure TfrmLocalidadesAE.Inicializar;
begin
  DM_General.ReiniciarTabla(DM_Empresa.Paises);
  DM_General.CargarComboBox(cbPaises, 'Pais', 'id', DM_Empresa.qTodosLosPaises );
  CargarProvinciasPais(DM_General.obtenerIDIntComboBox(cbPaises));
  CargarLocalidadesProvincia(DM_General.obtenerIDIntComboBox(cbProvincias));
end;

procedure TfrmLocalidadesAE.CargarProvinciasPais(refPais: integer);
begin
  DM_Empresa.ProvinciasPorPais(refPais);
  cbProvincias.Items.Clear;
  cbProvincias.Clear;
  with DM_Empresa.Provincias do
  begin
    First;
    While Not EOF do
    begin
      cbProvincias.Items.AddObject(FieldByName('Provincia').asString, TObject(FieldByName ('id').asInteger));
      Next;
    end;
  end;
  if cbProvincias.Items.Count > 0 then
   cbProvincias.ItemIndex:= 0;
end;

procedure TfrmLocalidadesAE.btnAPaisClick(Sender: TObject);
var
  elPais: string;
begin
  if InputQuery('Paises', 'Nombre del país',elPais)
     and (TRIM(elPais) <> EmptyStr) then
  begin
    with DM_Empresa do
    begin
      Paises.Insert;
      PaisesPAIS.AsString:= elPais;
      Paises.Post;
      DM_General.GrabarDatos(SELPaises, INSPaises, UPDPaises, Paises, 'id');
    end;
  end;
end;

procedure TfrmLocalidadesAE.btnALocalidadClick(Sender: TObject);
var
  laLocalidad
  ,elCP: string;
begin
  if InputQuery('Localidades', 'Nombre de la localidad',laLocalidad)
     and (TRIM(laLocalidad) <> EmptyStr) then
  begin
    elCP:= InputBox('Localidades', 'Código Postal','');
    with DM_Empresa do
    begin
      Localidades.Insert;
      LocalidadesLOCALIDAD.AsString:= laLocalidad;
      LocalidadesCODIGOPOSTAL.AsString:= elCP;
      LocalidadesPROVINCIA_ID.AsInteger:= DM_General.obtenerIDIntComboBox(cbProvincias);
      Localidades.Post;
      DM_General.GrabarDatos(SELLocalidades, INSLocalidades, UPDLocalidades, Localidades, 'id');
      CargarLocalidadesProvincia(DM_General.obtenerIDIntComboBox(cbProvincias));
    end;
  end;
end;

procedure TfrmLocalidadesAE.btnMPaisClick(Sender: TObject);
var
  elPais: string;
begin
  elPais:= EmptyStr;
  if ( (DM_Empresa.Paises.Active)
       and
      (DM_Empresa.Paises.RecordCount > 0)) then
  begin
    elPais:= DM_Empresa.PaisesPAIS.asString;
    if InputQuery('Paises', 'Nombre del país',elPais)
       and (TRIM(elPais) <> EmptyStr) then
    begin
      with DM_Empresa do
      begin
        Paises.Edit;
        PaisesPAIS.AsString:= elPais;
        Paises.Post;
        DM_General.GrabarDatos(SELPaises, INSPaises, UPDPaises, Paises, 'id');
      end;
    end;
  end;
end;

procedure TfrmLocalidadesAE.cbPaisesChange(Sender: TObject);
begin
  //Paises
  with DM_Empresa do
  begin
    DM_General.ReiniciarTabla(Paises);
    SELPaises.Close;
    SELPaises.ParamByName('id').asInteger:= DM_General.obtenerIDIntComboBox(cbPaises);
    SELPaises.Open;
    Paises.LoadFromDataSet(SELPaises, 0, lmAppend);
    SELPaises.close;
    CargarProvinciasPais(DM_General.obtenerIDIntComboBox(cbPaises));
  end;
end;

procedure TfrmLocalidadesAE.cbProvinciasChange(Sender: TObject);
begin
   with DM_Empresa do
  begin
    DM_General.ReiniciarTabla(Provincias);
    SELProvincias.Close;
    SELProvincias.ParamByName('id').asInteger:= DM_General.obtenerIDIntComboBox(cbProvincias);
    SELProvincias.Open;
    Provincias.LoadFromDataSet(SELProvincias, 0, lmAppend);
    SELProvincias.close;
    CargarLocalidadesProvincia (DM_General.obtenerIDIntComboBox(cbProvincias));
  end;
end;

procedure TfrmLocalidadesAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmLocalidadesAE.btnBPaisClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro ' +DM_Empresa.PaisesPAIS.AsString +'?'
                , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Empresa.DELPaises.ParamByName('id').asInteger:= DM_General.obtenerIDIntComboBox(cbPaises);
    DM_Empresa.DELPaises.ExecSQL;
    DM_General.CargarComboBox(cbPaises, 'Pais', 'id', DM_Empresa.qTodosLosPaises);
  end;
end;

procedure TfrmLocalidadesAE.btnBProvinciaClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro ' +DM_Empresa.ProvinciasPROVINCIA.AsString +'?'
                , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Empresa.DELProvincias.ParamByName('id').asInteger:= DM_General.obtenerIDIntComboBox(cbProvincias);
    DM_Empresa.DELProvincias.ExecSQL;
    CargarProvinciasPais(DM_General.obtenerIDIntComboBox(cbPaises));
  end;
end;

procedure TfrmLocalidadesAE.btnAProvinciaClick(Sender: TObject);
var
  laProvincia: string;
begin
  if InputQuery('Provincias', 'Nombre de la provincia',laProvincia)
     and (TRIM(laProvincia) <> EmptyStr) then
  begin
    with DM_Empresa do
    begin
      Provincias.Insert;
      ProvinciasPROVINCIA.AsString:= laProvincia;
      Provincias.Post;
      DM_General.GrabarDatos(SELProvincias, INSProvincias, UPDProvincias , Provincias, 'id');
      CargarProvinciasPais(DM_General.obtenerIDIntComboBox(cbPaises));
    end;
  end;
end;

procedure TfrmLocalidadesAE.btnBLocalidadClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION', 'Borro ' +DM_Empresa.LocalidadesLOCALIDAD.AsString +'?'
                , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_Empresa.DELLocalidades.ParamByName('id').asInteger:= DM_General.obtenerIDIntComboBox(cbLocalidades);
    DM_Empresa.DELLocalidades.ExecSQL;
    CargarLocalidadesProvincia(DM_General.obtenerIDIntComboBox(cbProvincias));
  end;

end;


procedure TfrmLocalidadesAE.btnMProvinciaClick(Sender: TObject);
var
  laProvincia: string;
begin
  laProvincia:= EmptyStr;
  if ( (DM_Empresa.Provincias.Active)
       and
      (DM_Empresa.Provincias.RecordCount > 0)) then
  begin
    laProvincia:= DM_Empresa.ProvinciasPROVINCIA.AsString;
    if InputQuery('Provincias', 'Nombre de la provincia',laProvincia)
       and (TRIM(laProvincia) <> EmptyStr) then
    begin
      with DM_Empresa do
      begin
        Provincias.Edit;
        ProvinciasPROVINCIA.AsString:= laProvincia;
        Provincias.Post;
        DM_General.GrabarDatos(SELProvincias, INSProvincias, UPDProvincias , Provincias, 'id');
        CargarProvinciasPais(DM_General.obtenerIDIntComboBox(cbPaises));
      end;
    end;
  end;
end;

procedure TfrmLocalidadesAE.cbLocalidadesChange(Sender: TObject);
begin
 with DM_Empresa do
 begin
   DM_General.ReiniciarTabla(Localidades);
   SELLocalidades.Close;
   SELLocalidades.ParamByName('id').asInteger:= DM_General.obtenerIDIntComboBox(cbLocalidades);
   SELLocalidades.Open;
   Localidades.LoadFromDataSet(SELLocalidades, 0, lmAppend);
   SELLocalidades.close;
 end;
end;

procedure TfrmLocalidadesAE.CargarLocalidadesProvincia(refProvincia: integer);
begin
  DM_Empresa.LocalidadesPorProvincia(refProvincia);
  cbLocalidades.Items.Clear;
  cbLocalidades.Clear;
  with DM_Empresa.Localidades do
  begin
    First;
    While Not EOF do
    begin
      cbLocalidades.Items.AddObject(FieldByName('Localidad').asString, TObject(FieldByName ('id').asInteger));
      Next;
    end;
  end;
  if cbLocalidades.Items.Count > 0 then
   cbLocalidades.ItemIndex:= 0;
end;



end.

