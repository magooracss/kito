unit frm_seleccionmotivonoentrega;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Buttons;

type

  { TfrmMotivoNoEntrega }

  TfrmMotivoNoEntrega = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    btnTugMotivosNoEntrega: TSpeedButton;
    cbMotivoNoEntrega: TComboBox;
    Label1: TLabel;
    procedure btnTugMotivosNoEntregaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function getMotivoNoEntrega: integer;
    { private declarations }
  public
    property idMotivoNoEntrega: integer read getMotivoNoEntrega;
  end;

var
  frmMotivoNoEntrega: TfrmMotivoNoEntrega;

implementation
{$R *.lfm}
uses
  dmgeneral
  ,dmhojaderutapresentacion
  ,dmediciontugs
  ,frm_ediciontugs
  ;

{ TfrmMotivoNoEntrega }

procedure TfrmMotivoNoEntrega.FormShow(Sender: TObject);
begin
  DM_General.CargarComboBox(cbMotivoNoEntrega,'MotivoNoEntrega', 'id', DM_HdRPresentacion.qMotivosNoEntrega);
end;

procedure TfrmMotivoNoEntrega.btnTugMotivosNoEntregaClick(Sender: TObject);
var
  pantalla: TfrmEdicionTugs;
  datos: TTablaTUG;
begin
  pantalla:=TfrmEdicionTugs.Create(self);
  datos:= TTablaTUG.Create;
  try
    with datos do
    begin
      nombre:= 'MotivoNoEntrega';
      titulo:= 'Motivo por el que no se realiza la entrega';
      AgregarCampo('motivoNoEntrega','Detalle del motivo');
    end;
    pantalla.laTUG:= datos;
    pantalla.ShowModal;
    DM_General.CargarComboBox(cbMotivoNoEntrega,'MotivoNoEntrega', 'id', DM_HdRPresentacion.qMotivosNoEntrega);
  finally
    datos.Free;
    pantalla.Free;
  end;
end;

function TfrmMotivoNoEntrega.getMotivoNoEntrega: integer;
begin
  Result:= DM_General.obtenerIDIntComboBox(cbMotivoNoEntrega);
end;

end.

