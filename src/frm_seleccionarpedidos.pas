unit frm_seleccionarpedidos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids, Buttons, Grids
  , dmgeneral;

const
  IDX_AENTREGAR = -1;

  //Los ID de estados en la BD son IDX_ + 1
  IDX_TOMADO = 0;
  IDX_ARMADO = 1;
  IDX_TRANSPORTE = 2;
  IDX_ENTREGADO = 3;
  IDX_RECHAZADO = 4;


type

  { TfrmSeleccionarPedidos }

  TfrmSeleccionarPedidos = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    btnFiltrar: TBitBtn;
    ckEstados: TCheckGroup;
    Grilla: TDBGrid;
    ds_seleccion: TDataSource;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnFiltrarClick(Sender: TObject);
    procedure GrillaDblClick(Sender: TObject);
    procedure GrillaDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GrillaTitleClick(Column: TColumn);
  private
    _EstadosValidos: integer;
    function GetPedidosSeleccionados: TStringList;
    procedure Inicializar;
    procedure FiltrarPorEstado;

  public
    property restringirEstados: integer write _EstadosValidos;
    property PedidosSeleccionados: TStringList read GetPedidosSeleccionados;
  end;

var
  frmSeleccionarPedidos: TfrmSeleccionarPedidos;

implementation
{$R *.lfm}
uses
  dmseleccionarpedidos
  ;

{ TfrmSeleccionarPedidos }

procedure TfrmSeleccionarPedidos.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmSeleccionarPedidos.GrillaTitleClick(Column: TColumn);
begin
  DM_General.OrdenarTitulo(column);
end;

procedure TfrmSeleccionarPedidos.FormDestroy(Sender: TObject);
begin
  DM_SeleccionarPedidos.Free;
end;

procedure TfrmSeleccionarPedidos.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_SeleccionarPedidos,DM_SeleccionarPedidos);
end;

procedure TfrmSeleccionarPedidos.btnFiltrarClick(Sender: TObject);
begin
  FiltrarPorEstado;
end;

procedure TfrmSeleccionarPedidos.btnAceptarClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmSeleccionarPedidos.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmSeleccionarPedidos.GrillaDblClick(Sender: TObject);
begin
  DM_SeleccionarPedidos.CambiarEstadoFila;
end;

procedure TfrmSeleccionarPedidos.GrillaDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
const
  clPaleAzul =   TColor($FF0000);
begin
 with DM_SeleccionarPedidos do
  begin
   if (SeleccionPedidosSeleccionado.AsBoolean) then
       Grilla.canvas.brush.color := clPaleAzul;
   Grilla.Canvas.FillRect(Rect);
   Grilla.DefaultDrawColumnCell(rect,DataCol,Column,State)
  end;
end;

procedure TfrmSeleccionarPedidos.Inicializar;
begin
  if _EstadosValidos < 0 then
  begin
    case _EstadosValidos of
     IDX_AENTREGAR:
       begin
         ckEstados.Checked[IDX_ARMADO]:= True;
         ckEstados.Checked[IDX_TOMADO]:= True;
       end;
    end;
  end
  else
   ckEstados.Checked[ _EstadosValidos]:= True;
  FiltrarPorEstado;
end;

function TfrmSeleccionarPedidos.GetPedidosSeleccionados: TStringList;
begin
  Result:= DM_SeleccionarPedidos.PedidosSeleccionados;
end;

procedure TfrmSeleccionarPedidos.FiltrarPorEstado;
var
  idx: integer;
begin
  DM_SeleccionarPedidos.NuevaSeleccion;
  for idx:= 0 to ckEstados.Items.Count -1 do
  begin
    if ckEstados.Checked[idx] then
      DM_SeleccionarPedidos.ObtenerPedidosEstado(idx + 1);
  end;
end;

end.

