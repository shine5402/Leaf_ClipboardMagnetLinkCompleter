program leaf_clipboardmagnetcompleter;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, mainunit, settingunit
  { you can add units after this };

{$R *.res}

begin
  Application.Title:='Leaf 磁力链剪贴板自动补全守护进程';
  RequireDerivedFormResource:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TSettingForm, SettingForm);
  Application.Run;
end.

