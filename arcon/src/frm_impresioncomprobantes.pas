unit frm_impresioncomprobantes;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, rxdbgrid, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, ComCtrls, Buttons, StdCtrls;

type

  { TfrmImpresionComprobantes }

  TfrmImpresionComprobantes = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    btnFiltrar: TBitBtn;
    edCliRazonSocial: TEdit;
    Label1: TLabel;
    PCFiltros: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    rgCriterioFiltro: TRadioGroup;
    RxDBGrid1: TRxDBGrid;
    tabNroAFIP: TTabSheet;
    tabNroCAE: TTabSheet;
    tabNroVenta: TTabSheet;
    tabCliente: TTabSheet;
    tabMonto: TTabSheet;
    tabVenta: TTabSheet;
    tabTipoComprobanteAFIP: TTabSheet;
    tabFechaComprAFIP: TTabSheet;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgCriterioFiltroSelectionChanged(Sender: TObject);
  private
    procedure Inicializar;
  public
    { public declarations }
  end;

var
  frmImpresionComprobantes: TfrmImpresionComprobantes;

implementation

{$R *.lfm}

{ TfrmImpresionComprobantes }


procedure TfrmImpresionComprobantes.rgCriterioFiltroSelectionChanged(
  Sender: TObject);
begin
  PCFiltros.ActivePageIndex:= rgCriterioFiltro.ItemIndex;
end;

procedure TfrmImpresionComprobantes.Inicializar;
begin
  rgCriterioFiltro.ItemIndex:= 0;
end;

procedure TfrmImpresionComprobantes.FormShow(Sender: TObject);
begin
  Inicializar;
end;

procedure TfrmImpresionComprobantes.BitBtn1Click(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

end.

