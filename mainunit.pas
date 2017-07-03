unit mainunit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls, Clipbrd;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);

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
     if not(RunComplete) then showmessage('看起来剪贴板不需要或者不能补全。') else showmessage('补全完成！'+#10+'现在的剪贴板是：'+Clipboard.AsText);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  if
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  SettingForm.Show;
end;


end.

