unit mainunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Clipbrd, ExtCtrls, inifiles;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Timer1: TTimer;
    TrayIcon1: TTrayIcon;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  private
    { private declarations }

  public
    { public declarations }
        function ClipboradJudge():boolean;
    procedure ClipboradComplete();
    function RunComplete():boolean;
  end;

var
  Form1: TForm1;
  switch:boolean;
  settings:Tinifile;
  settingspath:string;
implementation
 uses settingunit;
{$R *.lfm}

{ TForm1 }
function Tform1.ClipboradJudge():boolean;
var i:string;
  j,k1,k2,k3:integer;
  l:char;
begin
  k1:=0;k2:=0;k3:=0;
  i:=trim(Clipboard.AsText);
  if length(i)=32 then begin
    for j:= 1 to 32 do begin for l:= 'A' to 'Z' do if l=i[j] then k1:=k1+1;
      for l:='a' to 'z' do if l=i[j] then k2:=k2+1;
      for l:='0' to '9' do if l=i[j] then k3:=k3+1;
  end;
  if k1+k2+k3=32 then ClipboradJudge:=true;
  end else
  if length(i)=40 then begin
    for j:= 1 to 40 do begin for l:= 'A' to 'F' do if l=i[j] then k1:=k1+1;
      for l:='a' to 'f' do if l=i[j] then k2:=k2+1;
      for l:='0' to '9' do if l=i[j] then k3:=k3+1;
  end;
  if k1+k2+k3=40 then ClipboradJudge:=true;
  end else ClipboradJudge:=false;
end;

procedure Tform1.ClipboradComplete();
begin
   Clipboard.AsText:='magnet:?xt=urn:btih:'+trim(Clipboard.AsText);
end;
function Tform1.RunComplete():boolean;
var i:boolean;
begin
  i:=ClipboradJudge;
  if i then ClipboradComplete;
  RunComplete:=i;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
     if not(RunComplete) then MessageDlg('Leaf 磁力链接剪贴板自动补全守护进程','剪贴板看起来不能或者不需要补全',mtInformation,[mbOK],0) else MessageDlg('Leaf 磁力链接剪贴板自动补全守护进程','补全完成！'+#13+#10+'现在的剪贴板是：'+Clipboard.AsText,mtInformation,[mbOK],0);//showmessage('补全完成！'+#13+#10+'现在的剪贴板是：'+Clipboard.AsText);
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var i:integer;
begin
  i:=timer1.Interval;
     settings.WriteInteger('Timer','Interval',i);
     settings.WriteBool('General','Switch',switch);
     settings.Destroy;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   settingspath:='./settings.ini';
   settings:=Tinifile.create(settingspath);
   //开始读取设置
   switch:=settings.ReadBool('General','Switch',false);
   timer1.Interval:=settings.ReadInteger('Timer','Interval',500);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if switch then Label1.Caption:='当前状态：开启' else Label1.Caption:='当前状态：关闭';
    timer1.Enabled:=switch;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var a:boolean;
begin
  a:=ClipboradJudge;
  if a then begin
  RunComplete;
  TrayIcon1.BalloonTitle:='补全已完成';
  TrayIcon1.BalloonHint:='补全后的剪贴板为：'+Clipboard.AsText;
  TrayIcon1.ShowBalloonHint;
  end;
end;
procedure TForm1.Button2Click(Sender: TObject);
begin
  SettingForm.Show;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  switch:=not(switch);
    if switch then Label1.Caption:='当前状态：开启' else Label1.Caption:='当前状态：关闭';
    timer1.Enabled:=switch;

end;


end.

