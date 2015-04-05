unit frm_clientesae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  fra_empresa, dmgeneral;

type

  { TfrmClientesAE }

  TfrmClientesAE = class(TForm)
    fraEmpresa1: TfraEmpresa;
    Panel1: TPanel;
    Panel2: TPanel;
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
  ;

{ TfrmClientesAE }

procedure TfrmClientesAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmClientesAE.Inicializar;
begin
  DM_General.CargarComboBox(fraEmpresa1.cbCondicionFiscal, 'CondicionFiscal', 'id', DM_Empresa.qCondicionesFiscales);
end;

end.

