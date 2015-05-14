unit frm_hojaderutaae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, dbdateedit, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, DBGrids, DbCtrls, Buttons, StdCtrls, Menus, ActnList
  ,dmgeneral;

type

  { TfrmHojaDeRutaAE }

  TfrmHojaDeRutaAE = class(TForm)
    pedSubir: TAction;
    pedBajar: TAction;
    pedAgregar: TAction;
    pedEliminar: TAction;
    pedEditar: TAction;
    ActionList1: TActionList;
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    btnBuscarTransportista: TBitBtn;
    DBText1: TDBText;
    ds_HRdetalles: TDataSource;
    ds_HR: TDataSource;
    DBGrid1: TDBGrid;
    edTransportista: TEdit;
    Label1: TLabel;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    PopupMenu1: TPopupMenu;
    RxDBDateEdit1: TRxDBDateEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnBuscarTransportistaClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure pedAgregarExecute(Sender: TObject);
    procedure pedBajarExecute(Sender: TObject);
    procedure pedEditarExecute(Sender: TObject);
    procedure pedEliminarExecute(Sender: TObject);
    procedure pedSubirExecute(Sender: TObject);
  private
    _HojaRutaID: GUID_ID;
     procedure Inicializar;
     function Validar: boolean;
     procedure ModificarRenglon;
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
  ,frm_hojaderutapedido
  ,dmtransportistas
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

procedure TfrmHojaDeRutaAE.btnCancelarClick(Sender: TObject);
begin
   ModalResult:= mrCancel;
end;

procedure TfrmHojaDeRutaAE.FormDestroy(Sender: TObject);
begin
  DM_HojaDeRuta.Free;
end;

procedure TfrmHojaDeRutaAE.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmHojaDeRutaAE.pedAgregarExecute(Sender: TObject);
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

procedure TfrmHojaDeRutaAE.pedBajarExecute(Sender: TObject);
begin
  DM_HojaDeRuta.ModificarPosicionPedido(2);
end;

procedure TfrmHojaDeRutaAE.pedEditarExecute(Sender: TObject);
var
  pant: TfrmHdRPedidos;
begin
  pant:= TfrmHdRPedidos.Create(self);
  try
    pant.ShowModal;
  finally
    pant.Free;
  end;

end;

procedure TfrmHojaDeRutaAE.pedEliminarExecute(Sender: TObject);
begin
  if (MessageDlg ('ATENCION'
                , 'Borro el pedido de la hoja de ruta?'
                , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_HojaDeRuta.EliminarPedido;
  end;
end;

procedure TfrmHojaDeRutaAE.pedSubirExecute(Sender: TObject);
begin
  DM_HojaDeRuta.ModificarPosicionPedido(-2);
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
    DM_Transportistas.Editar(DM_HojaDeRuta.HojaDeRutatransportista_id.AsString);
    edTransportista.Text:= DM_Transportistas.RazonSocial;
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

procedure TfrmHojaDeRutaAE.ModificarRenglon;
var
  pant: TfrmHdRPedidos;
begin
  pant:= TfrmHdRPedidos.Create(self);
  try
    pant.ShowModal;
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



end.

