unit frm_asientomanualae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbdateedit, DBDateTimePicker, Forms,
  Controls, Graphics, Dialogs, StdCtrls, Buttons, DBExtCtrls, DbCtrls,
  dmgeneral, dmasientomanual;

type

  { TfrmAsientoManualAE }

  TfrmAsientoManualAE = class(TForm)
    btnGrabar: TBitBtn;
    btnCancelar: TBitBtn;
    btnBuscarEmpresa: TBitBtn;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    dsAsiento: TDataSource;
    edRazonSocial: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnGrabarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnBuscarEmpresaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    asientoDM: TDM_AsientoManual;
    _asientoID: GUID_ID;
    _empresaID:GUID_ID;
  public
    property asientoID: GUID_ID write _asientoID;
    property empresaID: GUID_ID write _empresaID;

  end;

var
  frmAsientoManualAE: TfrmAsientoManualAE;

implementation
{$R *.lfm}
uses
  frm_busquedaempresas
  ,dmempresa
  ;

{ TfrmAsientoManualAE }

procedure TfrmAsientoManualAE.FormCreate(Sender: TObject);
begin
  _empresaID:= GUIDNULO;
  _asientoID:= GUIDNULO;
  asientoDM:= TDM_AsientoManual.Create(self);

  dsAsiento.DataSet:= asientoDM.AsientoManual;
end;

procedure TfrmAsientoManualAE.FormDestroy(Sender: TObject);
begin
  asientoDM.Free;
end;

procedure TfrmAsientoManualAE.FormShow(Sender: TObject);
begin
  if _asientoID = GUIDNULO then
  begin
    asientoDM.Nuevo;
  end
  else
  begin
    asientoDM.Editar (_asientoID);
  end;

  if _empresaID <> GUIDNULO then
  begin
    DM_Empresa.LevantarEmpresa(_empresaID);
    edRazonSocial.Text:= DM_Empresa.RazonSocial;
    asientoDM.EmpresaID:= _empresaID;
  end;
end;



(*******************************************************************************
*** BUSQUEDA EMPRESA
*******************************************************************************)

procedure TfrmAsientoManualAE.btnBuscarEmpresaClick(Sender: TObject);
var
  panBus: TfrmBusquedaEmpresas;
begin
  panBus:= TfrmBusquedaEmpresas.Create(self);
  try
    panBus.restringirTipo:= IDX_NINGUNO;
    if panBus.ShowModal = mrOK then
    begin
       _empresaID:= panBus.idEmpresa;
       edRazonSocial.Text:= panBus.RazonSocial;
       asientoDM.EmpresaID:= _empresaID;
    end
    else
      _empresaID:= GUIDNULO;
  finally
    panBus.Free;
  end;
end;

procedure TfrmAsientoManualAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmAsientoManualAE.btnGrabarClick(Sender: TObject);
begin
  asientoDM.Grabar;
  ModalResult:= mrOK;
end;


end.

