unit frm_hojaderutaae;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  DBGrids;

type

  { TfrmHojaDeRutaAE }

  TfrmHojaDeRutaAE = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmHojaDeRutaAE: TfrmHojaDeRutaAE;

implementation
{$R *.lfm}
uses
  dmhojaderuta
  ;

{ TfrmHojaDeRutaAE }

procedure TfrmHojaDeRutaAE.FormCreate(Sender: TObject);
begin
  Application.CreateForm(TDM_HojaDeRuta, DM_HojaDeRuta);
end;

procedure TfrmHojaDeRutaAE.FormDestroy(Sender: TObject);
begin
  DM_HojaDeRuta.Free;
end;

end.

