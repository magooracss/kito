unit frm_hojaderutapresentarpedidos;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, DBDateTimePicker, dbdateedit, Forms,
  Controls, Graphics, Dialogs, ExtCtrls, Buttons, StdCtrls, DbCtrls, dmgeneral
  ;

type

  { TfrmHdRPresentacionPedidos }

  TfrmHdRPresentacionPedidos = class(TForm)
    btnSalir: TBitBtn;
    DBText1: TDBText;
    ds_HDR: TDataSource;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    RxDBDateEdit1: TRxDBDateEdit;
    procedure btnSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
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

procedure TfrmHdRPresentacionPedidos.FormDestroy(Sender: TObject);
begin
  DM_HojaDeRuta.Free;
end;

procedure TfrmHdRPresentacionPedidos.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmHdRPresentacionPedidos.Inicializar;
begin
  DM_HojaDeRuta.Editar(_idHojaDeRuta);
  DM_HojaDeRuta.HojaDeRuta.Edit;
end;


end.

