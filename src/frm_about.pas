unit frm_about;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Buttons, StdCtrls;

type

  { TfrmAbout }

  TfrmAbout = class(TForm)
    Image1: TImage;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Version: TStaticText;
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation
{$R *.lfm}
uses
 versioninfo
 ;

{ TfrmAbout }

procedure TfrmAbout.FormShow(Sender: TObject);
Var
  NroVersion: String;
  Info: TVersionInfo;
begin
  Info := TVersionInfo.Create;
  Info.Load(HINSTANCE);
  NroVersion := IntToStr(Info.FixedInfo.FileVersion[0])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[1])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[2])+'.'
                +IntToStr(Info.FixedInfo.FileVersion[3]);
  Info.Free;

  Version.Caption := 'version prg:' + NroVersion;end;

procedure TfrmAbout.Image1Click(Sender: TObject);
begin

end;

procedure TfrmAbout.SpeedButton1Click(Sender: TObject);
begin
  ModalResult:= mrOK;
  close;
end;

end.

