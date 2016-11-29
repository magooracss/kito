unit frm_recibointernoae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, rxdbgrid, dbcurredit, Forms, Controls,
  Graphics, Dialogs, ExtCtrls, DbCtrls, DBExtCtrls, StdCtrls, Buttons,
  dmclientes, dmrecibosinternos, dmgeneral;

type

  { TfrmReciboInternoAE }

  TfrmReciboInternoAE = class(TForm)
    btnSave: TBitBtn;
    btnAgregarConcepto: TBitBtn;
    btnAgregarCobro: TBitBtn;
    btnAgregarPagoACuenta: TBitBtn;
    btnQuitarConcepto: TBitBtn;
    btnBuscarCliente: TBitBtn;
    btnQuitarMonto: TBitBtn;
    btnSave1: TBitBtn;
    btnExit: TBitBtn;
    ds_recInt: TDataSource;
    ds_recIntCpts: TDataSource;
    ds_recIntMontos: TDataSource;
    DBDateEdit1: TDBDateEdit;
    DBEdit1: TDBEdit;
    edCliente: TEdit;
    edMontoConceptos: TEdit;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    RxDBCurrEdit1: TRxDBCurrEdit;
    RxDBGrid1: TRxDBGrid;
    RxDBGrid2: TRxDBGrid;
    procedure btnAgregarCobroClick(Sender: TObject);
    procedure btnAgregarConceptoClick(Sender: TObject);
    procedure btnAgregarPagoACuentaClick(Sender: TObject);
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnQuitarMontoClick(Sender: TObject);
    procedure btnQuitarConceptoClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure DBEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
     clienteDM: TDM_Clientes;
     reciboIntDM: TDM_RecibosInternos;
     procedure Inicializar;
     procedure CalcularTotales;
  public
    procedure NuevoRecibo;
    procedure LevantarRecibo (var elRecibo: TDM_RecibosInternos);
  end;

var
  frmReciboInternoAE: TfrmReciboInternoAE;

implementation
{$R *.lfm}
uses
  frm_busquedaempresas
 ,frm_recibointernoconcepto
 ,frm_recibointernocobros
  ;


{ TfrmReciboInternoAE }

procedure TfrmReciboInternoAE.FormDestroy(Sender: TObject);
begin
  reciboIntDM.Free;
  clienteDM.Free;
end;

procedure TfrmReciboInternoAE.FormCreate(Sender: TObject);
begin
  Inicializar;
  NuevoRecibo;

  reciboIntDM.Edit('{D3726E9D-7226-49BA-B26B-FF208BD1CB54}');
  CalcularTotales;
end;

procedure TfrmReciboInternoAE.btnBuscarClienteClick(Sender: TObject);
var
  pant: TfrmBusquedaEmpresas;
  idCliente: GUID_ID;
begin
  pant:= TfrmBusquedaEmpresas.Create(self);
  try
    pant.restringirTipo:= IDX_CLIENTE;
    if pant.ShowModal = mrOK then
    begin
      edCliente.Text:= pant.RazonSocial;
      idCliente:= pant.idCliente;
    end
    else
    begin
      edCliente.Clear;
      idCliente:= GUIDNULO;
    end;

    reciboIntDM.RecibosInternos.Edit;
    reciboIntDM.RecibosInternoscliente_id.AsString:= idCliente;
  finally
    pant.Free;
  end;
end;

procedure TfrmReciboInternoAE.btnExitClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmReciboInternoAE.DBEdit1Change(Sender: TObject);
begin
 (sender as TDBEdit).Visible:= (ds_recInt.DataSet.FieldByName('numero').AsInteger > 0);
end;

procedure TfrmReciboInternoAE.Inicializar;
begin
  clienteDM:= TDM_Clientes.Create(self);
  reciboIntDM:= TDM_RecibosInternos.Create(self);
  edMontoConceptos.Text:= '$0.00';
  edCliente.Clear;

  ds_recInt.DataSet:= reciboIntDM.RecibosInternos;
  ds_recIntCpts.DataSet:= reciboIntDM.RecibosIntCptos;
  ds_recIntMontos.DataSet:= reciboIntDM.RecibosIntMontos;
end;

procedure TfrmReciboInternoAE.CalcularTotales;
begin
  edMontoConceptos.Text:= formatFloat ('$############0.00', reciboIntDM.SumConcepts);
  reciboIntDM.Refresh;
end;

procedure TfrmReciboInternoAE.NuevoRecibo;
begin
  reciboIntDM.New;
  btnBuscarCliente.Enabled:= True;
end;

procedure TfrmReciboInternoAE.LevantarRecibo(var elRecibo: TDM_RecibosInternos);
begin
  reciboIntDM:= elRecibo;
  btnBuscarCliente.Enabled:= False;
end;

(*******************************************************************************
*** CONCEPTOS
*******************************************************************************)

procedure TfrmReciboInternoAE.btnAgregarConceptoClick(Sender: TObject);
var
  pant: TfrmRecIntConceptoAE;
begin
  pant:= TfrmRecIntConceptoAE.Create( (self as TComponent)
                                     , reciboIntDM
                                     , reciboIntDM.RecibosInternoscliente_id.AsString);
  try
    reciboIntDM.RecibosIntCptos.Insert;
    if pant.ShowModal = mrCancel  then
      reciboIntDM.RecibosIntCptos.Delete;
  finally
    pant.Free;
  end;
  CalcularTotales;
end;


procedure TfrmReciboInternoAE.btnQuitarConceptoClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION'
                 ,'Quito el concepto ' + reciboIntDM.RecibosIntCptosconcepto.AsString + '?'
                   , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    reciboIntDM.deleteConcept;
  end;
  CalcularTotales;
end;

procedure TfrmReciboInternoAE.btnSaveClick(Sender: TObject);
var
  id: GUID_ID;
begin
  id:= reciboIntDM.RecibosInternosid.AsString;
  reciboIntDM.Save;
  reciboIntDM.Edit(id);
end;

(*******************************************************************************
*** FORMAS DE COBRO
*******************************************************************************)

procedure TfrmReciboInternoAE.btnAgregarCobroClick(Sender: TObject);
var
  pant: TfrmRecIntFormaCobro;
begin
  pant:= TfrmRecIntFormaCobro.Create( (self as TComponent), reciboIntDM );
  try
    reciboIntDM.RecibosIntMontos.Insert;
    if pant.ShowModal = mrCancel  then
      reciboIntDM.RecibosIntMontos.Delete;
  finally
    pant.Free;
  end;
  CalcularTotales;
end;


procedure TfrmReciboInternoAE.btnQuitarMontoClick(Sender: TObject);
begin
  if (MessageDlg ('ATENCION'
                 ,'Quito la forma de pago seleccionada ?'
                   , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  begin
    reciboIntDM.DeleteAmount;
  end;
  CalcularTotales;
end;


procedure TfrmReciboInternoAE.btnAgregarPagoACuentaClick(Sender: TObject);
begin
  reciboIntDM.SumPagoACuenta;
  CalcularTotales;
end;


end.



