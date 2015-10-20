unit FES_U4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Forms, XPMan,// ����������� ������
  Dialogs, // ������ ��� �������� (showmessage)
  Controls, StdCtrls, // ������ ��� TLabel, TButton, TEdit
  DB, ADODB, Menus; // ������ ��� ����������� � ��

type
  TForm4 = class(TForm)
    EFileName: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    ADOConnection1: TADOConnection;
    Label6: TLabel;
    MainMenu1: TMainMenu;
    Selectfile1: TMenuItem;
    Open1: TMenuItem;
    Close1: TMenuItem;
    Help1: TMenuItem;
    About1: TMenuItem;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

procedure TForm4.Button1Click(Sender: TObject);
var
  a:array [0..127] of byte; // ������ ������ ��� ������ �� �����
  s_hex:string; // ������ ��� �������������� �� ������� ^^^ � ����������������� ��� ��� ������� � ��
  i:Integer; // ���������� ��� �����
  pth:string;
begin
pth := ExtractFileDir(Application.ExeName);
if pth[Length(pth)] <> '\' then
pth := pth + '\';
try
ADOConnection1.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+pth+'extension.mdb;Persist Security Info=False';
ADOConnection1.Connected := True; // ������������ � ��
except
// ����������� try ... except ... end ��� ��������� ������
end;

// ��������� ���������� �� ��. ���� ��� - �������
if not ADOConnection1.Connected then
  begin
  ShowMessage('���� ������ �� ����������');
  Exit;
  end;

EFileName.Clear; // ������ ���� � ������ �����

with TOpenDialog.Create(nil) do // ������� ������ ������ �����
  begin
  if Execute then // ���� ���� ������ ��...
    EFileName.Text := FileName; // ...��������� ��� �����
  Free; // "�������" ������ ������ �����
  end;

if EFileName.Text = EmptyStr then // ���� �����...
  Exit; // ...�������

with TFileStream.Create(EFileName.Text, fmOpenRead or fmShareDenyNone) do // ������� ����� ��� �������� �����
  begin
  ReadBuffer(a, SizeOf(a)); // ������ � ������ ������ 128 ����
  Free; // "�������" �������� �����
  end;

for i := Low(a) to High(a) do // ����� �� ������� �� ������� �� ���������� ��������
  s_hex := s_hex + IntToHex(a[i], 2); // ��������� ������ ������������������ ���������� �� �������

with TADOQuery.Create(nil) do // ������� ������ ��� ��������� ������ �� ��
  begin
  Connection := ADOConnection1; // ��������� ����� ������������ ������������
  SQL.Text := 'select * from File_Extension where :hex like hex+"%"'; // ������ � ������� ��� ��������� ������
  Parameters.ParamByName('hex').Value := s_hex; // �������� �������� ��� �������
  Open; // ���������
  First; // ���������� �� ������ ������
  if not Eof then // ���� ���� ���� ���� ������, �� Eof �� ����� �����. ������ ���� � ��� ��������
    begin // ����� ��� �������
    Label6.Caption := '��������� Hex';
    Label6.Visible:=true;
    Label2.Caption := FieldByName('Program').AsString;
    Label2.Visible:=true;
    Label4.Visible:=true;
    Label3.Caption := FieldByName('��������').AsString;
    Label3.Visible:=true;
    Label5.Visible:=true;
    end
  else // ���� ������ �� ���� �������...
    begin // ... ���� �� ����������
    SQL.Text := 'select * from File_Extension where Extension=:ext';
    Parameters.ParamByName('ext').Value := ExtractFileExt(EFileName.Text);
    Open;
    First;
    if not Eof then
      begin // ����� ��� �������
      Label6.Caption := '��������� Ext';
      Label6.Visible:=true;
      Label2.Caption := FieldByName('Program').AsString;
      Label2.Visible:=true;
      Label4.Visible:=true;
      Label3.Caption := FieldByName('��������').AsString;
      Label3.Visible:=true;
      Label5.Visible:=true;
      end
    else // ���� � ��� ������ �� �������...
      begin // ...����� ��� �� �������
      Label6.Caption := '������ �� �������. ���������, ����������, ���� ���� �� ��� �����: mrDeShock@yandex.ua';
      Label6.Visible:=true;
      Label2.Caption := EmptyStr;
      Label3.Caption := EmptyStr;
      end;
    end;
  Free;
  end;

ADOConnection1.Connected := False;
end;


end.
