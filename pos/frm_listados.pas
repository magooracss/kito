unit frm_listados;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, DateTimePicker, Forms, Controls, Graphics,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons, EditBtn, contnrs, dmgeneral;

type

   TReportOption = class
    position: integer; //For sort
    name: string; //Visible name
    parameterIdx: integer; //Index of Visual Tab parameters need;
    processIdx: integer; //Simplest, faster and unthought way to make report functions
  end;


  { TfrmListados }

  TfrmListados = class(TForm)
    BitBtn1: TBitBtn;
    btnImprimir: TBitBtn;
    btnExportar: TBitBtn;
    cbFileFormats: TComboBox;
    edDatesFIni: TDateEdit;
    edDatesFFin: TDateEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbReports: TListBox;
    PCParameters: TPageControl;
    Panel1: TPanel;
    tabDates: TTabSheet;
    tabEmpty: TTabSheet;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lbReportsSelectionChange(Sender: TObject; User: boolean);
  private
    reportOptions:TObjectList;

    procedure CreateOptions;
    procedure Initialise;

    procedure ExecuteReport (reportIdx: integer; rptAction: TReportAction);

  public
    { public declarations }
  end;

var
  frmListados: TfrmListados;

implementation
{$R *.lfm}
uses
  dateutils
, rpt_movimentoscaja
, rpt_movimientosentrefechas
;

{ TfrmListados }
const
  PARAM_EMPTY = 0;
  PARAM_DATES = 1;
  PARAM_DATEPRODUCT = 2;
  PARAM_DATEPROVIDER = 3;

  RPT_MOVSFECHAS = 1;
  RPT_VENT_PRODUCTOS = 2;
  RPT_MOV_PROVEEDOR = 3;
  RPT_DEBAJO_MINIMO = 4;
  RPT_CAJADIARIA = 5;

procedure TfrmListados.FormCreate(Sender: TObject);
begin
  reportOptions:= TObjectList.Create(true);
  with cbFileFormats do
  begin
    Items.Clear;
    items.AddObject('Archivo PDF', TObject(raPDF));
    items.AddObject('Archivo Excel 97-2003', TObject(raXLS));
    items.AddObject('Archivo Excel', TObject(raXLSX));
    ItemIndex:= 0;
  end;
end;

procedure TfrmListados.FormShow(Sender: TObject);
begin
  Initialise;
end;

procedure TfrmListados.lbReportsSelectionChange(Sender: TObject; User: boolean);
begin
 PCParameters.ActivePageIndex:= (reportOptions[lbReports.ItemIndex] as TReportOption).parameterIdx;
end;

procedure TfrmListados.BitBtn1Click(Sender: TObject);
begin
  ModalResult:= mrOK;
end;

procedure TfrmListados.btnExportarClick(Sender: TObject);
begin
 if (lbReports.ItemIndex >= 0) then
 begin
   ExecuteReport((reportOptions[lbReports.ItemIndex] as TReportOption).processIdx
                 ,TReportAction (cbFileFormats.Items.Objects[cbFileFormats.ItemIndex])
                 );
 end;
end;

procedure TfrmListados.btnImprimirClick(Sender: TObject);
begin
 if (lbReports.ItemIndex >= 0) then
   ExecuteReport((reportOptions[lbReports.ItemIndex] as TReportOption).processIdx , raPrint);
end;

procedure TfrmListados.CreateOptions;
  procedure createObj( Objpos: integer; Objname: string; ObjtabIdx, ObjProcIdx: integer);
  var
    obj: TReportOption;
  begin
    obj:= TReportOption.Create;
    obj.position:= Objpos;
    obj.name:= Objname;
    obj.parameterIdx:= ObjtabIdx;
    obj.processIdx:= ObjProcIdx;
    reportOptions.Add(obj);
  end;
begin
  createObj(1,'Ventas entre fechas ', PARAM_DATES, RPT_MOVSFECHAS);
//   createObj(2,'Ventas por producto', PARAM_DATEPRODUCT, RPT_VENT_PRODUCTOS);
 // createObj(3,'Movimientos por proveedor', PARAM_DATEPROVIDER, RPT_MOV_PROVEEDOR);
 // createObj(4,'Productos por debajo del stock mínimo', PARAM_EMPTY, RPT_DEBAJO_MINIMO);
  createObj(5,'Listado de caja', PARAM_DATES, RPT_CAJADIARIA);
end;

procedure TfrmListados.Initialise;
var
  iter: integer;
  dateToday: TDate;
begin
  CreateOptions;
  for iter:= 0 to reportOptions.Count - 1 do
  begin
    lbReports.Items.Add((reportOptions[iter] as TReportOption).name);
  end;
  PCParameters.ActivePageIndex:= 0;
  lbReports.ItemIndex:= 0;

  dateToday:= now;

  edDatesFIni.Date:= dateToday;
  edDatesFFin.Date:= dateToday;
end;

procedure TfrmListados.ExecuteReport(reportIdx: integer;
  rptAction: TReportAction);
var
  frm: TForm;
begin
   try
     case reportIdx of
       RPT_CAJADIARIA: begin
                 frm:= Trpt.Create(self);
                 (frm as Trpt).RunReport ( edDatesFIni.Date, edDatesFFin.Date
                                         , rptAction
                                         );
               end;
       RPT_MOVSFECHAS: begin
                 frm:= TrptMovEntreFechas.Create(self);
                 (frm as TrptMovEntreFechas).RunReport ( edDatesFIni.Date, edDatesFFin.Date
                                                       , rptAction
                                                       );
               end;


     end;
   finally
     if (frm <> nil) then
   	   frm.Free;
   end;

end;

end.

