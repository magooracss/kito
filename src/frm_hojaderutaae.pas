unit frm_hojaderutaae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbdateedit, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, DBGrids, DbCtrls, Buttons, StdCtrls
  ,dmgeneral;

type

  { TfrmHojaDeRutaAE }

  TfrmHojaDeRutaAE = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    btnAgregarPedido: TBitBtn;
    btnMoverArriba: TBitBtn;
    btnMoverAbajo: TBitBtn;
    BitBtn4: TBitBtn;
    btnBuscarTransportista: TBitBtn;
    DBDateEdit1: TDBDateEdit;
    DBText1: TDBText;
    ds_HRdetalles: TDataSource;
    ds_HR: TDataSource;
    DBGrid1: TDBGrid;
    edTransportista: TEdit;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure BitBtn4Click(Sender: TObject);
    procedure btnAceptarClick(Sender: TObject);
    procedure btnAgregarPedidoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnMoverArribaClick(Sender: TObject);
    procedure btnMoverAbajoClick(Sender: TObject);
    procedure btnBuscarTransportistaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _HojaRutaID: GUID_ID;
     procedure Inicializar;
     function Validar: boolean;
  public
    property HojaDeRutaID: GUID_ID read _HojaRutaID write _HojaRutaID;
  end;

var
  frmHojaDeRutaAE: TfrmHojaDeRutaAE;

implementation
{$R *.lfm}
uses
  dmhojaderuta
  ,frm_busquedaempresas
  ,frm_seleccionarpedidos
  ;

{ TfrmHojaDeRutaAE }

procedure TfrmHojaDeRutaAE.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_HojaDeRuta, DM_HojaDeRuta);
end;

procedure TfrmHojaDeRutaAE.btnBuscarTransportistaClick(Sender: TObject);
var
  pant: TfrmBusquedaEmpresas;
begin
  pant:= TfrmBusquedaEmpresas.Create(self);
  try
    pant.restringirTipo:= IDX_TRANSPORTISTA;
    if pant.ShowModal = mrOK then
    begin
      DM_HojaDeRuta.HojaDeRuta.Edit;
      DM_HojaDeRuta.HojaDeRutatransportista_id.AsString:= pant.idTransportista;
      DM_HojaDeRuta.HojaDeRuta.Post;
      edTransportista.Text:= pant.RazonSocial;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmHojaDeRutaAE.btnMoverArribaClick(Sender: TObject);
begin
  DM_HojaDeRuta.ModificarPosicionPedido(-2);
end;

procedure TfrmHojaDeRutaAE.btnMoverAbajoClick(Sender: TObject);
begin
  DM_HojaDeRuta.ModificarPosicionPedido(2);
end;

procedure TfrmHojaDeRutaAE.FormDestroy(Sender: TObject);
begin
  DM_HojaDeRuta.Free;
end;

procedure TfrmHojaDeRutaAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmHojaDeRutaAE.Inicializar;
begin
  if _HojaRutaID = GUIDNULO then
  begin
    DM_HojaDeRuta.Nuevo;
  end
  else
  begin
    DM_HojaDeRuta.Editar(_HojaRutaID);
  end;
end;

function TfrmHojaDeRutaAE.Validar: boolean;
begin
  Result:= True;
  if DM_HojaDeRuta.HojaDeRutatransportista_id.AsString = GUIDNULO then
   Result:= False;
  if DM_HojaDeRuta.HojaDeRutaDetalles.RecordCount = 0 then
   Result:= False;
end;

procedure TfrmHojaDeRutaAE.btnAgregarPedidoClick(Sender: TObject);
var
  pant: TfrmSeleccionarPedidos;
  idx: integer;
begin
  pant:= TfrmSeleccionarPedidos.Create(self);
  try
    pant.restringirEstados:= IDX_AENTREGAR;
    if pant.ShowModal = mrOK then
    begin
      for idx:= 0 to pant.PedidosSeleccionados.Count -1 do
       DM_HojaDeRuta.AgregarPedido(pant.PedidosSeleccionados[idx]);
    end;
  finally
    pant.Free;
  end;

end;

procedure TfrmHojaDeRutaAE.btnAceptarClick(Sender: TObject);
begin
  if Validar then
  begin
    DM_HojaDeRuta.Grabar;
    ModalResult:= mrOK;
  end
  else
   ShowMessage('Complete todos los datos antes de intentar salir de esta pantalla');

end;

procedure TfrmHojaDeRutaAE.BitBtn4Click(Sender: TObject);
begin
  if (MessageDlg ('ATENCION'
                , 'Borro el pedido de la hoja de ruta?'
                , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_HojaDeRuta.EliminarPedido;
  end;

end;

procedure TfrmHojaDeRutaAE.btnCancelarClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;


end.

