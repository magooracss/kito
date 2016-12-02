unit frm_hojaderutapresentarpedidos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, Forms, Controls, Graphics, Dialogs
  , ExtCtrls, Buttons, StdCtrls, DbCtrls,  DBExtCtrls, DBGrids, Menus
  , dmgeneral, dmrecibosinternos, dmhojaderuta
  ;

type

  { TfrmHdRPresentacionPedidos }

  TfrmHdRPresentacionPedidos = class(TForm)
    btnEntregaCompleta: TBitBtn;
    btnNoEntregado: TBitBtn;
    btnEntregaParcial: TBitBtn;
    btnSalir: TBitBtn;
    ckEditRecibosInternos: TCheckBox;
    cbFormaDePago: TComboBox;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBText1: TDBText;
    ds_HDR: TDataSource;
    ds_PresentacionPedidos: TDataSource;
    edTransportista: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    MenuItem1: TMenuItem;
    Panel1: TPanel;
    Panel2: TPanel;
    PopupMenu1: TPopupMenu;
    RxDBGrid1: TRxDBGrid;
    procedure btnEntregaCompletaClick(Sender: TObject);
    procedure btnEntregaParcialClick(Sender: TObject);
    procedure btnNoEntregadoClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure RxDBGrid1DblClick(Sender: TObject);
  private
    _idHojaDeRuta: GUID_ID;
    dmHdR: TDM_HojaDeRuta;

    procedure Inicializar;
    procedure Finalizar;

    procedure CrearRecibo(refPedido, refCliente: GUID_ID
  ; nroPedido: Integer;  montoCobrado: double; fecha: TDateTime);
  public
    property idHojaDeRuta: GUID_ID write _idHojaDeRuta;

  end;

var
  frmHdRPresentacionPedidos: TfrmHdRPresentacionPedidos;

implementation
{$R *.lfm}
uses
    dmtransportistas
  , frm_seleccionmotivonoentrega
  , frm_devolucionesae
  , frm_hojaderutapresentarpedido
  , SD_Configuracion
  , dmhojaderutapresentacion
  , frm_recibointernoae
  ;

{ TfrmHdRPresentacionPedidos }

procedure TfrmHdRPresentacionPedidos.FormCreate(Sender: TObject);
begin
  _idHojaDeRuta:= GUIDNULO;

  dmHdR:= TDM_HojaDeRuta.Create(self);
  ds_HDR.DataSet:= dmHdR.HojaDeRuta;

end;

procedure TfrmHdRPresentacionPedidos.btnSalirClick(Sender: TObject);
begin
  dmHdR.CambiarEstado(HdR_ESTADO_PRESENTADA);
  dmHdR.Grabar;
  ModalResult:= mrOK;
end;

procedure TfrmHdRPresentacionPedidos.btnEntregaCompletaClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION'
               , 'Marco como pedidos ENTREGADOS todos los que se encuentran marcados?'
               , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    with ds_PresentacionPedidos.DataSet do
    begin
      First;
      DisableControls;
      While not EOF do
      begin
        if FieldByName('marca').AsBoolean then
        begin
          CrearRecibo(FieldByName('pedido_id').AsString
                     ,FieldByName('clienteID').AsString
                     ,FieldByName('nroPedido').AsInteger
                     ,FieldByName('montoCobrado').AsFloat
                     ,ds_HDR.DataSet.FieldByName('fPresentada').AsDateTime
                     );
         end;
       Next;
      end;
      EnableControls;
    end;
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
            begin
              CrearRecibo(FieldByName('pedido_id').AsString
                         ,FieldByName('clienteID').AsString
                         ,FieldByName('nroPedido').AsInteger
                         ,FieldByName('montoCobrado').AsFloat
                         ,dmHdR.HojaDeRutafPresentada.AsDateTime
                         );
              DM_HdRPresentacion.PedMarcadoDevuelto(pantDev.idDevolucion);
            end;
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
  Finalizar;
  dmHdR.Free;
end;

procedure TfrmHdRPresentacionPedidos.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmHdRPresentacionPedidos.MenuItem1Click(Sender: TObject);
var
  pant: TfrmHdRPresentacionPedido;
begin
  pant:= TfrmHdRPresentacionPedido.Create(self);
  try
    if pant.ShowModal = mrOK then
    begin
      dmHdR.LevantarRenglon(ds_PresentacionPedidos.DataSet.FieldByName('hojaderuta_id').asString);
      dmHdR.HojaDeRutaDetalles.Edit;
      dmHdR.HojaDeRutaDetallesmontoCobrado.AsFloat:= ds_PresentacionPedidos.DataSet.FieldByName('montoCobrado').AsFloat;
      dmHdR.HojaDeRutaDetalles.Post;
      dmHdR.GrabarDetalles;
    end;
  finally
    pant.Free;
  end;
end;


procedure TfrmHdRPresentacionPedidos.RxDBGrid1DblClick(Sender: TObject);
begin
  DM_HdRPresentacion.CambiarMarcaPedido;
end;

procedure TfrmHdRPresentacionPedidos.Inicializar;
var
  rta:string;
  dmRecInt: TDM_RecibosInternos;
begin
  dmRecInt:= TDM_RecibosInternos.Create(self);

  dmHdR.Editar(_idHojaDeRuta);
  DM_Transportistas.Editar(dmHdR.HojaDeRutatransportista_id.AsString);
  edTransportista.Text:= DM_Transportistas.RazonSocial;
  dmHdR.HojaDeRuta.Edit;
  DM_HdRPresentacion.LevantarPedidosHdR(_idHojaDeRuta);
  try
    DM_General.CargarComboBoxTzb(cbFormaDePago, 'FormaPago', 'id', dmRecInt.FormasPago);
  finally
    dmRecInt.Free;
  end;

  rta:= LeerDato(SECCION_APP,CHK_ED_REC_INT);
  if rta = ERROR_CFG then
  begin
    rta:= '1';
    EscribirDato(SECCION_APP,CHK_ED_REC_INT, rta);
  end;
  ckEditRecibosInternos.Checked:= (StrToIntDef (rta, 1) = 1);

  rta:= LeerDato(SECCION_APP,CB_HDR_DEF_FP);
  if rta = ERROR_CFG then
  begin
    rta:= '0';
     EscribirDato(SECCION_APP,CB_HDR_DEF_FP, rta);
  end;
  cbFormaDePago.ItemIndex:= DM_General.obtenerIdxCombo(cbFormaDePago, StrToIntDef(rta, 0));

end;

procedure TfrmHdRPresentacionPedidos.Finalizar;
begin
  EscribirDato(SECCION_APP,CHK_ED_REC_INT, BoolToStr(ckEditRecibosInternos.Checked, '1', '0'));
  EscribirDato(SECCION_APP,CB_HDR_DEF_FP, IntToStr(DM_General.obtenerIDIntComboBox(cbFormaDePago)));
end;

procedure TfrmHdRPresentacionPedidos.CrearRecibo(refPedido, refCliente: GUID_ID
  ; nroPedido: Integer;  montoCobrado: double; fecha: TDateTime);
var
  idRecibo: GUID_ID;
  pantRI: TfrmReciboInternoAE;
  dmRecInt: TDM_RecibosInternos;
begin
  dmRecInt:= TDM_RecibosInternos.Create(self);
  try
    with dmRecInt do
    begin


      if fecha = 0 then fecha:= now;

      idRecibo:=InsertHeader(fecha, montoCobrado, refCliente, REC_INT_ABIERTO);
      InsertConcept('Pedido Nro: ' + InttoStr(nroPedido), montoCobrado, refPedido);
      InsertAmount(DM_General.obtenerIDIntComboBox(cbFormaDePago), montoCobrado);
      Save;
    end;

    if ckEditRecibosInternos.Checked then
    begin
      pantRI:= TfrmReciboInternoAE.Create(self);
      try
        dmRecInt.Edit(idRecibo);
        pantRI.LevantarRecibo(dmRecInt);
        pantRI.ShowModal;
      finally
        pantRI.Free;
      end;
    end;

  finally
  //  dmRecInt.Free;
  end;

end;


end.

