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
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
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
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnBuscarEmpresaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    asientoDM: TDM_AsientoManual;
    _asientoID: GUID_ID;
    _empresaID:GUID_ID;
  public
    property asientoID: GUID_ID write _asientoID;
  end;

var
  frmAsientoManualAE: TfrmAsientoManualAE;

implementation
{$R *.lfm}
uses
  frm_busquedaempresas
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
    end
    else
      _empresaID:= GUIDNULO;
  finally
    panBus.Free;
  end;
end;

procedure TfrmAsientoManualAE.BitBtn2Click(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmAsientoManualAE.BitBtn1Click(Sender: TObject);
begin
  ModalResult:= mrOK;
end;


end.

