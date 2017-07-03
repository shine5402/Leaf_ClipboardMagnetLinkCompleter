unit settingunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls;

type

  { TSettingForm }

  TSettingForm = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  SettingForm: TSettingForm;

implementation
uses mainunit;
{$R *.lfm}

{ TSettingForm }

procedure TSettingForm.Button1Click(Sender: TObject);
begin
  form1.timer1.Interval:=strtoint(edit1.text);
  settingform.hide;
end;

procedure TSettingForm.FormCreate(Sender: TObject);
begin

end;

procedure TSettingForm.FormShow(Sender: TObject);
begin
  edit1.text:=inttostr(form1.timer1.Interval);
end;

end.

