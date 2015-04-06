unit frm_clientesae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, fra_empresa, dmgeneral;

type

  { TfrmClientesAE }

  TfrmClientesAE = class(TForm)
    btnCancelar: TBitBtn;
    btnGrabar: TBitBtn;
    fraEmpresaCliente: TfraEmpresa;
    Panel1: TPanel;
    procedure FormShow(Sender: TObject);
  private
    _idCliente: GUID_ID;
    procedure Inicializar;
  public
    property idCliente: GUID_ID read _idCliente write _idCliente;
  end;

var
  frmClientesAE: TfrmClientesAE;

implementation
{$R *.lfm}
uses
  dmempresa
  ,dmclientes
  ;

{ TfrmClientesAE }

procedure TfrmClientesAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;


procedure TfrmClientesAE.Inicializar;
begin
  DM_General.CargarComboBox(fraEmpresaCliente.cbCondicionFiscal, 'CondicionFiscal', 'id', DM_Empresa.qCondicionesFiscales);
  if idCliente = GUIDNULO then
  Begin
    DM_Clientes.Nuevo;
  end;

end;

end.

