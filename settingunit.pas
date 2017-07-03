unit settingunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TSettingForm }

  TSettingForm = class(TForm)
    Button1: TButton;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  SettingForm: TSettingForm;

implementation

{$R *.lfm}

{ TSettingForm }

procedure TSettingForm.Button1Click(Sender: TObject);
begin

end;

end.

