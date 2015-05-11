unit frm_hojaderutapedido;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, RxDBSpinEdit, dbcurredit, rxdbcomb, rxlookup,
  Forms, Controls, Graphics, Dialogs, ExtCtrls, Buttons, StdCtrls, DbCtrls,
  dmgeneral
  ;

type

  { TfrmHdRPedidos }

  TfrmHdRPedidos = class(TForm)
    btnAceptar: TBitBtn;
    btnCancelar: TBitBtn;
    cbDomCliente: TComboBox;
    ds_Domicilios: TDataSource;
    DBCheckBox1: TDBCheckBox;
    DBMemo1: TDBMemo;
    DBText1: TDBText;
    DBText2: TDBText;
    ds_detallepedidos: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel2: TPanel;
    RxDBCurrEdit1: TRxDBCurrEdit;
    RxDBSpinEdit1: TRxDBSpinEdit;
    procedure btnAceptarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    _ClavesDomicilio: TStringList;

    procedure Inicializar;
    procedure CargarCombo (var CbCombo: TComboBox; var Lista: TStringList);
  public
    { public declarations }
  end;

var
  frmHdRPedidos: TfrmHdRPedidos;

implementation
{$R *.lfm}
uses
  dmclientes
  ,dmempresa
  ,dmhojaderuta
  ,dmpedidos
  ;

{ TfrmHdRPedidos }

procedure TfrmHdRPedidos.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmHdRPedidos.btnCancelarClick(Sender: TObject);
begin
  DM_HojaDeRuta.HojaDeRutaDetalles.Cancel;
  ModalResult:= mrCancel;
end;

procedure TfrmHdRPedidos.FormCreate(Sender: TObject);
begin
  _ClavesDomicilio:= TStringList.Create;
end;

procedure TfrmHdRPedidos.FormDestroy(Sender: TObject);
begin
  _ClavesDomicilio.Free;
end;

procedure TfrmHdRPedidos.btnAceptarClick(Sender: TObject);
begin
  with DM_HojaDeRuta, HojaDeRutaDetalles do
  begin
    Edit;
    HojaDeRutaDetallesclienteDireccion_id.AsString:=_ClavesDomicilio[cbDomCliente.ItemIndex];
    HojaDeRutaDetalleslxClienteDir.AsString:= cbDomCliente.Items[cbDomCliente.ItemIndex];
    Post;
  end;
  ModalResult:= mrOK;
end;

procedure TfrmHdRPedidos.Inicializar;
begin
  DM_Pedidos.LevantarPedido(DM_HojaDeRuta.HojaDeRutaDetallespedido_id.AsString);
  DM_Clientes.Editar(DM_Pedidos.Pedidoscliente_id.AsString);
  CargarCombo(cbDomCliente, _ClavesDomicilio);
end;

procedure TfrmHdRPedidos.CargarCombo(var CbCombo: TComboBox;
  var Lista: TStringList);
var
  idx: integer;
begin
   CbCombo.Items.Clear;
   with DM_Empresa, Domicilios do
   begin
     First;
     idx:= 0;
     while Not EOF do
     begin
       CbCombo.Items.Add(Domiciliosdomicilio.AsString);
       Lista.Add(Domiciliosid.AsString);
       if (DM_HojaDeRuta.HojaDeRutaDetallesclienteDireccion_id.AsString = Domiciliosid.AsString )
           then
       begin
         CbCombo.ItemIndex:= idx;
       end
       else
       begin
         Inc(idx);
       end;
       Next;
     end;
   end;
end;

end.

