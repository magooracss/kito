unit frm_ventaae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, DBDateTimePicker, RxDBSpinEdit, Forms,
  Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, Buttons, DBExtCtrls, DbCtrls,
  DBGrids, dmgeneral;

type

  { TfrmVentasAE }

  TfrmVentasAE = class(TForm)
    btnSalir: TBitBtn;
    btnGrabar: TBitBtn;
    btnImprimir: TBitBtn;
    BitBtn4: TBitBtn;
    btnAgregarConcepto: TBitBtn;
    btnAgregarConcepto1: TBitBtn;
    btnAgregarConcepto2: TBitBtn;
    btnAgregarConcepto3: TBitBtn;
    btnClienteNuevo: TBitBtn;
    btnBuscar: TBitBtn;
    cbTipoComprobante: TComboBox;
    cbFormaDePago: TComboBox;
    ds_IVA: TDataSource;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBDateEdit1: TDBDateEdit;
    DBDateEdit2: TDBDateEdit;
    DBDateEdit3: TDBDateEdit;
    DBDateEdit4: TDBDateEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    ds_Comprobante: TDataSource;
    ds_Conceptos: TDataSource;
    edCliente: TEdit;
    edCUIT: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    totGravado: TStaticText;
    totGral: TStaticText;
    totNoGravado: TStaticText;
    totExento: TStaticText;
    totIVA: TStaticText;
    procedure btnSalirClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure btnAgregarConcepto1Click(Sender: TObject);
    procedure btnAgregarConcepto2Click(Sender: TObject);
    procedure btnAgregarConceptoClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnClienteNuevoClick(Sender: TObject);
    procedure btnGrabarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure cbTipoComprobanteChange(Sender: TObject);
    procedure cbTipoComprobanteExit(Sender: TObject);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    _ventaID: GUID_ID;
    _clienteID: GUID_ID;
    _PtoVenta: integer;

    procedure Inicializar;
    procedure CargarCombos;
    procedure LevantarPuntoDeVenta;

    procedure AgregarConcepto;
    procedure AgregarConceptoPedidos;

    procedure MostrarTotales;

    procedure GrabarComprobante;
    procedure PantallaFacturar;


  public
    property ventaID: GUID_ID read _ventaID write _VentaID;

  end;

var
  frmVentasAE: TfrmVentasAE;

implementation
{$R *.lfm}
uses
  dmventas
  , dmpedidos
  , frm_busquedaempresas
  , frm_clientesae
  , frm_ventaconceptosae
  , SD_Configuracion
  , process
  , dmfacturaelectronica
  , dmfacturas

  ,dmclientes
  ;

{ TfrmVentasAE }

procedure TfrmVentasAE.Inicializar;
begin
  _clienteID:= GUIDNULO;
  _ventaID:= GUIDNULO;
  _PtoVenta:= StrToIntDef(LeerDato(SECCION_APP, CFG_PTO_VTA), 1);
  EscribirDato(SECCION_APP, CFG_PTO_VTA, IntToStr(_PtoVenta));
  CargarCombos;
  DM_Ventas.NuevoComprobante;
  LevantarPuntoDeVenta;
  MostrarTotales;
end;

procedure TfrmVentasAE.CargarCombos;
begin
  DM_General.CargarComboBox(cbTipoComprobante,'comprobanteVenta', 'id', DM_Ventas.qTiposComprobantesVentas);
  DM_General.CargarComboBox(cbFormaDePago, 'formaDePago', 'id', DM_Ventas.qFormasPago);
end;

procedure TfrmVentasAE.LevantarPuntoDeVenta;
var
  comprobante: integer;
begin
  comprobante:= DM_Ventas.obtenerNroComprobante (DM_General.obtenerIDIntComboBox(cbTipoComprobante), _PtoVenta);
  if Comprobante <> 0 then
  begin
    DM_Ventas.ComprobanteEditarNro(comprobante);
  end
  else
  begin
   ShowMessage ('No se encuentra cargado el numerador para este tipo de comprobante');
   DM_Ventas.ComprobanteEditarNro(0);
  end;
end;


procedure TfrmVentasAE.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_FacturaElectronica, DM_FacturaElectronica);
  Application.CreateForm(TDM_Ventas, DM_Ventas);
  Application.CreateForm(TDM_Facturas, DM_Facturas);

  Inicializar;
end;

procedure TfrmVentasAE.FormDestroy(Sender: TObject);
begin
   DM_Facturas.Free;
   DM_Ventas.Free;
   DM_FacturaElectronica.Free;
end;

procedure TfrmVentasAE.btnBuscarClick(Sender: TObject);
var
  pantBus: TfrmBusquedaEmpresas;
begin
  pantBus:= TfrmBusquedaEmpresas.Create(self);
  try
    pantBus.restringirTipo:= IDX_CLIENTE;
    if pantBus.ShowModal = mrOK then
    begin
      edCliente.Text:= pantBus.RazonSocial;
      edCUIT.Text:= pantBus.CUIT;
      _clienteID:= pantBus.idCliente;
      LevantarPuntoDeVenta;
    end;
  finally
    pantBus.Free;
  end;
end;

procedure TfrmVentasAE.btnAgregarConceptoClick(Sender: TObject);
begin
  AgregarConcepto;
end;

procedure TfrmVentasAE.btnAgregarConcepto2Click(Sender: TObject);
begin
  DM_Ventas.ModificarPosicionDetalle(-2);
end;

procedure TfrmVentasAE.btnAgregarConcepto1Click(Sender: TObject);
begin
  DM_Ventas.ModificarPosicionDetalle(2);
end;


procedure TfrmVentasAE.btnClienteNuevoClick(Sender: TObject);
var
  pant: TfrmClientesAE;
begin
  pant:= TfrmClientesAE.Create(self);
  try
    pant.idCliente:= GUIDNULO;
    pant.ShowModal;
  finally
    pant.Free;
  end;
end;


procedure TfrmVentasAE.cbTipoComprobanteChange(Sender: TObject);
begin
  LevantarPuntoDeVenta;
end;

procedure TfrmVentasAE.cbTipoComprobanteExit(Sender: TObject);
begin
  LevantarPuntoDeVenta;
end;

procedure TfrmVentasAE.DBEdit1KeyPress(Sender: TObject; var Key: char);
begin
  if key = #13 then
  begin
    _PtoVenta:= StrToIntDef((Sender as TDBEdit).Text, 0 );
    LevantarPuntoDeVenta;
  end;
end;


(*******************************************************************************
*** Totales en Pantalla
*******************************************************************************)

procedure TfrmVentasAE.MostrarTotales;
var
 tGravado, tNoGravado, tExento, tIVA: Double;
begin
  DM_Ventas.CalcularTotales;
  tGravado:= DM_Ventas.TotalGravado;
  tNoGravado:= DM_Ventas.TotalNoGravado;
  tExento:= DM_Ventas.TotalExento;
  tIVA:= DM_Ventas.TotalIVA;
  totGravado.Caption:= 'GRAVADO: ' + FormatFloat ('$ ########0.00', tGravado );
  totNoGravado.Caption:= 'NO GRAVADO: ' + FormatFloat ('$ ########0.00', tNoGravado );
  totExento.Caption:= 'EXENTO: ' + FormatFloat ('$ ########0.00', tExento );
  totIVA.Caption:= 'IVA: ' + FormatFloat ('$ ########0.00', tIVA );
  totGral.Caption:= 'TOTAL: ' + FormatFloat ('$ ##########0.00'
                         , tGravado
                         + tNoGravado
                         + tExento
                         + tIVA);
end;



(*******************************************************************************
*** CONCEPTOS
*******************************************************************************)
procedure TfrmVentasAE.AgregarConceptoPedidos;
begin
  DM_Ventas.AgregarConceptoPedidos;
end;


procedure TfrmVentasAE.AgregarConcepto;
var
  pant: TfrmVentaConceptosAE;
begin
  pant:= TfrmVentaConceptosAE.Create(self);
  try
    pant.refCliente:= _clienteID;
    if pant.ShowModal = mrOK then
    begin
       if pant.tipoConcepto = CONCEPTO_PEDIDO then
        AgregarConceptoPedidos
       else
        DM_Ventas.AgregarConcepto( pant.cantidad
                                  ,pant.refConcepto
                                  ,pant.descripcion
                                  ,pant.montoGravado
                                  ,pant.montoNoGravado
                                  ,pant.montoExento
                                  ,pant.refProducto
                                  ,pant.refAlicuotaIVA
                                 );
    end;
  finally
    pant.Free;
  end;
  MostrarTotales;
end;


(*******************************************************************************
*** CERRAR VENTA
*******************************************************************************)
procedure TfrmVentasAE.GrabarComprobante;
begin
 DM_Ventas.AjustarComprobante( DM_General.obtenerIDIntComboBox(cbTipoComprobante)
                             , DM_General.obtenerIDIntComboBox(cbFormaDePago)
                             , DM_Ventas.TotalGravado
                             , DM_Ventas.TotalNoGravado
                             , DM_Ventas.TotalExento
                             , _clienteID
                             );
 DM_Ventas.Grabar;
end;

procedure TfrmVentasAE.PantallaFacturar;
var
  archivo: string;
  AProcess: TProcess;
begin

  archivo:= LeerDato(SECCION_APP, RUTA_SERV_FE);

  if FileExists(archivo) then
  begin
   AProcess := TProcess.Create (nil);
   AProcess.CommandLine  :=  archivo;
   AProcess.Options  := AProcess.Options + [poWaitOnExit] ;
   AProcess.Execute;
   AProcess.Free;
  end
  else
   ShowMessage('No se encuentra el módulo de facturación: ' + archivo);
end;

procedure TfrmVentasAE.btnGrabarClick(Sender: TObject);
begin
  GrabarComprobante;
end;

procedure TfrmVentasAE.btnImprimirClick(Sender: TObject);
begin
  GrabarComprobante;
  if DM_Ventas.ComproVtafactura_id.AsString <> GUIDNULO then
  begin
     DM_Facturas.ImprimirFactura(DM_Ventas.ComproVtafactura_id.AsString);
     DM_Facturas.elReporte.ShowReport;
  end
  else
     ShowMessage('El comprobante todavía no está facturado');
end;

procedure TfrmVentasAE.BitBtn4Click(Sender: TObject);
begin
  GrabarComprobante;
  DM_FacturaElectronica.FacturarVenta(DM_Ventas.ComproVtaid.AsString) ;
  PantallaFacturar;
end;

procedure TfrmVentasAE.btnSalirClick(Sender: TObject);
begin
 if (MessageDlg ('Confirmación'
                  , 'Desea salir del comprobante en el estado actual?'
                   , mtConfirmation, [mbYes, mbNo],0 ) = mrYes) then
  ModalResult:= mrOK;
end;


end.

