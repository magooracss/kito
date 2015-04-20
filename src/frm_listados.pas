unit frm_listados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ComCtrls, DBGrids, Buttons;

type

  { TfrmListados }

  TfrmListados = class(TForm)
    btnSalir: TBitBtn;
    btnMostrar: TBitBtn;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    PCParametros: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    TabNada: TTabSheet;
    procedure btnMostrarClick(Sender: TObject);
    procedure btnSalirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmListados: TfrmListados;

implementation
{$R *.lfm}
uses
  dmlistados
  ;

{ TfrmListados }

procedure TfrmListados.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_Listados, DM_Listados);
end;

procedure TfrmListados.btnSalirClick(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmListados.FormDestroy(Sender: TObject);
begin
  DM_Listados.Free;
end;


procedure TfrmListados.btnMostrarClick(Sender: TObject);
begin
  DM_Listados.StockMinimimo;
end;


end.

