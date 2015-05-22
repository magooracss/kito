unit frm_hojaderutapresentarpedidos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, DBDateTimePicker, dbdateedit, rxdbgrid,
  Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons, StdCtrls, DbCtrls,
  DBExtCtrls, DBGrids, dmgeneral
  ;

type

  { TfrmHdRPresentacionPedidos }

  TfrmHdRPresentacionPedidos = class(TForm)
    btnEntregaCompleta: TBitBtn;
    btnNoEntregado: TBitBtn;
    btnEntregaParcial: TBitBtn;
    btnSalir: TBitBtn;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBText1: TDBText;
    ds_HDR: TDataSource;
    ds_PresentacionPedidos: TDataSource;
    edTransportista: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    RxDBGrid1: TRxDBGrid;
    procedure btnEntregaCompletaClick(Sender: TObject);
    procedure btnEntregaParcialClick(Sender: TObject);
    procedure btnNoEntregadoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RxDBGrid1DblClick(Sender: TObject);
  private
    _idHojaDeRuta: GUID_ID;

    procedure Inicializar;
  public
    property idHojaDeRuta: GUID_ID write _idHojaDeRuta;

  end;

var
  frmHdRPresentacionPedidos: TfrmHdRPresentacionPedidos;

implementation
{$R *.lfm}
uses
  dmhojaderuta
  ,dmtransportistas
  ,dmhojaderutapresentacion
  ,frm_seleccionmotivonoentrega
  ,frm_devolucionesae
  ;

{ TfrmHdRPresentacionPedidos }

procedure TfrmHdRPresentacionPedidos.FormCreate(Sender: TObject);
begin
  _idHojaDeRuta:= GUIDNULO;
  Application.CreateForm(TDM_HojaDeRuta, DM_HojaDeRuta);
end;

procedure TfrmHdRPresentacionPedidos.btnSalirClick(Sender: TObject);
begin
  DM_HojaDeRuta.CambiarEstado(HdR_ESTADO_PRESENTADA);
  DM_HojaDeRuta.Grabar;
  ModalResult:= mrOK;
end;

procedure TfrmHdRPresentacionPedidos.btnEntregaCompletaClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION'
               , 'Marco como pedidos ENTREGADOS todos los que se encuentran marcados?'
               , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    DM_HdRPresentacion.PedMarcadosEntregaCompleta;
    DM_HdRPresentacion.LevantarPedidosHdR(_idHojaDeRuta);
  end;
end;

procedure TfrmHdRPresentacionPedidos.btnEntregaParcialClick(Sender: TObject);
var
  pantDev: TfrmDevolucionesae;
begin
  if (MessageDlg ('ATENCION'
               , 'Marco como pedidos DEVUELTOS todos los que se encuentran marcados?'
               , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    with ds_PresentacionPedidos.DataSet do
    begin
      First;
      DisableControls;
      pantDev:= TfrmDevolucionesae.Create(self);
      try
        While not EOF do
        begin
          if FieldByName('marca').AsBoolean then
          begin
            pantDev.idPedido:= FieldByName('pedido_id').AsString;
            if pantDev.ShowModal = mrOK then
             DM_HdRPresentacion.PedMarcadoDevuelto(pantDev.idDevolucion);;
          end;
          Next;
        end;
      finally
        pantDev.Free;
      end;
      EnableControls;
      DM_HdRPresentacion.LevantarPedidosHdR(_idHojaDeRuta);
    end;
  end;
end;

procedure TfrmHdRPresentacionPedidos.btnNoEntregadoClick(Sender: TObject);
var
  pant: TfrmMotivoNoEntrega;
begin
  pant:= TfrmMotivoNoEntrega.Create (Self);
  try
    if (MessageDlg ('ATENCION'
                 , 'Marco como pedidos NO ENTREGADOS todos los que se encuentran marcados?'
                 , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
    begin
      if pant.ShowModal = mrOK then
      begin
        DM_HdRPresentacion.PedMarcadosNoEntregados(pant.idMotivoNoEntrega);
        DM_HdRPresentacion.LevantarPedidosHdR(_idHojaDeRuta);
      end;
    end;
  finally
    pant.Free;
  end;
end;

procedure TfrmHdRPresentacionPedidos.FormDestroy(Sender: TObject);
begin
  DM_HojaDeRuta.Free;
end;

procedure TfrmHdRPresentacionPedidos.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmHdRPresentacionPedidos.RxDBGrid1DblClick(Sender: TObject);
begin
  DM_HdRPresentacion.CambiarMarcaPedido;
end;

procedure TfrmHdRPresentacionPedidos.Inicializar;
begin
  DM_HojaDeRuta.Editar(_idHojaDeRuta);
  DM_Transportistas.Editar(DM_HojaDeRuta.HojaDeRutatransportista_id.AsString);
  edTransportista.Text:= DM_Transportistas.RazonSocial;
  DM_HojaDeRuta.HojaDeRuta.Edit;
  DM_HdRPresentacion.LevantarPedidosHdR(_idHojaDeRuta);
end;


end.

